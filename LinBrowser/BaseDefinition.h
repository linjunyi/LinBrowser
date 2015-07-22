//
//  BaseDefinition.h
//  LinBrowser
//
//  Created by lin on 15-3-19.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#ifndef LinBrowser_BaseDefinition_h
#define LinBrowser_BaseDefinition_h

#import "UIBaseView.h"
#import "UIBaseScrollView.h"
#import "UIBaseSwitch.h"
#import "UIBaseCollectionViewCell.h"

//参数表
#define screenWidth       [UIScreen mainScreen].bounds.size.width
#define screenHeight      [UIScreen mainScreen].bounds.size.height
#define boundsX           bounds.origin.x
#define boundsY           bounds.origin.y
#define boundsWidth       bounds.size.width
#define boundsHeight      bounds.size.height
#define RGBA(r,g,b,a)     [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]; //颜色
#define kCachePath        [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]                //缓存文件路径
#define kBottomBarHeight   45  //底栏高度
#define kWidthForIphone6   375.0f
#define kHeightForIphone6  667.0f
#define kWidthForIphone5   320.0f
#define kHeightForIphone5  568.0f
#define kCoolButtonWidth   50
#define kCoolButtonheight  50
#define kLuckButtonWidth   80
#define kLuckButtonHeight  50


#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0)

#endif
