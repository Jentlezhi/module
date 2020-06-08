//
//  CYTResetPwdViewModel.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTResetPwdViewModel.h"
#import "CYTResetPwdParmeters.h"
#import "AESCrypt.h"

@implementation CYTResetPwdViewModel

/**
 *  初始化方法
 *
 *  @return self
 */
- (instancetype)init{
    if (self = [super init]) {
        [self resetPwdViewModelBasicConfig];
    }
    return self;
}
/**
 * 基本配置
 */
- (void)resetPwdViewModelBasicConfig{
    //登录按钮是否可点击
    _nextStepEnableSiganl = [RACSignal combineLatest:@[RACObserve(self, firstPwd),RACObserve(self, secondPwd)] reduce:^id(NSString *accountString,NSString *pwdString){
        return @(accountString.length && pwdString.length);
    }];
    //获取验证码的点击事件
    _nextStepCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            //校验密码
            NSString *firstPwdString = _firstPwd;
            NSString *secondPwdString = _secondPwd;
            if (_firstPwd.length>CYTPwdLengthMax) {
                firstPwdString = [_firstPwd substringToIndex:CYTPwdLengthMax];
            }
            if(_secondPwd.length>CYTPwdLengthMax){
                secondPwdString = [_secondPwd substringToIndex:CYTPwdLengthMax];
            }
            if (![CYTCommonTool isPassWord:firstPwdString] ||![CYTCommonTool isPassWord:secondPwdString] ) {
                [CYTToast errorToastWithMessage:CYTPwdError];
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }else if (![firstPwdString isEqualToString:secondPwdString]){
                [CYTToast errorToastWithMessage:CYTTowPwdError];
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }else{
                CYTResetPwdParmeters *resetPwdParmeters = [[CYTResetPwdParmeters alloc] init];
                CYTAppManager *appManager = [CYTAppManager sharedAppManager];
                resetPwdParmeters.mobile = appManager.userPhoneNum;
                //密码加密
                NSString *secretKey = [NSString tokenValueOf16];
                NSString *secretPwd = [AESCrypt encrypt:firstPwdString password:secretKey];
                resetPwdParmeters.tokenValue = Token_Value;
                resetPwdParmeters.password = secretPwd;
                resetPwdParmeters.deviceId = CYTDeviceUUIDKey;
                [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeNotEditable];
                [CYTNetworkManager POST:kURL.user_identity_resetPassword parameters:resetPwdParmeters.mj_keyValues dataTask:nil showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
                    [CYTLoadingView hideLoadingView];
                    if (responseObject.resultEffective) {
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
