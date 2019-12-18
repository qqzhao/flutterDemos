bool checkExceptionValid(dynamic e) {
  /// 处理 Exception: Invalid argument(s): Illegal argument in isolate message : (object is a closure - Function '<anonymous closure>':.)
  /// 其实属于上传成功
  /// var invalidMessagePre = 'Exception: Invalid argument(s): Illegal argument in isolate message';
  /// if (e.toString().startsWith(invalidMessagePre)) {
  ///  print('处理 Exception: Invalid argument(s): Illega');
  /// }
  if (e is Exception && '${e}'.contains('anonymous closure')) {
    return true;
  }
  return false;
}
