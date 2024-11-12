import 'package:flutter/material.dart';

class AppConstants {

  // Colours
  static const Color primaryColor = Color(0xFFF2A02B);
  static const Color secondaryColor = Color(0xFFDF6F56);
  static const Color backgroundColor = Color.fromARGB(255, 238, 238, 238);

  static const Color gradientStart = Color(0xFFF2A02B);
  static const Color gradientEnd = Color(0xFFDF6F56);

  static const Color buttonForeground = Color(0xFFFFFFFF);

  static const LinearGradient mainGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Spacing
  static const double defaultPadding = 16.0;
  static const double defaultPaddingLarge = 24.0;
  static const double defaultPaddingExtraLarge = 32.0;

  // Border Radius
  static const double borderRadius = 12.0;

  // Sizes
  static const double buttonHeight = 56.0;

  // Text Styles
  static const TextStyle titleStyle = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 24,
    color: Colors.black,
  );

}