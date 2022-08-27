import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeValueNotifier extends ValueNotifier<ThemeMode> {
  ThemeValueNotifier(super.value);

  @override
  set value(value) {
    SharedPreferences.getInstance().then((sharedPreferences) =>
        sharedPreferences.setBool("isDarkMode", value == ThemeMode.dark));
    super.value = value;
  }
}
