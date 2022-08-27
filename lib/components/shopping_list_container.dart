import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglistapp/components/category_list_tile.dart';
import 'package:shoppinglistapp/components/checkable_food_list_tile.dart';
import 'package:shoppinglistapp/components/grouped_reorderable_list_view.dart';
import 'package:shoppinglistapp/models/category.dart';
import 'package:shoppinglistapp/models/food_item.dart';
import 'package:shoppinglistapp/models/shopping_list.dart';
import 'package:shoppinglistapp/providers/provider.dart';

class ShoppingListContainer extends StatelessWidget {
  const ShoppingListContainer({Key? key, required this.shoppingList})
      : super(key: key);

  final ShoppingList shoppingList;

  @override
  Widget build(BuildContext context) {
    return GroupedReorderableListView<CheckableFoodItem, Category>(
      elements: shoppingList.itemList,
      groupBy: (item) => item.category,
      // groups: categories,
      // groupItems: (group) => group.foodlist,
      onReorder: (oldIndex, newIndex, targetGroup) {
        Provider.of<AppProvider>(context, listen: false)
            .reorderFoodItem(oldIndex, newIndex, targetGroup);
      },
      itemBuilder: (context, item) => CheckableFoodListTile(
        item: item,
      ),
      groupSeparatorBuilder: (context, group) => CategoryListTile(
        title: group.name,
        color: group.color,
      ),
    );
  }
}
