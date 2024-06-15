import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglistapp/models/category.dart';
import 'package:shoppinglistapp/providers/provider.dart';

void showCategoryDialog(BuildContext context, {Category? existingCategory}) {
  showDialog(
      context: context,
      builder: (context) => CategoryDialog(existingCategory: existingCategory));
}

class CategoryDialog extends StatelessWidget {
  CategoryDialog({Key? key, this.existingCategory}) : super(key: key) {
    if (existingCategory is Category) {
      nameController.text = existingCategory!.name;
      colorNotifier.value = existingCategory!.color;
    }
  }

  final Category? existingCategory;

  final TextEditingController nameController = TextEditingController();

  final ValueNotifier<Color> colorNotifier = ValueNotifier(Colors.amber);

  final _formKey = GlobalKey<FormState>();

  bool _save(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (existingCategory is Category) {
        Provider.of<AppProvider>(context, listen: false).updateCategory(
          existingCategory!,
          name: nameController.text,
          color: colorNotifier.value,
        );
      } else {
        Provider.of<AppProvider>(context, listen: false).createCategory(
          Category(
            name: nameController.text,
            color: colorNotifier.value,
          ),
        );
      }
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  existingCategory == null ? "New Category" : "Edit Category",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextFormField(
                    controller: nameController,
                    validator: (value) => value == null || value.isEmpty
                        ? "Please Enter Name"
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ColorPicker(
                    pickerColor: colorNotifier.value,
                    onColorChanged: (value) {
                      colorNotifier.value = value;
                    },
                    enableAlpha: false,
                    pickerAreaBorderRadius: BorderRadius.circular(12),
                    pickerAreaHeightPercent: 0.7,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_save(context)) Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                          ),
                          child: const Text("Add"),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
