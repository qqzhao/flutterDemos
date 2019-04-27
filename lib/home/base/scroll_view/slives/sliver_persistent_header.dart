import 'dart:math' as math;

import 'package:flutter/material.dart';

class SliverPersistentHeaderPage extends StatefulWidget {
  @override
  _SliverPersistentHeaderPageState createState() => _SliverPersistentHeaderPageState();
}

class _SliverPersistentHeaderPageState extends State<SliverPersistentHeaderPage> {
  bool _floating = false;
  bool _pinned = true;

  var children = [1, 2, 3, 4, 5, 6, 7, 8]
      .map(
        (item) => Container(
              width: 80.0,
              height: 80.0,
              color: Colors.red,
              child: Text('index = $item'),
            ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test Sliver FillViewport Page'),
      ),
      body: Center(
        child: SizedBox(
          width: 200.0,
          height: 400.0,
          child: Container(
            color: Colors.red,
            child: CustomScrollView(
//              reverse: true, /// 会以下边距为基线。
//              shrinkWrap: true, /// 不能设置，设置就有点乱套。
              slivers: <Widget>[
                SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  sliver: SliverPersistentHeader(
                    pinned: _pinned,
                    floating: _floating,
                    delegate: _SliverPersistentHeaderDelegate(
                      minHeight: 60.0,
                      maxHeight: 100.0,
                      child: Container(
                        color: Colors.purple,
                        child: Center(
                          child: Text('header content....11'),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverList(delegate: SliverChildListDelegate(children)),
                SliverPersistentHeader(
                  pinned: _pinned,
                  floating: _floating,
                  delegate: _SliverPersistentHeaderDelegate(
                    minHeight: 60.0,
                    maxHeight: 100.0,
                    child: Container(
                      color: Colors.blue,
                      child: Center(
                        child: Text('header content....22'),
                      ),
                    ),
                  ),
                ),
                SliverList(delegate: SliverChildListDelegate(children)),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _floating = !_floating;
              });
            },
            child: Text('floating'),
            heroTag: 'floating1',
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _pinned = !_pinned;
              });
            },
            heroTag: 'floating2',
            child: Text('pinned'),
          ),
        ],
      ),
    );
  }
}

class _SliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  _SliverPersistentHeaderDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    print('shrinkOffset = $shrinkOffset');
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
  }
}
