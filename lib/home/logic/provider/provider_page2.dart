import 'package:flutter/material.dart';
import 'package:hello/home/logic/provider/models.dart';
import 'package:provider/provider.dart';

class MyCounter2 extends ChangeNotifier {
  int _myValue = 0;
  int get myValue {
    return _myValue - 100;
  }

  void updateMyValue({int value}) {
    print('updateMyValue = $value');
    _myValue = value;
    notifyListeners();
//    return this;
  }
}

class ProviderTestPage2 extends StatefulWidget {
  @override
  _ProviderTestPage2State createState() => _ProviderTestPage2State();
}

class _ProviderTestPage2State extends State<ProviderTestPage2> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProxyProvider<Counter, MyCounter2>(
          create: (_) => MyCounter2(),
          update: (_, counter, counter2) => counter2..updateMyValue(value: counter.count),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('app page 2'),
        ),
        body: Container(
          width: 100.0,
          height: 100.0,
          child: Center(
            child: Column(
              children: <Widget>[
                Consumer<MyCounter2>(
                  builder: (BuildContext context, MyCounter2 value, Widget child) {
                    print('build Consumer');
                    return Column(
                      children: <Widget>[
                        Text('value = ${value.myValue}'),
                        child,
                      ],
                    );
                  },
                  child: Builder(builder: (context) {
                    print('builder Consumer child');
                    return Text('aaa');
                  }),
                ),
                Selector<MyCounter2, int>(
                  selector: (context, vm) => vm.myValue,
                  builder: (BuildContext context, int value, Widget child) {
                    print('build Selector');
                    return Column(
                      children: <Widget>[
                        Text('value = ${value}'),
                        child,
                      ],
                    );
                  },
                  child: Builder(builder: (context) {
                    print('builder Selector child');
                    return Text('aaa');
                  }),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: Builder(builder: (context) {
          print('floatingActionButton build');
          return FloatingActionButton(
            onPressed: () {
              print('floatingActionButton clicked');
              Provider.of<Counter>(context, listen: false).increment();
            },
            child: const Icon(Icons.add),
          );
        }),
      ),
    );
  }
}

/// 为什么都调用了builder函数。
