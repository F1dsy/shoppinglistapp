import 'package:shoppinglistapp/models/category.dart';

class FoodItem {
  FoodItem({
    required this.name,
    required this.category,
    this.price = 0.00,
    this.quantity = 1,
  });

  String name;
  Category category;
  double price;
  double quantity;
  String? unit;
}

class CheckableFoodItem extends FoodItem {
  CheckableFoodItem({
    required name,
    required category,
    this.isChecked = false,
  }) : super(name: name, category: category);
  bool isChecked;
}
