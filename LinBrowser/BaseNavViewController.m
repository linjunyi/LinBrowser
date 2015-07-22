//
//  BaseNavViewController.m
//  LinBrowser
//
//  Created by lin on 15-3-20.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "BaseNavViewController.h"

@interface BaseNavViewController ()

@end

@implementation BaseNavViewController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if(self){
        self = [super initWithRootViewController:rootViewController];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarHidden = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --禁用横屏

- (BOOL)shouldAutorotate{
    return NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
