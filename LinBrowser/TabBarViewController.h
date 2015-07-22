//
//  TabBarViewController.h
//  LinBrowser
//
//  Created by lin on 15-3-20.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BottomBarView.h"
#import "BaseDefinition.h"
#import "BrowserView.h"
#import "DataView.h"
#import "CoolButton.h"
#import "WebViewController.h"

@interface TabBarViewController : UIViewController

- (void)browserStatusBtnClick;
- (void)dataStatusBtnClick;
- (void)coolButtonOnClick:(CoolButton *)coolButton;
- (void)openWebPageWithText:(NSString *)text;

@end
