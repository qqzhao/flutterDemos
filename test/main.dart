import 'dart:async';

void main() {
  print('111');
  main2();
}

void main2() async {
//  var future = new Future.value(499);
  print('before future2');
  Future.delayed(Duration(seconds: 1), () {
    print('in delay');
  });
}
