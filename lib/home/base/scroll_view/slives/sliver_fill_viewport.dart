import 'package:flutter/material.dart';

class SliverFillViewportPage extends StatefulWidget {
  @override
  _SliverFillViewportPageState createState() => _SliverFillViewportPageState();
}

class _SliverFillViewportPageState extends State<SliverFillViewportPage> {
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
                SliverFillViewport(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              color: Colors.purple[200],
                              child: Center(
                                child: Text('index = $index'),
                              ),
                            ),
                          ),
                          Divider(
                            height: 2.0,
                            color: Colors.white,
                          ),
                        ],
                      );
                    },
                    childCount: 10,
                  ),
                  viewportFraction: 1.5,
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FlatButton.icon(
          onPressed: () {},
          icon: Icon(
            Icons.format_align_justify,
            color: Colors.blue,
          ),
          label: Text('a')),
    );
  }
}
