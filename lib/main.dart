import 'package:bazi_app_frontend/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'configs/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: appTheme, home: WelcomeScreen());
  }
}
