import 'package:flutter/material.dart';
import 'package:hello/home/logic/provider/models.dart';
import 'package:hello/home/logic/provider/provider_page2.dart';
import 'package:provider/provider.dart';

class CounterLabel extends StatelessWidget {
  const CounterLabel({Key? key}) : super(key: key);

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
          selector: (_, foo) => (foo.data['list'] as List).length,
          builder: (BuildContext context, value, Widget? child) {
            print('child selector = $child');
            return Text('value = ${value}');
          },
        ),
        Consumer<NetworkData>(
          child: Text('333'),
          builder: (BuildContext context, value, Widget? child) {
            print('child consumer = $child');
            return Text('value consumer = ${value.data['list'].length}');
          },
        ),
        Container(
          color: Colors.red,
          height: 70.0,
          child: GestureDetector(
            child: Text('jump to page2'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProviderTestPage2(),
              ));
            },
          ),
        ),
      ],
    );
  }
}
