import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/token_manager.dart';

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String loginError = '';
  RxBool isLoading = false.obs;
  String accessToken = '';
  String refreshToken = '';

  Future<void> loginUser() async {
    isLoading.value = true;
    update();
    try {
      String email = emailController.text;
      String password = passwordController.text;
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
        accessToken = data['token']['access'];
        refreshToken = data['token']['refresh'];
        await TokenManager.saveAccessToken(accessToken);
        await TokenManager.saveRefreshToken(refreshToken);
        await TokenManager.saveUserEmail(email);
        await TokenManager.saveUserPassword(password);
        Get.snackbar('Login Success', 'Login Successful',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        emailController.text = "";
        passwordController.text = "";
        Get.toNamed("/");
      } else if (response.statusCode == 409) {
        Get.snackbar('Failed to Login', 'Student already exist.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      } else {
        Get.snackbar('Failed to Login', "Failed to Login",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      debugPrint("$e");
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
