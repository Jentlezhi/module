//
//  CYTCompleteUserInfoResult.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTRootResponseModel.h"

@interface CYTCompleteUserInfoResult : CYTRootResponseModel

/** 返回结果 */
@property(assign, nonatomic) BOOL Result;
/** 返回信息 */
@property(copy, nonatomic) NSString *Message;
/** 版本号 */
@property(assign, nonatomic) NSInteger version;
/** 错误码 */
@property(assign, nonatomic) NSInteger ErrorCode;

@end
