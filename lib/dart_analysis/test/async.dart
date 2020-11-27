import 'dart:async';

/// 同步和增加 await 之后可以捕获，异步捕获不到异常。
void main() async {
  test1();
}

void test1() {
  runZoned(() async {
    // FlutterError.onError = (detail) {
    //   print('onError: $detail');
    // };
    asyncFunc();
  }, onError: (error, stackTrace) {
    print("Error FROM OUT_SIDE FRAMEWORK ");
    print("--------------------------------");
    print("Error :  $error");
    print("StackTrace :  $stackTrace");
  });
}

void test2() async {
  try {
    // asyncFunc();
    syncFunc();
    // await asyncFunc();
  } catch (e) {
    print('e = $e');
  }
}

void asyncFunc() async {
  List a = [1];
  var b = a[2];
  print('b = $b');
}

void syncFunc() {
  List a = [1];
  var b = a[2];
  print('b = $b');
}
