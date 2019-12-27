import 'package:flutter/material.dart';

class InheritedPage2 extends StatefulWidget {
  @override
  _InheritedPage2State createState() => _InheritedPage2State();
}

class _InheritedPage2State extends State<InheritedPage2> {
  @override
  Widget build(BuildContext context) {
    return ReportWidget(
      maps: {'keyOuter': '222', 'key1': 'replace111'},
      child: Scaffold(
        appBar: AppBar(
          title: Text('test inherited widget 2'),
        ),
        body: ReportWidget(
          maps: {'key1': '111'},
          child: Container(
              child: Column(
            children: <Widget>[
              Builder(
                builder: (context) {
                  return FlatButton(
                    onPressed: () {
                      var maps = ReportWidget.reportMaps(context);
                      print('maps = $maps');
                    },
                    child: Container(
                      width: 100,
                      height: 80,
                      color: Colors.lightBlue,
                      child: ReportWidget(
                        maps: {'childKey-2': '444'},
                        child: Text('tap me'),
                      ),
                    ),
                  );
                },
              ),
              Builder(
                builder: (context) {
                  return Row(
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          var maps = ReportWidget.reportMaps(context);
                          print('maps = $maps');
                        },
                        child: Container(
                          width: 100,
                          height: 80,
                          color: Colors.lightBlue,
                          child: ReportWidget(
                            maps: {'childKey-2': '444'},
                            child: Text('tap me2'),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              /// 这种方式 context 获取到不行
              Row(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      print('context = $context');
                      var maps = ReportWidget.reportMaps(context);
                      print('maps = $maps');
                    },
                    child: Container(
                      width: 100,
                      height: 80,
                      color: Colors.lightBlue,
                      child: ReportWidget(
                        maps: {'childKey-2': '444'},
                        child: Text('tap me3'),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}

class ReportWidget extends InheritedWidget {
  final Map<String, String> maps;
  ReportWidget({
    Key key,
    @required this.maps,
    @required child,
  })  : assert(maps != null),
        assert(child != null),
        super(
          child: child,
          key: key,
        );

  static ReportWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ReportWidget>();
  }

  static Map<String, String> reportMaps(BuildContext context) {
    final List<ReportWidget> reports = <ReportWidget>[];
    context.visitAncestorElements((Element ancestor) {
      if (ancestor.widget is ReportWidget) {
        final ReportWidget curReport = ancestor.widget;
        reports.add(curReport);
      }
      return true;
    });
    Map<String, String> _map = {};

    /// 里层的对象应该覆盖外层的，所以有 reserve
    reports.reversed.forEach((report) {
      _map.addAll(report.maps);
    });
//    print('reports = $reports');
    return _map;
  }

  @override
  bool updateShouldNotify(ReportWidget old) => maps != old.maps;
}
