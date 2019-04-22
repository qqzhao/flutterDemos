import 'package:flutter/material.dart';

class SliverAppBarPage extends StatefulWidget {
  @override
  _SliverAppBarPageState createState() => _SliverAppBarPageState();
}

class _SliverAppBarPageState extends State<SliverAppBarPage> {
  bool floating = false;
  bool snap = false;
  bool pinned = false;

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
              slivers: <Widget>[
                SliverAppBar(
                  actions: <Widget>[],
                  title: Text('SliverAppBar'),
                  backgroundColor: Theme.of(context).accentColor,
                  expandedHeight: 200.0,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: Container(
                      color: Colors.purple,
                    ),
                  ),
                  floating: floating,
                  snap: snap,
                  pinned: pinned,
                ),
                SliverFixedExtentList(
                  itemExtent: 120.0,
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              color: Colors.red,
                              child: Text('index = $index'),
                            ),
                          ),
                          Divider(
                            color: Colors.white,
                            height: 3.0,
                          )
                        ],
                      );
                    },
                    childCount: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        children: <Widget>[
          SizedBox(
            width: 10.0,
          ),
          Text('floationg: '),
          Switch(
              value: floating,
              onChanged: (value) {
                setState(() {
                  floating = !floating;
                });
              }),
          Text('snap: '),
          Switch(
              value: snap,
              onChanged: (value) {
                setState(() {
                  snap = !snap;
                });
              }),
          Text('pinned: '),
          Switch(
              value: pinned,
              onChanged: (value) {
                setState(() {
                  pinned = !pinned;
                });
              }),
        ],
      ),
    );
  }
}
