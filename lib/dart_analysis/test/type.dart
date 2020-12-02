void main() {
  print('in test');

  var a = 1;
  print('a.runtimeType = ${a.runtimeType}');

  int b = 1;
  print('b.runtimeType = ${b.runtimeType}');
  // ignore: unnecessary_type_check
  print('b is dynamic = ${b is dynamic}');
  // ignore: unnecessary_type_check
  print('b is Object = ${b is Object}');

  dynamic c = 1;
  print('c.runtimeType = ${c.runtimeType}');
  // ignore: unnecessary_type_check
  print('c is dynamic = ${c is dynamic}');

  num d = 1;
  print('d.runtimeType = ${d.runtimeType}');

  double e = 1;
  print('e.runtimeType = ${e.runtimeType}');

  Object f = 1;
  print('f.runtimeType = ${f.runtimeType}');
}
