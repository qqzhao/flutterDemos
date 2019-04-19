//
//  DemoTestViewFactory.m
//  platform_view_test
//
//  Created by 赵千千 on 2019/4/19.
//

#import "DemoTestViewFactory.h"

@interface DemoTestViewFactory ()
@property(nonatomic)NSObject<FlutterBinaryMessenger>* messenger;
@end

@implementation DemoTestViewFactory

- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
    self = [super init];
    if (self) {
        self.messenger = messenger;
    }
    return self;
}

- (NSObject<FlutterMessageCodec>*)createArgsCodec {
    return [FlutterStandardMessageCodec sharedInstance];
}

- (nonnull NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame
                                            viewIdentifier:(int64_t)viewId
                                                 arguments:(id _Nullable)args {
    DemoTestViewController *controller = [[DemoTestViewController alloc] initWithWithFrame:frame viewIdentifier:viewId arguments:args binaryMessenger:_messenger];
    return controller;
}

@end

#pragma mark - DemoTestViewController

@interface DemoTestViewController ()

@property(nonatomic)UIView * testView;
@property(nonatomic)int64_t viewId;
@property(nonatomic)FlutterMethodChannel* channel;
@property(nonatomic, assign)CGRect viewRect;

@end

@implementation DemoTestViewController

- (instancetype)initWithWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger{
    if ([super init]) {
        NSDictionary *dic = args;
        NSLog(@"dic = %@", dic);
        double x = [dic[@"x"] doubleValue];
        double y = [dic[@"y"] doubleValue];
        double width = [dic[@"width"] doubleValue];
        double height = [dic[@"height"] doubleValue];
        
        self.viewRect = CGRectMake(x, y, width, height);
        self.testView = [[UIView alloc] initWithFrame:CGRectZero];
        self.testView.backgroundColor = [UIColor redColor];
        
        self.viewId = viewId;
        NSString* channelName = [NSString stringWithFormat:@"platform_view_test_%lld", viewId];
        self.channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:messenger];
        __weak __typeof__(self) weakSelf = self;
        [self.channel setMethodCallHandler:^(FlutterMethodCall *  call, FlutterResult  result) {
            [weakSelf onMethodCall:call result:result];
        }];
    }
    
    return self;
}

-(UIView *)view{
    return self.testView;
}

-(void)onMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result{
    if ([[call method] isEqualToString:@"loadUrl"]) {
        __weak __typeof__(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.testView.backgroundColor = [UIColor blueColor];
        });
    } else if ([[call method] isEqualToString:@"reloadView"]) {
//        self.testView.frame = self.viewRect;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.testView.frame = self.viewRect;
        });
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
