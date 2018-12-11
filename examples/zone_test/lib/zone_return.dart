import 'dart:async';

// runZoned 后面跟的是返回值的类型
void testRunReturn() {
  var retValue = runZoned<String>(_innerEntry, onError: (e, s) {});

  print('retValue = $retValue');
}

String _innerEntry() {
  return '_innerEntry';
}
