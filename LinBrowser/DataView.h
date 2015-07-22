//
//  DataView.h
//  LinBrowser
//
//  Created by lin on 15-3-27.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDefinition.h"

@class UIBaseSwitch;

@interface DataView : UIBaseView<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) UIBaseSwitch     *openSwitch;
@property(nonatomic,strong) UIImageView      *message;
@property(nonatomic,strong) UILabel          *messageText;
@property(nonatomic,strong) UICollectionView *coolShow;
@property(nonatomic,strong) UIView           *blackBg;
@property(nonatomic,strong) NSTimer          *timer;
@property(nonatomic,strong) NSMutableArray   *coolImages;
@property(nonatomic,strong) UIView           *loadView;
@property(nonatomic,strong) UILabel          *loadViewLabel;
@property(nonatomic,strong) UILabel          *loadCount;
@property(nonatomic,strong) UILabel          *loadCountData;
@property(nonatomic,strong) UILabel          *averageLoadTime;
@property(nonatomic,strong) UILabel          *averageLoadTimeData;
@property(nonatomic,strong) UIView           *superLoadView;
@property(nonatomic,strong) UILabel          *superLoadViewLabel;
@property(nonatomic,strong) UILabel          *superLoadCount;
@property(nonatomic,strong) UILabel          *superLoadCountData;
@property(nonatomic,strong) UILabel          *superAverLoadTime;
@property(nonatomic,strong) UILabel          *superAverLoadTimeData;

- (void)clickSwitch;

@end
