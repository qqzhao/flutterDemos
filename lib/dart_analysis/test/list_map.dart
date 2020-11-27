void main() {
  print('in main');
  _list.map((e) => print('map1 = $e'));
  _list.map((e) => print('map2 = $e')).toList();
  _list.forEach((e) => print('forEach e = $e'));
}

List<String> _list = ['11', '22', '33'];
