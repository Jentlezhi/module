//
//  CYTSetPwdViewModel.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTSetPwdViewModel.h"
#import "CYTSetPwdParmeters.h"
#import "AESCrypt.h"

@implementation CYTSetPwdViewModel

/**
 *  初始化方法
 *
 *  @return self
 */
- (instancetype)init{
    if (self = [super init]) {
        [self setPwdeViewModelBasicConfig];
    }
    return self;
}
/**
 * 基本配置
 */
- (void)setPwdeViewModelBasicConfig{
    //登录按钮是否可点击
    _nextStepEnableSiganl = [RACSignal combineLatest:@[RACObserve(self, pwd)] reduce:^id(NSString *pwdString){
        return @(pwdString.length);
    }];
    //获取验证码的点击事件
    _nextStepCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            //校验密码
            NSString *pwdString = _pwd;
            if (_pwd.length>CYTPwdLengthMax) {
                pwdString = [_pwd substringToIndex:CYTPwdLengthMax];
            }
            if (pwdString.length==0) {
                [CYTToast errorToastWithMessage:CYTPwdNil];
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }else if (![CYTCommonTool isPassWord:pwdString]) {
                [CYTToast errorToastWithMessage:CYTPwdError];
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }else{
                CYTAppManager *appManager = [CYTAppManager sharedAppManager];
                CYTSetPwdParmeters *setPwdParmeters = [[CYTSetPwdParmeters alloc] init];
                setPwdParmeters.mobile = appManager.userPhoneNum;
                //密码加密
                NSString *secretKey = [NSString tokenValueOf16];
                NSString *secretPwd = [AESCrypt encrypt:pwdString password:secretKey];
                setPwdParmeters.tokenValue = Token_Value;
                setPwdParmeters.password = secretPwd;
                setPwdParmeters.deviceId = CYTUUID;
                setPwdParmeters.inviterPhone = appManager.inviterPhone;
                [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
                [CYTNetworkManager POST:kURL.user_identity_register parameters:setPwdParmeters.mj_keyValues dataTask:nil showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
                    [CYTLoadingView hideLoadingView];
                    if (responseObject.resultEffective) {
                        //登录成功，保存手机号
                        [CYTAccountManager sharedAccountManager].userPhoneNum = appManager.userPhoneNum;
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
