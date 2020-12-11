abstract class AbstractA {
  String name;
  String age;

  /// 抽象类可以实现方法
  void outputName() {
    print('name = $name');
  }

  void outputAge();
}

class A extends AbstractA {
  @override
  void outputAge() {
    print('age = $age');
  }
}

void main() {
  A()
    ..name = 'Andy'
    ..outputName();
}
