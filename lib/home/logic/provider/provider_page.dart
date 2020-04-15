import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Counter with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class NetworkData with ChangeNotifier {
  Map<String, dynamic> _data = {
    'name': '',
    'title': '',
    'list': [],
  };
  Map get data => _data;

  void request() async {
    print('NetworkData request');
    await Future.delayed(Duration(seconds: 3));
    _data = {
      'title': _data['title'] + '111_',
      'name': _data['name'] + '222_',
      'list': [111, 222, 333, 'aaa'],
    };
//    notifyListeners();
  }
}

class ProviderPageTest extends StatefulWidget {
  @override
  _ProviderPageTestState createState() => _ProviderPageTestState();
}

class _ProviderPageTestState extends State<ProviderPageTest> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
        ListenableProvider(create: (_) => NetworkData()),
      ],
      child: Consumer<Counter>(
        builder: (context, counter, _) {
          return MaterialApp(
            supportedLocales: const [Locale('en')],
            localizationsDelegates: [
              DefaultMaterialLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
              _ExampleLocalizationsDelegate(counter.count),
            ],
            home: const MyHomePage(),
          );
        },
      ),
    );
  }
}

class ExampleLocalizations {
  static ExampleLocalizations of(BuildContext context) {
    return Localizations.of<ExampleLocalizations>(context, ExampleLocalizations);
  }

  const ExampleLocalizations(this._count);

  final int _count;

  String get title => 'Tapped $_count times';
}

class _ExampleLocalizationsDelegate extends LocalizationsDelegate<ExampleLocalizations> {
  const _ExampleLocalizationsDelegate(this.count);

  final int count;

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'en';

  @override
  Future<ExampleLocalizations> load(Locale locale) {
    return SynchronousFuture(ExampleLocalizations(count));
  }

  @override
  bool shouldReload(_ExampleLocalizationsDelegate old) => old.count != count;
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Title()),
      body: const Center(child: CounterLabel()),
      floatingActionButton: const IncrementCounterButton(),
    );
  }
}

class IncrementCounterButton extends StatelessWidget {
  const IncrementCounterButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Provider.of<Counter>(context, listen: false).increment();
        Provider.of<NetworkData>(context, listen: false).request();
      },
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
}

class CounterLabel extends StatelessWidget {
  const CounterLabel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);
    final data = Provider.of<NetworkData>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'You have pushed the button this many times:',
        ),
        Text(
          '${counter.count}, ${data.data['name']}',
          // ignore: deprecated_member_use
          style: Theme.of(context).textTheme.display1,
        ),
        Selector<NetworkData, int>(
          child: Text('333'),
          selector: (_, foo) => foo.data['list'].length,
          builder: (BuildContext context, value, Widget child) {
            print('child selector = $child');
            return Text('value = ${value}');
          },
        ),
        Consumer<NetworkData>(
          child: Text('333'),
          builder: (BuildContext context, value, Widget child) {
            print('child consumer = $child');
            return Text('value consumer = ${value.data['list'].length}');
          },
        )
      ],
    );
  }
}

class Title extends StatelessWidget {
  const Title({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(ExampleLocalizations.of(context).title);
  }
}
