//
//  CYTGetCashVM.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/20.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"

@interface CYTGetCashVM : CYTExtendViewModel

///可提取金额
@property (nonatomic ,copy) NSString *accessCash;
///提取总金额
@property (nonatomic, copy) NSString *totalCash;
///优惠金额
@property (nonatomic, copy) NSString *benefitCash;
///账号
@property (nonatomic, copy) NSString *account;
///用户名
@property (nonatomic, copy) NSString *accountName;
///可以提交
@property (nonatomic, assign) BOOL canSubmit;

@property (nonatomic, copy) NSString *pwdString;
///手续费
@property (nonatomic, copy) NSString *poundage;
///提取现金
@property (nonatomic, strong) RACCommand *requestCommand;
///可提现金额
@property (nonatomic, strong) RACCommand *accessCashCommand;

@end
