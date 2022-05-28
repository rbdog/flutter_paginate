//
//
//

import 'package:flutter/material.dart';
import 'package:flutter_paginate/src/paginate_notifier.dart';
import 'package:flutter_paginate/src/row_info.dart';

/// Paginate Body
class PaginateBody<ItemType> extends StatelessWidget {
  /// items for this page
  final List<ItemType> items;

  /// the first item index in all items
  final int firstItemIndexInAllItems;

  /// Widget to display for an item
  final Widget Function(RowInfo info, ItemType item) buildRow;

  const PaginateBody({
    Key? key,
    required PaginateNotifier notifier,
    required this.items,
    required this.buildRow,
    required this.firstItemIndexInAllItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return buildRow(
            RowInfo(firstItemIndexInAllItems + index, index),
            items[index],
          );
        },
      ),
    );
  }
}
