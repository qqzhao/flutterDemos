

TODO: 

* schedule_microtask.dart 文件，工作机制

```
void _rootScheduleMicrotask(
    Zone self, ZoneDelegate parent, Zone zone, void f()) {
  if (!identical(_rootZone, zone)) {
    bool hasErrorHandler = !_rootZone.inSameErrorZone(zone);
    if (hasErrorHandler) {
      f = zone.bindCallbackGuarded(f);
    } else {
      f = zone.bindCallback(f);
    }
    // Use root zone as event zone if the function is already bound.
    zone = _rootZone;
  }
  _scheduleAsyncCallback(f);
}
```

_AsyncRun._scheduleImmediate(_startMicrotaskLoop); ??
