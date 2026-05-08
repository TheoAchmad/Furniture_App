import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF1A1A1A);
  static const Color accentColor = Color(0xFF000000);
  static const Color backgroundColor = Color(0xFFFAFAFA);
  static const Color greyColor = Color(0xFF9E9E9E);
  static const Color lightGrey = Color(0xFFF5F5F5);

  static ThemeData get theme => ThemeData(
    fontFamily: 'SF Pro Display',
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: primaryColor),
    ),
  );
}