import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 自己保存 context 会有脱离 build 函数，但是具体怎么用呢？
class ProviderTestPage5 extends StatefulWidget {
  @override
  _ProviderTestPage5State createState() => _ProviderTestPage5State();
}

class _ProviderTestPage5State extends State<ProviderTestPage5> {
  _ProviderTestPage5Model model;

  /// 监听器
  var _listener;

  @override
  void initState() {
    _listener = () {
      setState(() {});
    };
    super.initState();
  }

  @override
  void dispose() {
    model?.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      model = _ProviderTestPage5Model(read: context.read);
      model.addListener(_listener);
    }

    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('provider test 5'),
          ),
          body: Container(
            height: 100,
            child: Center(
              child: Text('aaa:${model.counter}'),
            ),
          ),
          persistentFooterButtons: <Widget>[
            FloatingActionButton(
              heroTag: 'tag1',
              child: Text('11'),
              onPressed: () {
                model.increase();
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
      },
    );
  }
}

class _ProviderTestPage5Model extends ChangeNotifier {
//  final BuildContext context;
  final Locator read;
  _ProviderTestPage5Model({
    this.read,
  });

  int _counter = 0;

  int get counter => _counter;

  void increase() {
    _counter++;
    notifyListeners();
  }

  /// 有什么用呢？
  void printFun() {
    print(read<_ProviderTestPage5Model>().counter);
  }
}
