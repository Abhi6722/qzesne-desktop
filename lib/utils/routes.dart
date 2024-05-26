import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (BuildContext context) => HomeScreen(),
  '/login': (BuildContext context) => const LoginScreen(),
};
