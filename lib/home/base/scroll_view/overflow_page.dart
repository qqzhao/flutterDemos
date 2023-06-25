import 'package:flutter/material.dart';

class TestOverflowPage extends StatefulWidget {
  @override
  _TestOverflowPageState createState() => _TestOverflowPageState();
}

class _TestOverflowPageState extends State<TestOverflowPage> {
  bool overFlowValue = true;
  void _floatButtonClicked() {
    print('_floatButtonClicked');
    overFlowValue = !overFlowValue;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('TestOverflowPage'),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  width: 200.0,
                  height: 200.0,
                  color: Colors.blue,
                  child: Stack(
                    clipBehavior: overFlowValue ? Clip.none : Clip.hardEdge,
                    children: <Widget>[
                      Positioned(
                        left: -50.0,
                        child: Container(
                          width: 300.0,
                          height: 30.0,
                          color: Colors.yellow,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 200.0,
                  height: 200.0,
                  color: Colors.red,
                  child: Text(
                    '我试放大看舒服奥拉夫就打死了放大看世纪东方拉扣几分的啦放假啊六块腹肌大理石空间发的撒六块腹肌',
//                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                ),
                Container(
                  width: 200.0,
                  height: 100.0,
                  color: Colors.blue,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    child: Stack(
                      clipBehavior: overFlowValue ? Clip.none : Clip.hardEdge,
                      children: <Widget>[
                        Positioned(
                          left: -50.0,
                          child: Container(
                            width: 300.0,
                            height: 30.0,
                            color: Colors.yellow,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: _floatButtonClicked),
      ),
    );
  }
}
