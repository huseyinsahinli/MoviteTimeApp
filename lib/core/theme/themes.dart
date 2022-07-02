import 'package:firebase_islemleri/core/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_color.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = true;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toogleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
        brightness: Brightness.light,
        fontFamily: GoogleFonts.openSans().fontFamily);
  }

  static ThemeData get darkTheme {
    return ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColor.mainColor,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: AppColor.mainColor,
          elevation: 12,
          titleTextStyle: AppConstants.mainTitleStyle,
        ),
        fontFamily: GoogleFonts.openSans().fontFamily);
  }
}
