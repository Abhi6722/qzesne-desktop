import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qzense_automation/utils/constants.dart';
import 'package:qzense_automation/widgets/LogoutButton.dart';
import 'package:qzense_automation/widgets/SocialFooter.dart';
import '../controllers/camera_controller.dart';
import '../utils/token_manager.dart';
import '../widgets/UserIcon.dart';
import 'fish_image_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final MyCameraController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder<String?>(
                    future: TokenManager
                        .getUserEmail(), // Fetch user email from SharedPreferences
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(); // Show loading indicator while fetching email
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final userEmail = snapshot.data;
                        return UserIcon(
                            userName:
                                userEmail ?? ''); // Show user icon with email
                      }
                    },
                  ),
                  const SizedBox(width: 15),
                  const LogoutButton(),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Image.asset(
                  'assets/images/logo.webp',
                  height: 70,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.species = 'Fish';
                              controller.model = 'sardine';
                              controller.mlModel = 'FISH';
                              controller.showLoading = false;
                              Get.to(() => PhotoWatcher());
                              controller.speak('Opening Sardine model...');
                              // setState(() {
                              //   getAccessToken();
                              //   fetchData();
                              // });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: Constants.primaryColor, width: 1.5),
                              ),
                              child: Ink(
                                height: 130,
                                width: 130,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/sardine.png',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              controller.species = 'Fish';
                              controller.model = 'mackerel';
                              controller.mlModel = 'FISH';
                              controller.showLoading = false;
                              Get.to(() => PhotoWatcher());
                              controller.speak('Opening Mackerel model...');
                              // _speak('Opening Gills model...');
                              // setState(() {
                              //   getAccessToken();
                              // });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: Constants.primaryColor, width: 1.5),
                              ),
                              child: Ink(
                                height: 130,
                                width: 130,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/mackerel.png',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.species = 'Prawn';
                              controller.model = 'white prawn';
                              controller.mlModel = 'prawn';
                              controller.showLoading = false;
                              Get.to(() => PhotoWatcher());
                              controller.speak('Opening Prawns model...');
                              // _speak('Opening Prawns model...');
                              // setState(() {
                              //   getAccessToken();
                              //   fetchData();
                              // });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: Constants.primaryColor, width: 1.5),
                              ),
                              child: Ink(
                                height: 130,
                                width: 130,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/prawnsModel.png',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SocialFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
