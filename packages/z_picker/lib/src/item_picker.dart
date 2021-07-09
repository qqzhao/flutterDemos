import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'assistant.dart';
import 'cupertino_picker_wrap.dart';
import 'flexible.dart';
import 'time_picker_help.dart';

const double _defaultHeight = 345.0;

typedef ItemPickerCallback = void Function(int index, String item);

/// 单条 item 选择器
class TCRItemPicker extends StatefulWidget {
  final int initialIndex;
  final String title;
  final double height;
  final List<String> items;
  final ItemPickerCallback? callback;

  TCRItemPicker({
    this.initialIndex = 0,
    this.title = '',
    this.height = _defaultHeight,
    this.items = const [],
    this.callback,
  }) : super() {
    assert(initialIndex < items.length && initialIndex >= 0, 'TCRItemPicker 参数错误');
  }

  @override
  _TCRItemPickerState createState() => _TCRItemPickerState();
}

class _TCRItemPickerState extends State<TCRItemPicker> {
  int _selectedValue = 0;

  @override
  void initState() {
    _selectedValue = widget.initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    XFlexible.registerWidth(MediaQuery.of(context).size.width);
    TimerPickerHelper.registerLocale(Localizations.localeOf(context));
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.w),
          topRight: Radius.circular(10.w),
        ),
      ),
      child: SafeArea(
        child: Container(
          height: widget.height,
          child: Column(
            children: <Widget>[
              Header(
                callback: () {
                  Navigator.of(context).maybePop();
                },
                title: widget.title,
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                  child: CupertinoPickerWrap(
                    onChange: (value) {
                      setState(() {
                        _selectedValue = value;
                      });
                    },
                    selectedIndex: _selectedValue,
                    items: widget.items,
                  ),
                ),
              ),
              Bottom(
                callback: () {
                  Navigator.of(context).maybePop();
                  if (widget.callback != null) {
                    widget.callback?.call(_selectedValue, widget.items[_selectedValue]);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
