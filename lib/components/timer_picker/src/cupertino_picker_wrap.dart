import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'flexible.dart';

class CupertinoPickerWrap extends StatefulWidget {
  final int selectedIndex;
  final List<String> items;
  final ValueChanged<int> onChange;
  CupertinoPickerWrap({this.selectedIndex, this.items, this.onChange});

  @override
  _CupertinoPickerWrapState createState() => _CupertinoPickerWrapState();
}

class _CupertinoPickerWrapState extends State<CupertinoPickerWrap> {
  FixedExtentScrollController _fixedExtentScrollController;

  @override
  void initState() {
    _fixedExtentScrollController = FixedExtentScrollController(initialItem: widget.selectedIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoPicker.builder(
//                    looping: false, // 是否循环显示 item
        useMagnifier: false, // 放大镜效果，元素被选中的时候会变大一点
        magnification: 1.07, // 放大镜的放大倍数
        squeeze: 1.2, // 选中区域（高度）可以挤下多少项目
        diameterRatio: 1.07, // 直径比，这里描述第几个元素会消失
        offAxisFraction: 0.0, // 旋转斜率，正的数值：靠左边显示；负值：靠右边显示。
        scrollController: _fixedExtentScrollController, // 设置初始元素
        backgroundColor: Colors.white,
        onSelectedItemChanged: widget.onChange,
        itemExtent: 36.w,
        childCount: widget.items.length,
        itemBuilder: (context, index) {
          return Container(
            child: Center(
              child: Text(
                '${widget.items[index]}',
                style: TextStyle(fontSize: 19.0.w),
              ),
            ),
          );
        },
      ),
    );
  }
}
