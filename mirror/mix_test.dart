abstract class PP {
  void pp();

  int a = 1;
}

mixin PPMixin {
  void pp() {
    print('in PPMixin pp; $a');
  }

  int a = 2;
}

class A extends PP {
  @override
  void pp() {
    print('in A, $a');
  }
}

// // Classes can only extend other classes.
// class AMixin extends PPMixin {
//   @override
//   void pp() {
//     print('in A, $a');
//   }
// }

class B implements PP {
  @override
  void pp() {
    print('in B, $a');
  }

  @override
  int a;
}

class BMixin implements PPMixin {
  @override
  void pp() {
    print('in B, $a');
  }

  @override
  int a;
}

class C with PP {
  @override
  void pp() {
    print('in C, $a');
  }
}

class CMixin with PPMixin {
  @override
  void pp() {
    print('in CMixin, $a');
    super.pp();
  }

  @override
  int a = 3;
}

mixin OutputNameMixin {
  String outputName() {
    dynamic obj = this;
    try {
      var outStr = 'your name is ${obj.name}';
      print(outStr);
      return outStr;
    } catch (e) {
      return '发生异常:$e';
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    print('no such method: ${invocation.memberName}');
    return super.noSuchMethod(invocation);
  }
}

class TestA with OutputNameMixin {
  String name;
  TestA({this.name});

  void printA() => print('AAAAA');
}

class TestB with OutputNameMixin {
  int age;
  TestB({this.age});
}

void main() {
  var a = A();
  a.pp();

  var b = B();
  b.pp();

  var c = C();
  c.pp();

  var cMixin = CMixin();
  cMixin.pp();

  var r = TestA(name: 'Andy').outputName();
  print('r = $r');
  r = TestB(age: 33).outputName();
  print('r = $r');

  Function.apply(TestA(name: 'Andy').printA, null);
}
