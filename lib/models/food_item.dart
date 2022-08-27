import 'package:shoppinglistapp/models/category.dart';

class FoodItem {
  FoodItem(
      {required this.name, required this.category, this.isChecked = false});

  String name;
  Category category;
  bool isChecked;
}
