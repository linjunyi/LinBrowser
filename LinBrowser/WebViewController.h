//
//  WebViewController.h
//  LinBrowser
//
//  Created by lin on 15-3-20.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDefinition.h"
#import "netdb.h"
#import "sys/socket.h"
#include <arpa/inet.h> 

@interface WebViewController : UIViewController<UIWebViewDelegate>

@property(nonatomic,strong) NSURL        *webUrl;
@property(nonatomic,strong) NSString     *url;
@property(nonatomic,strong) UIWebView    *webView;
@property(nonatomic,strong) UIButton     *backButton;
@property(nonatomic,strong) UIButton     *forwardButton;
@property(nonatomic,strong) UIButton     *homeButton;
@property(nonatomic,strong) UIButton     *reloadButton;
@property(nonatomic,strong) UIImageView  *navBar;
@property(nonatomic,strong) UIImageView  *loadingView;
@property(nonatomic,strong) UILabel      *loadingLabel;
@property(nonatomic,assign) BOOL         isLoading;
@property(nonatomic,strong) UIImageView  *errorView;
@property(nonatomic,strong) UILabel      *errorLabel;


+ (instancetype)initWithWebUrl:(NSString *)url;

@end
