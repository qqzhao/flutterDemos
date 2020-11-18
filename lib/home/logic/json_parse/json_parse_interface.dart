import 'dart:convert';

import 'package:flutter/material.dart';

abstract class JsonParseInterface {
  /// encoder 定义的解析函数
  /// 子类必须实现
  @protected
  Map<String, dynamic> toJson();

  /// 子类必须实现
  @protected
  JsonParseInterface generateObj(dynamic inputObj);

  String jsonString() {
    var encoderStr = json.encode(this);
    return encoderStr;
  }

  /// 转换list 对象
  @protected
  List<T> convertList<T>(inputList, JsonParseInterface targetObject) {
    if (inputList is List && targetObject is T) {
      return inputList.map((item) => targetObject.generateObj(item)).toList().cast<T>();
    }
    return null;
  }

  /// 转换Map 对象,
  Map<String, T> convertMap<T>(inputMap) {
    if (inputMap is Map) {
      return inputMap.cast<String, T>();
    }
    return null;
  }

  @protected
  Map<String, dynamic> stringToMap(String encoderStr) {
    try {
      return json.decode(encoderStr, reviver: null) as Map<String, dynamic>;
    } catch (e) {
      print('解析失败');
    }
    return null;
  }
}
