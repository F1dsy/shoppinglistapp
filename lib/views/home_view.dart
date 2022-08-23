import 'package:flutter/material.dart';
import 'package:shoppinglistapp/components/shopping_list.dart';
import 'package:shoppinglistapp/components/top_app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(
        title: "My App",
      ),
      body: ShoppingList(),
    );
  }
}
