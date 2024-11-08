import 'package:flutter/material.dart';
import 'package:flutter_take_home/src/features/auth/presentation/pages/login.dart';
import 'package:flutter_take_home/src/core/constants/app_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Take Home',
      debugShowCheckedModeBanner: false,
      theme: themeData(),
      home: const LoginPage(),
    );
  }

  ThemeData themeData() {
    return ThemeData(
      primarySwatch: Colors.orange,
      scaffoldBackgroundColor: AppConstants.backgroundColor,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppConstants.gradientEnd,
        selectionColor: AppConstants.gradientEnd,
        selectionHandleColor: AppConstants.gradientEnd,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: AppConstants.gradientEnd),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(AppConstants.buttonForeground),
        ),
      ),
    );
  }
}