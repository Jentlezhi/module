//
//  CYTRegisterViewModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//  校验输入的手机号

#import <Foundation/Foundation.h>

@interface CYTRegisterViewModel : NSObject

/** 账号 */
@property(copy, nonatomic) NSString *account;
/** 是否同意协议 */
@property(strong, nonatomic, readonly, getter=isAgreeProtocal) NSNumber *agreeProtocal ;

/** 登录按钮能否点击 */
@property (nonatomic, strong, readonly) RACSignal *nextStepEnableSiganl;
/** 登录按钮命令 */
@property (nonatomic, strong, readonly) RACCommand *nextStepCommand;

@end
