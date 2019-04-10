import 'dart:async';

import 'package:flutter/material.dart';

const List<String> levels = [
  'level1',
  'level2',
  'level3',
];

const String alphabetStr = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

const double marginLeft = 8.0;
const double marginTop = 8.0;
const double mainAxisSpacing = 10.0;
const double crossAxisSpacing = 10.0;
const int crossAxisCount = 3;
const double childAspectRatio = 1.0;

class CustomScrollViewTest2 extends StatefulWidget {
  @override
  _CustomScrollViewTest2State createState() => _CustomScrollViewTest2State();
}

class _CustomScrollViewTest2State extends State<CustomScrollViewTest2> {
  int selectIndex = 0;
  ScrollController _scrollController;
  double threshold1;
  double threshold2;
  GlobalKey globalKey1 = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      _handleScrollOffset(_scrollController.offset);
    });
  }

  void _checkAndCalculateThreshold() {
    if (threshold1 == null) {
      var length = alphabetStr.split('').length;
      var screenWidth = MediaQuery.of(context).size.width;
      var cellWidth = (screenWidth - 2 * marginLeft - mainAxisSpacing * (crossAxisCount - 1)) / crossAxisCount;
      var cellHeight = cellWidth * childAspectRatio;
      threshold1 = (cellHeight + crossAxisSpacing) * (length / crossAxisCount).ceil() + marginTop * 1;
      threshold2 = (cellHeight + crossAxisSpacing) * (length / crossAxisCount).ceil() * 2 + marginTop * 2;
      print('threshold1 = $threshold1, threshold2 = $threshold2, cellWidth = $cellWidth');
    }
  }

  void _handleScrollOffset(double offsetY) {
    _checkAndCalculateThreshold();
    print('offsetY = $offsetY');
    var index = 0;
    if (offsetY >= threshold1 && offsetY < threshold2) {
      index = 1;
    } else if (offsetY >= threshold2) {
      index = 2;
    }
    setState(() {
      selectIndex = index;
    });
  }

  void _handleSelectIndex(int index) {
    print('select index = $index');
    _checkAndCalculateThreshold();
    var durationTime = Duration(milliseconds: 400);
    Timer(durationTime, () {
      setState(() {
        selectIndex = index;
      });
    });
    _scrollController.animateTo(
      threshold1 * index,
      duration: durationTime,
      curve: Curves.easeInOut,
    );
  }

  void _selectCell({int index = 0, int level = 0}) {
    print('_selectCell index=$index, level = $level');
//    final RenderBox object = globalKey1.currentContext.findRenderObject();
//    print('object size = ${object.size}');
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < levels.length; i++) {
      var item = levels[i];
      children.add(AppBarItemWidget(
        text: '$item',
        isSelected: i == selectIndex,
        callback: () {
          _handleSelectIndex(i);
        },
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('test CustomScrollViewTest2'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 40.0,
            width: double.infinity,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: children,
              ),
            ),
          ),
          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                Container(
                  child: SliverBlockWidget(
                    strings: alphabetStr.split(''),
                    callback: (int index) {
                      _selectCell(index: index, level: 0);
                    },
                  ),
                ),
                SliverBlockWidget(
                  strings: alphabetStr.split(''),
                  callback: (int index) {
                    _selectCell(index: index, level: 1);
                  },
                ),
                SliverBlockWidget(
                  strings: alphabetStr.split(''),
                  callback: (int index) {
                    _selectCell(index: index, level: 2);
                  },
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 100.0,
                    color: Colors.blue,
                    width: double.infinity,
                    child: Text('other'),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 100.0,
            color: Colors.red,
            width: double.infinity,
            child: Text('bottom'),
          ),
        ],
      ),
    );
  }
}

typedef SliverBlockWidgetCallback = void Function(int index);

class SliverBlockWidget extends StatelessWidget {
  final List<String> strings;
  final SliverBlockWidgetCallback callback;
  SliverBlockWidget({
    @required this.strings,
    @required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
//      key: key,
      padding: const EdgeInsets.symmetric(horizontal: marginLeft, vertical: marginTop),
      sliver: SliverGrid(
        //Grid
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          childAspectRatio: childAspectRatio,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            var char = strings[index];
            return GestureDetector(
              onTap: () {
                if (callback is SliverBlockWidgetCallback) {
                  callback(index);
                }
              },
              child: Container(
                alignment: Alignment.center,
                color: Colors.cyan,
                child: Text(
                  '${char.toUpperCase()}${char.toLowerCase()}',
                  style: TextStyle(
                    fontSize: 40.0,
                  ),
                ),
                height: 100.0,
              ),
            );
          },
          childCount: alphabetStr.split('').length,
        ),
      ),
    );
  }
}

class AppBarItemWidget extends StatelessWidget {
  final bool isSelected;
  final String text;
  final VoidCallback callback;
  final String elementId;
  AppBarItemWidget({this.isSelected, this.text = '', this.callback, this.elementId});
  @override
  Widget build(BuildContext context) {
    var _selectedColor = Colors.purple;
    return new GestureDetector(
      onTap: callback,
      child: new Container(
        decoration: new BoxDecoration(border: new Border(bottom: BorderSide(color: isSelected ? _selectedColor : Colors.transparent, width: 2.0))),
        height: 80.0,
        child: new Center(
          child: new Text(
            '$text',
            style: TextStyle(
              fontSize: 18.0,
              color: isSelected ? _selectedColor : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
