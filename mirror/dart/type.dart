void main() {
  // bool test = true;
  testType(true);
  testType(false);

  String c = '111';
  Object d = '111';
  var e = '111';
  print('c == d: ${c == d}, e==d: ${e == d}');

  /// A value of type 'int' can't be assigned to a variable of type 'String'.
  // c = 111;
  d = 111;

  /// A value of type 'int' can't be assigned to a variable of type 'String'.
  // e = 111;
}

void testType(bool test) {
  dynamic c;
  print('c.type before = ${c?.runtimeType}');
  c = test ? 111 : 'str';
  print('c.type = ${c.runtimeType}');

  c = 111;
  print('c.type after = ${c.runtimeType}');
}
