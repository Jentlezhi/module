//
//  CYTTools.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/28.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTTools.h"
#import "CYTCommonNetErrorView.h"
#import "AESCrypt.h"
#import "CYTLoginViewController.h"
#import "CYTPrestrainManager.h"
#import "CYTNavigationController.h"

@implementation CYTTools

+ (void)configForMainView:(FFMainView *)mainView {
    //设置自动计算cell高度
    mainView.tableView.rowHeight = UITableViewAutomaticDimension;
    mainView.tableView.estimatedRowHeight = 100;
    mainView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置背景色
    mainView.tableView.ffBgColor = kFFColor_bg_nor;
    
    //设置网络异常样式
    CYTCommonNetErrorView *reloadView = [[CYTCommonNetErrorView alloc] init];
    reloadView.bottomSpace = 0;
    reloadView.topSpace = 0;
    reloadView.contentText = @"Sorry 网络出现问题了";
    reloadView.contentSubText = @"- 请稍后再试吧 -";
    reloadView.contentImage = @"dzn_netError_2";
    mainView.dznCustomView.reloadView = reloadView;
    
    //设置空数据样式
    mainView.dznCustomView.emptyView.dznLabel.text = @"- 暂时没有您要的数据 -";
    //loading
    mainView.dznCustomView.loadingView.contentText = @"...";
    
    [mainView radius:1 borderWidth:0.5 borderColor:[UIColor clearColor]];
}

+ (void)configForDZNSupernatant:(FFDZNSupernatant *)dznSupernatant {
    //设置网络异常样式
    CYTCommonNetErrorView *reloadView = [[CYTCommonNetErrorView alloc] init];
    reloadView.bottomSpace = 0;
    reloadView.topSpace = 0;
    reloadView.contentText = @"Sorry 网络出现问题了";
    reloadView.contentSubText = @"- 请稍后再试吧 -";
    reloadView.contentImage = @"dzn_netError_2";
    dznSupernatant.dznCustomView.reloadView = reloadView;
    
    //设置空数据样式
    dznSupernatant.dznCustomView.emptyView.dznLabel.text = @"- 暂时没有您要的数据 -";
    //loading
    dznSupernatant.dznCustomView.loadingView.contentText = @"...";
    
    [dznSupernatant radius:1 borderWidth:0.5 borderColor:[UIColor clearColor]];
}

+ (void)updateNavigationBarWithController:(UIViewController *)controller showBackView:(BOOL)showBackView showLine:(BOOL)showLine {
    FFExtendViewController *ctr = (FFExtendViewController *)controller;
    ctr.ffNavigationView.contentView.leftView.imageName = @"nav_back";
    [ctr.ffNavigationView.contentView.leftView setImageInsect:UIEdgeInsetsMake(0, -CYTAutoLayoutH(10), 0, CYTAutoLayoutH(10))];
    ctr.ffNavigationView.bgImageView.backgroundColor = kTranslucenceColor;
    
    ctr.ffNavigationView.bottomLineView.backgroundColor = CYTNavBarLineColor;
#ifdef DEBUG
#ifdef kFFDebug
    ctr.ffNavigationView.bottomLineView.backgroundColor = CYTRedColor;
#endif
#endif
    
    //返回按钮
    [ctr.ffNavigationView showLeftItem:showBackView];
    //line
    ctr.showNavigationBottomLine = showLine;
}

+ (NSDictionary *)headFiledDictionary {
    
    //基础参数
    NSString *appVersion = [NSMutableString stringWithFormat:@"%@",kFF_APP_VERSION];
    NSString *iosVersion = [CYTCommonTool getIOSVersion];
    NSString *devicePlatform = [CYTCommonTool devicePlatform];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"0" forKey:@"appBuild"];
    [parameters setValue:@"ios" forKey:@"os"];
    [parameters setValue:appVersion forKey:@"appVersion"];
    [parameters setValue:iosVersion forKey:@"osVersion"];
    [parameters setValue:CYTUUID forKey:@"deviceId"];
    [parameters setValue:devicePlatform forKey:@"devicePlatform"];
    
    //登录后的token
    NSString *auth = (![CYTAccountManager sharedAccountManager].accessToken)?@"":[CYTAccountManager sharedAccountManager].accessToken;
    if (auth.length != 0) {
        auth = [NSString stringWithFormat:@"Bearer %@",auth];
    }
    
    NSString *userId = CYTUserId;
    [parameters setValue:auth forKey:@"Authorization"];
    [parameters setValue:userId forKey:@"userId"];
    
    return parameters;
}

//判断是否含有非法字符 yes 有  no没有
+ (BOOL)haveInvalidCharacterWithString:(NSString *)content {
    //提示 标签不能输入特殊字符
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:content]) {
        return YES;
    }
    return NO;
}

+ (CYTLoginParmeters *)loginParameters {
    
    CYTLoginParmeters *loginParmeters = [[CYTLoginParmeters alloc] init];
    loginParmeters.grantType = @"2";
    
    loginParmeters.userId = CYTUserId;
    loginParmeters.refreshToken = [CYTAccountManager sharedAccountManager].refreshToken;
    loginParmeters.deviceId = CYTUUID;
    
    loginParmeters.password = @"";
    loginParmeters.tokenValue = @"";
    loginParmeters.mobile = @"";
    
    return loginParmeters;
}

+ (void)existLoginStateWithMessage:(NSString *)message {
    if (!message || message.length == 0) {
        message = @"登录信息已过期，请重新登录。";
    }
    
    [CYTToast errorToastWithMessage:message];
    //不要延时
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //删除旧的数据
        [[CYTAccountManager sharedAccountManager] cleanUserData];
        
        //进入登录页面
        CYTLoginViewController *loginVC = [[CYTLoginViewController alloc] init];
        [loginVC setLoginStateBlock:^(BOOL success) {
            if (success) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kGoMainHomeViewKey object:nil];
            }
        }];
        CYTNavigationController *navController = [[CYTNavigationController alloc] initWithRootViewController:loginVC];
        loginVC.showBackButton = YES;

        //处理特殊情况
        UIViewController *top = [FFCommonCode topViewController];
        if ([top isKindOfClass:[CYTLoginViewController class]]) {
            return ;
        }
        [top presentViewController:navController animated:YES completion:^{

        }];
    });
}

+ (NSString *)filePath:(NSString *)path bindUser:(BOOL)bind {
    NSString *rootPath = [CYTTools fileRootPathBindUser:bind];
    if (rootPath.length>0 && path.length>0) {
        return [NSString stringWithFormat:@"%@/%@",rootPath,path];
    }
    return nil;
}

///获取用户数据默认根目录
+ (NSString *)fileRootPathBindUser:(BOOL)bind {
    CYTLog(@"document = %@",CYTDocumentPath);
    NSString *userIdString = @"";
    if (bind) {
        userIdString = CYTUserId;
        if ([userIdString isEqualToString:@""]) {
            userIdString = @"unLogin";
        }
        return [NSString stringWithFormat:@"%@/%@",CYTDocumentPath,userIdString];
    }else {
        return [NSString stringWithFormat:@"%@",CYTDocumentPath];
    }
}

+ (NSString *)unloginRootPath {
    NSString *userIdString = @"unLogin";
    return [NSString stringWithFormat:@"%@/%@",CYTDocumentPath,userIdString];
}

@end
