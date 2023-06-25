import 'package:flutter/material.dart';

class SliverProtoTypeExtentListPage extends StatefulWidget {
  @override
  _SliverProtoTypeExtentListPageState createState() => _SliverProtoTypeExtentListPageState();
}

class _SliverProtoTypeExtentListPageState extends State<SliverProtoTypeExtentListPage> {
  double prototypeItemHeight = 100.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test Sliver ProtoTypeExtentList Page'),
      ),
      body: Center(
        child: SizedBox(
          width: 200.0,
          height: 400.0,
          child: Container(
            color: Colors.red,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverPrototypeExtentList(
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
                  prototypeItem: Container(
                    width: 100.0,
                    height: prototypeItemHeight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            prototypeItemHeight = prototypeItemHeight * 1.4;
          });
        },
        child: Icon(
          Icons.format_align_justify,
          color: Colors.blue,
        ),
      ),
    );
  }
}
