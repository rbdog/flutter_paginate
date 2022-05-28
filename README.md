![Header](https://github.com/rbdog/flutter_paginate/blob/main/resources/images/flutter-paginate-header.png?raw=true)

# Flutter Paginate

https://pub.dev/packages/flutter_paginate

<br>
<br>

## Usage

### 1. Prepare data items

```
class MyItem {...}

final myItems = [
  MyItem(),
  MyItem(),
  MyItem(),
  ...
  MyItem(),
];
```

### 2. Widget for each item

```
Widget buildRow(RowInfo info, MyItem item) {
  // return widget to display
}
```

### 3. use FlutterPaginate widget

```
FlutterPaginate(
  allItems: myItems,
  buildRow: buildRow,
  itemCountInPage: 4,
)
```

<br>
<br>

## FlutterPaginate(...) constructor

| [ param ]                | [ discription ]                         |
| ------------------------ | --------------------------------------- |
| **allItems***            | all items over the all pages            |
| **buildRow***            | widget builder for an item              |
| **itemCountInPage***     | items count in a page                   |
| displayedPageButtonCount | how many page-buttons displayed at once |
| paginateBarWidth         | width for page buttons                  |
| paginateBarHeight        | height for page buttons                 |
| backButton               | builder for back button                 |
| pageButton               | builder for page button                 |
| nextButton               | builder for next button                 |

<br>
<br>

🎉 any issues, requests, contributions are welcomed!

<br>
