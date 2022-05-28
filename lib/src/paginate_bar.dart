//
//
//

import 'package:flutter/material.dart';
import 'package:flutter_paginate/src/paginate_notifier.dart';
import 'package:flutter_paginate/src/paginate_state.dart';

/// Paginate Bar
class PaginateBar extends StatelessWidget {
  final PaginateNotifier _notifier;
  final int allPageCount;
  final int pageButtonCount;
  final double width;
  final double height;
  final Widget Function()? backButton;
  final Widget Function(int pageIndex, bool isSelected)? pageButton;
  final Widget Function()? nextButton;

  const PaginateBar({
    Key? key,
    required PaginateNotifier notifier,
    required this.allPageCount,
    required this.pageButtonCount,
    required this.width,
    required this.height,
    this.backButton,
    this.pageButton,
    this.nextButton,
  })  : _notifier = notifier,
        super(key: key);

  List<int> pageIndexes(PaginateNotifier notifier) {
    // 今自分がいるページだけ入った配列
    final indexes = [notifier.state.selectedPage];
    // 十分な数になるまで先頭と末尾に付け足していく
    while (true) {
      // このループで配列要素を付け足したかどうか
      var add = false;
      final first = indexes.first;
      if (first - 1 >= 0) {
        // 先頭に付け足せる場合
        indexes.insert(0, first - 1);
        add = true;
      }
      if (indexes.length >= pageButtonCount) {
        // 十分な数になったら終了
        break;
      }
      final last = indexes.last;
      if (last + 1 < allPageCount) {
        // 末尾に付け足せる場合
        indexes.add(last + 1);
        add = true;
      }
      if (indexes.length >= pageButtonCount) {
        // 十分な数になったら終了
        break;
      }
      if (!add) {
        // もうこれ以上付け足せなくなったら十分な要素がなくても終了
        break;
      }
    }
    return indexes;
  }

  Widget _backButton() {
    final canBack = _notifier.state.selectedPage > 0;
    final textColor = canBack ? Colors.blue : Colors.transparent;
    Widget child = Text(
      '<Back',
      style: TextStyle(color: textColor),
    );
    if (backButton != null) {
      child = backButton!();
    }
    return TextButton(
      onPressed: canBack ? () => onPressedBack() : null,
      child: child,
    );
  }

  Widget _pageButton(int pageIndex, bool isSelected) {
    Widget child = Text(
      '$pageIndex',
      style: TextStyle(color: isSelected ? Colors.white : Colors.blue),
    );
    if (pageButton != null) {
      child = pageButton!(pageIndex, isSelected);
    }
    final buttonColor = isSelected ? Colors.blue : Colors.transparent;
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
      ),
      onPressed: () => onPressedPage(pageIndex),
      child: child,
    );
  }

  Widget _nextButton() {
    final canNext = _notifier.state.selectedPage + 1 < allPageCount;
    final textColor = canNext ? Colors.blue : Colors.transparent;
    Widget child = Text(
      'Next>',
      style: TextStyle(color: textColor),
    );
    if (nextButton != null) {
      child = backButton!();
    }
    return TextButton(
      onPressed: canNext ? () => onPressedNext() : null,
      child: child,
    );
  }

  onPressedBack() {
    final newState = PaginateState(_notifier.state.selectedPage - 1);
    _notifier.update(newState);
  }

  onPressedPage(int pageIndex) {
    final newState = PaginateState(pageIndex);
    _notifier.update(newState);
  }

  onPressedNext() {
    final newState = PaginateState(_notifier.state.selectedPage + 1);
    _notifier.update(newState);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Row(
        children: [
          // Back
          _backButton(),
          // Pages
          for (final pageIndex in pageIndexes(_notifier))
            _pageButton(pageIndex, _notifier.state.selectedPage == pageIndex),
          // Next
          _nextButton(),
        ],
      ),
    );
  }
}
