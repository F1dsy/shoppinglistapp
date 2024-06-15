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

ThemeData baseTheme = ThemeData().copyWith(
  appBarTheme: const AppBarTheme().copyWith(
    elevation: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(16)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(16)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8.0),
    ),
    isDense: true,
  ),
);

ThemeData lightTheme = baseTheme.copyWith(
  colorScheme: const ColorScheme.light(),
);

ThemeData darkTheme = ThemeData.dark()
    .copyWith(inputDecorationTheme: baseTheme.inputDecorationTheme);
