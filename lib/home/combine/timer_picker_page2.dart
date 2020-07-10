import 'package:flutter/material.dart';
import 'package:hello/components/picker/picker.dart';

class TimerPickerPage2 extends StatefulWidget {
  @override
  _TimerPickerPage2State createState() => _TimerPickerPage2State();
}

class _TimerPickerPage2State extends State<TimerPickerPage2> {
  @override
  void initState() {
    super.initState();
    var now = DateTime.now();
    var time2 = now.add(Duration(days: 1, hours: 1));
    print('time2 = $time2');
    var time3 = now.add(Duration(days: 1, hours: 13));
    print('time3 = $time3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test timer pick2'),
      ),
      body: Text('111'),
      persistentFooterButtons: <Widget>[
        FloatingActionButton(
          heroTag: '1',
          child: Icon(Icons.subject),
          onPressed: () {
            showModalBottomSheet(
                barrierColor: Colors.black.withOpacity(0.2),
                backgroundColor: Colors.transparent,
                context: context,
                builder: (BuildContext context) {
                  return TCRItemPicker(
                    initialIndex: 2,
                    title: '请选择作业学科',
                    items: ['语文', '数学', '英语', '化学', '政治', '历史'],
                    callback: (index, item) {
                      print('item = $item');
                    },
                  );
                });
          }, //
        ),
        FloatingActionButton(
          child: Icon(Icons.timer),
          heroTag: '2',
          onPressed: () {
            showModalBottomSheet(
              barrierColor: Colors.black.withOpacity(0.2),
              backgroundColor: Colors.transparent,
              context: context,
              builder: (BuildContext context) {
                return TCRTimePicker(
                  title: '请选择时间',
                  beginTime: DateTime.now(),
                  selectTime: DateTime.now().add(Duration(minutes: 8)),
//                    selectTime: DateTime.now().add(Duration(days: 1, hours: 13)),
                  callback: (time) {
                    print('item = $time');
                  },
                );
              },
            );
          }, //
        )
      ],
    );
  }
}
