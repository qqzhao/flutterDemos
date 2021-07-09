import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'print.dart';
import 'ui_blueprints_rectangle.dart';

// ignored: constant_identifier_names
const _cTag = '【_Fx】';

class Info {
  static bool initialed = false;

  static Info? _instance;

  static Info get instance {
    assert(initialed, "未初始化完成");
    return _instance!;
  }

  ///适配之后，每个逻辑像素对应的设备像素数
  final double actualPixelRatio;

  ///设计稿尺寸
  final BlueprintsRectangle uiBlueprints;

  final bool enableLog;

  ///长度差值
  double deltaLength = -1;

  EdgeInsets _deltaPadding = EdgeInsets.zero;

  double _bodyMaxLength = -1;

  Info._({required this.actualPixelRatio, required this.uiBlueprints, required this.enableLog});

  factory Info.init({required double actualPixelRatio, required BlueprintsRectangle uiBlueprints, bool enableLog = false}) {
    _instance ??= Info._(actualPixelRatio: actualPixelRatio, uiBlueprints: uiBlueprints, enableLog: enableLog);
    initialed = true;
    return _instance!;
  }

  ///密度无关像素，每个逻辑像素对应的设备像素数。就像 dp 或者 pt
  double get devicePixelRatio => window.devicePixelRatio;

  double get bodyMaxLength => _bodyMaxLength;

  EdgeInsets get deltaPadding => _deltaPadding;

  ///设备显示区域dp尺寸
  Size get actualDpSize => window.physicalSize / actualPixelRatio;

  /// value*restoreRatio=未适配之前的value
  double get restoreRatio => devicePixelRatio / actualPixelRatio;

  ///还原为设备原始实际值
  double restore2DeviceValue(double dpValue) {
    return dpValue * restoreRatio;
  }

  EdgeInsets restore2DeviceEdgeInsets(EdgeInsets dpEdgeInsets) {
    return dpEdgeInsets * restoreRatio;
  }

  Size restore2DeviceSize(Size dpSize) {
    return dpSize * restoreRatio;
  }

  void onScreenMetricsChange(MediaQueryData queryData) {
    var deltaTg = 1 / window.physicalSize.aspectRatio - 1 / uiBlueprints.aspectRatio;
    _deltaPadding = restore2DeviceEdgeInsets(queryData.padding) - queryData.padding;
    deltaLength = deltaTg * uiBlueprints.width;
    bool isVertical = window.physicalSize.width <= window.physicalSize.height;
    double vertical = restore2DeviceEdgeInsets(queryData.padding).vertical;
    if (enableLog) print("原MediaQueryData=$queryData \n vertical=$vertical");
    if (isVertical) {
      _bodyMaxLength = uiBlueprints.length - vertical + deltaLength;
    } else {
      _bodyMaxLength = uiBlueprints.width - vertical;
    }
    _printInfo();
  }

  void _printInfo() {
    if (!enableLog) return;
    print("$_cTag △L=$deltaLength 状态栏△L=${_deltaPadding.vertical} _bodyMaxLength=$_bodyMaxLength");
    print("$_cTag 设计稿标准尺寸 = $uiBlueprints h/w tgθ= ${1 / uiBlueprints.aspectRatio}");
    print("$_cTag 设备的屏幕尺寸 =${window.physicalSize}  h/w tgθ=${1 / window.physicalSize.aspectRatio}");

    if (deltaLength > 0) {
      print("$_cTag 尺码过小 △L=$deltaLength 设置需要留白的区域");
    } else if (deltaLength < 0) {
      print("$_cTag 尺码过大 △L=$deltaLength 请启用纵向滑动式适配");
    } else {
      print("$_cTag 尺码完全符合");
    }
    print("$_cTag 原本屏幕尺寸比率=$devicePixelRatio");
    print("$_cTag 转换后的屏幕尺寸比率=$actualPixelRatio");
  }

  @override
  String toString() {
    if (uiBlueprints.width >= 720) {
      print("╔═══════════════════════════════════╗");
      print("║                ╭-╮                ║");
      print("║                ┆ ┆                ║");
      print("║                ┆ ┆                ║");
      print("║                ╰-╯                ║");
      print("║                 ○                 ║");
      print("║                                   ║");
      print("║      请以pt/dp为单位初始化ui尺寸     ║");
      print("║                                   ║");
      print("║                                   ║");
      print("╚═══════════════════════════════════╝");
    }
    return 'Info{actualPixelRatio: $actualPixelRatio, uiBlueprints: $uiBlueprints, deltaHeight: $deltaLength, _deltaPadding: $_deltaPadding, _bodyMaxLength: $_bodyMaxLength}';
  }

  static bool get isRelease {
    if (_isRelease == null) {
      _isRelease = true;
      assert(() {
        _isRelease = false;
        return true;
      }());
    }
    return _isRelease!;
  }
}

bool? _isRelease;
