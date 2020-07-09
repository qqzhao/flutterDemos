export './src/item_picker.dart';
export './src/time_picker.dart';

/// TCRItemPicker使用方法
/**
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
**/
/// TCRTimePicker使用方法
/**
showModalBottomSheet(
      barrierColor: Colors.black.withOpacity(0.2),
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return TCRTimePicker(
          initialIndex: 2,
          title: '请选择时间',
          beginTime: DateTime.now().add(Duration(days: 1, hours: 1)),
          selectTime: DateTime.now().add(Duration(days: 1, hours: 13)),
          callback: (time) {
            print('item = $time');
          },
        );
      },
    );
**/
