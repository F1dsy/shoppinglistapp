import 'package:shoppinglistapp/models/food_item.dart';
import 'package:shoppinglistapp/DUMMY_DATA.dart';

class ShoppingList {
  ShoppingList({required this.name});

  final String name;

  List<CheckableFoodItem> itemList = [...checkableFoodItems];
  List<CheckableFoodItem> checkedItems = [];
}
