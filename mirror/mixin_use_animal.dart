import 'dart:mirrors';

abstract class Animal {
  // String name;
  @override
  int get hashCode => super.hashCode + 1;

  @override
  dynamic noSuchMethod(Invocation invocation) {}

  @override
  bool operator ==(Object other) {
    return other.runtimeType == runtimeType && other.hashCode == hashCode;
  }
}

class Cat extends Animal with PrintName {
  @override
  String name;

  @override
  void printName() {
    print('aaa = $name');
    print('bbb = ${super.name}');
  }
}

class Dog extends Animal with PrintName {}

mixin PrintName {
  String name = 'in name';
  void printName() {
    print('aaa = $name');
  }
}

void main() {
  Cat cat = Cat();
  print('cat = ${cat.name}');

  cat.printName();
  Dog()
    ..name = 'dog'
    ..printName();

  // Symbol("_Cat&Animal&PrintName") => Symbol("Animal") => Symbol("Object")
  ClassMirror cm = reflectClass(Cat);
  cm.instanceMembers.forEach((key, value) => print('$key >>> $value'));

  print('staticMembers=====');
  cm.staticMembers.forEach((key, value) => print('$key >>> $value'));

  print('declarations====='); // 不包含父类
  cm.declarations.forEach((key, value) => print('$key >>> $value'));

  ClassMirror cm2 = reflectClass(PrintName);
  print('cm2 = $cm2');

  ClassMirror cm3 = reflectClass(Animal);
  print('cm3 = $cm3');
}
