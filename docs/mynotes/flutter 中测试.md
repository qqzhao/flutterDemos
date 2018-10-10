

## Flutter中测试

flutter 中测试分为单元测试和继承测试

### 单元测试

* 可以测试纯网络模块
* 无法测试插件，除非自己实现插件channel模拟。参考`path_provider` 和 `sqlite`插件的实现

### 集成测试

* 命令 `flutter drive --target=my_app/test_driver/user_list_scrolling.dart
* 可以测试界面元素，如button text等
* 无法导入 dart:ui 组件。导致很多功能无法测试，如`shared_preferences`中就引入了dart:ui 组件。

### 总结

测试框架还很不成熟。