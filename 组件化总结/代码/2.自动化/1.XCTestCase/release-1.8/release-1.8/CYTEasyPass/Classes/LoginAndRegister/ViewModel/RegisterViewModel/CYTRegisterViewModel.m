//
//  CYTRegisterViewModel.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTRegisterViewModel.h"
#import "CYTRegisterParmeters.h"

@implementation CYTRegisterViewModel

/**
 *  初始化方法
 *
 *  @return self
 */
- (instancetype)init{
    if (self = [super init]) {
        [self registerViewModelBasicConfig];
    }
    return self;
}
/**
 * 基本配置
 */
- (void)registerViewModelBasicConfig{
    //
    //下一步按钮是否可点击
    _nextStepEnableSiganl = [RACSignal combineLatest:@[RACObserve(self, account),RACObserve(self, agreeProtocal)] reduce:^id(NSString *accountString,NSNumber *isAgreeProtocal){
        return @(accountString.length > 0 && [isAgreeProtocal integerValue]);
    }];
    
    //校验输入的手机号
    _nextStepCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            //校验
            NSString *accountStr = [NSString string];
            if (_account.length>=CYTAccountLengthMax) {
               accountStr = [_account substringToIndex:CYTAccountLengthMax];
            }
            if (![CYTCommonTool isPhoneNumber:accountStr]) {
                [CYTToast errorToastWithMessage:CYTAccountError];
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }else{
                CYTAppManager *appManager = [CYTAppManager sharedAppManager];
                appManager.userPhoneNum = accountStr;
                CYTRegisterParmeters *registerParmeters = [[CYTRegisterParmeters alloc] init];
                registerParmeters.telPhone = accountStr;
                registerParmeters.sendType = 1;
          [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
          [CYTNetworkManager POST:kURL.user_authorization_inputTelPhoneValidate parameters:registerParmeters.mj_keyValues dataTask:nil showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
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
