void main() {
  print('in test');

  var a = 1;
  // A value of type 'Object' can't be assigned to a variable of type 'int'.
  // a = Object();

  dynamic b = 1;
  b = Object();

  num c = 1;
  // The constructor returns type 'Object' that isn't of expected type 'num'.
  // c = Object();

  print('a = $a, b = $b, c = $c');

  // The constructor returns type 'BaseClass' that isn't of expected type 'ChildClass'.
  // ChildClass childClass = BaseClass();
}

class BaseClass {}

class ChildClass extends BaseClass {}
