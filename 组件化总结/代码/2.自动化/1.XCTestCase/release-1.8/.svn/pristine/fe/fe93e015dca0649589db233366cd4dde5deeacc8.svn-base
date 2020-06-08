//
//  CYTAuthManager.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/15.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
#import "CYTUserInfoModel.h"

#define kAlert_authenticating   (@"您尚未通过认证，只有通过认证的用户才能进行此操作。")

typedef NS_ENUM(NSInteger,AccountState) {
    ///没有认证
    AccountStateLoginNotAuthenticationed = 0,
    ///已经认证
    AccountStateAuthenticationed = 2,
    ///认证中
    AccountStateAuthenticating = 1,
    ///认证失败
    AccountStateAuthenticateFailed = -2,
};

///全局单利类
@interface CYTAuthManager : CYTExtendViewModel
///单例
+ (instancetype)manager;

///是否登录
@property (nonatomic, assign) BOOL isLogin;

///显示登录页面
- (void)goLoginView;
///去认证页面
- (void)goAuthenticateView;
///自动处理提示的认证
- (void)alert_authenticate;


///获取用户状态，并且自动处理非认证成功的状态。
- (void)autoHandleAccountStateWithLocalState:(BOOL)localState result:(void(^)(AccountState))block;
///直接使用已有状态
- (AccountState)getLocalAccountState;
///获取认证数据
- (void)getUserDealerInfoFromLocal:(BOOL)local result:(void (^)(CYTUserInfoModel *))block;

@end
