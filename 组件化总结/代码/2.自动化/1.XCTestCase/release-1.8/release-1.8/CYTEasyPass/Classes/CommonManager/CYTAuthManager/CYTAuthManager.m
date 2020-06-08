//
//  CYTAuthManager.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/15.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAuthManager.h"
#import "CYTLoginViewController.h"
#import "CYTPersonalCertificateViewController.h"
#import "CYTNavigationController.h"
#import "CYTCertificationPreviewController.h"

@interface CYTAuthManager ()<UIAlertViewDelegate>

@end

@implementation CYTAuthManager
@synthesize requestCommand = _requestCommand;

+ (instancetype)manager {
    static CYTAuthManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [CYTAuthManager new];
    });
    return instance;
}

- (BOOL)isLogin {
    return ([CYTAccountManager sharedAccountManager].accessToken)?YES:NO;
}

#pragma mark- api
///获取经销商信息
- (void)getUserDealerInfoFromLocal:(BOOL)local result:(void (^)(CYTUserInfoModel *))block {
    
    CYTUserInfoModel *model = [CYTAccountManager sharedAccountManager].userAuthenticateInfoModel;
    if (!local) {model = nil;}
    
    //如果本地有经销商信息，直接返回，如果没有则请求
    if (model) {
        block(model);
    }else{
        //未登录
        if (![CYTAuthManager manager].isLogin) {block(nil);return;}
        
        //网络请求
        [[CYTAccountManager sharedAccountManager] updateUserInfoCompletion:^(CYTUserInfoModel *userAuthenticateInfoModel) {
            if (userAuthenticateInfoModel.isStoreAuth) {
                [CYTCommonTool setValue:@(userAuthenticateInfoModel.isStoreAuth) forKey:CYTIsStoreAuthKey];
            }else{
                [CYTCommonTool removeValueForKey:CYTIsStoreAuthKey];
            }
            
            //返回数据
            block(userAuthenticateInfoModel);
        }];
    }
}

- (void)autoHandleAccountStateWithLocalState:(BOOL)localState result:(void(^)(AccountState))block {
    
    NSInteger auStatus = [CYTAccountManager sharedAccountManager].authStatus;
    if ([CYTAccountManager sharedAccountManager].accessToken) {
        //判断是使用实时状态还是本地状态
        if (localState) {
            
            [self handleState:auStatus result:block];
        }else{
            //已登录,请求认证信息
            //先从本地读取，如果是已经认证通过则直接返回否则请求接口。
            AccountState stateTmp = auStatus;
            if (stateTmp == AccountStateAuthenticationed) {
                [self handleState:stateTmp result:block];
            }else {
                //网络请求
                [[CYTAccountManager sharedAccountManager] updateUserInfoCompletion:^(CYTUserInfoModel *userAuthenticateInfoModel) {
                    //返回数据
                    [self handleState:userAuthenticateInfoModel.authStatus result:block];
                }];
            }
        }
    }else{
        //未登录
        [self handleState:-100 result:block];
    }
}

- (void)handleState:(AccountState)state result:(void(^)(AccountState))block{
    
    switch (state) {
        case AccountStateLoginNotAuthenticationed://未认证
        case AccountStateAuthenticating://认证中
        case AccountStateAuthenticateFailed:
        {
            [self alert_authenticate];
        }
            break;
        case AccountStateAuthenticationed://已认证
        {
            
        }
            break;
        default:
        {
            //未登录
            [self goLoginView];
        }
            break;
    }
    
    if (block) {
        block(state);
    }
}

- (AccountState)getLocalAccountState {
    NSInteger auStatus = [CYTAccountManager sharedAccountManager].userAuthenticateInfoModel.authStatus;
    return auStatus;
}

#pragma mark- method
- (void)goLoginView {
    //进入登录页面
    CYTLoginViewController *loginVC = [[CYTLoginViewController alloc] init];
    CYTNavigationController *navController = [[CYTNavigationController alloc] initWithRootViewController:loginVC];
    loginVC.showBackButton = YES;
    [CYTApplication.keyWindow.rootViewController presentViewController:navController animated:YES completion:^{
        
    }];
}

- (void)goAuthenticateView {
    //进入认证页面
    CYTPersonalCertificateViewController *personalCertificateVC = [[CYTPersonalCertificateViewController alloc] init];
    personalCertificateVC.backType = CYTBackTypeDismiss;
    CYTNavigationController *navController = [[CYTNavigationController alloc] initWithRootViewController:personalCertificateVC];
    [CYTApplication.keyWindow.rootViewController presentViewController:navController animated:YES completion:^{
        
    }];
}

#pragma mark- alert
- (void)alert_authenticate {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:kAlert_authenticating delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去认证", nil];
    [alert show];
}

///需要在dismiss方法中调用
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        
        AccountState state = [self getLocalAccountState];

        if (state == AccountStateLoginNotAuthenticationed || state == AccountStateAuthenticateFailed) {
            //如果失败和未认证进入提交页面
            [self goAuthenticateView];
        }else if (state == AccountStateAuthenticating) {
            //如果正在认证中进入浏览
            CYTCertificationPreviewController *certificationPreviewController = [[CYTCertificationPreviewController alloc] init];
            certificationPreviewController.accountState = state;
            certificationPreviewController.backType = CYTBackTypeDismiss;
            CYTNavigationController *nav = [[CYTNavigationController alloc] initWithRootViewController:certificationPreviewController];
            [CYTApplication.keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                
            }];
        }
    }
}

@end
