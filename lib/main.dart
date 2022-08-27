import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglistapp/providers/provider.dart';
import 'package:shoppinglistapp/providers/theme_provider.dart';
import 'package:shoppinglistapp/views/home_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ThemeMode>(
      future: getThemeMode(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => ThemeValueNotifier(snapshot.data!),
              ),
              ChangeNotifierProvider(create: (context) => AppProvider())
            ],
            builder: (context, child) => MaterialApp(
              title: 'Flutter Demo',
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: Provider.of<ThemeValueNotifier>(context).value,
              debugShowCheckedModeBanner: false,
              home: HomeView(),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
