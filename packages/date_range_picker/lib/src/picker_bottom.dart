import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'flexible.dart';
import 'picker_model.dart';

class PickerBottom extends StatelessWidget {
  const PickerBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PickerModel vm = Provider.of<PickerModel>(context);
    return Container(
      height: 104.w,
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              vm.cancel(context);
            },
            child: Container(
              width: 148.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color(0xFFE8E9ED),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.w)),
              ),
              child: Center(
                child: Text(
                  '取消',
                  style: TextStyle(fontSize: 16.w, fontWeight: FontWeight.bold, color: Color(0xFF292D3E)),
                ),
              ),
            ),
          ),
          Opacity(
            opacity: vm.canConfirm ? 1.0 : 0.6,
            child: GestureDetector(
              onTap: () {
                vm.confirm(context);
              },
              child: Container(
                width: 148.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: Color(0xFF0088FB),
                  borderRadius: BorderRadius.all(Radius.circular(8.w)),
                ),
                child: Center(
                  child: Text(
                    '确定',
                    style: TextStyle(fontSize: 16.w, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
