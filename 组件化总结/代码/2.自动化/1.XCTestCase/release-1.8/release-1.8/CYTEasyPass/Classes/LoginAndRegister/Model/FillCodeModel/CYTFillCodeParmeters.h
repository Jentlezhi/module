//
//  CYTFillCodeParmeters.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTFillCodeParmeters : NSObject

/** 手机号 */
@property(copy, nonatomic) NSString *telPhone;
/** 邀请人手机号手机号 */
@property(copy, nonatomic) NSString *inviterPhone;
/** 状态 */
@property(assign, nonatomic) int sendType;

@end
