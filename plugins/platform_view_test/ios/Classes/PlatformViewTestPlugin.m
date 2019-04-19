#import "PlatformViewTestPlugin.h"
#import "DemoTestViewFactory.h"


@implementation PlatformViewTestPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
//  FlutterMethodChannel* channel = [FlutterMethodChannel
//      methodChannelWithName:@"platform_view_test"
//            binaryMessenger:[registrar messenger]];
//  PlatformViewTestPlugin* instance = [[PlatformViewTestPlugin alloc] init];
//  [registrar addMethodCallDelegate:instance channel:channel];
    
    DemoTestViewFactory* factory = [[DemoTestViewFactory alloc] initWithMessenger:registrar.messenger];
    [registrar registerViewFactory:factory withId:@"plugins.platform_view_test"];
}

//- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
//  if ([@"getPlatformVersion" isEqualToString:call.method]) {
//    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
//  } else {
//    result(FlutterMethodNotImplemented);
//  }
//}

@end
