import 'package:flutter/material.dart';
// import 'package:flutter_utils_z/flow_control.dart';

class FlowControlPage extends StatefulWidget {
  @override
  _FlowControlPageState createState() => _FlowControlPageState();
}

class _FlowControlPageState extends State<FlowControlPage> {
  @override
  Widget build(BuildContext context) {
    print('build =====');
    // var block = (msg) {
    //   print('---$msg');
    // };

    return Scaffold(
      appBar: AppBar(
        title: Text('test flow control'),
      ),
      body: Column(
        children: <Widget>[
          // FlatButton(
          //   onPressed: () {
          //     print('ontap1');
          //     Throttle.seconds(1, print, ['ontap1 action']);
          //   },
          //   child: Text('ontap1'),
          // ),
          // FlatButton(
          //   onPressed: () {
          //     print('ontap2');
          //     DeBouncer.seconds(1, print, ['ontap2 action']);
          //   },
          //   child: Text('ontap2'),
          // ),
          // FlatButton(
          //   onPressed: () {
          //     print('ontap3');
          //
          //     /// 这种写法不行，有问题，因为每次都是新的block
          //     DeBouncer.seconds(1, (msg) {
          //       print('---$msg');
          //     }, ['ontap3 action']);
          //   },
          //   child: Text('ontap3'),
          // ),
          // FlatButton(
          //   onPressed: () {
          //     print('ontap4');
          //
          //     /// 这种写法也不行，每次还是新的
          //     var block = (msg) {
          //       print('---$msg');
          //     };
          //     DeBouncer.seconds(1, block, ['ontap4 action']);
          //   },
          //   child: Text('ontap4'),
          // ),
          // FlatButton(
          //   onPressed: () {
          //     print('ontap5');
          //
          //     /// 这种写法可以
          //     DeBouncer.seconds(1, block, ['ontap5 action']);
          //   },
          //   child: Text('ontap5'),
          // ),
        ],
      ),
    );
  }
}
