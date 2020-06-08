//
//  CYTVerifyCodeOldParmeters.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTVerifyCodeOldParmeters : NSObject

/** 用户手机号 */
@property(copy, nonatomic) NSString *TelPhone;
/** 验证码 */
@property(copy, nonatomic) NSString *Code;
/** 状态 */
@property(assign, nonatomic) int SendType;

@end
