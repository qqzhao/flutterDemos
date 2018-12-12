import 'dart:async';

void _handleUncaughtError(Zone self, ZoneDelegate parent, Zone zone, dynamic exception, StackTrace stack) {
  print('exception = $exception');
  print('self = $self');
  print('zone = $zone');
}

// 这个不会被调--
void _printHandle(Zone self, ZoneDelegate parent, Zone zone, String line) {
  print('aaa = XX $line');
  parent.print(zone, line);
}

ScheduleMicrotaskHandler _microTaskHandler = (Zone self, ZoneDelegate parent, Zone zone, void f()) {
  print('_microtaskHandler --- before');
  f();
};

R _testRun<R>(Zone self, ZoneDelegate parent, Zone zone, R Function() f) {
  print('in testRun------before');
  return f();
}

void testRun() {
  final ZoneSpecification errorHandlingZoneSpecification = ZoneSpecification(
    handleUncaughtError: _handleUncaughtError,
    run: _testRun,
//    scheduleMicrotask: _microTaskHandler,
    print: _printHandle,
  );
  var _parentZone = Zone.current;
  final Zone testZone = _parentZone.fork(specification: errorHandlingZoneSpecification);
//  testZone.runBinary<Future<void>, Future<void> Function(), VoidCallback>(_runTestBody, testBody, invariantTester)
//      .whenComplete(testCompletionHandler);

//  testZone.runGuarded(() {
//    var curZone = Zone.current;
//    print('curZone = $curZone');
//    throw new Exception('exception2');
//  });
//  print('exception2 after');

  testZone.scheduleMicrotask(() {
    print('scheduleMicrotask callback');
  });

//  testZone.run(() {
//    throw new Exception('exception3');
//  });
//  print('exception3 after'); // 不会执行到这一句
}
