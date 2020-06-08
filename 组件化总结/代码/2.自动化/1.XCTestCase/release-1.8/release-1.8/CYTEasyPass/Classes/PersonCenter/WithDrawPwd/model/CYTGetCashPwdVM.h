//
//  CYTGetCashPwdVM.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/11.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"

@interface CYTGetCashPwdVM : CYTExtendViewModel
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, strong) NSDictionary *confirmParameters;

@property (strong, nonatomic) RACCommand *fetchVerifyCode;
@property (strong, nonatomic) RACCommand *confirmVerifyCode;

@end
