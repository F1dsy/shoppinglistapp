import 'package:flutter/material.dart';
import 'package:shoppinglistapp/components/category_list_tile.dart';
import 'package:shoppinglistapp/components/food_list_tile.dart';
import 'package:shoppinglistapp/components/grouped_reorderable_list_view.dart';
import 'package:shoppinglistapp/models/category.dart';
import 'package:shoppinglistapp/models/food_item.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  // final List<Category> categories = [];

  final Category abort = Category(name: "Abort");
  final Category belkin = Category(name: "Belkin");
  final Category ceta = Category(name: "Ceta");

  @override
  Widget build(BuildContext context) {
    final List<FoodItem> foodlist = [
      FoodItem("HI", abort),
      FoodItem("test", abort),
      FoodItem("thyme", belkin),
      FoodItem("thermemin", belkin),
      FoodItem("2thermemin", belkin),
      FoodItem("3thermemin", belkin),
      FoodItem("Bellini", belkin),
      FoodItem("Gouda", ceta),
      FoodItem("orange", ceta),
      FoodItem("citrus", ceta),
    ];

    return GroupedReorderableListView<FoodItem, Category>(
      elements: foodlist,
      groupBy: (item) => item.category,
      onReorder: (oldIndex, newIndex, targetGroup) {},
      itemBuilder: (context, item) => FoodListTile(title: item.name),
      groupSeparatorBuilder: (context, group) =>
          CategoryListTile(title: group.name),
    );
  }
}
