import 'package:flutter/material.dart';
import 'package:shoppinglistapp/models/food_item.dart';

void showFoodTileDialog(BuildContext context, FoodItem item) {
  showDialog(
    context: context,
    builder: (context) => FoodTileDialog(item: item),
  );
}

class FoodTileDialog extends StatelessWidget {
  FoodTileDialog({Key? key, required this.item}) : super(key: key) {
    nameController.text = item.name;
    priceController.text = item.price.toString();
    unitController.text = item.unit ?? "";
    quantityController.text = item.quantity.toString();
  }
  final FoodItem item;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: TextField(
        controller: nameController,
      ),
      children: [
        TextField(
          controller: quantityController,
        ),
        TextField(
          controller: priceController,
        ),
        TextField(
          controller: unitController,
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.delete)),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.check))
          ],
        ),
      ],
    );
  }
}
