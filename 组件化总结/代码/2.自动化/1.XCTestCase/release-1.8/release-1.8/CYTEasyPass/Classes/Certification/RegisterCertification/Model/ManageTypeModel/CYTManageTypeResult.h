//
//  CYTManageTypeResult.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/14.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTManageTypeResult : NSObject

/** 结果 */
@property(copy, nonatomic) NSString *Result;
/** 返回信息 */
@property(copy, nonatomic) NSString *Message;
/** 数据 */
@property(strong, nonatomic) NSArray *Data;
/** 版本 */
@property(copy, nonatomic) NSString *Version;
/** 错误码 */
@property(copy, nonatomic) NSString *ErrorCode;

@end
