import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppinglistapp/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ThemeMode>(
      future: getThemeMode(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ChangeNotifierProvider(
            create: (context) => ThemeValueNotifier(snapshot.data!),
            builder: (context, _) {
              ThemeMode theme = Provider.of<ThemeValueNotifier>(context).value;
              return MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                darkTheme: ThemeData.dark(),
                themeMode: theme,
                debugShowCheckedModeBanner: false,
                home: const HomeView(),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}

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

class ThemeValueNotifier extends ValueNotifier<ThemeMode> {
  ThemeValueNotifier(super.value);

  @override
  set value(value) {
    SharedPreferences.getInstance().then((sharedPreferences) =>
        sharedPreferences.setBool("isDarkMode", value == ThemeMode.dark));
    super.value = value;
  }
}
