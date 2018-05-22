
### 1. *** widgets require a Directionality widget ancestor.

```
runApp(
    new MediaQuery(
        data: new MediaQueryData.fromWindow(ui.window),
        child: new Directionality(
            textDirection: TextDirection.rtl,
            child: new MyHome())))
```

如果不使用`MaterialApp`, 需要如上封装一下。或者下面的方法：

```
new Directionality(
          textDirection: TextDirection.ltr,
          child: new Text('Hello')
```

[1. no-directionality-widget-found](https://stackoverflow.com/questions/49687181/no-directionality-widget-found)
