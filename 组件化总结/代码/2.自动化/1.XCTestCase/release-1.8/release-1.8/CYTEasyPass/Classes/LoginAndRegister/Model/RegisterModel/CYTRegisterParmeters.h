//
//  CYTRegisterParmeters.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTRegisterParmeters : NSObject

/** 手机号 */
@property(copy, nonatomic) NSString *telPhone;
/** 请求方式 */
@property(assign, nonatomic) int sendType;

@end
