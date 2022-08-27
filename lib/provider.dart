import 'package:flutter/material.dart';
import 'package:shoppinglistapp/models/category.dart';
import 'package:shoppinglistapp/models/food_item.dart';
import 'package:shoppinglistapp/models/shopping_list.dart';
import 'DUMMY_DATA.dart' as data;

class AppProvider extends ChangeNotifier {
  AppProvider() {
    categories = data.categories;
    _shoppingLists = [
      ShoppingList(name: "List 1", categories: categories),
      ShoppingList(name: "List 2", categories: categories),
    ];
  }

  late List<Category> categories = [];

  final List<FoodItem> allFoodItems = [];

  late List<ShoppingList> _shoppingLists = [];

  int _selectedShoppingListIndex = 0;

  ShoppingList get selectedShoppingList {
    return _shoppingLists[_selectedShoppingListIndex];
  }

  set selectedShoppingList(ShoppingList shoppingList) {
    _selectedShoppingListIndex = _shoppingLists.indexOf(shoppingList);
    notifyListeners();
  }

  List<ShoppingList> get shoppingLists {
    return _shoppingLists;
  }

  void reorderCategory(oldIndex, newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    Category category = categories.removeAt(oldIndex);
    categories.insert(newIndex, category);
  }

  void setFoodItemState(FoodItem item, bool state) {
    item.isChecked = state;
    notifyListeners();
  }
}
