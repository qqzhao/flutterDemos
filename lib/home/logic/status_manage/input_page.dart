import 'package:flutter/material.dart';
import 'package:hello/home/logic/status_manage/bloc_test_1.dart';
import 'package:hello/home/logic/status_manage/bloc_test_2.dart';
import 'package:hello/home/logic/status_manage/bloc_test_3.dart';
import 'package:hello/home/logic/status_manage/bloc_test_4.dart';

class StateManageTestPage extends StatefulWidget {
  @override
  _StateManageTestPageState createState() => _StateManageTestPageState();
}

class _StateManageTestPageState extends State<StateManageTestPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _itemClick(int index) {
    Widget page;
    switch (index) {
      case 0:
        page = BlocTestPage1();
        break;
      case 1:
        page = BlocTestPage2();
        break;
      case 2:
        page = BlocTestPage3();
        break;
      case 3:
        page = BlocTestPage4();
        break;
    }

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    var testItems = [
      "bloc1",
      "bloc2",
      "bloc3",
      "bloc4",
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('state manage test'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _itemClick(index);
            },
            child: Center(
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(style: BorderStyle.solid),
                  ),
                ),
                child: Center(
                  child: Container(
                    child: Text('$index, ${testItems[index]}'),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: testItems.length,
      ),
    );
  }
}
