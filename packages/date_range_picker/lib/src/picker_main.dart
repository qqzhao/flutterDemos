import 'package:flutter/material.dart';

import 'flexible.dart';
import 'month_item_widget.dart';
import 'picker_model.dart';

class PickerMainContent extends StatefulWidget {
  final PickerModel model;
  const PickerMainContent({Key? key, required this.model}) : super(key: key);

  @override
  _PickerMainContentState createState() => _PickerMainContentState();
}

class _PickerMainContentState extends State<PickerMainContent> {
  @override
  Widget build(BuildContext context) {
    final PickerModel vm = widget.model;
    return Container(
      child: Column(
        children: [
          _ContentHeader(
            title: '${vm.monthIndex}月',
            leftCallback: vm.prevPage,
            rightCallback: vm.nextPage,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.transparent,
              child: PageView.builder(
                controller: vm.pageController,
                itemBuilder: (BuildContext context, int index) {
                  final DateTime month = DateUtils.addMonthsToMonthDate(DateTime(vm.validRange.start!.year, vm.validRange.start!.month), index);
                  return Container(
                    color: Colors.white,
                    child: MonthItemWidget(
                      displayedMonth: month,
                      range: vm.selectRange,
                      firstDate: vm.validRange.start!,
                      lastDate: vm.validRange.end!,
                      changedCallback: vm.updateSelection,
                    ),
                  );
                },
                onPageChanged: vm.updatePageIndex,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ContentHeader extends StatelessWidget {
  final String title;
  final VoidCallback? leftCallback;
  final VoidCallback? rightCallback;
  const _ContentHeader({this.title = '', this.leftCallback, this.rightCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ArrowBtn(
            callback: leftCallback,
          ),
          Container(
            child: Text(
              '$title',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18.w,
              ),
            ),
          ),
          _ArrowBtn(
            isLeft: false,
            callback: rightCallback,
          ),
        ],
      ),
    );
  }
}

class _ArrowBtn extends StatelessWidget {
  final VoidCallback? callback;
  final bool isLeft;
  const _ArrowBtn({this.callback, this.isLeft = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        width: 70.w,
        height: 40.w,
        color: Colors.transparent,
        child: Icon(
          isLeft ? Icons.arrow_back_ios_rounded : Icons.arrow_forward_ios_rounded,
          size: 16.w,
          color: Color(0xFF80838D),
        ),
      ),
    );
  }
}
