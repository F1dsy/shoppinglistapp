import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglistapp/components/category_dialog.dart';
import 'package:shoppinglistapp/models/category.dart';
import 'package:shoppinglistapp/provider.dart';

class CategorySettingsView extends StatelessWidget {
  const CategorySettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Category> categories = Provider.of<AppProvider>(context).categories;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
        actions: [
          IconButton(
            onPressed: () {
              showCategoryDialog(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ReorderableListView.builder(
        prototypeItem: const ListTile(),
        itemCount: categories.length,
        itemBuilder: (context, index) => ListTile(
          key: Key(categories[index].hashCode.toString()),
          title: Text(
            categories[index].name,
            style: TextStyle(color: categories[index].color),
          ),
          trailing: const Icon(Icons.drag_indicator),
          onTap: () {
            showCategoryDialog(context, existingCategory: categories[index]);
          },
        ),
        onReorder: (oldIndex, newIndex) {
          Provider.of<AppProvider>(context).reorderCategory(oldIndex, newIndex);
        },
      ),
    );
  }
}
