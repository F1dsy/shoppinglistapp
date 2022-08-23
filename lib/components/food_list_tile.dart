import 'package:flutter/material.dart';

class FoodListTile extends StatelessWidget {
  const FoodListTile({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: CheckboxListTile(
        value: false,
        onChanged: (value) {},
        checkboxShape: const CircleBorder(
          side: BorderSide(width: 2),
        ),
        title: Text(title),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
