import 'package:flutter/material.dart';
import 'package:hello/global.dart';
import 'package:hello/home/base/base.dart';
import 'package:hello/home/base/objectdbPage.dart';
import 'package:hello/utils/route.dart';
import './home/home.dart';
import './components/custom_navigator_observe.dart';

void main() => runApp(new MyApp());

List<dynamic> globalRouters = [
  MyRouterList(name: '/base', lists: [
    MyRouter(name: '/base/objectpage', widget: ObjectdbTestPage()),
  ]),
  MyRouter(name: '/base/objectpage', widget: ObjectdbTestPage()),
  MyRouter(name: '/base/objectpage2', widget: ObjectdbTestPage()),

];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    // dark: 电池条显示白色, 但是页面都是黑底、白字（白字看不见）
    // light: 电池条显示黑色（默认）
    Brightness curBright = Brightness.light;

    return new MaterialApp(
      title: 'Flutter Demo',
      navigatorObservers: <NavigatorObserver>[new CustomNavObserver()],
      theme: new ThemeData(
//        primarySwatch: Colors.blue,
        // NavBar 背景的颜色
        primaryColor: Colors.red,
        accentColor: Colors.blue,
        primaryColorLight: Colors.green,

        brightness: curBright,
        primaryColorBrightness: curBright,
        accentColorBrightness: curBright,
      ),
      home: new HomePage2(),
      navigatorKey: globalKey,
      routes: {
        '/base/objectpage': (BuildContext context) => new ObjectdbTestPage(),
        '/base': (BuildContext context) => new BasePage(),
      },
    );
  }
}

class HomePage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('flutter demos'),
      ),
      body: new Container(
        color: Colors.white,
        child: new ListView.builder(
            itemCount: globalRouters.length,
            shrinkWrap: true,
            itemExtent: 80.0,
            itemBuilder: (context, index) {
              var item = globalRouters[index];
              Widget cell = new Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                  border: new Border(
                      bottom: const BorderSide(
                        color: Color(0x3f000000),
                        width: 1.0,
                      )
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text(item.name),
                  ],
                ),
              );
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, new MaterialPageRoute(
                    builder: (_){
                      return item.route;
                    },
                  ));
                },
                child: cell,
              );
            }),
      ),
    );
  }
}
