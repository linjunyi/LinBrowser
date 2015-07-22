//
//  UIBaseScrollView.h
//  LinBrowser
//
//  Created by lin on 15-3-25.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBaseScrollView : UIScrollView

@property(nonatomic,assign) float top;
@property(nonatomic,assign) float bottom;
@property(nonatomic,assign) float left;
@property(nonatomic,assign) float right;
@property(nonatomic,assign) float width;
@property(nonatomic,assign) float height;

@end
