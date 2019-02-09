
仿照`DefaultAssetBundle`实现`InheritedWidget`的使用，即按照继承顺序访问最近祖先中定义的值。

### 1. 定义基础的类型

```dart
class BaseConfig {
  String get name {
    return 'base_config';
  }
}
```

### 2. 实现`InheritedWidget`的继承类。注意`updateShouldNotify`和`of`方法

```dart
class RootConfig extends BaseConfig {
  String get name {
    return 'root_config';
  }
}

BaseConfig rootConfig = RootConfig();

class DefaultBaseConfig extends InheritedWidget {
  final BaseConfig config;
  const DefaultBaseConfig({Key key, @required this.config, @required Widget child})
      : assert(config != null),
        assert(child != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(DefaultBaseConfig oldWidget) {
    return config != oldWidget.config;
  }

  static BaseConfig of(BuildContext context) {
    final DefaultBaseConfig result = context.inheritFromWidgetOfExactType(DefaultBaseConfig);
    return result?.config ?? rootConfig;
  }
}
```

### 3. 定义Test和样例

```dart
class TestConfig extends BaseConfig {
  String get name {
    return 'test_config';
  }
}
class InheritedWidgetTest extends StatefulWidget {
  @override
  _InheritedWidgetTestState createState() => _InheritedWidgetTestState();
}

class _InheritedWidgetTestState extends State<InheritedWidgetTest> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('test inheritedWidget'),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Builder(builder: (context) {
              var a = DefaultBaseConfig.of(context);
              return Text('${a.name}'); // root_config
            }),
            DefaultBaseConfig(
              config: TestConfig(),
              child: new Builder(builder: (context) {
                var a = DefaultBaseConfig.of(context);
                return Text('${a.name}'); // test_config
              }),
            )
          ],
        ),
      ),
    );
  }
}
```