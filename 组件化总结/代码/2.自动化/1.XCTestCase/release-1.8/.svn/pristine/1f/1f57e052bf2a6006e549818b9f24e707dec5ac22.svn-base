//
//  CYTGetCashVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/20.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTGetCashVM.h"
#import "AESCrypt.h"

@implementation CYTGetCashVM
@synthesize requestCommand = _requestCommand;

- (void)setAccountName:(NSString *)accountName {
    _accountName = accountName;
    self.canSubmit = (accountName.length>0 && _account.length>0);
}

- (void)setAccount:(NSString *)account {
    _account = account;
    self.canSubmit = (_accountName.length>0 && account.length>0);
}

#pragma mark- get
- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.requestURL = kURL.user_useraccount_withdraw;
            model.needHud = YES;
            NSString *userID = CYTUserId;
            NSString *secretKey = [NSString tokenValueOf16];
            NSString *Amount = [AESCrypt encrypt:self.totalCash password:secretKey];
            NSString *IncomeAccountNO = [AESCrypt encrypt:self.account password:secretKey];
            NSString *PassWord = [AESCrypt encrypt:self.pwdString password:secretKey];
            NSString *accountName = [AESCrypt encrypt:self.accountName password:secretKey];

            NSDictionary *parameters = @{@"accountID":userID,
                                         @"amount":Amount,
                                         @"incomeAccountNO":IncomeAccountNO,
                                         @"accountName":accountName,
                                         @"passWord":PassWord,
                                         @"tokenValue":Token_Value};
            model.requestParameters = parameters;
            
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            //none
        }];
    }
    return _requestCommand;
}

- (RACCommand *)accessCashCommand {
    if (!_accessCashCommand) {
        _accessCashCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.requestURL = kURL.user_useraccount_myaccount;
            model.needHud = YES;
            model.requestParameters = @{@"accountID":CYTUserId};
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            //none
        }];
    }
    return _accessCashCommand;
}

@end
