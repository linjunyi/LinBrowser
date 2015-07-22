//
//  UIBaseSwitch.h
//  LinBrowser
//
//  Created by lin on 15-3-27.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBaseSwitch : UIView

@property(nonatomic,assign) BOOL  isOn;
@property(nonatomic,strong) UIButton *switchButton;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)switchClick;

@end
