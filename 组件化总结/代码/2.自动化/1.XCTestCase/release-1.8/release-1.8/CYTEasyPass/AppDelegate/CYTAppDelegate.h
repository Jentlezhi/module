//
//  AppDelegate.h
//  CYTEasyPass
//
//  Created by bita on 15/8/21.
//  Copyright (c) 2015年 EasyPass. All rights reserved.
//
/*
 说明
 1、AESCrypt不可使用pod管理，因为内容使用了加密向量，修改了库代码。

 */

#import <UIKit/UIKit.h>
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "CYTCustomTabbarController.h"
#import "CYTMessageCenterVM.h"
#import "CYTShareRequestModel.h"

@class CYTAppManager;

@interface CYTAppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate,UITabBarControllerDelegate>
/** 项目管理者 */
@property (strong, nonatomic) CYTAppManager *appManager;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) CYTCustomTabbarController *tabBarController;
@property (nonatomic, assign) ShareTypeId wxShareType;
@property (nonatomic, assign) NSInteger wxShareBusinessId;

///进入首页
- (void)goHomeView;
- (void)goCarSourceView;
- (void)goSeekCarView;
- (void)goDiscover;
- (void)goMe;

@end

