void testTry() {
  try {
    throw new Exception('exception Try');
  } catch (e, s) {
    // try 异常可以带栈
    print('e = $e, \n s = $s');
  }
}
