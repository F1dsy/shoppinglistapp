import 'package:flutter/material.dart';

class Category {
  Category({
    required this.name,
    this.color = Colors.amber,
    // required this.foodlist,
  });

  String name;
  Color color;
  // List<FoodItem> foodlist;
}
