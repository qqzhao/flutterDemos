#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"


@interface AppDelegate ()
@property(nonatomic)UIBackgroundTaskIdentifier backIden;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"applicationDidEnterBackground =============");
    self.backIden = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        NSLog(@"in ExpirationHandler=============");
        [self endBack]; // 如果在系统规定时间内任务还没有完成，在时间到之前会调用到这个方法，一般是10分钟
    }];
    
    return [super applicationDidEnterBackground:application];
}


-(void)endBack{
    NSLog(@"endBack =============");
    [[UIApplication sharedApplication] endBackgroundTask:self.backIden];
    self.backIden = UIBackgroundTaskInvalid;
}

@end
