//
//  BrowserView.m
//  LinBrowser
//
//  Created by lin on 15-3-20.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "BrowserView.h"

#define kSearchBarOriginY 25

@interface  BrowserView()

@property BOOL isCoolButton;
@property BOOL isShowAuthor;
@property CoolButton *clickedButton;

@end

@implementation BrowserView

@synthesize delegate;

- (instancetype)initWithFrame:(CGRect)frame {
    if(self){
        self = [super initWithFrame:frame];
        [self addSubview:self.coolBg];
        [self addSubview:self.luckyBg];
        [self addSubview:self.luckyView];
        [self addSubview:self.authorBg];
        [self addSubview:self.authorView];
        [self addSubview:self.whiteBg];
        [self addSubview:self.searchBar];
        [self addGestureRecognizer:self.longPress];

        
        float top   = self.coolBg.frame.origin.y + self.coolBg.boundsHeight + 10;
        for(NSInteger i=0; i < self.coolPages.count; i++){
            CoolButton *button = [self.coolPages objectAtIndex:i];
            button.frame = CGRectMake(25+(i%5)*55, top+(i/5)*50, kCoolButtonWidth, kCoolButtonheight);
            [button addTarget:self action:@selector(buttonTouchDown:) forControlEvents:UIControlEventTouchDown];
            [button addTarget:self action:@selector(coolButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
            [button addTarget:self action:@selector(coolButtonOnClick:) forControlEvents:UIControlEventTouchUpOutside];
            [self addSubview:button];
        }
    }
    return self;
}

- (void)hideKeyBoard{
    NSLog(@"隐藏键盘");
    if([self.searchBar isFirstResponder]){
        _isSearch = NO;
        [self.searchBar resignFirstResponder];
    }
}

- (void)showLucky {
    CGRect frame = self.authorBg.frame,
    viewFrame  = self.luckyView.frame,
    whiteFrame = self.whiteBg.frame,
    authFrame  = self.authorView.frame;
    if([self.searchBar isFirstResponder])
        [self hideKeyBoard];
    if(!self.isShowLucky){
        self.luckyImage.image = [UIImage imageNamed:@"lucky_highlight.png"];
        frame.origin.y += 200;
        viewFrame.size.height += 200;
        whiteFrame.origin.y += 200;
        whiteFrame.size.height = 0;
        authFrame.origin.y += 200;
        authFrame.size.height -=200;
        [UIView animateWithDuration:0.3f animations:^{
            self.luckyShow.image = [UIImage imageNamed:@"luckyshow_showed.png"];
            self.authorBg.frame  = frame;
            self.luckyView.frame = viewFrame;
            self.whiteBg.frame   = whiteFrame;
            self.authorView.frame = authFrame;
        }];
    }else{
        self.luckyImage.image = [UIImage imageNamed:@"lucky.png"];
        frame.origin.y -= 200;
        viewFrame.size.height -= 200;
        whiteFrame.origin.y -= 200;
        whiteFrame.size.height = 200;
        authFrame.origin.y -= 200;
        authFrame.size.height +=200;
        [UIView animateWithDuration:0.3f animations:^{
            self.luckyShow.image = [UIImage imageNamed:@"luckyshow_normal.png"];
            self.luckyView.frame = viewFrame;
            self.authorBg.frame  = frame;
            self.whiteBg.frame   = whiteFrame;
            self.authorView.frame = authFrame;
        }];
    }
    self.isShowLucky = !self.isShowLucky;
}

- (void)showAuthor {
    if(_isShowLucky)
        [self showLucky];
    CGRect whiteFrame = self.whiteBg.frame;
    if(!_isShowAuthor){
        whiteFrame.origin.y += 200;
        whiteFrame.size.height -= 200;
        [UIView animateWithDuration:0.3f animations:^{
            self.whiteBg.frame = whiteFrame;
            self.authorShow.image = [UIImage imageNamed:@"luckyshow_showed.png"];
            self.authorImage.image = [UIImage imageNamed:@"author_highlight.png"];
        }];
    }else{
        whiteFrame.origin.y -= 200;
        whiteFrame.size.height += 200;
        [UIView animateWithDuration:0.3f animations:^{
            self.whiteBg.frame = whiteFrame;
            self.authorShow.image = [UIImage imageNamed:@"luckyshow_normal.png"];
            self.authorImage.image = [UIImage imageNamed:@"author.png"];
        }];
    }
    _isShowAuthor = !_isShowAuthor;
}

#pragma mark --CoolButton

- (void)coolButtonOnClick:(CoolButton*)coolButton {
    [self buttonTouchUp:coolButton];
}

- (void)buttonTouchDown:(CoolButton *)button {
    button.backgroundColor = RGBA(140, 136, 123, 1.0);
    _isCoolButton = YES;
    _clickedButton = button;
}

- (void)buttonTouchUp:(CoolButton *)button {
    button.backgroundColor = RGBA(140, 136, 123, 1.0);
    [UIView animateWithDuration:0.2f animations:^{
        button.backgroundColor = [UIColor clearColor];
    }];
    if([self.delegate respondsToSelector:@selector(coolButtonOnClick:)])
        [self.delegate coolButtonOnClick:button];
}

- (void)longPress:(UILongPressGestureRecognizer *)longPressGes{
    if(longPressGes.state == UIGestureRecognizerStateEnded){
        if(_isCoolButton){
            _clickedButton.backgroundColor = [UIColor clearColor];
            _clickedButton = nil;
            _isCoolButton = NO;
        }
    }
}

#pragma mark --UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchBar.placeholder = @"请输入网址或关键词";
    [self addGestureRecognizer:self.tap];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self removeGestureRecognizer:self.tap];
    NSLog(@"完成输入");
    if([self.delegate respondsToSelector:@selector(openWebPageWithText:)] && _isSearch ){
        [self.delegate openWebPageWithText:searchBar.text];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"点击search");
    _isSearch = YES;
    [self.searchBar resignFirstResponder];
}

#pragma mark --property

- (UIImageView *)coolBg {
    if(!_coolBg){
        _coolBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, kSearchBarOriginY+40, self.width,40)];
        _coolBg.backgroundColor = RGBA(249, 249, 247, 1.0);
        [_coolBg addSubview:self.coolLabel];
        [_coolBg addSubview:self.coolImage];
    }
    return _coolBg;
}

- (UILabel *)coolLabel {
    if(!_coolLabel){
        _coolLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 100, 30)];
        _coolLabel.text = @"酷站";
        _coolLabel.font = [UIFont systemFontOfSize:12.0f];
        _coolLabel.textColor = RGBA(79, 78, 74, 1.0);
        _coolLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _coolLabel;
}

- (UIImageView *)coolImage {
    if(!_coolImage){
        _coolImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kuZhan.png"]];
        _coolImage.frame = CGRectMake(10, 10, 20, 20);
    }
    return _coolImage;
}

- (NSMutableArray *)coolPages {
    if(!_coolPages){ 
        CoolButton *baidu = [CoolButton initWithName:@"百度" andUrl:@"http://www.baidu.com" andTag:0];
        baidu.imageView.image = [UIImage imageNamed:@"baidu.png"];
        CoolButton *sina = [CoolButton initWithName:@"新浪" andUrl:@"http://sina.cn" andTag:1];
        sina.imageView.image = [UIImage imageNamed:@"sina.png"];
        CoolButton *taobao = [CoolButton initWithName:@"淘宝" andUrl:@"http://www.taobao.com" andTag:2];
        taobao.imageView.image = [UIImage imageNamed:@"taobao.ico"];
        CoolButton *tudou = [CoolButton initWithName:@"优酷" andUrl:@"http://www.youku.com" andTag:3];
        tudou.imageView.image = [UIImage imageNamed:@"youku.png"];
        CoolButton *qiubai = [CoolButton initWithName:@"糗百" andUrl:@"http://www.qiushibaike.com" andTag:4];
        qiubai.imageView.image = [UIImage imageNamed:@"qiushibaike.png"];
        CoolButton *zhihu = [CoolButton initWithName:@"知乎" andUrl:@"http://www.zhihu.com" andTag:5];
        zhihu.imageView.image = [UIImage imageNamed:@"zhihu.ico"];
        CoolButton *sohu = [CoolButton initWithName:@"搜狐" andUrl:@"http://www.sohu.com" andTag:6];
        sohu.imageView.image = [UIImage imageNamed:@"sohu.png"];
        CoolButton *douban = [CoolButton initWithName:@"豆瓣" andUrl:@"http://www.douban.com" andTag:7];
        douban.imageView.image = [UIImage imageNamed:@"douban.ico"];
        CoolButton *renren = [CoolButton initWithName:@"人人" andUrl:@"http://www.renren.com" andTag:8];
        renren.imageView.image = [UIImage imageNamed:@"renren.png"];
        CoolButton *meituan = [CoolButton initWithName:@"美团" andUrl:@"http://www.meituan.com" andTag:9];
        meituan.imageView.image = [UIImage imageNamed:@"meituan.jpg"];
        
        _coolPages = [NSMutableArray arrayWithObjects:baidu, sina, taobao, tudou, qiubai, zhihu, sohu, douban, renren, meituan, nil];
    }
    return _coolPages;
}

- (UIButton *)luckyBg {
    if(!_luckyBg){
        _luckyBg = [[UIButton alloc] initWithFrame:CGRectMake(0, kSearchBarOriginY+200, self.width,40)];
        _luckyBg.backgroundColor = RGBA(249, 249, 247, 1.0);
        [_luckyBg addSubview:self.luckyLabel];
        [_luckyBg addSubview:self.luckyImage];
        [_luckyBg addSubview:self.luckyShow];
        [_luckyBg addTarget:self action:@selector(showLucky) forControlEvents:UIControlEventTouchUpInside];
    }
    return _luckyBg;
}

- (UILabel *)luckyLabel {
    if(!_luckyLabel){
        _luckyLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 100, 30)];
        _luckyLabel.text = @"手气不错";
        _luckyLabel.font = [UIFont systemFontOfSize:12.0f];
        _luckyLabel.textColor = RGBA(79, 78, 74, 1.0);
        _luckyLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _luckyLabel;
}

- (UIImageView *)luckyImage {
    if(!_luckyImage){
        _luckyImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lucky.png"]];
        _luckyImage.frame = CGRectMake(10, 10, 20, 20);
    }
    return _luckyImage;
}

- (UIImageView *)luckyShow {
    if(!_luckyShow){
        _luckyShow = [[UIImageView alloc] initWithFrame:CGRectMake(self.boundsWidth-50, 10, 20, 20)];
        _luckyShow.image = [UIImage imageNamed:@"luckyshow_normal.png"];
    }
    return _luckyShow;
}

- (UIImageView *)luckyView {
    if(!_luckyView){
        _luckyView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kSearchBarOriginY+240, self.boundsWidth, 0)];
        NSInteger i = 0;
        _luckyView.userInteractionEnabled = YES;
        for(CoolButton *button in self.luckButtons){
            button.frame = CGRectMake(20+(i%3)*100, (i/3)*40, 80, 40);
            [button addTarget:self action:@selector(buttonTouchDown:) forControlEvents:UIControlEventTouchDown];
            [button addTarget:self action:@selector(buttonTouchUp:) forControlEvents:UIControlEventTouchUpInside];
            [button addTarget:self action:@selector(buttonTouchUp:) forControlEvents:UIControlEventTouchUpOutside];
            [_luckyView addSubview:button];
            i++;
        }
    }
    return _luckyView;
}

- (NSMutableArray *)luckButtons{
    if(!_luckButtons){
        CoolButton *blog = [CoolButton initLuckButtonWithName:@"我的博客" andUrl:@"http://blog.sina.com.cn/u/2419133487" andTag:0];
        CoolButton *kongjian = [CoolButton initLuckButtonWithName:@"我的空间" andUrl:@"http://qzone.qq.com" andTag:0];
        CoolButton *yunpan = [CoolButton initLuckButtonWithName:@"我的云盘" andUrl:@"http://pan.baidu.com/" andTag:0];
        CoolButton *appleDoc = [CoolButton initLuckButtonWithName:@"Apple文档" andUrl:@"https://developer.apple.com/search/" andTag:0];
        CoolButton *qqMail = [CoolButton initLuckButtonWithName:@"QQ邮箱" andUrl:@"https://w.mail.qq.com/cgi-bin/loginpage?f=xhtml&kvclick=loginpage%7Capp_push%7Center%7Cios&ad=false&" andTag:0];
        CoolButton *sinaMail = [CoolButton initLuckButtonWithName:@"新浪邮箱" andUrl:@"http://mail.sina.com.cn/" andTag:0];
        CoolButton *piano = [CoolButton initLuckButtonWithName:@"钢琴曲库" andUrl:@"http://www.hqgq.com/" andTag:0];
        CoolButton *music = [CoolButton initLuckButtonWithName:@"音乐" andUrl:@"http://music.baidu.com/" andTag:0];
        CoolButton *googleHk = [CoolButton initLuckButtonWithName:@"google" andUrl:@"http://www.google.com.hk" andTag:0];
        CoolButton *wangyi = [CoolButton initLuckButtonWithName:@"网易公开课" andUrl:@"http://open.163.com/" andTag:0];
        CoolButton *baozou = [CoolButton initLuckButtonWithName:@"暴走漫画" andUrl:@"http://baozoumanhua.com" andTag:0];
        CoolButton *movie = [CoolButton initLuckButtonWithName:@"电影" andUrl:@"http://v.baidu.com/movie" andTag:0];
        _luckButtons = [NSMutableArray arrayWithObjects:blog, kongjian, yunpan, appleDoc, qqMail, sinaMail, piano, music, googleHk, wangyi, baozou, movie, nil];
    }
    return _luckButtons;
}


- (UIButton *)authorBg {
    if(!_authorBg){
        _authorBg = [[UIButton alloc] initWithFrame:CGRectMake(0, kSearchBarOriginY+240, self.width,40)];
        _authorBg.backgroundColor = RGBA(249, 249, 247, 1.0);
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,self.width,0.5)];
        line.backgroundColor = RGBA(214, 210, 194, 1.0);
        [_authorBg addSubview:line];
        [_authorBg addSubview:self.authorLabel];
        [_authorBg addSubview:self.authorImage];
        [_authorBg addSubview:self.authorShow];
        [_authorBg addTarget:self action:@selector(showAuthor) forControlEvents:UIControlEventTouchUpInside];
    }
    return _authorBg;
}

- (UILabel *)authorLabel {
    if(!_authorLabel){
        _authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 100, 30)];
        _authorLabel.text = @"开发者";
        _authorLabel.font = [UIFont systemFontOfSize:12.0f];
        _authorLabel.textColor = RGBA(79, 78, 74, 1.0);
        _authorLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _authorLabel;
}

- (UIImageView *)authorImage {
    if(!_authorImage){
        _authorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"author_highlight.png"]];
        _authorImage.frame = CGRectMake(10, 10, 20, 20);
    }
    return _authorImage;
}

- (UIImageView *)authorShow {
    if(!_authorShow){
        _authorShow = [[UIImageView alloc] initWithFrame:CGRectMake(self.boundsWidth-50, 10, 20, 20)];
        _authorShow.image = [UIImage imageNamed:@"luckyshow_normal.png"];
    }
    return _authorShow;
}

- (UITextView *)authorView {
    if(!_authorView){
        _authorView = [[UITextView alloc] initWithFrame:CGRectMake(0, kSearchBarOriginY+280, self.boundsWidth, 200)];
        _authorView.editable = NO;
        _authorView.text = @"           APP：LinBrowser\n\n           姓名：林君毅\n\n       教学号：53110617\n\n           学号：21110617\n\n           学院：计算机科学与技术学院 6班";
        _isShowAuthor = YES;
    }
    return _authorView;
}

- (UIImageView *)whiteBg {
    if(!_whiteBg){
        _whiteBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, kSearchBarOriginY+480, self.width, 0)];
        _whiteBg.backgroundColor = [UIColor whiteColor];
    }
    return _whiteBg;
}

- (UISearchBar *)searchBar {
    if(!_searchBar){
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, kSearchBarOriginY, self.width, 30)];
        _searchBar.delegate = self;
    }
    return _searchBar;
}

- (UITapGestureRecognizer *)tap {
    if(!_tap){
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    }
    return _tap;
}

- (UILongPressGestureRecognizer*)longPress{
    if(!_longPress){
        _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        _longPress.minimumPressDuration = 1.0f;
        _longPress.delegate = self;
    }
    return _longPress;
}

@end
