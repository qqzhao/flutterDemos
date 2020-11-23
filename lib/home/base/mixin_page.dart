import 'package:flutter/material.dart';

class A {
  String getMessage() => 'A';
}

class B {
  String getMessage() => 'B';
}

class P {
  String getMessage() => 'P';
}

class AB extends P with A, B {}

class BA extends P with B, A {}

///////////////// Super
abstract class Super {
  void method() {
    print("Super");
  }
}

class MySuper implements Super {
  @override
  void method() {
    print("MySuper");
  }
}

//  使用的时候，这个 Super 会找到对应的非抽象类
mixin Mixin on Super {
//  void method() {
//    super.method();
//    print("Sub");
//  }
}

// 和下面的报错一样
//class ClientP1 extends P with Mixin {}

//// 这样加也不行，报错：
// error: The class doesn't have a concrete implementation of the super-invoked member 'method'.
// error: The class doesn't implement the required class 'Super'.
//class ClientP2 extends P with Mixin {
//  void method(){}
//}

// 这里Mixin对应的非抽象类就是MySuper
class Client extends MySuper with Mixin {}

class MixinTestPage extends StatelessWidget {
  void _testMixin() {
    String result = '';
    AB ab = AB();
    result = ab.getMessage();
    print('result = $result'); // result = B

    BA ba = BA();
    result = ba.getMessage();
    print('result = $result'); // result = A
  }

  void _testMixin2() {
    AB ab = AB();
    print(ab is P);
    print(ab is A);
    print(ab is B);

    BA ba = BA();
    print(ba is P); // true
    print(ba is A); // true
    print(ba is B); // true
  }

  void _testMixin3() {
    // MySuper
    // Sub
    Client().method();
  }

  /// ignore: unused_element
  void _testMixin4() {
//    class S {
//    a() {print("S.a");}
//    }
//
//    class A {
//    a(){print("A.a");}
//    b(){print("A.b");}
//    }
//
//    class B {
//    a(){print("B.a");}
//    b(){print("B.b");}
//    c(){print("B.c ");}
//    }
//
//    class T = B with A, S;
//
//    T t = new T();
//    t.a();
//    t.b();
//    t.c();
//  输入：
//    S.a
//    A.b
//    B.c
  }

  @override
  Widget build(BuildContext context) {
    _testMixin();
    _testMixin2();
    _testMixin3();
    return new Container(
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('test mixin'),
        ),
      ),
    );
  }
}

// 原文：https://medium.com/flutter-community/dart-what-are-mixins-3a72344011f3
// 翻译：https://juejin.im/post/5bb204d3e51d450e4f38e2f6
