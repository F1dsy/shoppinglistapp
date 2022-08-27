import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglistapp/components/shopping_list_container.dart';

import 'package:shoppinglistapp/provider.dart';
import 'package:shoppinglistapp/views/settings_view.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final Map<String, Function> popUpActions = {
    "settings": (context) {
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
        elevation: 0,
        title: TextButton(
          onPressed: () {
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
            style: Theme.of(context).textTheme.headline6,
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
      bottomNavigationBar: Transform.translate(
        offset: Offset(0, -1 * MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          width: double.infinity,
          height: 70,
          child: BottomAppBar(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                    flex: 4,
                    child: SizedBox(
                      height: 45,
                      child: TextField(
                        decoration: InputDecoration(
                          fillColor: Colors.white70,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.menu)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
