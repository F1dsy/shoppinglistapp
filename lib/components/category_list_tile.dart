import 'package:flutter/material.dart';

class CategoryListTile extends StatelessWidget {
  const CategoryListTile({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ListTile(
        onTap: () {},
        title: Text(
          title.toUpperCase(),
          style: TextStyle(color: color),
        ),
        dense: true,
      ),
    );
  }
}
