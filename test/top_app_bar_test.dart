import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shoppinglistapp/components/top_app_bar.dart';

void main() {
  testWidgets("description", (widgetTester) async {
    widgetTester.pumpWidget(
      const MaterialApp(
        home: TopAppBar(title: "Title"),
      ),
    );
  });
}
