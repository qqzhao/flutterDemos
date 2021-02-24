//
// Generated file. Do not edit.
//

// ignore: unused_import
import 'dart:ui';

// ignore: implementation_imports
import 'package:flutter_device_locale/src/web.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:video_player_web/video_player_web.dart';

// ignore: public_member_api_docs
void registerPlugins(PluginRegistry registry) {
  FlutterDeviceLocaleWebPlugin.registerWith(registry.registrarFor(FlutterDeviceLocaleWebPlugin));
  VideoPlayerPlugin.registerWith(registry.registrarFor(VideoPlayerPlugin));
  registry.registerMessageHandler();
}
