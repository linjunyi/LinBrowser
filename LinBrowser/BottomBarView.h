//
//  BottomBarView.h
//  LinBrowser
//
//  Created by lin on 15-3-19.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDefinition.h"
#import "TabBarViewController.h"

enum BottomBarStatus{
    BottomBarStatusBrowser=0,
    BottomBarStatusData
};

@class TabBarViewController;

@interface BottomBarView : UIBaseView

@property(nonatomic,assign) enum BottomBarStatus bottomBarStatus;
@property(nonatomic,strong) TabBarViewController *delegate;

- (void)browserStatusBtnClick;
- (void)dataStatusBtnClick;

@end
