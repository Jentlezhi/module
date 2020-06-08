//
//  CYTCouponListModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/28.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTCouponListModel : NSObject

/** 未使用总量 */
@property(copy, nonatomic) NSString *unUsedCount;
/** 已使用总量 */
@property(copy, nonatomic) NSString *usedCount;
/** 可用总量 */
@property(copy, nonatomic) NSString *usableCount;
/** 不可用总量 */
@property(copy, nonatomic) NSString *unableCount;
/** 已过期总量 */
@property(copy, nonatomic) NSString *expiredCount;
/** 券集合 */
@property(strong, nonatomic) NSArray *list;
/** 是否更多 */
@property(assign, nonatomic) BOOL isMore;


@end
