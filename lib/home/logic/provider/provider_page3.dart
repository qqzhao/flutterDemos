import 'package:flutter/material.dart';
import 'package:hello/home/logic/provider/provider_page4.dart';
import 'package:provider/provider.dart';

/// 可以用 `Selector` 定义局部刷新
/// 可以定义是否需要刷新: `shouldRebuild`
class _ProviderTestPage3Model extends ChangeNotifier {
  int _counter = 0;
  int _counter2 = 0;

  int get counter => _counter;
  int get counter2 => _counter2;

  void increase() {
    _counter++;
    notifyListeners();
  }

  void increase2() {
    _counter2++;
    notifyListeners();
  }
}

class ProviderTestPage3 extends StatefulWidget {
  @override
  _ProviderTestPage3State createState() => _ProviderTestPage3State();
}

class _ProviderTestPage3State extends State<ProviderTestPage3> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<_ProviderTestPage3Model>(
          create: (_) => _ProviderTestPage3Model(),
        ),
      ],
      child: Builder(builder: (context) {
//        var modelWatch = context.watch<_ProviderTestPage3Model>();
//        var modelWatch = Provider.of<_ProviderTestPage3Model>(context, listen: true);
        return Scaffold(
          appBar: AppBar(
            title: Text('provider test3'),
          ),
          body: Container(
            child: Column(
              children: <Widget>[
                Selector<_ProviderTestPage3Model, int>(
                  selector: (context, vm) => vm.counter,
                  shouldRebuild: (prev, next) {
                    print('in shouldRebuild');
                    return false;
                  },
                  builder: (context, value, child) {
                    return Container(
                      height: 100,
                      child: Center(
                        child: Text('column1: $value'),
                      ),
                    );
                  },
                ),
                Selector<_ProviderTestPage3Model, String>(
                  selector: (context, vm) => vm.counter2.toString(),
                  builder: (context, value, child) {
                    return Container(
                      height: 100,
                      child: Center(
                        child: Text('column2: $value'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          persistentFooterButtons: <Widget>[
            FloatingActionButton(
              heroTag: 'tag1',
              child: Text('11'),
              onPressed: () {
                context.read<_ProviderTestPage3Model>().increase();
              },
            ),
            FloatingActionButton(
              heroTag: 'tag2',
              child: Text('22'),
              onPressed: () {
                context.read<_ProviderTestPage3Model>().increase2();
              },
            ),
            FloatingActionButton(
              heroTag: 'tag3',
              child: Text('N'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ProviderTestPage4()),
                );
              },
            ),
          ],
        );
      }),
    );
  }
}
