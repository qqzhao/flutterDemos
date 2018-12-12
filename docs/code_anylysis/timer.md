## Timer Class

### 1. 为什么抽象类的方法可以直接调用呢？比如，下面的代码

```
var timer = new Timer(new Duration(seconds: 1), () {
    print('ccc');
  });

print('timer = $timer');
```

打印的结果是`timer = Instance of '_Timer'`, 那**_Timer**又是什么类呢？

相同的类还有**Future**，也是Future直接调用函数。

### 2. 使用`abstract`类进行尝试

```
abstract class Musical{
  int ts = 0;
  Musical({this.ts});
  factory Musical.play(int ts){
    print('print mucial');
    //error: Abstract classes can't be created with a 'new' expression. 
    return Musical(ts: ts);
  }
}

class Player{
  int ts = 0;
  Player({this.ts});
  factory Player.play(int ts){
    print('print mucial');
    return Player(ts: ts);
  }
}
```

**Musical**是抽象类，但是发现其用工厂类构造的时候是有问题的。但是同类型的非抽象类**Player**则没有一点问题。还需要继续分析**Timer**类的源码。

### 3. 分析Timer Class

```dart
abstract class Timer {
  factory Timer(Duration duration, void callback()) {
    if (Zone.current == Zone.root) {
      // No need to bind the callback. We know that the root's timer will
      // be invoked in the root zone.
      return Zone.current.createTimer(duration, callback);
    }
    return Zone.current
        .createTimer(duration, Zone.current.bindCallbackGuarded(callback));
  }
}
```
代码的含义比较简单。当前是`root zone`的时候，直接创建定时器；否则，会增加`zone`的保护回调函数，让`zone`的异常处理，可以捕获到**Timer**回调中的异常。然后分析到zone中，发现它也是一个抽象类。

### 4. Zone类的结构

Zone是一个抽象类，不同于Timer中，它里面就有其实现。实现了两种，_Zone和_CustomZone.
```dart
abstract class _Zone implements Zone {
  const _Zone();
}
class _CustomZone extends _Zone {
  Timer createTimer(Duration duration, void f()) {
    var implementation = this._createTimer;
    assert(implementation != null);
    ZoneDelegate parentDelegate = _parentDelegate(implementation.zone);
    CreateTimerHandler handler = implementation.function;
    return handler(implementation.zone, parentDelegate, this, duration, f);
  }
}
Timer _rootCreateTimer(Zone self, ZoneDelegate parent, Zone zone,
    Duration duration, void callback()) {
  if (!identical(_rootZone, zone)) {
    callback = zone.bindCallback(callback);
  }
  return Timer._createTimer(duration, callback);
}

ZoneCallback<R> bindCallback<R>(R f()) {
  var registered = registerCallback(f);
  // 将回调运行在当前的zone中
  return () => this.run(registered);
}
ZoneCallback<R> registerCallback<R>(R callback()) {
  // _Custom 中的registerCallback回调函数。如果自定义的zone中，可以自己去实现这个处理函数。
  var implementation = this._registerCallback;
  assert(implementation != null);
  ZoneDelegate parentDelegate = _parentDelegate(implementation.zone);
  RegisterCallbackHandler handler = implementation.function;
  return handler(implementation.zone, parentDelegate, this, callback);
}

// 如果当前zone的specification上面的registerCallback存在（即自定义zone中配置了这个参数），
// 返回自己的，否则返回parent的。
_registerCallback = (specification.registerCallback != null)
        ? new _ZoneFunction<Function>(this, specification.registerCallback)
        : parent._registerCallback;
```

上面的代码看出，最终都会调用到root zone的创建Timer的函数`_rootCreateTimer`。这里也搞了一个类似于Timer里面的判断是否是root zone的判断，这里主要是为了将callback运行在对应的zone中。

### 5. 如果是root zone的话，调用`Timer._createTimer(duration, callback)`创建过程

在Timer文件中发现了如下这样一条：

```dart
external static Timer _createTimer(Duration duration, void callback());
```

这个`external`的静态函数，究竟在什么地方实现呢，还没有研究出来；还有一点创建出来以后，为什么是`_Timer类型`。应该是有类似于_Zone实现类Zone，有_Timer类实现Timer类的代码没找到。示例如下：

```dart
class _Timer implements Timer{
    static _Timer _createTimer(Duration duration, void callback()){
        //具体创建_Timer 的过程。
    }
}
```