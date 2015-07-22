//
//  UIBaseSwitch.m
//  LinBrowser
//
//  Created by lin on 15-3-27.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "UIBaseSwitch.h"

@implementation UIBaseSwitch

- (instancetype)initWithFrame:(CGRect)frame {
    if(self){
        self = [super initWithFrame:frame];
        [self addSubview:self.switchButton];
    }
    return self;
}

- (void)switchClick {
    if(!self.isOn){
            [self.switchButton setImage:[UIImage imageNamed:@"switch_on.png"] forState:UIControlStateNormal];
    }else{
            [self.switchButton setImage:[UIImage imageNamed:@"switch_off.png"] forState:UIControlStateNormal];
    }
    self.isOn = !self.isOn;
 }

#pragma mark --property

- (UIButton *)switchButton {
    if(!_switchButton){
        _switchButton = [[UIButton alloc] initWithFrame:self.bounds];
        [_switchButton setImage:[UIImage imageNamed:@"switch_off.png"] forState:UIControlStateNormal];
    }
    return _switchButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
