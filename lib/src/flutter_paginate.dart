//
//
//

import 'package:flutter/material.dart';
import 'package:flutter_paginate/src/paginate_bar.dart';
import 'package:flutter_paginate/src/paginate_body.dart';
import 'package:flutter_paginate/src/paginate_notifier.dart';
import 'package:flutter_paginate/src/paginate_state.dart';
import 'package:flutter_paginate/src/provider.dart';
import 'package:flutter_paginate/src/row_info.dart';

/// FlutterPaginate
class FlutterPaginate<ItemType> extends StatelessWidget {
  final PaginateNotifier _notifier;

  /// all items over the all pages
  final List<ItemType> allItems;

  /// widget builder for an item
  final Widget Function(RowInfo info, ItemType item) buildRow;

  /// items count in a page
  final int itemCountInPage;

  /// how many page-buttons displayed
  final int displayedPageButtonCount;

  /// width for page buttons
  final double paginateBarWidth;

  /// height for page buttons
  final double paginateBarHeight;

  /// builder for back button
  final Widget Function()? backButton;

  /// builder for page button
  final Widget Function(int pageIndex, bool isSelected)? pageButton;

  /// builder for next button
  final Widget Function()? nextButton;

  /// Constructor
  FlutterPaginate({
    Key? key,
    required this.allItems,
    required this.buildRow,
    required this.itemCountInPage,
    this.displayedPageButtonCount = 5,
    this.paginateBarWidth = 400,
    this.paginateBarHeight = 92,
    this.backButton,
    this.pageButton,
    this.nextButton,
  })  : _notifier = PaginateNotifier(PaginateState(0)),
        super(key: key);

  List<ItemType> _items() {
    final startIndex = _notifier.state.selectedPage * itemCountInPage;
    var endIndex = (_notifier.state.selectedPage + 1) * itemCountInPage;
    if (endIndex > allItems.length) {
      endIndex = allItems.length;
    }
    return allItems.sublist(startIndex, endIndex);
  }

  int _firstItemIndex() {
    return _notifier.state.selectedPage * itemCountInPage;
  }

  int _allPageCount() {
    return (allItems.length / itemCountInPage).ceil();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ChangeNotifierProvider(
      create: (context) {
        return _notifier;
      },
      child: Consumer<PaginateNotifier>(
        builder: (context, notifier, _) {
          return Column(
            children: [
              PaginateBody(
                notifier: _notifier,
                items: _items(),
                buildRow: buildRow,
                firstItemIndexInAllItems: _firstItemIndex(),
              ),
              PaginateBar(
                notifier: _notifier,
                allPageCount: _allPageCount(),
                pageButtonCount: displayedPageButtonCount,
                width: paginateBarWidth,
                height: paginateBarHeight,
                backButton: backButton,
                pageButton: pageButton,
                nextButton: nextButton,
              )
            ],
          );
        },
      ),
    );
    return provider;
  }
}
