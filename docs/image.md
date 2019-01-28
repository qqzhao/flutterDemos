### Image 结构说明

1. Codec: 图像编解码器的句柄，Native的定义类.

2. Ui.Image: 原始解码图像数据(像素)的句柄。 通过instantiateImageCodec 进行转换

```
final Uint8List bytes = await consolidateHttpClientResponseBytes(response);
return await PaintingBinding.instance.instantiateImageCodec(bytes);
```

3. ImageInfo： 相应比例(scale)的ui.Image对象, 用于ImageStream中真实的Image对象

4. ImageStream: Image资源的句柄

基础图像对象可能会随着时间而更改，原因可能是图像正在设置动画，或者底层图像资源发生了变化。
内部包含ImageStreamCompleter。

5. ImageStreamCompleter： 用于管理ImageStream中ui.Image的加载的基类。

[ImageStreamListener]对象很少直接构造。通常，[ImageProvider]子类将返回一个[ImageStream]，并在可能的情况下自动将其配置为正确的[ImageStreamCompleter]。

6. ImageErrorListener: 解析图像时报告错误的签名。

```
typedef ImageErrorListener = void Function(dynamic exception, StackTrace stackTrace);
```

7. MultiFrameImageStreamCompleter: 多帧Image的加载和调度

8. AssetBundleImageKey： 由[AssetImage]或[ExactAssetImage]获取的图像的键。

这用于标识[imageCache]中的精确资源。

9. Image

10. RawImage

11. ImageProvider(resolve)->AssetBundleImageProvider(load)->AssetImage(obtainKey)

12. ImageCache(PaintingBinding.instance.imageCache) 是缓存<Key, ImageStreamCompleter>的

### 加载Image.network('')的过程

```
new Container(
          width: 200.0,
          height: 200.0,
          color: Colors.purple,
          child: new Image.network('$url'),
        )
_resolveImage(_ImageState)
    -->resolve(ImageProvider)
        -->obtainKey(ImageProvider的子类,key作为PaintingBinding.instance.imageCache中的key)
            -->putIfAbsent(ImageStreamCompleter)
                -->load(ImageProvider的子类,如果缓存中存在，则直接返回，否则进行load)
                    -->_loadAsync(NetworkImage, 网络请求，获取图片数据)
                        -->instantiateImageCodec(Codec，生成Codec对象)
                            -->_handleCodecReady(MultiFrameImageStreamCompleter)
                                -->_decodeNextFrameAndSchedule(MultiFrameImageStreamCompleter)
                                    -->_codec.getNextFrame(调用native)
                                        -->_emitFrame(单张图片的情况)
                                            -->setImage(ImageStreamCompleter)
                                                -->_handleImageChanged(_ImageState,回调)
                                                    -->setState(_ImageState， 更新界面)
```

上面是以`Image.network`为入口的加载图片的整个流程.

### Native 层代码

其中有几个地方调用了navite引擎层的代码。下面简单看下(在路径`engine/lib/ui/patting/codec.cc`)：

进行接口的注册
```
#define FOR_EACH_BINDING(V) \
  V(Codec, getNextFrame)    \
  V(Codec, frameCount)      \
  V(Codec, repetitionCount) \
  V(Codec, dispose)
void Codec::RegisterNatives(tonic::DartLibraryNatives* natives) {
  natives->Register({
      {"instantiateImageCodec", InstantiateImageCodec, 3, true},
  });
  natives->Register({FOR_EACH_BINDING(DART_REGISTER_NATIVE)});
}
```
上面是定义了`instantiateImageCodec`, `Codec_dispose`, `Codec_getNextFrame`, `Codec_frameCount`等接口。
重点看下`instantiateImageCodec`：
```
instantiateImageCodec
    -->InitCodecAndInvokeCodecCallback
        -->InitCodec(image_info不存在的时候)
            -->DecodeImage
                -->InvokeCodecCallback(将Native层的codec对象返回)
```

### 类结构说明
```
ImageProvider(继承类NetworkImage, MemoryImage, FileImage,AssetBundleImageProvider)
resolve(所有的开始入口)
evict
**obtainKey**(子类实现)
**load**(子类实现)
```

### 其他

有的时候我们需要像Android那样使用一个占位图或者图片加载出错时显示某张特定的图片，这时候需要用到 FadeInImage 这个组件。
第一种方法是加载一个本地的占位图，第二种是加载一个透明的占位图，但是需要注意的是，这个组件是不可以设置加载出错显示的图片的；这里有另一种方法可以使用第三方 package 的 CachedNetworkImage 组件。

[from](https://juejin.im/post/5c00a971f265da61776bb1c6)