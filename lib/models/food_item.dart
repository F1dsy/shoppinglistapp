import 'package:shoppinglistapp/models/category.dart';

class FoodItem {
  FoodItem({
    required this.name,
    required this.category,
  });

  String name;
  double? price;
  double? quantity;
  String? unit;
  Category category;
}

class CheckableFoodItem extends FoodItem {
  CheckableFoodItem({
    required name,
    required category,
    this.isChecked = false,
  }) : super(name: name, category: category);
  bool isChecked;
}
