import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglistapp/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shoppinglistapp/views/category_settings_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = Provider.of<ThemeValueNotifier>(context).value;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: ListView(
        children: [
          ListTile(
            dense: true,
            title: Text(AppLocalizations.of(context)!.theme),
          ),
          RadioListTile<ThemeMode>(
              title: Text(AppLocalizations.of(context)!.light),
              value: ThemeMode.light,
              groupValue: themeMode,
              onChanged: (value) {
                Provider.of<ThemeValueNotifier>(context, listen: false).value =
                    value!;
              }),
          RadioListTile<ThemeMode>(
              title: Text(AppLocalizations.of(context)!.dark),
              value: ThemeMode.dark,
              groupValue: themeMode,
              onChanged: (value) {
                Provider.of<ThemeValueNotifier>(context, listen: false).value =
                    value!;
              }),
          ListTile(
            dense: true,
            title: Text(AppLocalizations.of(context)!.categoriesAndUnits),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.categories),
            subtitle: Text(AppLocalizations.of(context)!.categoriesDescription),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Theme.of(context).textTheme.caption!.color,
              // color: Color(0xB3FFFFFF),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CategorySettingsView(),
              ));
            },
          ),
          ListTile(
            title: const Text("About"),
            onTap: () {
              showAboutDialog(context: context);
            },
          )
        ],
      ),
    );
  }
}
