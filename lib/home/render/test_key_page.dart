import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// 原始说明文档：https://weilu.blog.csdn.net/article/details/104745624
/// 对于有状态的 [StatefulColorfulTile], Row 中的两个 State 的顺序是不变的，所有对应的里面各自的 _Color 也是不变的。所以，点击不会交换颜色。
/// 如果加入两个 key 之后，
/// 对于有状态的 [StatefulColorfulTile],
class TestKeyPage extends StatefulWidget {
  TestKeyPage({
    Key key,
  }) : super(key: key);

  @override
  _TestKeyPageState createState() => _TestKeyPageState();
}

class _TestKeyPageState extends State<TestKeyPage> {
  List<Widget> widgets;
  List<Widget> widgets2;
  List<Widget> widgets3;

  @override
  void initState() {
    super.initState();
    widgets = [StatelessColorfulTile(), StatelessColorfulTile()];
    widgets2 = [StatefulColorfulTile(), StatefulColorfulTile()];

    /// `widgets3` 是 [updateChildren] 函数中的 child 进行了替换。不会再调用 [StatefulColorfulTile] 里面的 build 函数。
    widgets3 = [
      StatefulColorfulTile(
        key: const Key('1'),
      ),
      StatefulColorfulTile(
        key: const Key('2'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test key page'),
      ),
      body: Column(
        children: <Widget>[
//          Row(
//            children: widgets,
//          ),
//          Row(
//            children: widgets2,
//          ),
          Container(
            child: Builder(
              builder: (context) {
                return Row(
                  children: widgets3,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: _swapTile,
      ),
    );
  }

  void _swapTile() {
    setState(() {
      widgets.insert(1, widgets.removeAt(0));
      widgets2.insert(1, widgets2.removeAt(0));
      widgets3.insert(1, widgets3.removeAt(0));
    });
  }
}

/// 有状态的
class StatefulColorfulTile extends StatefulWidget {
  // final Key key;
  StatefulColorfulTile({Key key}) : super(key: key);

  @override
  _StatefulColorfulTileState createState() => _StatefulColorfulTileState();
}

class _StatefulColorfulTileState extends State<StatefulColorfulTile> {
  final Color _color = Utils.randomColor();

  @override
  Widget build(BuildContext context) {
    print('Stateful build');
    return Container(
      height: 150,
      width: 150,
      color: _color,
    );
  }
}

/// 无状态的
class StatelessColorfulTile extends StatelessWidget {
  final Color _color = Utils.randomColor();

  @override
  Widget build(BuildContext context) {
    print('Stateless build');
    return Container(
      height: 150,
      width: 150,
      color: _color,
    );
  }
}

class Utils {
  static Color randomColor() {
    var red = Random.secure().nextInt(255);
    var greed = Random.secure().nextInt(255);
    var blue = Random.secure().nextInt(255);
    return Color.fromARGB(255, red, greed, blue);
  }
}
