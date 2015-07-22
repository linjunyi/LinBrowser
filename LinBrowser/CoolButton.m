//
//  CoolButton.m
//  LinBrowser
//
//  Created by lin on 15-3-20.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "CoolButton.h"

@implementation CoolButton

@synthesize imageView = _imageView;

+ (instancetype)initWithName:(NSString *)name andUrl:(NSString *)url andTag:(NSInteger)tag{
    CoolButton *coolButton = [super buttonWithType:UIButtonTypeCustom];
    coolButton.name.text       = name;
    coolButton.url             = url;
    coolButton.tag             = tag;
    coolButton.bounds = CGRectMake(0, 0, kCoolButtonWidth, kCoolButtonheight);
    [coolButton addSubview:coolButton.name];
    [coolButton addSubview:coolButton.imageView];
    return coolButton;
}

+ (instancetype)initLuckButtonWithName:(NSString *)name andUrl:(NSString *)url andTag:(NSInteger)tag{
    CoolButton *coolButton = [super buttonWithType:UIButtonTypeCustom];
    coolButton.name.text       = name;
    coolButton.url             = url;
    coolButton.tag             = tag;
    coolButton.bounds = CGRectMake(0, 0, kLuckButtonWidth, kLuckButtonHeight);
    coolButton.name.font       = [UIFont systemFontOfSize:13.0f];
    coolButton.name.frame      = coolButton.bounds;
    [coolButton addSubview:coolButton.name];
    return coolButton;
}

#pragma mark --property

- (UILabel *)name{
    if(!_name){
        _name = [[UILabel alloc] initWithFrame:CGRectMake(kCoolButtonWidth/2-12.5, 30, 25, 18)];
        _name.textAlignment = NSTextAlignmentCenter;
        _name.font = [UIFont systemFontOfSize:11.0f];
    }
    return _name;
}

- (UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kCoolButtonWidth/2-15, 8, 30, 25)];
        _imageView.backgroundColor = [UIColor clearColor];
    }
    return _imageView;
}

@end
