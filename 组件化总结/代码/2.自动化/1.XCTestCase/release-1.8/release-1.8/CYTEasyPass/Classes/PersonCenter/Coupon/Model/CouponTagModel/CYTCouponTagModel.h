//
//  CYTCouponTagModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/29.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTCouponTagModel : NSObject

/** 未使用 */
@property(copy, nonatomic) NSString *unusedTag;
/** 已使用 */
@property(copy, nonatomic) NSString *usedTag;
/** 已过期 */
@property(copy, nonatomic) NSString *expiredTag;
/** 可用 */
@property(copy, nonatomic) NSString *usableTag;
/** 不可用 */
@property(copy, nonatomic) NSString *disableTag;

@end
