//
//  TabBarViewController.m
//  LinBrowser
//
//  Created by lin on 15-3-20.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController()

@property(nonatomic,strong) BottomBarView *bottomBar;
@property(nonatomic,strong) BrowserView   *browserView;
@property(nonatomic,strong) DataView      *dataView;

@end

@implementation TabBarViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomBar];
    [self.view addSubview:self.browserView];
    [self.view addSubview:self.dataView];
}

- (void)browserStatusBtnClick{
    self.browserView.hidden = NO;
    self.dataView.hidden    = YES;
}
- (void)dataStatusBtnClick{
    self.browserView.hidden = YES;
    self.dataView.hidden    = NO;
}

- (void)coolButtonOnClick:(CoolButton *)coolButton{
    NSLog(@"打开%@",coolButton.name.text);
    WebViewController *webController = [WebViewController initWithWebUrl:coolButton.url];
    [self.navigationController pushViewController:webController animated:YES];
}

- (void)openWebPageWithText:(NSString *)text{
    NSString *url = [self realUrl:text];
    WebViewController *webController = [WebViewController initWithWebUrl:url];
    [self.navigationController pushViewController:webController animated:YES];
}

- (NSString *)realUrl:(NSString *)text{
    NSString *str = @"((http|ftp|https|ftps|sftp|telnet|nntp|news|gopher|file):/{0,2})?((www|[0-9a-z]*)\\.)?[0-9a-z]+\\.[a-z]+";
    NSString *urlText = [text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];  //将url转换成UTF-8编码，以实现中文关键词搜索
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:str options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *result;
    result = [regex matchesInString:urlText options:0 range:NSMakeRange(0, urlText.length)];
    if(result.count > 0){
        NSTextCheckingResult *chResult = (NSTextCheckingResult *)result[0];
        //若是网址
        if(chResult.range.location == 0){
            NSString *str1 = @"(http|ftp|https|ftps|sftp|telnet|nntp|news|gopher|file):";
            regex = [NSRegularExpression regularExpressionWithPattern:str1 options:0 error:nil];
            NSArray *result1 = [regex matchesInString:urlText options:0 range:NSMakeRange(0,7)];
            if(result1.count > 0){
                return  urlText;
            }
            return [NSString stringWithFormat:@"http://%@",urlText];
        }
    }
    
    //输入的是关键词
    return [NSString stringWithFormat:@"http://www.baidu.com/s?ie=UTF-8&wd=%@",urlText];
}

#pragma mark --property

- (BottomBarView *)bottomBar {
    if(!_bottomBar){
        _bottomBar = [[BottomBarView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - kBottomBarHeight, self.view.bounds.size.width,kBottomBarHeight)];
        _bottomBar.delegate = self;
    }
    return _bottomBar;
}

- (BrowserView *)browserView {
    if(!_browserView){
        _browserView = [[BrowserView alloc] initWithFrame:CGRectMake(0, 0 ,self.view.bounds.size.width, self.view.bounds.size.height-kBottomBarHeight)];
        _browserView.delegate = self;
    }
    return _browserView;
}

- (DataView *)dataView {
    if(!_dataView){
        _dataView = [[DataView alloc] initWithFrame:CGRectMake(0, 0 ,self.view.bounds.size.width, self.view.bounds.size.height-kBottomBarHeight)];
        _dataView.hidden = YES;
    }
    return _dataView;
}


@end
