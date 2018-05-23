

### 对比FlatButton和RaisedButton,差别是一些海报的属性(Elevation)。

 * FlatButton: 平坦的button
 * RaisedButton: 凸起的button。和FlatButton的区别主要是有没有凸起，也就是有没有evaluation（海拔）相关的属性。其他的属性都一样。都包括.icon方法。

```
const FlatButton({
  Key key,
  @required this.onPressed,
  this.onHighlightChanged,
  this.textTheme,
  this.textColor,
  this.disabledTextColor,
  this.color,
  this.disabledColor,
  this.highlightColor,
  this.splashColor,
  this.colorBrightness,
  this.padding,
  this.shape,
  @required this.child,
}) : super(key: key);


const RaisedButton({
  Key key,
  @required this.onPressed,
  this.onHighlightChanged,
  this.textTheme,
  this.textColor,
  this.disabledTextColor,
  this.color,
  this.disabledColor,
  this.highlightColor,
  this.splashColor,
  this.colorBrightness,
  this.elevation: 2.0,
  this.highlightElevation: 8.0,
  this.disabledElevation: 0.0,
  this.padding,
  this.shape,
  this.animationDuration: kThemeChangeDuration,
  this.child,
}) : assert(elevation != null),
     assert(highlightElevation != null),
     assert(disabledElevation != null),
     assert(animationDuration != null),
     super(key: key);
```