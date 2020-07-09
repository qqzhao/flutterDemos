import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello/home/combine/timer_picker_page2.dart';

class TimerPickerPage extends StatefulWidget {
  @override
  _TimerPickerPageState createState() => _TimerPickerPageState();
}

class _TimerPickerPageState extends State<TimerPickerPage> {
  int selectedValue = 0;
  FixedExtentScrollController _fixedExtentScrollController = FixedExtentScrollController(initialItem: 3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test picker'),
      ),
      body: Container(
        height: 200,
        color: Colors.white,
        child: CupertinoPicker(
          looping: false, // 是否循环显示 item
          useMagnifier: false, // 放大镜效果，元素被选中的时候会变大一点
          magnification: 1.2, // 放大镜的放大倍数
          squeeze: 1.2, // 选中区域（高度）可以挤下多少项目
          diameterRatio: 1.07, // 直径比，这里描述第几个元素会消失
          offAxisFraction: 0.0, // 旋转斜率，正的数值：靠左边显示；负值：靠右边显示。
          scrollController: _fixedExtentScrollController, // 设置初始元素
          backgroundColor: Colors.blue.withOpacity(0.1),
          onSelectedItemChanged: (value) {
            setState(() {
              selectedValue = value;
            });
          },
          itemExtent: 32,
          children: [
            Container(
              color: Colors.red,
              child: Text('Item01'),
            ),
            Text('Item02'),
            Text('Item03'),
            Text('Item04'),
            Text('Item05'),
            Text('Item06'),
            Text('Item07'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.timer),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TimerPickerPage2(),
              ));
        },
      ),
    );
  }
}
