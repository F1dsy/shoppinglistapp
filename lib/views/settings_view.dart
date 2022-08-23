import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglistapp/main.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = Provider.of<ThemeValueNotifier>(context).value;

    return Scaffold(
      body: Column(
        children: [
          RadioListTile<ThemeMode>(
              title: const Text("Light"),
              value: ThemeMode.light,
              groupValue: themeMode,
              onChanged: (value) {
                Provider.of<ThemeValueNotifier>(context, listen: false).value =
                    value!;
              }),
          RadioListTile<ThemeMode>(
              title: const Text("Dark"),
              value: ThemeMode.dark,
              groupValue: themeMode,
              onChanged: (value) {
                Provider.of<ThemeValueNotifier>(context, listen: false).value =
                    value!;
              }),
        ],
      ),
    );
  }
}
