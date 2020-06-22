import 'package:flutter/material.dart';
import 'package:hello/home/combine/routes/route_base.dart';
import 'package:provider/provider.dart';

class RoutePageModuleMViewModel extends ChangeNotifier {
  int _counter = 0;
  int get count {
    return _counter;
  }

//  static RoutePageModuleMViewModel _model = RoutePageModuleMViewModel._();
//  RoutePageModuleMViewModel._();
//
//  factory RoutePageModuleMViewModel() {
//    print('in RoutePageModuleMViewModel');
//    return _model;
//  }

  void increase() {
    _counter++;
    notifyListeners();
  }
}

//class RoutePageModuleM extends StatelessWidget {
//  final Widget page;
//  RoutePageModuleM({this.page});
//  @override
//  Widget build(BuildContext context) {
//    return MultiProvider(
//      providers: [
//        ChangeNotifierProvider<RoutePageModuleMViewModel>(
//          create: (context) => RoutePageModuleMViewModel(),
//        ),
//      ],
//      child: Container(
//        child: page,
//      ),
//    );
//  }
//}

class RoutePageModuleM extends InheritedWidget {
  final Widget page;
  RoutePageModuleM({
    this.page,
    Key key,
  }) : super(
            key: key,
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider<RoutePageModuleMViewModel>(
                  create: (context) => RoutePageModuleMViewModel(),
                ),
              ],
              child: Container(
                child: page,
              ),
            ));

  static RoutePageModuleM of(BuildContext context) {
    var result = context.inheritFromWidgetOfExactType(RoutePageModuleM);
    return result;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}

/// page1
class RoutePageModuleMPage1 extends StatefulWidget {
  @override
  _RoutePageModuleMPage1State createState() => _RoutePageModuleMPage1State();
}

class _RoutePageModuleMPage1State extends State<RoutePageModuleMPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('moduleM page1'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            var aa = RoutePageModuleM.of(context);
            print('aa = $aa');

            // '${Routes.pageModuleM}${Routes.moduleSeparator}${Routes.pageModuleMPage2}'
            Routes.globalKey.currentState.pushNamed(Routes.gen([Routes.pageModuleM, Routes.pageModuleMPage2]), arguments: {
              'pageCParams': '111',
              'key2': 222,
              'RoutePageModuleMObj': aa,
            });
          },
          child: Container(
            width: 200,
            height: 100,
            color: Colors.red,
            child: Consumer<RoutePageModuleMViewModel>(
              builder: (context, vm, child) {
                return Text('count = ${vm.count}');
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var vm = Provider.of<RoutePageModuleMViewModel>(context, listen: false);
          vm.increase();
        },
      ),
    );
  }
}

/// page2
class RoutePageModuleMPage2 extends StatefulWidget {
  @override
  _RoutePageModuleMPage2State createState() => _RoutePageModuleMPage2State();
}

class _RoutePageModuleMPage2State extends State<RoutePageModuleMPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('moduleM page2'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Routes.globalKey.currentState.pushNamed('${Routes.pageModuleN}${Routes.moduleSeparator}${Routes.pageModuleNPage1}', arguments: {
              'pageCParams': '111',
              'key2': 222,
            });
          },
          child: Container(
            width: 200,
            height: 100,
            color: Colors.red,
            child: Consumer<RoutePageModuleMViewModel>(
              builder: (context, vm, child) {
                return Text('count = ${vm.count}');
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var vm = Provider.of<RoutePageModuleMViewModel>(context, listen: false);
          vm.increase();
        },
      ),
    );
  }
}
