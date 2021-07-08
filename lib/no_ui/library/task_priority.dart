import 'package:collection/collection.dart';

int _taskSorter(_TaskEntity e1, _TaskEntity e2) {
  /// 值越大，优先级越高
  return -e1.priority.compareTo(e2.priority);
}

final PriorityQueue<_TaskEntity> _taskQueue = HeapPriorityQueue<_TaskEntity>(_taskSorter);

class _TaskEntity {
  Future<void> Function() task;
  int priority;

  _TaskEntity({this.task, this.priority = 0});
}

Future<void> task1() async {
  await Future.delayed(Duration(seconds: 1));
  print('111');
}

Future<void> task2() async {
  await Future.delayed(Duration(seconds: 2));
  print('222');
}

Future<void> task3() async {
  await Future.delayed(Duration(seconds: 3));
  print('333');
}

void main() async {
  _taskQueue.add(_TaskEntity(task: task1, priority: 1));
  _taskQueue.add(_TaskEntity(task: task2, priority: 2));
  _taskQueue.add(_TaskEntity(task: task3, priority: 3));

  await runTask();
}

Future<void> runTask() async {
  while (_taskQueue.isNotEmpty) {
    var first = _taskQueue.first;
    await first.task.call();
    _taskQueue.removeFirst();
  }
}
