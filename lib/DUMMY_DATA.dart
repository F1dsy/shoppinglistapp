import 'package:flutter/material.dart';
import 'package:shoppinglistapp/models/category.dart';
import 'package:shoppinglistapp/models/food_item.dart';

final List<Category> categories = [
  Category(name: "Abort"),
  Category(name: "Belkin", color: Colors.green),
  Category(name: "Ceta", color: Colors.purple),
];

final List<FoodItem> foodItems = [
  FoodItem(name: "Basil", category: categories[0]),
  FoodItem(name: "Oregano", category: categories[0]),
  FoodItem(name: "Thyme", category: categories[0]),
  FoodItem(name: "Thyme", category: categories[1]),
  FoodItem(name: "Thyme", category: categories[1]),
  FoodItem(name: "Thyme", category: categories[1]),
  FoodItem(name: "Thyme", category: categories[2]),
  FoodItem(name: "Thyme", category: categories[2]),
  FoodItem(name: "Thyme", category: categories[2]),
];
