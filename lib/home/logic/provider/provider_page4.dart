import 'package:flutter/material.dart';
import 'package:hello/home/logic/provider/provider_page5.dart';
import 'package:provider/provider.dart';

/// 是否刷新满足的条件
class _ProviderTestPage4Model extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increase() {
    _counter++;
    notifyListeners();
  }
}

class ProviderTestPage4 extends StatefulWidget {
  @override
  _ProviderTestPage4State createState() => _ProviderTestPage4State();
}

class _ProviderTestPage4State extends State<ProviderTestPage4> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<_ProviderTestPage4Model>(
          create: (_) => _ProviderTestPage4Model(),
        )
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('provider4'),
          ),
          body: Column(
            children: <Widget>[
              Container(
                height: 100,
                child: Center(
                  child: Builder(
                    builder: (context) {
//                      var vm = Provider.of<_ProviderTestPage4Model>(context, listen: false); // 不会更新
//                      var vm = Provider.of<_ProviderTestPage4Model>(context, listen: true); // 会更新
//                      var vm = context.select((_ProviderTestPage4Model model) => model); // 不会更新
                      var value = context.select((_ProviderTestPage4Model model) => model.counter); // 会更新
                      return Text('${value}');
                    },
                  ),
                ),
              )
            ],
          ),
          persistentFooterButtons: <Widget>[
            FloatingActionButton(
              heroTag: 'tag1',
              child: Text('11'),
              onPressed: () {
                context.read<_ProviderTestPage4Model>().increase();
              },
            ),
            FloatingActionButton(
              heroTag: 'tag2',
              child: Text('N'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ProviderTestPage5()),
                );
              },
            ),
          ],
        );
      }),
    );
  }
}
