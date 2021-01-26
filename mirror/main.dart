import 'dart:mirrors';

// ignore_for_file: unused_element

void main() {
  print('in main');
  _test2();
}

class BaseTest {
  void simple(a) {
    print('A new Simple: $a');
  }

  final int finalA = 10;
  int varB = 11;
  String varC = 'StringC';

  BaseTest({this.varB, this.varC});

  BaseTest.name1(this.varB, this.varC);

  static String varD = 'StringD';

  int printTest(int a) {
    print('in print test: $a');
    return 0;
  }

  static int printStaticTest(int a) {
    print('in print test: $a');
    return 0;
  }

  @override
  String toString() {
    return 'BaseTest{finalA: $finalA, varB: $varB, varC: $varC}';
  }
}

class SuperClass extends Object {
  int superField = 0;
  final int superFinalField = 1;
  int get superGetter => 2;
  set superSetter(int x) {
    superField = x;
  }

  int superMethod(x) => 4;

  static int superStaticField = 5;
  static final int superStaticFinalField = 6;
  static const superStaticConstField = 7;
  static int get superStaticGetter => 8;
  static set superStaticSetter(x) {}
  static int superStaticMethod(x) => 10;
}

class ChildClass extends SuperClass {
  int aField = 11;
  final int aFinalField = 12;
  int get aGetter => 13;
  set aSetter(int x) {
    aField = x;
  }

  int aMethod(x) => 15;

  static int staticField = 16;
  static final staticFinalField = 17;
  static const staticConstField = 18;
  static int get staticGetter => 19;
  static set staticSetter(int x) {
    staticField = x;
  }

  static int staticMethod(x) => 21;
}

void _test1() {
  ClassMirror cm = reflectClass(ChildClass);
  cm.instanceMembers.forEach((key, value) => print('$key >>> $value'));

  print('staticMembers=====');
  cm.staticMembers.forEach((key, value) => print('$key >>> $value'));

  print('declarations====='); // 不包含父类
  cm.declarations.forEach((key, value) => print('$key >>> $value'));
}

// 用反射构造对象
void _test2() {
  ClassMirror classMirror = reflectClass(BaseTest);

  InstanceMirror instanceMirror = classMirror.newInstance(Symbol('name1'), [2222, 'bbbb']);

  // 修改实例的值
  instanceMirror.setField(#varB, 22223);
  BaseTest baseTest3 = instanceMirror.mirrorObj as BaseTest;
  print('baseTest3 = $baseTest3');

  BaseTest baseTest2 = BaseTest(varB: 1111, varC: 'vvvvv');
  print('baseTest2 = $baseTest2');

  BaseTest baseTest = (classMirror.newInstance(Symbol(''), [], {#varB: 1112, #varC: 'XXX'})).reflectee as BaseTest;
  // BaseTest baseTest = (classMirror.newInstance(
  //   Symbol.empty,
  //   [], // 这里必须是空数组
  //   {Symbol('varB'): 111, Symbol('varC'): 'yyyy'},
  // )).reflectee as BaseTest;
  print('baseTest = $baseTest');

  print('Symbol(\'XX1\') == #XX1: ${Symbol('XX1') == #XX1}');
}

extension ObjectXX on Object {
  dynamic get mirrorObj {
    if (this is InstanceMirror) {
      InstanceMirror instanceMirror = this as InstanceMirror;
      if (instanceMirror.hasReflectee) {
        return instanceMirror.reflectee;
      }
    }
  }
}

// 可以发现父类静态成员没有出现在列表中，这是因为静态属性不会被继承、不能被ChildClass调用。
void _test3() {
  var a = SuperClass.superStaticField;
  print('a = $a');

  // The getter 'superStaticField' isn't defined for the type 'ChildClass'.
  // var b = ChildClass.superStaticField;
}

// 用反射调用类中实例方法，以及返回值
void _test4() {
  BaseTest baseTest2 = BaseTest(varB: 1111, varC: 'vvvvv');
  baseTest2.printTest(0);
  InstanceMirror instanceMirror2 = reflect(baseTest2);
  InstanceMirror res = instanceMirror2.invoke(Symbol('printTest'), [2222222]);
  print('res = ${res.reflectee}');
}

// 用反射调用类中实例方法，以及返回值
void _test4_2() {
  ClassMirror cm = reflectClass(BaseTest);
  InstanceMirror res = cm.invoke(Symbol('printTest'), [44]);
  print('res = ${res.reflectee}');
}

/// 用反射调用类中静态方法: 使用ClassMirror.invoke
// Unhandled exception:
// NoSuchMethodError: No static method 'printTest' declared in class 'BaseTest'.
// Receiver: BaseTest
void _test5() {
  ClassMirror cm = reflectClass(BaseTest);
  InstanceMirror res = cm.invoke(Symbol('printStaticTest'), [44]);
  print('res = ${res.reflectee}');
}

/// Object 构造ClassMirror
void _test6() {
  BaseTest baseTest2 = BaseTest(varB: 1111, varC: 'vvvvv');
  ClassMirror cm = reflect(baseTest2).type;
  print('cm = $cm');
}

void _test7() {
  BaseTest baseTest2 = BaseTest(varB: 1111, varC: 'vvvvv');
  TypeMirror cm = reflectType(baseTest2.runtimeType);
  print('cm = $cm');

  print('cm = ${cm.typeArguments}');
  print('cm = ${cm.typeVariables}');
  print('cm = ${cm.reflectedType}');
  print('cm = ${cm.originalDeclaration}');
}

class MyJsonEnable {
  const MyJsonEnable();
}

class MyJsonEnable2 {
  const MyJsonEnable2();
}

@MyJsonEnable2()
@MyJsonEnable()
class IncludeMyJsonClass {}

class ExcludeMyJsonClass {}

/// 测试 metaData
void _test8() {
  print('_testMetaData');
  ClassMirror cm1 = reflectClass(IncludeMyJsonClass);
  ClassMirror cm2 = reflectClass(ExcludeMyJsonClass);

  bool cm1Enable = cm1.metadata.any((element) => element.reflectee is MyJsonEnable);
  print('cm1Enable = $cm1Enable');

  bool cm1Enable2 = cm1.metadata.any((element) => element.reflectee is MyJsonEnable2);
  print('cm1Enable2 = $cm1Enable2');

  bool cm2Enable = cm2.metadata.any((element) => element.reflectee is MyJsonEnable);
  print('cm2Enable = $cm2Enable');
}
