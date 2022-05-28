import 'package:flutter/material.dart';
import 'package:flutter_paginate/flutter_paginate.dart';

void main() {
  runApp(App());
}

/// item data
class MyItem {
  String name;
  MyItem(this.name);
}

final myItems = [
  MyItem("A"),
  MyItem("B"),
  MyItem("C"),
  MyItem("D"),
  MyItem("E"),
  MyItem("F"),
  MyItem("G"),
  MyItem("H"),
  MyItem("I"),
  MyItem("J"),
  MyItem("K"),
  MyItem("L"),
  MyItem("M"),
  MyItem("N"),
  MyItem("O"),
  MyItem("P"),
  MyItem("Q"),
  MyItem("R"),
  MyItem("S"),
  MyItem("T"),
  MyItem("U"),
  MyItem("V"),
  MyItem("W"),
  MyItem("X"),
  MyItem("Y"),
  MyItem("Z"),
];

/// display a item
Widget buildRow(RowInfo info, MyItem item) {
  // custom row widget
  return SizedBox(
    height: 50,
    child: Card(
      child: Text('Row: ${item.name}'),
    ),
  );
}

///  Your App
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //
        //  Use FlutterPaginate
        // --- --- --- --- --- --- ---
        //
        body: FlutterPaginate(
          allItems: myItems, // put all items
          buildRow: buildRow, // a function buildRow
          itemCountInPage: 4, // item count to display in a page
        ),
        //
        // --- --- --- --- --- --- ---
        //
      ),
    );
  }
}
