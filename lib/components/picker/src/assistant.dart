import 'package:flutter/material.dart';

import 'flexible.dart';
import 'time_picker_help.dart';

class Header extends StatelessWidget {
  final String title;
  final VoidCallback callback;
  Header({this.title, this.callback});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.w),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 17.0.w,
                fontWeight: FontWeight.bold,
                color: Color(0xFF302B34),
              ),
            ),
          ),
          _TapedContainer(
            callback: callback,
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.only(right: 20.w, left: 20.w),
              child: Center(
                child: Icon(
                  Icons.clear,
                  size: 27.w,
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Bottom extends StatelessWidget {
  final VoidCallback callback;
  Bottom({this.callback});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0.w, horizontal: 20.0.w),
      child: _TapedContainer(
        callback: callback,
        child: Container(
          margin: EdgeInsets.only(bottom: 20.0.w),
          child: Container(
            height: 40.0.w,
            decoration: BoxDecoration(
              color: Color(0xFF0088FB),
              borderRadius: BorderRadius.circular(10.0.w),
            ),
            child: Center(
              child: Text(
                TimerPickerHelper.confirmString,
                style: TextStyle(color: Colors.white, fontSize: 17.0.w),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TapedContainer extends StatefulWidget {
  final Widget child;
  final VoidCallback callback;
  _TapedContainer({this.child, this.callback});
  @override
  __TapedContainerState createState() => __TapedContainerState();
}

class __TapedContainerState extends State<_TapedContainer> {
  double _opacity = 1.0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapCancel: () {
        setState(() {
          _opacity = 1.0;
        });
      },
      onTapDown: (detail) {
        setState(() {
          _opacity = 0.7;
        });
      },
      onTapUp: (detail) {
        setState(() {
          _opacity = 1.0;
        });
        if (widget.callback != null) {
          widget.callback();
        }
      },
      child: Opacity(
        opacity: _opacity,
        child: widget.child,
      ),
    );
  }
}
