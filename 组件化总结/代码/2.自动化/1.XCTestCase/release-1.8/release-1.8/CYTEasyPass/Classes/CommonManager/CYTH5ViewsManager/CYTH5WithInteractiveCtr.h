//
//  CYTOldHomeViewController.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/2/27.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTH5ViewController.h"

@interface CYTH5WithInteractiveCtr : CYTH5ViewController
///url拦截处理
- (BOOL)handleURL:(NSURL *)urlString;
///js交互
@property (nonatomic, strong) WebViewJavascriptBridge* bridge;

@end
