//
//  CYTFillCodeViewModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//  获取验证码
//  校验验证码以及邀请人手机号

#import <Foundation/Foundation.h>

@interface CYTFillCodeViewModel : NSObject

/** 账号 */
@property(copy, nonatomic) NSString *account;

/** 验证码 */
@property(copy, nonatomic) NSString *code;
/** 邀请人手机号 */
@property(copy, nonatomic) NSString *otherPhoneNum;

/** 登录按钮能否点击 */
@property (nonatomic, strong, readonly) RACSignal *nextStepEnableSignal;

/** 获取验证码命令 */
@property (nonatomic, strong, readonly) RACCommand *getCodeCommand;

/** 校验验证码 */
@property (nonatomic, strong, readonly) RACCommand *verifyCodeCommand;

@end
