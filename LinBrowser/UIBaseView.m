//
//  UIBaseView.m
//  LinBrowser
//
//  Created by lin on 15-3-19.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "UIBaseView.h"

@implementation UIBaseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark -- property

- (float)top{
    return self.frame.origin.y;
}

- (float)bottom{
    return self.frame.origin.y + self.frame.size.height;
}

- (float)left{
    return self.frame.origin.x;
}

- (float)right{
    return self.frame.origin.x + self.frame.size.width;
}

- (float)width{
    return self.frame.size.width;
}

- (float)height{
    return self.frame.size.height;
}

@end
