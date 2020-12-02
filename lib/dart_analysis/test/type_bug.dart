void main() {
  print('in main');
  var x = ['HelloX', '22'];
  dynamic y = x;

  // 之前： Error: Iterable<dynamic> is not an Iterable<String>
  // type 'MappedListIterable<String, dynamic>' is not a subtype of type 'Iterable<String>'
  var z1 = y.map((i) {
    print('i = $i');
    return i;
  });
  // var z2 = y.map((i) {
  //   print('i = $i');
  //   return i;
  // }).toList();
  // Iterable<String> z = z1;
  print('in main end $z1');
}

/// 为什么打印两次
/// in main
// i = HelloX
// i = 22
// i = HelloX
// i = 22
