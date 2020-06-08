//
//  CYTH5ViewController.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicViewController.h"
#import "CYTWebLoadingProgressView.h"

@interface CYTH5ViewController : CYTBasicViewController<UIScrollViewDelegate,UIWebViewDelegate>
///vm
@property (nonatomic, strong) id baseViewModel;
@property (nonatomic, strong) UIWebView *webView;
///可以在外部设置，也可以在内部实现 - (NSString *)requestURL {}返回url
@property (nonatomic, copy) NSString *requestURL;
/** 加载成功的回调 */
@property(copy, nonatomic) void(^webViewLoadSuccess)();
/** 加载失败的回调 */
@property(copy, nonatomic) void(^webViewLoadFail)();
///使用indicator,默认不使用
@property (nonatomic, assign) BOOL showIndicator;
/** 加载进度 */
@property(strong, nonatomic) CYTWebLoadingProgressView *loadingProgressView;

- (void)loadUI;
- (void)loadURL;

///cookie 处理
+ (void)cleanCacheAndCookie;
+ (void)addCookie;

@end
