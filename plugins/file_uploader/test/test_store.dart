import 'package:file_uploader/store.dart';

int main() {
  UploadTaskProvider.open();
  test();
  return 0;
}

void test() async {
  await UploadTaskProvider.insert(UploadTaskItem(taskId: 'id1', data: '1111'));
  await UploadTaskProvider.insert(UploadTaskItem(taskId: 'id2', data: '1111'));
  await UploadTaskProvider.insert(UploadTaskItem(taskId: 'id3', data: '3333'));

  var items = await UploadTaskProvider.getItems();
  print('item = ${items}');

  await UploadTaskProvider.remove('id1');
  items = await UploadTaskProvider.getItems();
  print('item = ${items}');
}
