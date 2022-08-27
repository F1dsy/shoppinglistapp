import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shoppinglistapp/models/category.dart';

void showCategoryDialog(BuildContext context, {Category? existingCategory}) {
  showDialog(
      context: context,
      builder: (context) => CategoryDialog(existingCategory: existingCategory));
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class CategoryDialog extends StatelessWidget {
  CategoryDialog({Key? key, this.existingCategory}) : super(key: key) {
    if (existingCategory is Category) {
      nameController.text = existingCategory!.name;
      colorController.text = existingCategory!.color.value.toString();
    }
  }

  final Category? existingCategory;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController colorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(existingCategory == null ? "New Category" : "Edit Category"),
      children: [
        TextField(
          controller: nameController,
        ),
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              color: Color.fromRGBO(Random().nextInt(255),
                  Random().nextInt(255), Random().nextInt(255), 1),
            ),
            Flexible(
              child: TextField(
                controller: colorController,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {},
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("Add"),
            )
          ],
        )
      ],
    );
  }
}
