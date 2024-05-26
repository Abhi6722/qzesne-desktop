import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qzense_automation/utils/constants.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  bool emailEmpty = true;
  bool passEmpty = true;
  bool loginButtonEnabled = false;
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.07),
        child: GetBuilder<AuthController>(builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.webp',
                height: 70,
              ),
              const SizedBox(height: 50),
              Text(
                'Welcome back',
                style: TextStyle(
                  fontSize: 34,
                  color: Constants.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Login to your account',
                style: TextStyle(
                  fontSize: 16,
                  color: Constants.primaryColor,
                ),
              ),
              const SizedBox(height: 50),
              TextField(
                onChanged: (val) {
                  setState(() {
                    authController.loginError = '';
                    emailEmpty = val.isNotEmpty ? false : true;
                    loginButtonEnabled =
                        (!emailEmpty && !passEmpty) ? true : false;
                  });
                },
                cursorColor: Constants.primaryColor,
                keyboardType: TextInputType.emailAddress,
                autofocus: true,
                controller: authController.emailController,
                style: TextStyle(fontSize: 15, color: Constants.primaryColor),
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(
                    Icons.email,
                    color: Constants.primaryColor,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 25.0,
                    horizontal: 25.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Constants.secondaryColor,
                  hintStyle: TextStyle(
                    color: Constants.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: authController.passwordController,
                onChanged: (val) {
                  setState(() {
                    authController.loginError = '';
                    passEmpty = val.isNotEmpty ? false : true;
                    loginButtonEnabled =
                        (!emailEmpty && !passEmpty) ? true : false;
                  });
                },
                cursorColor: Constants.primaryColor,
                obscureText: obscureText,
                autofocus: false,
                style: TextStyle(fontSize: 15, color: Constants.primaryColor),
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Constants.primaryColor,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    child: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Constants.primaryColor.withOpacity(0.5),
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 25.0,
                    horizontal: 25.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide:
                        BorderSide.none, // Remove the active border line
                  ),
                  filled: true,
                  fillColor: Constants.secondaryColor,
                  hintStyle: TextStyle(
                    color: Constants.primaryColor,
                    fontWeight:
                        FontWeight.bold, // Make the placeholder text bold
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  if (loginButtonEnabled) {
                    authController.loginUser();
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: loginButtonEnabled
                        ? Constants.primaryColor
                        : Constants.primaryColor.withOpacity(0.5),
                  ),
                  height: 45,
                  width: double.infinity,
                  child: const Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Visibility(
                visible: authController.isLoading.value ? true : false,
                child: Center(
                    child: CircularProgressIndicator(
                  color: Constants.primaryColor,
                )),
              ),
              Visibility(
                visible: authController.loginError == 'Invalid' ? true : false,
                child: const Text(
                  'Invalid ID or Password',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Visibility(
                visible: authController.loginError == 'Error' ? true : false,
                child: const Text(
                  'Server error',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
