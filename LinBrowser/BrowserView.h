//
//  BrowserView.h
//  LinBrowser
//
//  Created by lin on 15-3-20.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDefinition.h"
#import "TabBarViewController.h"
#import "CoolButton.h"

@interface BrowserView : UIBaseScrollView<UISearchBarDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,strong) UIImageView           *coolBg;
@property(nonatomic,strong) UILabel               *coolLabel;
@property(nonatomic,strong) UIImageView           *coolImage;
@property(nonatomic,strong) NSMutableArray        *coolPages;   //酷站
@property(nonatomic,strong) UIButton              *luckyBg;
@property(nonatomic,strong) UILabel               *luckyLabel;
@property(nonatomic,strong) UIImageView           *luckyImage;
@property(nonatomic,strong) UIImageView           *luckyShow ;  //手气不错
@property(nonatomic,strong) UIImageView           *luckyView ;  //初始隐藏
@property(nonatomic,strong) NSMutableArray        *luckButtons;
@property(nonatomic,strong) UIButton              *authorBg  ;
@property(nonatomic,strong) UILabel               *authorLabel;
@property(nonatomic,strong) UIImageView           *authorImage;
@property(nonatomic,strong) UIImageView           *authorShow;
@property(nonatomic,strong) UITextView            *authorView;
@property(nonatomic,strong) UIImageView           *whiteBg   ;
@property(nonatomic,strong) UISearchBar           *searchBar;
@property(nonatomic,strong) UITapGestureRecognizer      *tap;   //点击搜索栏时，往视图中添加手势，用于隐藏软键盘
@property(nonatomic,strong) UILongPressGestureRecognizer *longPress;  //长按图标，则不跳转
@property(nonatomic,assign) BOOL                  isSearch;     //点击软键盘search，才开始搜索
@property(nonatomic,assign) BOOL                  isShowLucky;  //是否已经展示“手气不错”
@property(nonatomic,weak  )   id                  delegate;

@end

