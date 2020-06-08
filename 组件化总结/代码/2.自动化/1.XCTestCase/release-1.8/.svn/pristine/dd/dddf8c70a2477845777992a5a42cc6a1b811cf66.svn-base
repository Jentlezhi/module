//
//  CYTWebLoadingProgressView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/2.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTWebLoadingProgressView.h"

@interface CYTWebLoadingProgressView()<UIWebViewDelegate>

/** progressBar */
@property(weak, nonatomic) UIView *progressBarView;
/** displayLink */
@property(strong, nonatomic) CADisplayLink *displayLink;
/** progressValue */
@property(assign, nonatomic) CGFloat progressValue;
/** currentURL */
@property(strong, nonatomic) NSURL *currentURL;
/** interactive */
@property(assign, nonatomic) BOOL interactive;


@end

@implementation CYTWebLoadingProgressView
{
    UIColor *_progressBarColor;
}

- (UIColor *)progressBarColor{
    if (!_progressBarColor) {
        _progressBarColor = [UIColor colorWithRed:22.f / 255.f green:126.f / 255.f blue:251.f / 255.f alpha:1.0];
    }
    return _progressBarColor;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self webLoadingProgressBasicConfig];
        [self initWebLoadingProgressComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  basic config
 */
- (void)webLoadingProgressBasicConfig{
    self.backgroundColor = [UIColor clearColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(self.progressBarView.alpha != 0){
            [self completeProgress];
        }
    });

}
/**
 *  init components
 */
- (void)initWebLoadingProgressComponents{
    //progress bar
    UIView *progressBarView = [[UIView alloc] init];
    progressBarView.backgroundColor = self.progressBarColor;
    [self addSubview:progressBarView];
    _progressBarView = progressBarView;
    //begin loading
    [self startAutoUpdateProgress];
}

/**
 *  makeConstrains
 */
- (void)makeConstrains{
    [_progressBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        make.width.equalTo(0);
    }];
}
/**
 *  updateProgressValue
 */
- (void)updateProgressValue{
    NSTimeInterval totalTime = 2.0f;
    NSTimeInterval screenRefreshTime = 1/60.f;
    CGFloat perSecondPoint = screenRefreshTime*1/totalTime;
    if (self.progressValue<=0.85f){
        self.progressValue+=perSecondPoint;
    }else{
        return;
    }
    [_progressBarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.progressValue*kScreenWidth);
    }];
    [UIView animateWithDuration:0.25f animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)startAutoUpdateProgress{
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateProgressValue)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stopAutoUpdateProgress{
    [self.displayLink invalidate];
    self.displayLink = nil;
}

- (void)completeProgress{
    [self stopAutoUpdateProgress];
    [_progressBarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(kScreenWidth);
    }];
    [UIView animateWithDuration:0.1f animations:^{
        [self layoutIfNeeded];
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.35f animations:^{
            _progressBarView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
}

#pragma mark - <UIWebViewDelegate>

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    BOOL result = YES;
    if ([_webViewProxyDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        result = [_webViewProxyDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    return result;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    if ([_webViewProxyDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [_webViewProxyDelegate webViewDidStartLoad:webView];
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if ([_webViewProxyDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [_webViewProxyDelegate webViewDidFinishLoad:webView];
    }
    [self completeProgress];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if ([_webViewProxyDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [_webViewProxyDelegate webView:webView didFailLoadWithError:error];
    }
    [self completeProgress];
}
/**
 * set bar color
 */
- (void)setProgressBarColor:(UIColor *)progressBarColor{
    _progressBarColor = progressBarColor;
    _progressBarView.backgroundColor = progressBarColor;
}

@end
