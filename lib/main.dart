import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controllers/bindings.dart';
import 'utils/routes.dart';
import 'utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkLoginStatus(),
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          return GetMaterialApp(
            theme: myTheme,
            title: "Qzense App",
            debugShowCheckedModeBanner: false,
            initialRoute: snapshot.data == true ? "/" : "/login",
            routes: routes,
            initialBinding: AllBinder(),
          );
        }
      },
    );
  }

  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getString('access_token') != null;
    debugPrint('IsLoggedIn: $isLoggedIn');
    return isLoggedIn;
  }
}
