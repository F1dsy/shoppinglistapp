import 'package:shoppinglistapp/models/category.dart';
import 'package:shoppinglistapp/models/food_item.dart';

class ShoppingList {
  ShoppingList({this.name = "", required this.categories});

  final List<Category> categories;

  final String name;
  List<FoodItem> get foodList {
    return [
      FoodItem(name: "HI", category: categories[0]),
      FoodItem(name: "thermemin", category: categories[0]),
      FoodItem(name: "test", category: categories[0]),
      FoodItem(name: "thyme", category: categories[1]),
      FoodItem(name: "3thermemin", category: categories[1]),
      FoodItem(name: "Bellini", category: categories[1]),
      FoodItem(name: "Gouda", category: categories[1]),
      FoodItem(name: "orange", category: categories[2]),
      FoodItem(name: "2thermemin", category: categories[2]),
      FoodItem(name: "citrus", category: categories[2]),
    ];
  }

  List<FoodItem> itemList = [];
  List<FoodItem> checkedItems = [];

  void checkItem(FoodItem item) {
    itemList.remove(item);
    checkedItems.add(item);
  }
}
