//
//  CYTOldHomeViewController.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/2/27.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTH5WithInteractiveCtr.h"
#import "CYTLoginViewController.h"
#import "CYTLinkHandler.h"
#import "CYTH5WithInteractiveModel.h"
#import "CYTWebLoadingProgressView.h"
#import <JavaScriptCore/JavaScriptCore.h>

///帮助
#define kHelpURL            @"CustomerService"
///拨打客服电话
#define kcallServiceUrl     @"callServiceUrl"
///立即注册
#define kregisterUrl        @"registerUrl"
///去认证
#define kuserAuthUrl        @"userAuthUrl"
///过期
#define kExpired            @"redirect_to_expired"

@interface CYTH5WithInteractiveCtr ()
///js调用传递的参数
@property (nonatomic, strong) CYTH5WithInteractiveModel *bridgeDataModel;
@property (nonatomic, strong) JSContext *jsContext;

@end

@implementation CYTH5WithInteractiveCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerMethodForJS];
}

- (void)backButtonClick:(UIButton *)backButton {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [super webViewDidStartLoad:webView];
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError*)error{
    [super webView:webView didFailLoadWithError:error];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    [super webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    return [self handleURL:request.URL];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [super webViewDidFinishLoad:webView];
    NSString *htmlTitle = @"document.title";
    NSString *titleString = [webView stringByEvaluatingJavaScriptFromString:htmlTitle];
    self.navTitle = titleString;
}

- (BOOL)handleURL:(NSURL *)urlString {
    
    if ([urlString.scheme isEqualToString:@"cxt"]) {
        //cxy跳转处理
        //取反!!
        return ![[CYTLinkHandler new] handleAPPInnerLinkWithURL:urlString.absoluteString];
    }else {
        //其他http跳转
        if (urlString.absoluteString && [urlString.absoluteString rangeOfString:kExpired].location != NSNotFound ) {
            //弹出登录页面
            [CYTTools existLoginStateWithMessage:nil];
            return NO;
        }else {
            NSArray *pathArray = [urlString pathComponents];
            if ([pathArray containsObject:kHelpURL]) {
                [self goHelp];
                return NO;
            }else if ([pathArray containsObject:kcallServiceUrl]) {
                [self makePhone];
                return NO;
            }else if ([pathArray containsObject:kregisterUrl]) {
                [self registerMethod];
                return NO;
            }else if ([pathArray containsObject:kuserAuthUrl]) {
                [self authenticateMethod];
                return NO;
            }else {
                //其他的http链接不拦截。
                return YES;
            }
        }
    }
}

- (NSArray *)getParameters:(NSString *)queryString {
    NSArray *groupArray = [queryString componentsSeparatedByString:@"&"];
    NSMutableArray *mulArray = [NSMutableArray array];
    for (int i = 0; i<groupArray.count; i++) {
        NSString *itemString  = groupArray[i];
        NSArray *itemArray = [itemString componentsSeparatedByString:@"="];
        NSDictionary *itemDic = @{@"key":itemArray[0],
                                  @"value":itemArray[1]};
        [mulArray addObject:itemDic];
    }
    return mulArray;
}

#pragma mark- method

- (void)registerMethod {
    [[CYTAuthManager manager] goLoginView];
}

- (void)authenticateMethod {
    [[CYTAuthManager manager] goAuthenticateView];
}

- (void)makePhone {
    [self alert_service];
}

- (void)alert_service {
    [CYTPhoneCallHandler makeServicePhone];
}

- (void)goHelp {
    CYTH5WithInteractiveCtr *ctr = [[CYTH5WithInteractiveCtr alloc] init];
    ctr.requestURL = kURL.kURL_Home_help;
    [self.navigationController pushViewController:ctr animated:YES];
}

#pragma mark- js method
///提供方法共js调用
- (void)registerMethodForJS {
    [self.bridge registerHandler:@"YCBJsBridge" handler:^(id data, WVJBResponseCallback responseCallback) {
        CYTH5WithInteractiveModel *model = [CYTH5WithInteractiveModel mj_objectWithKeyValues:data];
        //拼接方法名字
        if (model.methodName.length==0) {
            return ;
        }
        self.bridgeDataModel = model;
        NSString *methodName = [NSString stringWithFormat:@"%@_method",model.methodName];
        SEL selector = NSSelectorFromString(methodName);
        if ([self respondsToSelector:selector]) {
            [self performSelector:selector withObject:model];
        }

        responseCallback(@"");
    }];
}

- (void)back_method {
    [self backButtonClick:nil];
}

- (void)goodsDetail_method {
    CYTH5WithInteractiveCtr *h5 = [[CYTH5WithInteractiveCtr alloc] init];
    h5.requestURL = self.bridgeDataModel.params[@"url"];
    [self.navigationController pushViewController:h5 animated:YES];
}

- (WebViewJavascriptBridge *)bridge {
    if (!_bridge) {
        _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
        [_bridge setWebViewDelegate:self];
    }
    return _bridge;
}

@end
