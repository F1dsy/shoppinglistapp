import 'package:flutter/material.dart';
import 'package:shoppinglistapp/models/category.dart';
import 'package:shoppinglistapp/models/food_item.dart';
import 'package:shoppinglistapp/models/shopping_list.dart';
import '../DUMMY_DATA.dart' as data;

class AppProvider extends ChangeNotifier {
  AppProvider() {
    categories = data.categories;
    _shoppingLists = [
      ShoppingList(name: "List 1"),
      ShoppingList(name: "List 2"),
    ];
  }

  late List<Category> categories = [];

  final List<FoodItem> allFoodItems = [...data.foodItems];

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

  void reorderCategory(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    Category category = categories.removeAt(oldIndex);
    categories.insert(newIndex, category);
  }

  void reorderFoodItem(int oldIndex, int newIndex, Category newCategory) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    CheckableFoodItem item = selectedShoppingList.itemList.removeAt(oldIndex);
    selectedShoppingList.itemList.insert(newIndex, item);
    changeFoodItemGroup(item, newCategory);
  }

  void setFoodItemState(CheckableFoodItem item, bool state) {
    item.isChecked = state;
    notifyListeners();
  }

  void changeFoodItemGroup(FoodItem foodItem, Category newCategory) {
    foodItem.category = newCategory;
    notifyListeners();
  }

  void createCategory(Category category) {
    categories.add(category);
    notifyListeners();
  }

  void addFoodItem(FoodItem item) {
    allFoodItems.add(item);
    notifyListeners();
  }

  void updateFoodItem(
    FoodItem item, {
    String? name,
    Category? category,
    double? price,
    double? quantity,
    String? unit,
  }) {
    if (category != null) item.category = category;
    if (name != null) item.name = name;
    if (price != null) item.price = price;
    if (quantity != null) item.quantity = quantity;
    item.unit = unit;
    notifyListeners();
  }

  void updateCategory(
    Category category, {
    String? name,
    Color? color,
  }) {
    if (name != null) category.name = name;
    if (color != null) category.color = color;
    notifyListeners();
  }
}
