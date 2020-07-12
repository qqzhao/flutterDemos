import 'package:flutter_test/flutter_test.dart';

import 'package:z_notification/z_notification.dart';

void main() {
  test('test base notification', () async{
    var object1 = Object();
    var object2 = Object();
    var curMessage;

    NotificationCenter.instance.addObserver(
        observer: object1,
        key: 'key1',
        callback: (message) {
          print('message object1 = $message');
          curMessage = message;
        });

    NotificationCenter.instance.addObserver(
        observer: object2,
        key: 'key2',
        callback: (message) {
          print('message object2 = $message');
          curMessage = message;
        });

    NotificationCenter.instance.post(key: 'key1', data: 'post data1');
    expect(curMessage, 'post data1');
    NotificationCenter.instance.post(key: 'key2', data: 'post data2');
    expect(curMessage, 'post data2');

    NotificationCenter.instance.removeObserver(observer: object1);
    NotificationCenter.instance.post(key: 'key1', data: 'post data1');
    expect(curMessage, 'post data2');

    NotificationCenter.instance.post(key: 'key2', data: 'post data3');
    expect(curMessage, 'post data3');
  });
}
