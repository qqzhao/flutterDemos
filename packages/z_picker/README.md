# z_picker

A time picker in Cupertino style.

## Features

* screen adapt(based 375.0 width)
* support Engllish and Chinese.

## How to Use

```dart
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
```
