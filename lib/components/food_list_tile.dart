import 'package:flutter/material.dart';
import 'package:shoppinglistapp/components/food_tile_dialog.dart';
import 'package:shoppinglistapp/models/food_item.dart';

class FoodListTile extends StatelessWidget {
  const FoodListTile({
    Key? key,
    required this.item,
  }) : super(key: key);
  final FoodItem item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: const Icon(Icons.drag_indicator),
      title: Text(item.name),
      onTap: () {
        showFoodTileDialog(context, item);
      },
    );
  }
}
