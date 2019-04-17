//
//  ViewController.m
//  TestOne
//
//  Created by qianzhao on 2019/4/17.
//  Copyright © 2019 qianzhao. All rights reserved.
//

#import "ViewController.h"
#import <Flutter/Flutter.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(handleButtonAction)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Press me" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button];
}

- (void)handleButtonAction {
    FlutterViewController* flutterViewController = [[FlutterViewController alloc] init];
//    [self presentViewController:flutterViewController animated:false completion:nil];
//    [flutterViewController setInitialRoute:@"route1"];
    [self.navigationController pushViewController:flutterViewController animated:YES];
}


@end
