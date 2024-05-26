import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:qzense_automation/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  bool userLogout = false;

  Future<void> _removeTokens() async {
    final prefs = await SharedPreferences.getInstance();
    prefs
        .remove('email')
        .then((value) => {debugPrint('email removed : $value')});
    prefs
        .remove('token')
        .then((value) => {debugPrint('Token removed : $value')});
    debugPrint('Removed Email and Token credentials from Local Storage!');
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            MaterialButton(
              color: Constants.primaryColor,
              textColor: Colors.white,
              child: const Text('Yes'),
              onPressed: () {
                setState(() {
                  userLogout = true;
                });
                userLogout ? _removeTokens() : null;
                Get.to(const LoginScreen());
                // // Navigator.popUntil(context, (route) => false);
                // // Navigator.popUntil(context, (route) => false);
                // Get.until((route) {
                //   return route.settings.name == '/login';
                // });
              },
            ),
            MaterialButton(
              color: Constants.primaryColor,
              textColor: Colors.white,
              child: const Text('No'),
              onPressed: () {
                setState(() {
                  userLogout = false;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _displayDialog(context);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Constants.primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Padding(
          padding: EdgeInsets.all(6.5),
          child: FaIcon(
            FontAwesomeIcons.powerOff,
            color: Color.fromRGBO(12, 52, 61, 1),
          ),
        ),
      ),
    );
  }
}
