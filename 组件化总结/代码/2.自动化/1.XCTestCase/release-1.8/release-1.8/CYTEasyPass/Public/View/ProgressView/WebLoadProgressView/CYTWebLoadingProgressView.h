//
//  CYTWebLoadingProgressView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/2.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYTWebLoadingProgressView : UIView<UIWebViewDelegate>

/** progressBarColor */
@property(strong, nonatomic) UIColor *progressBarColor;

/** webView delegate */
@property(weak, nonatomic) id<UIWebViewDelegate>webViewProxyDelegate;
///开始
- (void)startAutoUpdateProgress;
///结束
- (void)completeProgress;

@end
