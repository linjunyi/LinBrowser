///Users/admin/Desktop/LinBrowser/LinBrowser.xcodeproj
//  BottomBarView.m
//  LinBrowser
//
//  Created by lin on 15-3-19.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "BottomBarView.h"

#define kBgImageViewHeight 60
#define kStatusBtnWidth    80
#define kStatusBtnHeight   30
#define kHighLightTextColor RGBA(102,204,255,1.0)

@interface BottomBarView()

@property(nonatomic,strong) UIImageView    *bgImageView;
@property(nonatomic,strong) UIButton       *browserStatus;
@property(nonatomic,strong) UILabel        *browserStatusText;
@property(nonatomic,strong) UIButton       *dataStatus;
@property(nonatomic,strong) UILabel        *dataStatusText;
@property(nonatomic,strong) UIImageView    *statusLine;

@end

@implementation BottomBarView
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame{
    if(self){
        self = [super initWithFrame:frame];
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bgImageView];
        [self addSubview:self.browserStatus];
        [self addSubview:self.browserStatusText];
        [self addSubview:self.dataStatus];
        [self addSubview:self.dataStatusText];
        [self addSubview:self.statusLine];
        self.bottomBarStatus = BottomBarStatusBrowser;
        [self browserStatusBtnClick];
    }
    return self;
}

- (void)browserStatusBtnClick{
    [_browserStatus setImage:[UIImage imageNamed:@"browserStatus_highlight.png"] forState:UIControlStateNormal];
    _browserStatus.backgroundColor = [UIColor grayColor];
    [_dataStatus setImage:[UIImage imageNamed:@"dataStatus_normal.png"] forState:UIControlStateNormal];
    _dataStatus.backgroundColor = [UIColor clearColor];
    _browserStatusText.backgroundColor = [UIColor grayColor];
    _browserStatusText.textColor = kHighLightTextColor;
    _dataStatusText.backgroundColor = [UIColor clearColor];
    _dataStatusText.textColor = [UIColor blackColor];
    CGRect frame = self.statusLine.frame;
    frame.origin.x = self.width/2 - 30 - kStatusBtnWidth;
    [UIView animateWithDuration:0.3f animations:^{
        self.statusLine.frame = frame;
    }];
    if([self.delegate respondsToSelector:@selector(browserStatusBtnClick)])
        [self.delegate browserStatusBtnClick];
}

- (void)dataStatusBtnClick{
    [_browserStatus setImage:[UIImage imageNamed:@"browserStatus_normal.png"] forState:UIControlStateNormal];
    _browserStatus.backgroundColor = [UIColor clearColor];
    [_dataStatus setImage:[UIImage imageNamed:@"dataStatus_highlight.png"] forState:UIControlStateNormal];
     _dataStatus.backgroundColor = [UIColor grayColor];
    _browserStatusText.backgroundColor = [UIColor clearColor];
    _browserStatusText.textColor = [UIColor blackColor];
    _dataStatusText.backgroundColor = [UIColor grayColor];
    _dataStatusText.textColor = kHighLightTextColor;
    CGRect frame = self.statusLine.frame;
    frame.origin.x = self.width/2 + 30;
    [UIView animateWithDuration:0.3f animations:^{
        self.statusLine.frame = frame;
    }];

    if([self.delegate respondsToSelector:@selector(dataStatusBtnClick)])
        [self.delegate dataStatusBtnClick];
}


#pragma mark --property

- (UIImageView *)bgImageView{
    if(!_bgImageView){
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width,self.bounds.size.height)];
        _bgImageView.image = [UIImage imageNamed:@"BottomBarBg.png"];
        _bgImageView.clipsToBounds = YES;
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bgImageView;
}

- (UIButton *)browserStatus{
    if(!_browserStatus){
        _browserStatus = [UIButton buttonWithType:UIButtonTypeCustom];
        _browserStatus.frame = CGRectMake(self.width/2 - 30 - kStatusBtnWidth, 0, kStatusBtnWidth, kStatusBtnHeight);
        [_browserStatus setImage:[UIImage imageNamed:@"browserStatus_normal.png"] forState:UIControlStateNormal];
        [_browserStatus setImage:[UIImage imageNamed:@"browserStatus_highlight.png"] forState:UIControlStateHighlighted];
        [_browserStatus addTarget:self action:@selector(browserStatusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _browserStatus;
}

- (UILabel *)browserStatusText{
    if(!_browserStatusText){
        _browserStatusText = [[UILabel alloc] initWithFrame:CGRectMake(self.width/2 - 30 - kStatusBtnWidth, kStatusBtnHeight, kStatusBtnWidth, kStatusBtnHeight/2)];
        _browserStatusText.font = [UIFont boldSystemFontOfSize:12.0f];
        _browserStatusText.text = @"浏览器";
        _browserStatusText.textAlignment = NSTextAlignmentCenter;
    }
    return _browserStatusText;
}


- (UIButton *)dataStatus{
    if(!_dataStatus){
        _dataStatus = [UIButton buttonWithType:UIButtonTypeCustom];
        _dataStatus.frame = CGRectMake(self.width/2 + 30, 0, kStatusBtnWidth, kStatusBtnHeight);
        [_dataStatus setImage:[UIImage imageNamed:@"dataStatus_normal.png"] forState:UIControlStateNormal];
        [_dataStatus setImage:[UIImage imageNamed:@"dataStatus_highlight.png"] forState:UIControlStateHighlighted];
        [_dataStatus addTarget:self action:@selector(dataStatusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dataStatus;
}

- (UILabel *)dataStatusText{
    if(!_dataStatusText){
        _dataStatusText = [[UILabel alloc] initWithFrame:CGRectMake(self.width/2+30, kStatusBtnHeight, kStatusBtnWidth, kStatusBtnHeight/2)];
        _dataStatusText.font = [UIFont boldSystemFontOfSize:10.0f];
        _dataStatusText.text = @"数据统计";
        _dataStatusText.textAlignment = NSTextAlignmentCenter;
    }
    return _dataStatusText;
}


- (UIImageView *)statusLine{
    if(!_statusLine){
        _statusLine = [[UIImageView alloc] initWithFrame:CGRectMake(self.width/2 - 30 - kStatusBtnWidth, 0, kStatusBtnWidth, 2)];
        _statusLine.backgroundColor = RGBA(36, 150, 251, 1.0);
    }
    return _statusLine;
}

@end
