import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hello/home/logic/provider/count_label.dart';
import 'package:hello/home/logic/provider/models.dart';
import 'package:provider/provider.dart';

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
        Provider<MyIntValue>(
          create: (BuildContext context) {
            print('provider create');
            return MyIntValue(value2: 100);
          },
          dispose: (BuildContext context, MyIntValue value) {
            print('provider dispose');
          },
        ),
        ChangeNotifierProvider(create: (_) => Counter()),
        ListenableProvider(create: (_) => NetworkData()),
        Consumer<MyIntValue>(
          builder: (context, myIntValue, child) => Provider.value(value: myIntValue.value2 - 10, child: child),
          child: Text('11111: '),
        ),
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
        var value2 = Provider.of<MyIntValue>(context, listen: false).value2;
        print('value2 = $value2');

//        var value3 = Provider.of<MyIntValue>(context, listen: false).value;
//        print('value3 = $value3');
      },
      tooltip: 'Increment',
      child: const Icon(Icons.add),
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
