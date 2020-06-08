//
//  CYTResetPwdViewModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//  重置密码

#import <Foundation/Foundation.h>

@interface CYTResetPwdViewModel : NSObject

/** 第一个密码 */
@property(copy, nonatomic) NSString *firstPwd;

/** 第二个密码 */
@property(copy, nonatomic) NSString *secondPwd;

/** 下一步按钮能否点击 */
@property (nonatomic, strong, readonly) RACSignal *nextStepEnableSiganl;

/** 下一步按钮的点击 */
@property (nonatomic, strong, readonly) RACCommand *nextStepCommand;

@end
