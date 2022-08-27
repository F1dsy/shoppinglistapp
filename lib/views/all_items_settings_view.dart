import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglistapp/components/category_dialog.dart';
import 'package:shoppinglistapp/components/category_list_tile.dart';
import 'package:shoppinglistapp/components/food_list_tile.dart';
import 'package:shoppinglistapp/components/grouped_reorderable_list_view.dart';
import 'package:shoppinglistapp/models/category.dart';
import 'package:shoppinglistapp/models/food_item.dart';
import 'package:shoppinglistapp/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllItemsSettingsView extends StatelessWidget {
  const AllItemsSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<FoodItem> allItems = Provider.of<AppProvider>(context).allFoodItems;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.allFoodItems),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: GroupedReorderableListView<FoodItem, Category>(
        elements: allItems,
        prototypeItem: const ListTile(),
        itemBuilder: (context, item) => FoodListTile(
          item: item,
        ),
        onReorder: (oldIndex, newIndex, targetCategory) {
          Provider.of<AppProvider>(context)
              .reorderFoodItem(oldIndex, newIndex, targetCategory);
        },
        groupBy: (item) => item.category,
        groupSeparatorBuilder: (context, group) =>
            CategoryListTile(title: group.name, color: group.color),
      ),
    );
  }
}
