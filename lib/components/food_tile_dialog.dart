import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglistapp/models/category.dart';
import 'package:shoppinglistapp/models/food_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shoppinglistapp/providers/provider.dart';

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
    category.value = item.category;
  }
  final FoodItem item;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  late final ValueNotifier<Category> category;

  final InputDecoration inputDecoration = InputDecoration(
    isDense: true,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey)),
  );

  void _saveItem(BuildContext context) {
    Provider.of<AppProvider>(context).updateFoodItem(
      item,
      category: category.value,
      name: nameController.text,
      price: double.parse(priceController.text),
      quantity: double.parse(quantityController.text),
      unit: unitController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: inputDecoration,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 8, bottom: 8),
              child: Text(
                AppLocalizations.of(context)!.price,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: inputDecoration,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 8, bottom: 8),
              child: Text(AppLocalizations.of(context)!.price),
            ),
            DropdownButton<Category>(
              items: Provider.of<AppProvider>(context)
                  .categories
                  .map(
                    (e) => DropdownMenuItem<Category>(child: Text(e.name)),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  category.value = value;
                }
              },
              value: Provider.of<ValueNotifier<Category>>(context).value,
            ),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 8, bottom: 8),
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
                    child: TextField(
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      decoration: inputDecoration,
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      controller: unitController,
                      decoration: inputDecoration,
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
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      // icon: const Icon(Icons.delete),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(16)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      child: const Text("Cancel"),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 8),
                    child: ElevatedButton.icon(
                      label: Text(""),
                      onPressed: () {
                        _saveItem(context);
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.check),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(12)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
