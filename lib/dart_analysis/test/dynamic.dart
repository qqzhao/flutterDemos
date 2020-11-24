void main() {
  print('in test');
  var sum1 = sum(1, 2, 3);
  print('sum1 = $sum1');

  // Unhandled exception:
  // type 'String' is not a subtype of type 'num' of 'other'
  var sum2 = sum(1, 2, '3');
  print('sum2 = $sum2');
}

/// 这里的类型可选，其实可以当做动态处理。
dynamic sum(a, b, c) {
  return a + b + c;
}

// error: The name 'sum' is already defined.
// dynamic sum(int a, int b) {
//   return a + b;
// }
