//
//  CYTLoginResult.h
//  CYTEasyPass
//
//  Created by Juniort on 2017/3/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTLoginResult : NSObject

/** 结果 */
@property(assign, nonatomic) BOOL result;
/** 信息 */
@property(copy, nonatomic) NSString *message;
/** 数据 */
@property(strong, nonatomic) NSDictionary *Data;

@end
