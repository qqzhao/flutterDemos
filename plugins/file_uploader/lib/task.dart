class TaskSession<T> {
  bool looping = false; // 标识是否在循环中
  @override
  Future<bool> taskExist() async {
    return false;
  }

  @override
  Function getNextTask() {
    return () async {};
  }

  void addTask(T item) async {}

  void removeTask(String taskId) async {}

  void doLoop() async {
    if (!looping) {
      looping = true;
      while (await taskExist()) {
        beforeTask();
        Function nextT = getNextTask();
        await nextT();
        afterTask();
//        await Future.delayed(Duration(seconds: 5));
      }
      looping = false;
    }
  }

  void beforeTask() {
    _inPrint('beforeTask');
  }

  void afterTask() {
    _inPrint('afterTask');
  }
}

void _inPrint(str) {
//  print('task: $str');
}
