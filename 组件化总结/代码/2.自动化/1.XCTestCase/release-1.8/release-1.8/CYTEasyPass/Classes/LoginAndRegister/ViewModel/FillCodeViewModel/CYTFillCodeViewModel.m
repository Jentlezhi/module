//
//  CYTFillCodeViewModel.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTFillCodeViewModel.h"
#import "CYTFillCodeParmeters.h"
#import "CYTVerifyCodeParmeters.h"

@implementation CYTFillCodeViewModel

/**
 *  初始化方法
 *
 *  @return self
 */
- (instancetype)init{
    if (self = [super init]) {
        [self fillCodeViewModelBasicConfig];
    }
    return self;
}
/**
 * 基本配置
 */
- (void)fillCodeViewModelBasicConfig{
    
    _nextStepEnableSignal = [RACSignal combineLatest:@[RACObserve(self, code)] reduce:^id(NSString *codeString){
        return @(codeString.length);
    }];
    
    //获取验证码
    _getCodeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            CYTFillCodeParmeters *fillCodeParmeters = [[CYTFillCodeParmeters alloc] init];
            CYTAppManager *appManager = [CYTAppManager sharedAppManager];
            fillCodeParmeters.telPhone = appManager.userPhoneNum;
            if (appManager.setPwdType == CYTSetPwdTypeReset) {
                fillCodeParmeters.sendType = 2;
            }else{
                //校验邀请人手机号
                NSString *otherPhoneNumString = _otherPhoneNum;
                if (_otherPhoneNum.length>CYTAccountLengthMax) {
                    otherPhoneNumString = [_otherPhoneNum substringToIndex:CYTAccountLengthMax];
                }
                fillCodeParmeters.sendType = 1;
                fillCodeParmeters.inviterPhone = otherPhoneNumString;
            }
            [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
            [CYTNetworkManager POST:kURL.user_account_SendTelCode parameters:fillCodeParmeters.mj_keyValues dataTask:nil showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
                [CYTLoadingView hideLoadingView];
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
            }];
            return nil;
        }];
        
    }];
    //校验验证码
    _verifyCodeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            //校验验证码
            NSString *codeString = _code;
            if (_code.length>CYTCodeLengthMax) {
                codeString = [_code substringToIndex:CYTCodeLengthMax];
            }
            //校验邀请人手机号
            CYTNetworkResponse *networkResponse;
            NSString *otherPhoneNumString = _otherPhoneNum;
            if (_otherPhoneNum.length>CYTAccountLengthMax) {
                otherPhoneNumString = [_otherPhoneNum substringToIndex:CYTAccountLengthMax];
            }
            if (codeString.length == 0) {
                [CYTToast errorToastWithMessage:CYTCodeNil];
                [subscriber sendNext:networkResponse];
                [subscriber sendCompleted];
            }else if (codeString.length != CYTCodeLengthMax ) {
                [CYTToast errorToastWithMessage:CYTCodeError];
                [subscriber sendNext:networkResponse];
                [subscriber sendCompleted];
            }else{
                NSMutableDictionary *verifyCodeParmeters = [NSMutableDictionary dictionary];
                CYTAppManager *appManager = [CYTAppManager sharedAppManager];
                appManager.inviterPhone = otherPhoneNumString;
                NSInteger sendType = 0;
                if (appManager.setPwdType == CYTSetPwdTypeReset) {
                    [verifyCodeParmeters setValue:appManager.userPhoneNum forKey:@"telPhone"];
                    [verifyCodeParmeters setValue:codeString forKey:@"telCode"];
                    [verifyCodeParmeters setValue:@(2) forKey:@"sendType"];
                    sendType = 2;
                }else{
                    [verifyCodeParmeters setValue:appManager.userPhoneNum forKey:@"telPhone"];
                    [verifyCodeParmeters setValue:appManager.inviterPhone forKey:@"inviterPhone"];
                    [verifyCodeParmeters setValue:codeString forKey:@"code"];
                    [verifyCodeParmeters setValue:@(1) forKey:@"sendType"];
                    sendType = 1;
                }
                NSString *requestUrl;
                if(sendType == 1){//校验：输入的验证码以及邀请人手机号校验
                    requestUrl = kURL.user_authorization_validateCodePhone;
                }else{//校验：输入的验证码
                    requestUrl = kURL.user_authorization_validateTelCode;
                }
                [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
                [CYTNetworkManager POST:requestUrl parameters:verifyCodeParmeters.mj_keyValues dataTask:nil showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
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
