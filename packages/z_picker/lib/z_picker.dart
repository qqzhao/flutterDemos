library z_picker;

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
    title: 'Please select the subject',
    items: ['Math', 'English', 'Chemistry', 'History'],
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
    title: 'Please select the time',
    beginTime: DateTime.now().add(Duration(days: 1, hours: 1)),
    selectTime: DateTime.now().add(Duration(days: 1, hours: 13)),
    callback: (time) {
    print('item = $time');
    },
    );
    },
    );
 **/
