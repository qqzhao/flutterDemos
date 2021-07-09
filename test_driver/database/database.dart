import 'package:flutter_driver/driver_extension.dart';

import 'database_app.dart' as app;

void main() {
  // This line enables the extension
  print('in main');
  enableFlutterDriverExtension(handler: handleMessage);

  // Call the `main()` function of your app or call `runApp` with any widget you
  // are interested in testing.
  app.main();
  print('in main end');
}

Future<String> handleMessage(String? message) async {
  print('message =$message');
  return '';
}
