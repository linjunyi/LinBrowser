 //
//  WebViewController.m
//  LinBrowser
//
//  Created by lin on 15-3-20.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property(nonatomic,assign) BOOL isLoadError;
@property(nonatomic,assign) BOOL isTimeOut;
@property(nonatomic,strong) NSTimer *loadTime;
@property(nonatomic,strong) NSURLRequest   *currentRequest;
@property(nonatomic,assign) BOOL canReload;
@property(nonatomic,strong) NSMutableDictionary *localDNS;
@property(nonatomic,assign) BOOL isLoadIp;    //是否直接加载IP地址（用于DNS解析部分）

@end

@implementation WebViewController

+ (instancetype)initWithWebUrl:(NSString *)url {
    WebViewController *webController = [[WebViewController alloc] init];
    webController.webUrl = [NSURL URLWithString:url];
    [webController.view addSubview:webController.webView];
    [webController.view addSubview:webController.loadingView];
    [webController.view addSubview:webController.loadingLabel];
    [webController.view addSubview:webController.navBar];
    [webController.view addSubview:webController.backButton];
    [webController.view addSubview:webController.forwardButton];
    [webController.view addSubview:webController.homeButton];
    [webController.view addSubview:webController.reloadButton];
    [webController.view addSubview:webController.errorView];
    [webController.view addSubview:webController.errorLabel];
    webController.isLoadError = NO;
    webController.webView.delegate = webController;
    return webController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:self.webUrl];
    [self.webView setScalesPageToFit:YES];
/*离线缓存
    NSString *fileName = [NSString stringWithFormat:@"%@/http_www.baidu.com_.html",[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]];
    NSString *htmlString = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:@"http://www.baidu.com"]];
*/
    [self.webView loadRequest:request];
    [self getDNSFromDocument];
    // Do any additional setup after loading the view..
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)getIpWithURL:(NSString *)url {
    NSString *realUrl = [[url stringByReplacingCharactersInRange:NSMakeRange(0, 7) withString:@""] stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSLog(@"realUrl : %@",realUrl);
    const char *linUrl = [realUrl UTF8String];
    NSLog(@"%@",url);
    struct hostent* lHost;
    @try {
        lHost = gethostbyname(linUrl);   //此处不应有http://等字眼，否则查询结果会出错。若出现211.98.71.195类似的返回结果，则表示该网址解析失败，被作为未命名主机来解析了。211.98.71.195是本地DNS服务器地址。
        //查询结果与本机DNS设置有关，因为其实质是通过连接DNS服务器来获取结果的
        //可用 “nslookup 域名” 来看本机设置的DNS是否能解析该网址
        //同时，相应网站可能会做限制。比如，我用的是联通的，连接一些电信的ip时可能会被限制（网站可以识别你的ip类型，从而打开与你的类型相同的网站ip，联通用户打开该网站的联通ip，当然并非所有网站都是这样）。这就会出现ip能ping得通，但是浏览器却打不开的现象。
    }
    @catch (NSException *exception) {
        return nil;
    }
    struct in_addr ip_addr;
    if(lHost != nil ) {
        memcpy(&ip_addr, lHost->h_addr_list[0], 4);
        char ipAddress[20] = "";
        inet_ntop(AF_INET, &ip_addr, ipAddress, sizeof(ipAddress));
        printf("DNS解析后的主机别名: %s\n",lHost->h_name);
        NSMutableString* NSIpAddress = [NSMutableString stringWithUTF8String:ipAddress];
        NSLog(@"DNS解析后ip地址: %@\n",NSIpAddress);
        NSArray *strArray = [NSIpAddress componentsSeparatedByString:@"."];
        if([strArray[0] isEqualToString:@"211"]) {
            NSLog(@"解析出错");
            [self.localDNS setObject:url forKey:url];
        }else {
            NSLog(@"解析成功");
            NSIpAddress = [NSMutableString stringWithFormat:@"http://%@/",NSIpAddress];
            [self.localDNS setObject:NSIpAddress forKey:url];
        }
    }
    [self writeToDocument];
    return nil;
}

- (void)getDNSFromDocument {
     self.localDNS = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.youku.com/", @"http://www.youku.com/", @"http://www.taobao.com/", @"http://www.taobao.com/", @"http://www.qiushibaike.com/", @"http://www.qiushibaike.com/", @"http://www.sohu.com/", @"http://www.sohu.com/", @"http://www.renren.com/", @"http://www.renren.com/", @"http://www.meituan.com/", @"http://www.meituan.com/", nil];
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath  = [NSString stringWithFormat:@"%@/localDNS.txt",[documents objectAtIndex:0]];
    NSString *desDocPath = @"/Users/lin/Desktop/localDNS.txt";
    NSFileManager *fm  = [NSFileManager defaultManager];
    NSLog(@"%@",docPath);
    if(![fm fileExistsAtPath:docPath]) {
        [fm createFileAtPath:docPath contents:nil attributes:nil];
        [self.localDNS writeToFile:docPath atomically:YES];
        NSLog(@"创建文件成功!!");
    }else {
        self.localDNS = [NSMutableDictionary dictionaryWithContentsOfFile:docPath];
        [self.localDNS writeToFile:desDocPath atomically:YES];
    }
}

- (void)writeToDocument {
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath  = [NSString stringWithFormat:@"%@/localDNS.txt",[documents objectAtIndex:0]];
    NSString *desDocPath = @"/Users/lin/Desktop/localDNS.txt";
    [self.localDNS writeToFile:docPath atomically:YES];
    [self.localDNS writeToFile:desDocPath atomically:YES];
}

#pragma mark --buttonOnClick

- (void)backButtonOnClick {
    if([self.webView canGoBack]) {
        [self.webView goBack];
    }else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)forwardButtonOnClick {
    [self.webView goForward];
}

- (void)homeButtonOnClick {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)reloadButtonOnClick {
    if(_canReload) {
        [self.webView reload];    //加载失败之后,调用reload无效
    }else {
        [self.webView loadRequest:_currentRequest];
    }
}

#pragma mark --UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if([request.URL.absoluteString isEqualToString:@"about:blank"])   //若为空白栏
        return NO;
    _currentRequest = request;
    NSString *ip = [self.localDNS objectForKey:request.URL.absoluteString];
    NSLog(@"ip : %@",ip);
    if(ip != nil && !_isLoadIp ) {
        _isLoadIp = !_isLoadIp;
        //[webView stopLoading];
        NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:ip]];
        [webView loadRequest:req];
        return NO;
    }else if(!_isLoadIp){
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self getIpWithURL:request.URL.absoluteString];
        });
    }
/*离线缓存
 
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSFileManager *fm = [NSFileManager defaultManager];
        NSData *htmlFile  = [NSData dataWithContentsOfURL:request.URL];
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *fileName = [request.URL.absoluteString stringByReplacingOccurrencesOfString:@"://" withString:@"_"];
        fileName = [fileName stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
        fileName = [NSString stringWithFormat:@"%@/%@.html",cachePath,fileName];
        NSLog(@"fileName : %@",fileName);
        [fm createFileAtPath:fileName contents:htmlFile attributes:nil];
    });
 
*/
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    if(_loadTime) {
        [_loadTime invalidate];
        _loadTime = nil;
    }
    _loadTime = [NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(loadTimeOut) userInfo:nil repeats:NO];
    self.isLoading = YES;
    self.loadingView.hidden  = NO;
    self.loadingLabel.hidden = NO;
    self.errorView.hidden    = YES;
    self.errorLabel.hidden   = YES;
    NSLog(@"开始加载");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if([self.webView canGoForward]) {
        [self.forwardButton setImage:[UIImage imageNamed:@"forward_highlight.png"] forState:UIControlStateNormal];
    }else {
            [self.forwardButton setImage:[UIImage imageNamed:@"forward_normal.png"] forState:UIControlStateNormal];
    }
    self.isLoadError         = NO;
    self.isLoading           = NO;
    self.loadingView.hidden  = YES;
    self.loadingLabel.hidden = YES;
    _canReload = YES;
    [_loadTime invalidate];
    _loadTime  = nil;
    _isTimeOut = NO;
    _isLoadIp  = NO;
    NSLog(@"加载完成");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [_loadTime invalidate];
    _loadTime = nil;
    self.isLoadError = YES;
    self.isLoading   = NO;
    self.loadingView.hidden  = YES;
    self.loadingLabel.hidden = YES;
    _canReload = NO;
    _isLoadIp  = NO;
    if(_isTimeOut) {
        NSLog(@"%@",error);
        self.errorLabel.text = @"很抱歉，加载页面超时啦！！";
        _isTimeOut = NO;
    }else {
        if(error.code == -999)      //“加载不完全”不显示错误
            return;
        NSLog(@"%@",error);
        if(error.code == -1009)
            self.errorLabel.text = @"无法连接到互联网，请检查您的网络配置";
        else
            self.errorLabel.text = @"很抱歉，加载页面出错啦！！";
    }
    int i = (arc4random() % 4) + 1;
    self.errorView.image   = [UIImage imageNamed:[NSString stringWithFormat:@"errorImage_%d.png",i]];
    self.errorView.hidden  = NO;
    //self.errorLabel.text = error.localizedDescription; //错误的本地化描述
    self.errorLabel.hidden = NO;
}

- (void)loadTimeOut {
    _loadTime  = nil;
    _isTimeOut = YES;
    [self.webView stopLoading];
    NSLog(@"加载超时");
}

#pragma mark --property

- (UIWebView *)webView {
    if(!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.backgroundColor = [UIColor whiteColor];
    }
    return _webView;
}

- (UIButton *)backButton {
    if(!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.boundsX+20, 20, 30, 20)];
        [_backButton setImage:[UIImage imageNamed:@"backButton_highlight.png"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UIButton *)forwardButton {
    if(!_forwardButton) {
        _forwardButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.boundsWidth-50, 20, 30, 20)];
        [_forwardButton setImage:[UIImage imageNamed:@"forward_normal.png"] forState:UIControlStateNormal];
        [_forwardButton addTarget:self action:@selector(forwardButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forwardButton;
}

- (UIButton *)homeButton {
    if(!_homeButton) {
        _homeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.boundsX+80, 18, 20, 20)];
        [_homeButton setImage:[UIImage imageNamed:@"homeButton.png"] forState:UIControlStateNormal];
        [_homeButton addTarget:self action:@selector(homeButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _homeButton;
    
}

- (UIButton *)reloadButton {
    if(!_reloadButton) {
        _reloadButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.boundsWidth-100, 19, 30, 20)];
        [_reloadButton setImage:[UIImage imageNamed:@"reload.png"] forState:UIControlStateNormal];
        [_reloadButton addTarget:self action:@selector(reloadButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reloadButton;
}

- (UIImageView *)navBar {
    if(!_navBar) {
        _navBar = [[UIImageView alloc] initWithFrame:CGRectMake(-5, 0, self.view.boundsWidth+20, 40)];
        _navBar.image = [UIImage imageNamed:@"navBarBg.png"];
        _navBar.alpha = 0.95f;
    }
    return _navBar;
}

- (UIImageView *)loadingView {
    if(!_loadingView) {
        _loadingView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.boundsWidth/2-25, self.view.boundsHeight/2-25, 50, 50)];
        NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:9];
        NSString *imgName;
        for(int i=1; i<10; i++) {
            imgName = [NSString stringWithFormat:@"loading_0%d",i];
            [imageArray addObject:[UIImage imageNamed:imgName]];
        }
        _loadingView.animationImages = imageArray;
        _loadingView.animationDuration = 0.8f;
        _loadingView.animationRepeatCount = 0;
        [_loadingView startAnimating];
        _loadingView.hidden = YES;
    }
    return _loadingView;
}

- (UILabel *)loadingLabel {
    if(!_loadingLabel) {
        _loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.loadingView.frame.origin.x-50, self.loadingView.frame.origin.y+self.loadingView.frame.size.height, 150, 50)];
        _loadingLabel.textAlignment = NSTextAlignmentCenter;
        _loadingLabel.font          = [UIFont systemFontOfSize:12.0f];
        _loadingLabel.text          = @"正在努力加载中...";
        _loadingLabel.hidden        = YES;
    }
    return _loadingLabel;
}

- (UIImageView *)errorView {
    if(!_errorView) {
        _errorView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"errorImage_1.png"]];
        _errorView.frame = CGRectMake(self.view.boundsWidth/2-60, self.view.boundsHeight/2-80, 120, 120);
        _errorView.hidden = YES;
    }
    return _errorView;
}

- (UILabel *)errorLabel {
    if(!_errorLabel) {
        _errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.boundsWidth/2-120, self.view.boundsHeight/2+40, 240, 60)];
        _errorLabel.textAlignment = NSTextAlignmentCenter;
        _errorLabel.text   = @"很抱歉，加载页面出错啦！！";
        _errorLabel.font   = [UIFont systemFontOfSize:12.0f];
        _errorLabel.hidden = YES;
    }
    return _errorLabel;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
