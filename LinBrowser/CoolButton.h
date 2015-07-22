//
//  CoolButton.h
//  LinBrowser
//
//  Created by lin on 15-3-20.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDefinition.h"

@interface CoolButton : UIButton

@property(nonatomic,strong) NSString     *url;
@property(nonatomic,strong) UILabel      *name;
@property(nonatomic,strong) UIImageView  *imageView;

+ (instancetype)initWithName:(NSString *)name andUrl:(NSString *)url andTag:(NSInteger)tag;
+ (instancetype)initLuckButtonWithName:(NSString *)name andUrl:(NSString *)url andTag:(NSInteger)tag;

@end
