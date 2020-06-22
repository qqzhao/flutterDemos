import 'package:flutter/material.dart';

class BaseConfig {
  String get name {
    return 'base_config';
  }
}

class RootConfig extends BaseConfig {
  String get name {
    return 'root_config';
  }
}

class TestConfig extends BaseConfig {
  String get name {
    return 'test_config';
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
              return Text('${a.name}');
            }),
            DefaultBaseConfig(
              config: TestConfig(),
              child: new Builder(builder: (context) {
                var a = DefaultBaseConfig.of(context);
                return Text('${a.name}');
              }),
            )
          ],
        ),
      ),
    );
  }
}
