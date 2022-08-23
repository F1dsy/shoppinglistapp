import 'package:flutter/material.dart';

class CategoryListTile extends StatelessWidget {
  const CategoryListTile({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title.toUpperCase()),
      dense: true,
    );
  }
}
