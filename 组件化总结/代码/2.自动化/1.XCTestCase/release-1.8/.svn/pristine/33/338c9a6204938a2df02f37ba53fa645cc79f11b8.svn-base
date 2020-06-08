//
//  CYTLoginViewModel.m
//  CYTEasyPass
//
//  Created by Juniort on 2017/3/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLoginViewModel.h"
#import "AESCrypt.h"
#import "CYTLoginResult.h"

@implementation CYTLoginViewModel

/**
 *  初始化方法
 *
 *  @return self
*/
- (instancetype)init{
    if (self = [super init]) {
        [self loginModelBasicConfig];
    }
    return self;
}
/**
 * 基本配置
 */
- (void)loginModelBasicConfig{
    //登录按钮是否可点击
    _loginEnableSiganl = [RACSignal combineLatest:@[RACObserve(self, account),RACObserve(self, pwd)] reduce:^id(NSString *accountString,NSString *pwdString){
        return @(accountString.length && pwdString.length);
    }];
    //按钮的点击事件
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSString *accountStr = _account;
            NSString *pwdStr = _pwd;
            if (_account.length>CYTAccountLengthMax) {
                accountStr = [_account substringToIndex:CYTAccountLengthMax];
            }
            if (_pwd.length>CYTPwdLengthMax) {
                pwdStr = [_pwd substringToIndex:CYTPwdLengthMax];
            }
            //校验
            if (![CYTCommonTool isPhoneNumber:accountStr]) {
                [CYTToast errorToastWithMessage:CYTAccountError];
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }else if (![CYTCommonTool isPassWord:pwdStr]){
                [CYTToast errorToastWithMessage:CYTPwdError];
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }else{
                //记录手机号
                CYTAppManager *appManager = [CYTAppManager sharedAppManager];
                appManager.userPhoneNum = accountStr;
                CYTLoginParmeters *loginParmeters = [[CYTLoginParmeters alloc] init];
                loginParmeters.mobile = accountStr;
                //加密
                NSString *secretKey = [NSString tokenValueOf16];
                NSString *secretPwd = [AESCrypt encrypt:pwdStr password:secretKey];
                loginParmeters.tokenValue = Token_Value;
                loginParmeters.password = secretPwd;
                loginParmeters.deviceId = CYTUUID;
                loginParmeters.grantType = @"1";
                [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
                [CYTNetworkManager POST:kURL.user_identity_auth parameters:loginParmeters.mj_keyValues dataTask:nil showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
                    [CYTLoadingView hideLoadingView];
                    //登录成功，保存手机号
                    if (responseObject.resultEffective) {
                        [CYTAccountManager sharedAccountManager].userPhoneNum = accountStr;
                    }
                    [subscriber sendNext:responseObject];
                    [subscriber sendCompleted];
                }];
            }
            return nil;
        }];
        
    }];
}


@end
