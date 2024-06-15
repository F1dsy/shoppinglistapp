// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shoppinglistapp/models/category.dart';
import 'package:shoppinglistapp/models/food_item.dart';

final List<Category> categories = [
  Category(name: "Abort", color: Colors.amber),
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

final List<CheckableFoodItem> checkableFoodItems = [
  CheckableFoodItem(name: "Basil", category: categories[0]),
  CheckableFoodItem(name: "Oregano", category: categories[0]),
  CheckableFoodItem(name: "Thyme", category: categories[0]),
  CheckableFoodItem(name: "Thyme", category: categories[1]),
  CheckableFoodItem(name: "Thyme", category: categories[1]),
  CheckableFoodItem(name: "Thyme", category: categories[1]),
  CheckableFoodItem(name: "Thyme", category: categories[2]),
  CheckableFoodItem(name: "Thyme", category: categories[2]),
  CheckableFoodItem(name: "Thyme", category: categories[2]),
];
