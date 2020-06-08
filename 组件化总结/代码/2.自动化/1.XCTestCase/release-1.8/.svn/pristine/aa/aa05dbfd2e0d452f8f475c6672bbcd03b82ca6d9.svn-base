//
//  CYTFillPhoneNumViewModel.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTFillPhoneNumViewModel.h"
#import "CYTRegisterParmeters.h"

@implementation CYTFillPhoneNumViewModel

/**
 *  初始化方法
 *
 *  @return self
 */
- (instancetype)init{
    if (self = [super init]) {
        [self fillPhoneNumBasicConfig];
    }
    return self;
}
/**
 * 基本配置
 */
- (void)fillPhoneNumBasicConfig{
    //登录按钮是否可点击
    _nextStepEnableSiganl = [RACSignal combineLatest:@[RACObserve(self, account)] reduce:^id(NSString *accountString){
        return @(accountString.length);
    }];
    //填写手机号的下一步的点击事件
    _nextStepCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            //校验手机号
            NSString *accountStr = _account;
            if (_account.length>CYTAccountLengthMax) {
                accountStr = [_account substringToIndex:CYTAccountLengthMax];
            }
            if (![CYTCommonTool isPhoneNumber:accountStr]) {
                [CYTToast errorToastWithMessage:CYTAccountError];
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }else{
                //记录手机号
                CYTAppManager *appManager = [CYTAppManager sharedAppManager];
                appManager.userPhoneNum = accountStr;
                CYTRegisterParmeters *registerParmeters = [[CYTRegisterParmeters alloc] init];
                registerParmeters.telPhone = accountStr;
                registerParmeters.sendType = 2;
                [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
                [CYTNetworkManager POST:kURL.user_authorization_inputTelPhoneValidate parameters:registerParmeters.mj_keyValues dataTask:nil showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
                    [CYTLoadingView hideLoadingView];
                    [subscriber sendNext:responseObject];
                    [subscriber sendCompleted];
                }];
            }
            
            return nil;
        }];
        
    }];
}


@end
