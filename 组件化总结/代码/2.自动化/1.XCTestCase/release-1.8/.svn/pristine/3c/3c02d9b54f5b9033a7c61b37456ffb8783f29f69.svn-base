//
//  CYTH5ViewController.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTH5ViewController.h"

@interface CYTH5ViewController ()<UIWebViewDelegate>
///边距
@property (nonatomic, assign) UIEdgeInsets insets;
///indicator
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
/** 请求次数 */
@property(assign, nonatomic) NSUInteger startLoadTime;

@end

@implementation CYTH5ViewController

- (CYTWebLoadingProgressView *)loadingProgressView{
    if (!_loadingProgressView) {
        CGFloat progressBarHeight = 2.f;
        CGRect frame = CGRectMake(0, CYTViewOriginY - progressBarHeight, kScreenWidth, progressBarHeight);
        _loadingProgressView = [[CYTWebLoadingProgressView alloc] initWithFrame:frame];
        _loadingProgressView.progressBarColor = CYTGreenNormalColor;
    }
    return _loadingProgressView;
}

- (instancetype)initWithViewModel:(id)viewModel {
    if (self = [super initWithViewModel:viewModel]) {
        _baseViewModel = viewModel;
        _insets = UIEdgeInsetsMake(CYTViewOriginY, 0, 0, 0);
        if (_baseViewModel) {
            _insets = UIEdgeInsetsFromString(self.baseViewModel);
        }
    }
    return self;
}

/**
 *  添加进度条
 */
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationZone addSubview:self.loadingProgressView];
}
/**
 *  移除进度条
 */
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"" andShowBackButton:YES showRightButtonWithTitle:nil];
    [self loadUI];
    [self loadURL];
    [self addGesture];
}

- (void)addGesture {

}

- (void)loadUI {
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(self.view).offset(self.insets.top);
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.safeAreaLayoutGuideBottom);
        }else {
            make.bottom.equalTo(self.view);
        }
    }];
    
    [self.view addSubview:self.indicatorView];
    [self.indicatorView makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(0);
    }];
}

- (void)loadURL {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[[NSURL alloc] initWithString:self.requestURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
    [self.webView loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.startLoadTime = self.startLoadTime + 1;;
    if (self.showIndicator) {
        [self.indicatorView startAnimating];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.startLoadTime = self.startLoadTime -1;
    if (self.startLoadTime>0)return;
}

- (void)setStartLoadTime:(NSUInteger)startLoadTime{
    _startLoadTime = startLoadTime;
    if (startLoadTime>0)return;
    [self.indicatorView stopAnimating];
    [self.loadingProgressView completeProgress];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError*)error{
    self.startLoadTime = self.startLoadTime -1;
    if (self.startLoadTime>0)return;
    !self.webViewLoadFail?:self.webViewLoadFail();
    [self.indicatorView stopAnimating];
    [self.loadingProgressView completeProgress];
}

#pragma mark- cookie
+ (void)cleanCacheAndCookie{
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]){
        [storage deleteCookie:cookie];
    }
}

+ (void)addCookie {
    //登录后的token
    NSString *auth = (![CYTAccountManager sharedAccountManager].accessToken)?@"":[CYTAccountManager sharedAccountManager].accessToken;
    if (auth.length != 0) {
        auth = [NSString stringWithFormat:@"Bearer %@",auth];
    }
    NSString *refreshToken = (![CYTAccountManager sharedAccountManager].refreshToken)?@"":[CYTAccountManager sharedAccountManager].refreshToken;
    NSString *userId = CYTUserId;
    
    NSDictionary *item = @{@"keyName":@"userId",
                           @"value":userId};
    NSDictionary *item1 = @{@"keyName":@"token",
                            @"value":auth};
    NSDictionary *item2 = @{@"keyName":@"refreshToken",
                            @"value":refreshToken};
    NSDictionary *item3 = @{@"keyName":@"deviceId",
                            @"value":CYTUUID};
    
    NSArray *array = @[item,item1,item2,item3];
    
    for (int i=0; i<array.count; i++) {
        NSDictionary *dic = array[i];
        
        NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:
                                [NSDictionary dictionaryWithObjectsAndKeys:
                                 kURL.URLDomain,NSHTTPCookieDomain,
                                 @"/",NSHTTPCookiePath,
                                 @"0",NSHTTPCookieVersion,
                                 dic[@"keyName"],NSHTTPCookieName,
                                 dic[@"value"],NSHTTPCookieValue,
                                 nil]];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        
    }
}

#pragma mark- get
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [UIWebView new];
        if (@available(iOS 11.0, *)) {
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _webView.scrollView.delegate = self;
        _webView.scrollView.bounces = YES;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scalesPageToFit = YES;
        _webView.multipleTouchEnabled = YES;
        _webView.userInteractionEnabled = YES;
    }
    return _webView;
}

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _indicatorView;
}

@end
