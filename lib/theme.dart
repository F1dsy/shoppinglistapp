import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ThemeMode> getThemeMode() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool? isDarkMode = sharedPreferences.getBool("isDarkMode");

  switch (isDarkMode) {
    case true:
      return ThemeMode.dark;
    case false:
      return ThemeMode.light;
    default:
      return ThemeMode.system;
  }
}

ThemeData lightTheme = ThemeData.light();
ThemeData darkTheme = ThemeData.dark();
