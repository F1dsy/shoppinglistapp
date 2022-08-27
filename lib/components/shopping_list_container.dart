import 'package:flutter/material.dart';
import 'package:shoppinglistapp/components/category_list_tile.dart';
import 'package:shoppinglistapp/components/food_list_tile.dart';
import 'package:shoppinglistapp/components/grouped_reorderable_list_view.dart';
import 'package:shoppinglistapp/models/category.dart';
import 'package:shoppinglistapp/models/food_item.dart';
import 'package:shoppinglistapp/models/shopping_list.dart';

class ShoppingListContainer extends StatefulWidget {
  const ShoppingListContainer({Key? key, required this.shoppingList})
      : super(key: key);

  final ShoppingList shoppingList;
  @override
  State<ShoppingListContainer> createState() => _ShoppingListContainerState();
}

class _ShoppingListContainerState extends State<ShoppingListContainer> {
  changeFoodItemGroup(FoodItem foodItem, Category newCategory) {
    foodItem.category = newCategory;
    setState(() {});
  }

  late List<FoodItem> foodlist;

  @override
  void initState() {
    foodlist = widget.shoppingList.foodList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GroupedReorderableListView<FoodItem, Category>(
      elements: foodlist,
      groupBy: (item) => item.category,
      // groups: categories,
      // groupItems: (group) => group.foodlist,
      onReorder: (oldIndex, newIndex, targetGroup) {
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }
        FoodItem item = foodlist.removeAt(oldIndex);
        foodlist.insert(newIndex, item);
        changeFoodItemGroup(item, targetGroup);
      },
      itemBuilder: (context, item) => FoodListTile(
        item: item,
      ),
      groupSeparatorBuilder: (context, group) => CategoryListTile(
        title: group.name,
        color: group.color,
      ),
    );
  }
}
