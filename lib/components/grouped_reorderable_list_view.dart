import 'dart:collection';

import 'package:flutter/material.dart';

class GroupedReorderableListView<Item, Group> extends StatefulWidget {
  const GroupedReorderableListView({
    Key? key,
    required this.elements,
    required this.groupBy,
    required this.onReorder,
    required this.itemBuilder,
    required this.groupSeparatorBuilder,
  }) : super(key: key);

  final List<Item> elements;
  final Group Function(Item item) groupBy;
  final Function(int oldIndex, int newIndex, Group targetGroup) onReorder;
  final Widget Function(BuildContext context, Item item) itemBuilder;
  final Widget Function(BuildContext context, Group group)
      groupSeparatorBuilder;

  @override
  State<GroupedReorderableListView<Item, Group>> createState() =>
      _GroupedReorderableListViewState<Item, Group>();
}

class _GroupedReorderableListViewState<Item, Group>
    extends State<GroupedReorderableListView<Item, Group>> {
  final LinkedHashMap<String, GlobalKey> _keys = LinkedHashMap();
  List<Widget> elements = [];

  @override
  void initState() {
    for (var i = 0; i < widget.elements.length * 2; i++) {
      elements.add(itemBuilder(context, i));
    }
    super.initState();
  }

  onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final Widget item = elements.removeAt(oldIndex);
      elements.insert(newIndex, item);
      print(oldIndex.toString());
      print(newIndex.toString());
    });
  }

  Function isSepatator = (int i) => i.isEven;

  Widget _buildItem(BuildContext context, int index) {
    return widget.itemBuilder(context, widget.elements[index]);
  }

  Widget _buildGroupSeparator(BuildContext context, int index) {
    return widget.groupSeparatorBuilder(
        context, widget.groupBy(widget.elements[index]));
  }

  Widget itemBuilder(BuildContext context, int index) {
    int realIndex = index ~/ 2;
    final key = _keys.putIfAbsent('$index', () => GlobalKey());
    KeyedSubtree keyedSubtree(child) => KeyedSubtree(
          key: key,
          child: child,
        );
    if (index == 0) {
      return keyedSubtree(_buildGroupSeparator(context, realIndex));
    }
    if (isSepatator(index)) {
      var curr = widget.groupBy(widget.elements[realIndex]);
      var prev = widget.groupBy(widget.elements[realIndex - 1]);
      if (prev != curr) {
        return keyedSubtree(_buildGroupSeparator(context, realIndex));
      }
      return keyedSubtree(const SizedBox.shrink());
    }
    return keyedSubtree(_buildItem(context, realIndex));
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      key: widget.key,
      // itemBuilder: itemBuilder,
      // itemCount: widget.elements.length * 2,
      onReorder: onReorder,
      children: elements,
    );
  }
}
