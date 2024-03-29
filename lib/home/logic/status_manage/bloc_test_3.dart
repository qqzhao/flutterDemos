import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

/// 类比 test1， 反应有点延迟。
class BlocTestPage3 extends StatefulWidget {
  @override
  _BlocTestPage1State createState() => _BlocTestPage1State();
}

class _BlocTestPage1State extends State<BlocTestPage3> {
  int _counter = 0;
  @override
  void initState() {
    // _globalCounterBloc.onEvent = ((event) {
    //   setState(() {
    //     _counter = event.;
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    BlocBuilder
    return Scaffold(
      appBar: AppBar(
        title: Text('bloc test 3'),
      ),
      body: Text('aa:$_counter'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Bloc.observer = SimpleBlocDelegate();
          final counterBloc = CounterBloc();
          counterBloc.add(CounterEvent.increment);
          counterBloc.add(CounterEvent.increment);
          counterBloc.close();
        },
      ),
      persistentFooterButtons: <Widget>[
        FloatingActionButton(
          heroTag: '222',
          child: Text('222'),
          onPressed: () {
            _globalCounterBloc.add(CounterEvent.increment);
          },
        ),
        FloatingActionButton(
          heroTag: '111',
          child: Text('111'),
          onPressed: () {
            _globalCounterBloc.add(CounterEvent.decrement);
          },
        ),
      ],
    );
  }
}

CounterBloc _globalCounterBloc = CounterBloc();

enum CounterEvent { increment, decrement }

/// 感觉有点类似于 ChangeNotifier，需要监听
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0);

  // @override
  // int get initialState => 0;

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.decrement:
        // Simulating Network Latency
        await Future<void>.delayed(Duration(seconds: 1));
        yield state - 1;
        break;
      case CounterEvent.increment:
        // Simulating Network Latency
        await Future<void>.delayed(Duration(milliseconds: 500));
        yield state + 1;
        break;
      default:
        throw Exception('unhandled event: $event');
    }
  }
}

/// 监听事件的回调
class SimpleBlocDelegate extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    print('bloc: ${bloc.runtimeType}, event: $event');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('bloc: ${bloc.runtimeType}, transition: $transition');
    super.onTransition(bloc, transition);
  }

//   @override
//   void onError(Cubic cubic, Object error, StackTrace stackTrace) {
//     print('bloc: ${cubic.runtimeType}, error: $error');
//     super.onError(cubic, error, stackTrace);
//
// //    var a = AbstractAImpl();
// //    a._counter = 3;
// //    print('${a.counter}');
//   }
}

abstract class AbstractA {
  late int _counter;

  int get counter => _counter;

  void printA();
}

//class AbstractAImpl extends AbstractA {}
