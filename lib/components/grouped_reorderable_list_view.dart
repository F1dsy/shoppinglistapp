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
    this.sort = true,
    this.groupComparator,
    this.itemComparator,
    this.primary,
    this.itemExtent,
    this.proxyDecorator,
    this.padding,
    this.prototypeItem,
  }) : super(key: key);

  final List<Item> elements;
  final Group Function(Item item) groupBy;
  final Function(int oldIndex, int newIndex, Group targetGroup) onReorder;
  final Widget Function(BuildContext context, Item item) itemBuilder;
  final Widget Function(BuildContext context, Group group)
      groupSeparatorBuilder;

  final bool sort;
  final int Function(Group value1, Group value2)? groupComparator;
  final int Function(Item element1, Item element2)? itemComparator;

  final bool? primary;
  final double? itemExtent;
  final Widget Function(Widget, int, Animation<double>)? proxyDecorator;
  final EdgeInsets? padding;
  final Widget? prototypeItem;

  @override
  State<GroupedReorderableListView<Item, Group>> createState() =>
      _GroupedReorderableListViewState<Item, Group>();
}

class _GroupedReorderableListViewState<Item, Group>
    extends State<GroupedReorderableListView<Item, Group>> {
  final LinkedHashMap<String, GlobalKey> _keys = LinkedHashMap();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List elements = [];
    List<int> indexOfGroups = [];

    _generateElements() {
      elements = [];

      for (var i = 0; i < widget.elements.length; i++) {
        if (i == 0) {
          indexOfGroups.add(0);
          elements.add(widget.groupBy(widget.elements[i]));
        } else {
          var curr = widget.groupBy(widget.elements[i]);
          var prev = widget.groupBy(widget.elements[i - 1]);

          if (prev != curr) {
            indexOfGroups.add(elements.length);
            elements.add(widget.groupBy(widget.elements[i]));
          }
        }

        elements.add(widget.elements[i]);
      }
    }

    _generateElements();

    onReorder(int oldIndex, int newIndex) {
      setState(() {
        // final item = elements.removeAt(oldIndex);
        // elements.insert(newIndex, item);

        int i = 1;
        while (elements[newIndex - i] is! Group) {
          i++;
        }

        int groupIndex = indexOfGroups.lastWhere((x) => x < newIndex);
        int newIndex2 =
            newIndex - indexOfGroups.takeWhile((x) => x < newIndex).length;
        int oldIndex2 =
            oldIndex - indexOfGroups.takeWhile((x) => x < oldIndex).length;

        widget.onReorder(oldIndex2, newIndex2, elements[groupIndex]);
        // _generateElements();
      });
    }

    Widget _buildItem(BuildContext context, int index) {
      return widget.itemBuilder(context, elements[index]);
    }

    Widget _buildGroupSeparator(BuildContext context, int index) {
      return widget.groupSeparatorBuilder(context, elements[index]);
    }

    Widget itemBuilder(BuildContext context, int index) {
      Key key = _keys.putIfAbsent('$index', () => GlobalKey());
      KeyedSubtree _keyedSubtree(child) => KeyedSubtree(
            key: key,
            child: child,
          );
      final element = elements[index];

      if (element is Item) {
        return _keyedSubtree(_buildItem(context, index));
      }
      if (element is Group) {
        return _keyedSubtree(_buildGroupSeparator(context, index));
      }
      return const SizedBox.shrink();
    }

    return ReorderableListView.builder(
      key: widget.key,
      itemBuilder: itemBuilder,
      itemCount: elements.length,
      onReorder: onReorder,
      itemExtent: widget.itemExtent,
      primary: widget.primary,
      proxyDecorator: widget.proxyDecorator,
      padding: widget.padding,
      prototypeItem: widget.prototypeItem,
      // children: ,
    );
  }
}
