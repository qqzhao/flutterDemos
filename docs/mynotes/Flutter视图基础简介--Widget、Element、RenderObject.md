

## Flutter视图基础简介--Widget、Element、RenderObject


### 1. Widget

定义： 描述Element的不可变的配置。

### 2. Element

定义： Element表示Widget配置树中的特定位置的实例。

```
Flutter创建Element的可见树，相对于Widget来说，是可变的，通常的Flutter界面开发中，我们不用直接操作Element,而是由框架层实现内部逻辑；就如一个UI视图树中，可能包含有多个TextWidget(Widget被使用多次)，但是放在内部视图树的视角，这些TextWidget都是填充到一个个独立的Element中
```

### 3. RenderObject

定义： 渲染树中的一个对象。负责渲染工作。

[原文](https://www.cnblogs.com/crashmaker/p/9123763.html)