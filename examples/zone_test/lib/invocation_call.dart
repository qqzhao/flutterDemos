void testInvocation() {
  print('in testInvocation');
  var method = Invocation.method(new Symbol('_innerTest'), ['message1', 'message2']);
  print('method.memberName = ${method.memberName}');
}

void _innerTest(String para1, String para2) {
  print('in innerTest, para1 = $para1, para2 = $para2');
}
