import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglistapp/models/food_item.dart';
import 'package:shoppinglistapp/providers/provider.dart';

class CheckableFoodListTile extends StatelessWidget {
  const CheckableFoodListTile({
    Key? key,
    required this.item,
  }) : super(key: key);
  final CheckableFoodItem item;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      secondary: const Icon(Icons.drag_indicator),
      value: item.isChecked,
      onChanged: (value) {
        if (value != null) {
          Provider.of<AppProvider>(context, listen: false)
              .setFoodItemState(item, value);
        }
      },
      checkboxShape: const CircleBorder(),
      side: BorderSide(color: item.category.color, width: 2),
      title: Text(item.name),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
