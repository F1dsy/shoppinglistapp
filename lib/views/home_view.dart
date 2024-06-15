import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglistapp/components/bottom_navigation_bar.dart';
import 'package:shoppinglistapp/components/shopping_list_container.dart';

import 'package:shoppinglistapp/providers/provider.dart';
import 'package:shoppinglistapp/views/settings_view.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final Map<String, Function> popUpActions = {
    "Settings": (context) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const SettingsView(),
      ));
    },
  };

  final Widget _noLists = const Center(
    child: Text("No Lists"),
  );

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.shoppingLists.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(provider.shoppingLists[index].name),
                    onTap: () {
                      provider.selectedShoppingList =
                          provider.shoppingLists[index];
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            );
          },
          child: Text(
            provider.selectedShoppingList.name,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              popUpActions[value]?.call(context);
            },
            itemBuilder: (context) => popUpActions.keys
                .map(
                  (String e) => PopupMenuItem<String>(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: provider.shoppingLists.isNotEmpty
          ? ShoppingListContainer(shoppingList: provider.selectedShoppingList)
          : _noLists,
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
