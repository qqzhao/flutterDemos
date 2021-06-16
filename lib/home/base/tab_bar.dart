import 'dart:async';

import 'package:flutter/material.dart';

GlobalKey _globalKey = GlobalKey();

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key key}) : super(key: key);

  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> with SingleTickerProviderStateMixin {
  TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, initialIndex: 0, vsync: this);
    _controller.addListener(_controllerHandler);
  }

  void _controllerHandler() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: AutomaticKeepAlive(
    //     child: KeepAlive(
    //       keepAlive: true,
    //       child: Container(
    //         // child: _WrapNoRefreshWidget(child: _TestOne()),
    //         width: 100,
    //         height: 100,
    //         color: Colors.yellow,
    //       ),
    //     ),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    //         return Scaffold(
    //           appBar: AppBar(
    //             title: Text('aaa'),
    //           ),
    //         );
    //       }));
    //     },
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        title: Text('tarBar'),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            child: TabBarView(
              controller: _controller,
              children: [
                Container(
                  color: Colors.black,
                  child: _TestOne(
                    child: _WrapNoRefreshWidget(
                      child: Text('123'),
                    ),
                  ),
                ),
                Container(
                  color: Colors.red,
                ),
                Container(
                  key: _globalKey,
                  color: Colors.blue,
                  child: _TestOne(),
                ),
              ],
            ),
          )),
          Container(
            height: 80,
            child: TabBar(
              controller: _controller,
              tabs: [
                Tab(
                  text: '111',
                ),
                Tab(
                  text: '222',
                ),
                Tab(
                  text: '333',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WrapNoRefreshWidget extends StatefulWidget {
  final Widget child;
  const _WrapNoRefreshWidget({Key key, this.child}) : super(key: key);

  @override
  __WrapNoRefreshWidgetState createState() => __WrapNoRefreshWidgetState();
}

class __WrapNoRefreshWidgetState extends State<_WrapNoRefreshWidget> with AutomaticKeepAliveClientMixin {
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}

class _TestOne extends StatefulWidget {
  final Widget child;
  const _TestOne({Key key, this.child}) : super(key: key);

  @override
  __TestOneState createState() => __TestOneState();
}

class __TestOneState extends State<_TestOne> {
  int a = 0;
  Timer _timer;
  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      a++;
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text(
            'a = $a',
            style: TextStyle(color: Colors.red),
          ),
        ),
        if (widget.child != null) widget.child,
      ],
    );
  }
}

// ignore: unused_element
class _ColumnWrap extends StatelessWidget {
  const _ColumnWrap({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              child: Column(
                children: [
                  Text('xxx: 00'),
                  _WrapNoRefreshWidget(child: _TestOne()),
                ],
              ),
            ),
            Container(
              height: 400,
              child: Column(
                children: [
                  Text('xxx: 111'),
                  _TestOne(),
                ],
              ),
            ),
            Container(
              height: 400,
              child: Column(
                children: [
                  Text('xxx: 222'),
                  _TestOne(),
                ],
              ),
            ),
            Container(
              height: 400,
              child: Column(
                key: _globalKey,
                children: [
                  Text('xxx: 333'),
                  _TestOne(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: unused_element
class _ListViewWrap extends StatelessWidget {
  const _ListViewWrap({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            height: 400,
            child: Column(
              children: [
                Text('xxx: $index'),
                if (index == 0) _WrapNoRefreshWidget(child: _TestOne()),
                if (index != 0) _TestOne(),
              ],
            ),
          );
        },
        itemCount: 4,
      ),
    );
  }
}
