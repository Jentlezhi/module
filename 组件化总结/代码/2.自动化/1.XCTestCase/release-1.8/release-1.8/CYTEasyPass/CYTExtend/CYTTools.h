//
//  CYTTools.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/28.
//  Copyright © 2017年 EasyPass. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CYTLoginParmeters.h"

@interface CYTTools : NSObject
///mainView通用配置,autoDimension-自动布局
+ (void)configForMainView:(FFMainView *)mainView;
///dzn
+ (void)configForDZNSupernatant:(FFDZNSupernatant *)dznSupernatant;
///修改导航样式
+ (void)updateNavigationBarWithController:(UIViewController *)controller showBackView:(BOOL)showBackView showLine:(BOOL)showLine;

///获取http请求token等参数
+ (NSDictionary *)headFiledDictionary;
///判断是否有特殊字符
+ (BOOL)haveInvalidCharacterWithString:(NSString *)content;
///获取登录接口参数
+ (CYTLoginParmeters *)loginParameters;
///提示登录失败原因、清除登录数据，弹出登录页面
+ (void)existLoginStateWithMessage:(NSString *)message;

///获取目录根路径
+ (NSString *)fileRootPathBindUser:(BOOL)bind;
///获取文件路径
+ (NSString *)filePath:(NSString *)path bindUser:(BOOL)bind;
///获取未登录的绑定用户的根目录
+ (NSString *)unloginRootPath;

@end
