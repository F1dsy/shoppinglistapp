import 'package:flutter/material.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TopAppBar({
    Key? key,
    required this.title,
    this.popUpActions,
  }) : super(key: key);

  final String title;
  final Map<String, Function>? popUpActions;

  @override
  get preferredSize {
    return const Size.fromHeight(60);
  }

  @override
  Widget build(BuildContext context) {
    // AppBarTheme appBarTheme = AppBarTheme.of(context);
    // print(appBarTheme.titleTextStyle.toStringShort());

    return SafeArea(
        child: SizedBox(
      height: preferredSize.height,
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
            if (popUpActions != null)
              PopupMenuButton(
                onSelected: (value) {
                  (popUpActions![value] ?? () {})();
                },
                itemBuilder: (context) => popUpActions!.keys
                    .map((String choice) => PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        ))
                    .toList(),
                icon: const Icon(Icons.more_vert),
              ),
          ],
        ),
      ),
    ));
  }
}
