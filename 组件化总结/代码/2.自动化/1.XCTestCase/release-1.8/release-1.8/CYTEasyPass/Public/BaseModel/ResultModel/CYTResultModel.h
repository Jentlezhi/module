//
//  CYTResultModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/21.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTResultModel : NSObject
/** 返回结果 */
@property(assign, nonatomic) BOOL Result;
/** 返回信息 */
@property(copy, nonatomic) NSString *Message;

/** 返回结果 */
@property(assign, nonatomic) BOOL result;
/** 返回信息 */
@property(copy, nonatomic) NSString *message;

/** Version */
@property(copy, nonatomic) NSString *Version;

@end
