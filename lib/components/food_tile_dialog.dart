import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglistapp/models/category.dart';
import 'package:shoppinglistapp/models/food_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shoppinglistapp/providers/provider.dart';

void showFoodTileDialog(BuildContext context, {FoodItem? item}) {
  showDialog(
    context: context,
    builder: (context) => FoodTileDialog(item: item),
  );
}

class FoodTileDialog extends StatelessWidget {
  FoodTileDialog({Key? key, this.item}) : super(key: key) {
    if (item is FoodItem) {
      nameController.text = item!.name;
      priceController.text = item!.price.toString();
      unitController.text = item!.unit ?? "";
      quantityController.text = item!.quantity.toString();
      categoryNotifier.value = item!.category;
    }
  }
  final FoodItem? item;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final ValueNotifier<Category?> categoryNotifier = ValueNotifier(null);

  final _formKey = GlobalKey<FormState>();

  bool _saveItem(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (item is FoodItem) {
        Provider.of<AppProvider>(context, listen: false).updateFoodItem(
          item!,
          category: categoryNotifier.value,
          name: nameController.text,
          price: double.parse(priceController.text),
          quantity: double.parse(quantityController.text),
          unit: unitController.text,
        );
      } else {
        Provider.of<AppProvider>(context, listen: false).addFoodItem(
          FoodItem(
            name: nameController.text,
            category: categoryNotifier.value ??
                Provider.of<AppProvider>(context, listen: false).categories[0],
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    item == null ? "New Category" : "Edit Category",
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: TextFormField(
                    controller: nameController,
                    validator: (value) => value == null || value.isEmpty
                        ? "Please enter Name"
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 8, bottom: 8),
                  child: Text(AppLocalizations.of(context)!.price),
                ),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value == null || double.tryParse(value) == null
                          ? "Please enter valid Number"
                          : null,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 8, bottom: 8),
                  child: Text(AppLocalizations.of(context)!.categories),
                ),
                InputDecorator(
                  decoration: InputDecoration(
                    constraints: const BoxConstraints(maxHeight: 50),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Category>(
                      items: Provider.of<AppProvider>(context)
                          .categories
                          .map(
                            (e) => DropdownMenuItem<Category>(
                              value: e,
                              child: Text(e.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          categoryNotifier.value = value;
                        }
                      },
                      value: categoryNotifier.value,
                      isExpanded: true,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 8, bottom: 8),
                      child: Text(AppLocalizations.of(context)!.quantity),
                    )),
                    Expanded(
                        child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 16, bottom: 8),
                      child: Text(AppLocalizations.of(context)!.unit),
                    )),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: TextFormField(
                          controller: quantityController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextFormField(
                          controller: unitController,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          right: 8.0,
                        ),
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
                        padding: const EdgeInsets.only(top: 20, left: 8),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_saveItem(context)) Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                          ),
                          child: const Text("Save"),
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
