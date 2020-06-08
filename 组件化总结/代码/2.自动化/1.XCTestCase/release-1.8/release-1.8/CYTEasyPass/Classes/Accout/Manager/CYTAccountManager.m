//
//  CYTAccountManager.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAccountManager.h"
#import "CYTLoginViewController.h"
#import "CYTNavigationController.h"

#define kAccountfilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"UserInfo"]

static NSString *const userIdKey = @"userIdKey";
static NSString *const accessTokenKey = @"accessTokenKey";
static NSString *const refreshTokenKey = @"refreshTokenKey";
static NSString *const userPhoneNumKey = @"userPhoneNumKey";
static NSString *const authStatusKey = @"authStatusKey";

@interface CYTAccountManager()

@end

@implementation CYTAccountManager
{
    NSString *_userId;
    NSString *_accessToken;
    NSString *_refreshToken;
    NSString *_userPhoneNum;
    NSInteger _authStatus;
    CYTUserKeyInfoModel *_userKeyInfoModel;
    CYTUserInfoModel *_userAuthenticateInfoModel;
}
/**
 *  单例
 */
+ (instancetype)sharedAccountManager{
    static CYTAccountManager *accountManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        accountManager = [[CYTAccountManager alloc] init];
    });
    
    return accountManager;
}

- (instancetype)init{
    if (self = [super init]) {

    }
    return self;
}

- (void)setUserId:(NSString *)userId{
    _userId = userId;
    [self accountSetValue:userId forKey:userIdKey];
}

- (NSString *)userId{
    return [self accountValueForKey:userIdKey];
}

- (void)setUserPhoneNum:(NSString *)userPhoneNum{
    _userPhoneNum = userPhoneNum;
    [self accountSetValue:userPhoneNum forKey:userPhoneNumKey];
}

- (NSString *)userPhoneNum{
    return [self accountValueForKey:userPhoneNumKey];
}

- (void)setAccessToken:(NSString *)accessToken{
    _accessToken = accessToken;
    [self accountSetValue:accessToken forKey:accessTokenKey];
}

- (NSString *)accessToken{
    return [self accountValueForKey:accessTokenKey];
}

- (void)setRefreshToken:(NSString *)refreshToken{
    _refreshToken = refreshToken;
    [self accountSetValue:refreshToken forKey:refreshTokenKey];
}

- (NSString *)refreshToken{
    return [self accountValueForKey:refreshTokenKey];
}

- (void)setAuthStatus:(NSInteger)authStatus{
    _authStatus = authStatus;
    [self accountSetValue:[NSNumber numberWithInteger:authStatus] forKey:authStatusKey];
}

- (NSInteger)authStatus{
    return [[self accountValueForKey:authStatusKey] integerValue];
}

- (BOOL)isLogin{
    return self.userId != nil;
}

- (void)cleanUserData{
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:kAccountfilePath error:&error];
    NSArray *keyArray = @[userIdKey,accessTokenKey,refreshTokenKey,userPhoneNumKey,authStatusKey];
    for (NSString *key in keyArray) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setUserKeyInfoModel:(CYTUserKeyInfoModel *)userKeyInfoModel{
    _userKeyInfoModel = userKeyInfoModel;
    self.userId = userKeyInfoModel.userId;
    self.accessToken = userKeyInfoModel.accessToken;
    self.refreshToken = userKeyInfoModel.refreshToken;
}

- (CYTUserKeyInfoModel *)userKeyInfoModel{
    CYTUserKeyInfoModel *keyInfoModel = [[CYTUserKeyInfoModel alloc] init];
    keyInfoModel.userId = self.userId;
    keyInfoModel.accessToken = self.accessToken;
    keyInfoModel.refreshToken = self.refreshToken;
    return keyInfoModel;
}

- (void)setUserAuthenticateInfoModel:(CYTUserInfoModel *)userAuthenticateInfoModel{
    _userKeyInfoModel = userAuthenticateInfoModel;
    NSDictionary *dict = userAuthenticateInfoModel.mj_keyValues;
    [dict writeToFile:kAccountfilePath atomically:YES];
}
- (CYTUserInfoModel *)userAuthenticateInfoModel{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:kAccountfilePath];
    CYTLog(@"%@",dict);
    return [CYTUserInfoModel mj_objectWithKeyValues:dict];
}
/**
 *  偏好设置
 */
- (void)accountSetValue:(id)obj forKey:(NSString *)key{
    if (!obj) return;
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)accountValueForKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}
/**
 *  更新用户认证信息
 */
- (void)updateUserInfoCompletion:(void(^)(CYTUserInfoModel *userAuthenticateInfoModel))completion{
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    [par setValue:self.userId forKey:@"userId"];
    [CYTNetworkManager POST:kURL.user_info_getUserInfo parameters:par dataTask:nil showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
        CYTUserInfoModel *userAuthenticateInfoModel = [CYTUserInfoModel mj_objectWithKeyValues:responseObject.dataDictionary];
        //更新用户手机号：
        if (userAuthenticateInfoModel.phone.length) {
            self.userPhoneNum = userAuthenticateInfoModel.phone;
        }
        !completion?:completion(userAuthenticateInfoModel);
        if (responseObject.resultEffective){
            self.userAuthenticateInfoModel = userAuthenticateInfoModel;
            self.authStatus = userAuthenticateInfoModel.authStatus;
        }else{
            
        }
    }];
}
- (void)getTokenByRefreshTokenComplation:(void(^)(CYTUserKeyInfoModel *userKeyInfoModel))complation{
    if (self.refreshToken) {
        NSMutableDictionary *par = [NSMutableDictionary dictionary];
        [par setValue:@"2" forKey:@"grantType"];
        [par setValue:self.refreshToken forKey:@"refreshToken"];
        [par setValue:self.userId forKey:@"userId"];
        [par setValue:CYTUUID forKey:@"deviceId"];
        CYTWeakSelf
        [CYTNetworkManager POST:kURL.user_identity_auth parameters:par dataTask:nil showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
            CYTUserKeyInfoModel *userKeyInfoModel = [CYTUserKeyInfoModel mj_objectWithKeyValues:responseObject.dataDictionary];
            userKeyInfoModel.message = responseObject.resultMessage;
            weakSelf.userKeyInfoModel = userKeyInfoModel;
            !complation?:complation(userKeyInfoModel);
        }];
    }else{
        [CYTToast warningToastWithMessage:@"登录信息已过期，请重新登录。" completion:^{
            CYTLoginViewController *loginViewController = [[CYTLoginViewController alloc] init];
            CYTNavigationController *navLoginVC = [[CYTNavigationController alloc] initWithRootViewController:loginViewController];
            loginViewController.showBackButton = YES;
            [loginViewController setLoginStateBlock:^(BOOL success) {
                !complation?:complation([CYTAccountManager sharedAccountManager].userKeyInfoModel);
            }];
            [CYTApplication.keyWindow.rootViewController presentViewController:navLoginVC animated:YES completion:nil];
        }];
    }
}

@end
