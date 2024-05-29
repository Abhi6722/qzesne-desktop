import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:qzense_automation/screens/login_screen.dart';
import 'package:qzense_automation/utils/constants.dart';
import 'package:qzense_automation/utils/token_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCameraController extends GetxController {
  //Fish Part
  var species = 'Fish';
  var model = 'sardine';
  var mlModel = 'FISH';
  var part = 'body';
  bool flashOn = false;
  var models = ['sardine', 'mackerel', 'white prawn'];
  bool showLoading = false;

  //Result Variables
  late String result = '';
  late int numericVal;
  late int numberOfFishes;
  late int goodFishes;
  late int badFishes;
  String resultImage = '';
  // String specialFeedback = '';
  String? inputImageUrl;
  String? resultImageUrl;

  Widget buildImageWidget(BuildContext context) {
    if (resultImage.isNotEmpty) {
      List<int> decodedImage = base64Decode(resultImage);
      Uint8List uint8List = Uint8List.fromList(decodedImage);
      return SizedBox(
        child: Image.memory(uint8List, fit: BoxFit.contain),
      );
    }
    return const SizedBox.shrink();
  }

  Future<void> regenerateTokenAndGetResult(String imagePath) async {
    final email = await TokenManager.getUserEmail();
    final password = await TokenManager.getUserPassword();
    final response = await http.post(
      Uri.parse('${Constants.apiURL}/auth/login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      debugPrint('Login Successful!');
      Map<String, dynamic> data = json.decode(response.body);
      String accessToken = data['token']['access'];
      String refreshToken = data['token']['refresh'];
      await TokenManager.saveAccessToken(accessToken);
      await TokenManager.saveRefreshToken(refreshToken);
      await getAutoResult(imagePath);
    } else {
      Get.snackbar('Failed to Get Result', "Please Login again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      Get.to(() => const LoginScreen());
    }
  }

  Future<void> getAutoResult(String imagePath) async {
    try {
      debugPrint("Getting the result");
      showLoading = true;
      update();
      await getAccessToken();

      var headers = {
        'Authorization': 'Bearer $accessT',
      };

      var request =
          http.MultipartRequest('POST', Uri.parse('${Constants.apiURL}/post/'));
      request.fields.addAll({
        'deviceModel': 'S22',
        'brand': 'Samsung',
        'test': 'False',
        'mlModel': mlModel,
        'part': part,
        'hour': '100',
        'flash': flashOn ? 1.toString() : 0.toString(),
        'FishName': model,
      });
      request.files
          .add(await http.MultipartFile.fromPath('capture', imagePath));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        debugPrint(responseBody);
        var responseData = json.decode(responseBody);
        result = responseData['Species'] ?? '';
        numberOfFishes = responseData['Fishes detected'];
        goodFishes = responseData['Good fishes'];
        badFishes = responseData['Bad fishes'];
        resultImage = responseData['Image'];
        inputImageUrl = responseData['input_image_url'];
        resultImageUrl = responseData['result_image_url'];
        // specialFeedback = responseData['Species-Feedback'];
        update();

        await ftts.setLanguage("en-US");
        await ftts.setSpeechRate(0.4); //speed of speech
        await ftts.setVolume(1.0); //volume of speech
        await ftts.setPitch(1); //pitch of sound

        if (goodFishes > 0 && badFishes == 0) {
          var speakResult = await ftts.speak(
              "$species Species $result, Number of $species Detected $numberOfFishes, All $species Good");
          // if(speakResult == 1){}else{}
        } else if (badFishes > 0 && goodFishes == 0) {
          var speakResult = await ftts.speak(
              "$species Species $result, Number of $species Detected $numberOfFishes, All $species Bad");
          // if(speakResult == 1){}else{}
        } else {
          var speakResult = await ftts.speak(
              "$species Species $result, Number of $species Detected $numberOfFishes, Number of Good $species $goodFishes, Number of Bad $species $badFishes ");
          // if(speakResult == 1){}else{}
        }
      } else if (response.statusCode == 403) {
        await ftts.setLanguage("en-US");
        await ftts.setSpeechRate(0.4); //speed of speech
        await ftts.setVolume(1.0); //volume of speech
        await ftts.setPitch(1); //pitch of sound
        var speak = await ftts.speak("No $species Detected. Please try Again!");

        // Get.to( ()=> const ResultScreen());
        update();
      } else if (response.statusCode == 401) {
        await regenerateTokenAndGetResult(imagePath);
      } else {
        debugPrint(response.reasonPhrase);
        debugPrint("\nThe status code is : ${response.statusCode.toString()}");
        debugPrint("\nResponse Headers : ${response.headers.toString()}");
        debugPrint(
            "\nThe Reason Phrase is : ${response.reasonPhrase.toString()}");
        debugPrint('Res: $response');
        // showErrorDialog("Session Expired. Login Again !!");
      }
    } catch (e) {
      debugPrint('error Message is ${e.toString()}');
    } finally {
      showLoading = false;
      update();
    }
  }

  void resetResult() {
    result = '';
    update();
  }

  // Speech Part
  FlutterTts ftts = FlutterTts();
  Future<void> speak(String text) async {
    await ftts.setLanguage("en-US");
    await ftts.setSpeechRate(0.4); //speed of speech
    await ftts.setVolume(1.0); //volume of speech
    await ftts.setPitch(1); //pitch of sound
    await ftts.speak(text);
  }

  // Access Token
  var accessT = '';
  Future getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    accessT = prefs.getString('access_token')!;
    debugPrint('Access Token : $accessT');
  }
}
