//
//  CYTGetCashPwdVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/11.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTGetCashPwdVM.h"

@implementation CYTGetCashPwdVM
#pragma mark- get

- (RACCommand *)fetchVerifyCode {
    if (!_fetchVerifyCode) {
        _fetchVerifyCode = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.needHud = YES;
            model.requestURL = kURL.user_account_SendTelCode;
            //验证码类型：1、注册；2、找回密码；3、设置交易密码
            NSDictionary *parameters = @{@"telPhone":self.phone,
                                         @"sendType":@(3)};
            
            model.requestParameters = parameters;
            
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *responseModel) {
            //
        }];
    }
    return _fetchVerifyCode;
}

- (RACCommand *)confirmVerifyCode {
    if (!_confirmVerifyCode) {
        _confirmVerifyCode = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.needHud = YES;
            model.requestURL = kURL.user_account_SetWithdrawalPassword;
            model.requestParameters = [self.confirmParameters copy];
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *responseModel) {
            //none
        }];
    }
    return _confirmVerifyCode;
}

@end
