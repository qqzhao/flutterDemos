import 'package:flutter/material.dart';

class TestCustomScrollView extends StatefulWidget {
  @override
  _TestCustomScrollViewState createState() => _TestCustomScrollViewState();
}

class _TestCustomScrollViewState extends State<TestCustomScrollView> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('test custom scrollview'),
      ),
      body: new CustomScrollView(
        ///slivers内:放置多个碎片，需要注意的是我们只能使用下面这三种:
        ///[SliverAppBar]， [SliverList]或[SliverFixedExtentList]，[SliverGrid]
        ///SliverAppBar:用于actionbar展示伸展缩放动画
        ///SliverList或SliverFixedExtentList:展示列表数据的
        ///SliverGrid展示网格列表数据的
        ///
        ///SliverList和SliverFixedExtentList比较:
        ///如果子类在主轴上有固定的范围，则考虑使用[SliverFixedExtentList]而不是[SliverList]
        ///因为[SliverFixedExtentList]不需要对其子类执行布局就能在主轴上获得它们的范围区间大小，
        ///因此更有效率.
        slivers: <Widget>[
          ///AppBar
          new SliverAppBar(
              //列表在滚动的时候appbar是否一直保持可见
              pinned: true,
              expandedHeight: 150.0,
              //flexibleSpace高度和appbar高度一致
              //FlexibleSpaceBar:一个灵活空间控制appbar扩展和伸缩
              flexibleSpace: const FlexibleSpaceBar(
                title: Text('SliverAppBar'),
                //centerTitle值表示:appbar缩回去之后是否居中展示title
                centerTitle: true,
                //背景,final Widget background;
                //我们要使用的Image对象必须是const声明的常量对象,对象不可变
                background: Image(
                  image: AssetImage("images/lake.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              actions: <Widget>[
                new IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  tooltip: 'Search',
                  onPressed: () {
                    /* search content */
                  },
                ),
              ]),

          ///SliverList或SliverFixedExtentList
          new SliverFixedExtentList(
              delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  //构建一个测试列表
                  return new Container(
                    alignment: Alignment.center,
                    color: Colors.blueGrey,
                    child: new Text(
                      'SliverFixedExtentList',
                      textAlign: TextAlign.center,
                    ),
                  );
                },
                childCount: 1,
              ),

              ///强制孩子在滚动方向上有指定的范围
              ///指定itemExtent比让孩子确定自己的范围更有效率
              itemExtent: 200.0),

          ///SliverGrid
          new SliverGrid(
              delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  ///这里实现自己的gridItem即可
                  return new Container(
                    alignment: Alignment.center,
                    color: Colors.teal[100 * (index % 9)],
                    child: new Text('grid item $index'),
                  );
                },
                childCount: 18,
              ),

              ///委托item都是最大范围
              gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                //均匀划分网格范围,范围最多为maxCrossAxisExtent的值
                //example:如果网格是垂直的，网格为500.0像素宽，
                //并且[maxCrossAxisExtent]为150.0（将要划分的网格范围最多不超过150）
                //此委托将创建一个网格，其中4列宽为125.0像素。
                maxCrossAxisExtent: 180.0,
                //主轴,横向,item之间的间距
                mainAxisSpacing: 1.0,
                //纵轴,item之间的间距
                crossAxisSpacing: 4.0,
                //宽/高的比例
                childAspectRatio: 1.0,
              )),
        ],
      ),
    );
  }
}

/// https://zhuanlan.zhihu.com/p/38704931
