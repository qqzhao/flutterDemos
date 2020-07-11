/// 需要先调用： XFlexible.registerWidth(MediaQuery.of(context).size.width);
/// 然后使用 20.w设置
class XFlexible {
  static double _baseWidth = 375.0;
  static double _realWidth = 375.0;
  static double _scaleWidth = _realWidth / _baseWidth;

  static registerWidth(double width) {
    _realWidth = width;
    print('width = $width');
    _scaleWidth = _realWidth / _baseWidth;
  }
}

extension FlexibleDouble on num {
  num get w {
//    return this.toDouble();
//    return this * XFlexible._scaleWidth;
    var a = (this * XFlexible._scaleWidth).floorToDouble();
    return a;
  }
}
