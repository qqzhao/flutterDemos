import 'dart:async';

Future future;
void testHandleError() {
  runZoned(() {
    // The asynchronous error is caught by the custom zone which prints
    // 'asynchronous error'.
    future = new Future.error("asynchronous error");
  }, onError: (e) {
    print(e);
  }); // Creates a zone with an error handler.
  // The following `catchError` handler is never invoked, because the
  // custom zone created by the call to `runZoned` provides an
  // error handler.
  future.catchError((e) {
    throw "is never reached";
  });
}

void testHandleError2() {
  runZoned(() {
    // The following asynchronous error is *not* caught by the `catchError`

    // in the nested zone, since errors are not to cross zone boundaries

    // with different error handlers.
    // Instead the error is handled by the current error handler,
    // printing "Caught by outer zone: asynchronous error".
    var future = new Future.error("asynchronous error");
    runZoned(() {
      future.catchError((e) {
        throw "is never reached";
      });
    }, onError: (e) {
      throw "is never reached";
    });
  }, onError: (e) {
    print("Caught by outer zone: $e");
  });
}
