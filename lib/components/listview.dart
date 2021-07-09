import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyListView extends BoxScrollView {
  final Widget? header; // added
  final Widget? bottom; // added

  final double? itemExtent;
  final SliverChildDelegate childrenDelegate;

  MyListView.builder({
    Key? key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    this.itemExtent,
    IndexedWidgetBuilder? itemBuilder,
    int? itemCount,
    this.header,
    this.bottom,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    double? cacheExtent,
  })  : childrenDelegate = new SliverChildBuilderDelegate(
          (context, index) {
            if (header is Widget && index == 0) return header;
            if (bottom is Widget && header is Widget && index == itemCount! + 1) return bottom;
            if (bottom is Widget && index == itemCount && !(header is Widget)) return bottom;

            int newIndex = index;
            if (header is Widget) {
              newIndex = index - 1;
            }
            return itemBuilder?.call(context, newIndex);
          },
          childCount: (header is Widget && bottom is Widget) ? (itemCount! + 2) : ((header is Widget || bottom is Widget) ? (itemCount! + 1) : (itemCount)),
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
        ),
        super(
            key: key,
            scrollDirection: scrollDirection,
            reverse: reverse,
            controller: controller,
            primary: primary,
            physics: physics,
            shrinkWrap: shrinkWrap,
            padding: padding,
            cacheExtent: cacheExtent);

  @override
  Widget buildChildLayout(BuildContext context) {
    if (itemExtent != null) {
      return new SliverFixedExtentList(
        delegate: childrenDelegate,
        itemExtent: itemExtent!,
      );
    }
    return new SliverList(delegate: childrenDelegate);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(new DoubleProperty('itemExtent', itemExtent, defaultValue: null));
  }
}
