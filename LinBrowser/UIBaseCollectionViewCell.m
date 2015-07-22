//
//  UIBaseCollectionViewCell.m
//  LinBrowser
//
//  Created by lin on 15-3-27.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "UIBaseCollectionViewCell.h"

@implementation UIBaseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageView];
    }
    return self;
}

#pragma mark --property

- (UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    }
    return _imageView;
}

@end
