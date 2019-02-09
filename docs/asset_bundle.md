源文件地址：`flutter/lib/src/services/asset_bundle.dart`

## flutter 中的资源集合

`Asset bundles`包含像图片或者字符串资源。

* NetworkAssetBundle 异步从网络加载资源
* 或者从本地加载。(不会阻塞UI构建)

### rootBundle

```dart
final AssetBundle rootBundle = _initRootBundle();
```

当应用程序构建的时候，包含的资源。需要：
* 1. 在assets目录下配置添加源文件
* 2. 在yaml文件中配置文件

注意：通常不会直接使用全局的变量`rootBundle`,而是使用`DefaultAssetBundle.of`，通过当前的`context`来或者祖先中最近的bundle。为方便使用，顶部的`widget [WidgetsApp] or [MaterialApp]`会去配置`DefaultAssetBundle`为`rootBundle`。
```dart
static AssetBundle of(BuildContext context) {
    final DefaultAssetBundle result = context.inheritFromWidgetOfExactType(DefaultAssetBundle);
    return result?.bundle ?? rootBundle;
}
```

### DefaultAssetBundle

可以指定它子孙的默认bundle的widget。

例如，`Image`中决定`AssetImage`中的bundle要用哪一个。

也可以用于测试中，覆盖当前的bundle。也就是在测试条件下允许注入制定的资源，例子如下：

 ```dart
 class TestAssetBundle extends CachingAssetBundle {
   @override
   Future<ByteData> load(String key) async {
     if (key == 'resources/test')
       return ByteData.view(Uint8List.fromList(utf8.encode('Hello World!')).buffer);
     return null;
   }
 }
 await tester.pumpWidget(
   MaterialApp(
     home: DefaultAssetBundle(
       bundle: TestAssetBundle(),
       child: TestWidget(),
     ),
   ),
 );

var b = DefaultAssetBundle.of(context).loadString(widget.resource);
b.then((strValue) {
    print('bValue = $strValue');
});
 ```
 当请求`resources/test`的时候，会看到`Hello World!`，而不是原始AssetBundle中的值。
