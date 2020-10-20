# z_tools

## calculate widget size

### change main file

```dart
void main() async {
  runZoned(
    () => runApp(
      CalculateWidgetAppContainer(
        child: Center(
          child: LocalizedApp(delegate, MyApp()),
        ),
      ),
    ),
    onError: (Object obj, StackTrace stack) {
      print('global exception: obj = $obj;\nstack = $stack');
    },
  );
}
```

### use in function

```dart
_Cell(
    title: 'cal: Column-min',
    callback: () async {
        Widget widget1 = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
            Container(
            width: 100,
            height: 30,
            color: Colors.blue,
            ),
            Container(
            height: 20.0,
            width: 30,
            ),
            Text('111'),
        ],
        );
        // size = Size(100.0, 66.0)
        print('size = ${await getWidgetSize(widget1)}');
    },
),
```
