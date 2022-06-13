import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTheme {
  const AppTheme();

  static ThemeData configureAppTheme() {
    final customTheme = ThemeData(
      primaryColor: primaryColor,
      primaryColorDark: primaryColorDark,
      primaryColorLight: primaryColorLight,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: accentColor),
      scaffoldBackgroundColor: backgroundColor,
      inputDecorationTheme: _configureInputDecorationTheme(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );

    return _configureTextTheme(customTheme);
  }

  static ThemeData _configureTextTheme(ThemeData customTheme) {
    return customTheme.copyWith(
      textTheme: customTheme.textTheme.copyWith(
        headline1: GoogleFonts.handlee(
          textStyle: customTheme.textTheme.headline1?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 48,
            color: Colors.black,
          ),
        ),
        headline2: GoogleFonts.handlee(
          textStyle: customTheme.textTheme.headline2?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 32,
            color: Colors.black,
          ),
        ),
        bodyText1: GoogleFonts.handlee(
          textStyle: customTheme.textTheme.bodyText1?.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  static InputDecorationTheme _configureInputDecorationTheme() {
    return InputDecorationTheme(
      border: const OutlineInputBorder(),
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
      hintStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: borderColor,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: primaryColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      filled: true,
      fillColor: Colors.white,
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: errorColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      errorStyle: const TextStyle(color: errorColor, fontSize: 16),
    );
  }
}
