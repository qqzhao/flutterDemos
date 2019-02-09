
## flutter 中如何管理image的存储

在文件`painting/image_cache.dart`中。使用全局变量`PaintingBinding.instance.imageCache`进行image缓存的管理。

### 基本定义数据及说明
```dart
const int _kDefaultSize = 1000; // 默认最大可以缓存1000张图片，可以设置
const int _kDefaultSizeBytes = 100 << 20; // 默认最大可以缓存100M的图片,可以设置

final Map<Object, _CachedImage> _cache;//缓存Key和image实体对象
final Map<Object, ImageStreamCompleter> _pendingImages; //表示当前正在请求中的图片(比如网络，文件等)。目的是防止重复请求。一旦图片成功下来后，则会将_pendingImages中的Key移除。
```

使用了LRU(最近最少使用)的淘汰策略，当前正在被使用的图片可以被移除(evict)。
应该程序引用的方式包括如下几种：
* ImageStream对象
* ImageStreamCompleter对象
* ImageInfo对象
* 原始的dart:ui.Image对象

如果是网络中的图片，则需要重新从网络中获取。但是，只要应用程序一直使用，原始的字节数据会一直在内存中。也就是说evict函数会清除缓存中数据，但是只有应用程序真的不使用此图片的数据，它才会从内存中释放。

### 对外暴露借口

* putIfAbsent

是缓存Api的主要接口。如果存在的话，它会返回给定key对应的ImageStreamCompleter。如果不存在，它会调用load函数去获取，无论什么情况，key都会被一道最近使用的位置。
```
final _CachedImage image = _cache.remove(key);
    if (image != null) {
      _cache[key] = image;
      return image.completer;
    }
```

* evict
把一个实体从缓存中移除。如果成功移除，则返回true。如果key当前不可用，可以直接调用`ImageProvider.evict`。
```dart
 class MyWidget extends StatelessWidget {
   final String url = '...';

   @override
   Widget build(BuildContext context) {
     return Image.network(url);
   }

   void evictImage() {
     final NetworkImage provider = NetworkImage(url);
     provider.evict().then<void>((bool success) {
       if (success)
         debugPrint('removed image!');
    });
   }
 }
```
* clear
移除缓存中所有的image。

* precacheImage

预先去拉取一张图片进入图片缓存。以后可以用于`Image`,`BoxDecoration`,`FadeInImage`。不需要有同样的ImageProvider,只需要图片的key保持一样就可以(依据ImageCache中原理)。

* createLocalImageConfiguration

```dart
return ImageConfiguration(
    bundle: DefaultAssetBundle.of(context),
    devicePixelRatio: MediaQuery.of(context, nullOk: true)?.devicePixelRatio ?? 1.0,
    locale: Localizations.localeOf(context, nullOk: true),
    textDirection: Directionality.of(context),
    size: size,
    platform: defaultTargetPlatform,
  );
```
创建默认的Image配置。会指定bundle等。


### 内部的接口和对象
```dart
void _checkCacheSize() {
    while (_currentSizeBytes > _maximumSizeBytes || _cache.length > _maximumSize) {
      final Object key = _cache.keys.first;
      final _CachedImage image = _cache[key];
      _currentSizeBytes -= image.sizeBytes;
      _cache.remove(key);
    }
  }
class _CachedImage {
  _CachedImage(this.completer, this.sizeBytes);

  final ImageStreamCompleter completer;
  final int sizeBytes;
}
```
如果不满足要求，不断的移除第一个位置的对象。

### 可能的扩展使用

* 某个特别大的图片，直接调用evict，从缓存中清除。
* 在内存紧张的时候(memory warning)，直接调用clear函数，清除所有的图片缓存。
* 动态监测图片缓存的大小，观测其对系统整体内存的影响。
* 根据应用的不同，动态的调整缓存图片数目和最大缓存尺寸，也可以不使用缓存。
* 自己实现image_cache,实现自己想要的图片缓存策略。
* 未来要实现网络图片的本地缓存，该如何实现。(增加中间层)
