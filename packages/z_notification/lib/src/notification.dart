import 'package:logging/logging.dart';

typedef NotificationCallback = Function(dynamic object);

class NotificationCenter {
  static NotificationCenter _singleton;

  NotificationCenter._init();

  static NotificationCenter get instance {
    if (_singleton == null) {
      _singleton = NotificationCenter._init();
      hierarchicalLoggingEnabled = true;
      Logger.root.onRecord.listen((record) {
        print('${record.level.name}: ${record.time}: ${record.message}');
      });
      _singleton.log.level = Level.INFO;
    }
    return _singleton;
  }

  static NotificationCenter get shared {
    return instance;
  }

  factory NotificationCenter() => _singleton;

  Logger log = Logger('z_notification');
  List<_Notification> _notifications = [];
//  final StreamController _controller = StreamController.broadcast(sync: true);

  void addObserver({
    Object observer,
    String key,
    NotificationCallback callback,
  }) {
    if (observer == null || key == null || callback == null) {
      log.severe('add: the param error');
      return;
    }
    _notifications.add(_Notification(key: key, observer: observer, callback: callback));
  }

  void removeObserver({Object observer, String key}) {
    if (observer == null) {
      log.severe('remove: the param error');
      return;
    }

    var removedItems = [];
    if (key == null) {
      removedItems = _notifications.where((element) => element.observer == observer).toList();
      _notifications.removeWhere((element) => element.observer == observer);
    } else {
      removedItems = _notifications.where((element) => element.key == key && element.observer == observer).toList();
      _notifications.removeWhere((element) => element.key == key && element.observer == observer);
    }
    log.info('removedItems.count = ${removedItems.length}');
  }

  void post({String key, dynamic data, Object sendObject}) {
    log.info('send = $sendObject, key = $key');
    if (key == null) {
      log.severe('post: the param error');
      return;
    }
    var items = _notifications.where((element) => element.key == key).toList();
    items.forEach((element) {
      if (element.callback != null) {
        element.callback(data);
      }
    });
  }
}

class _Notification {
//  final StreamController controller;
  final String key;
  final Object observer;
  final NotificationCallback callback;

  _Notification({this.key, this.observer, this.callback});
}
