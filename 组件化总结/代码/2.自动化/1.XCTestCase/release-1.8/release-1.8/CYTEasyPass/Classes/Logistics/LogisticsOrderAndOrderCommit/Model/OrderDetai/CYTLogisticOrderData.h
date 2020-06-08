//
//  CYTLogisticOrderData.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/23.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTLogisticOrderData : NSObject

/** Order实体 */
@property(strong, nonatomic) NSDictionary *order;
/** 车辆详情Model */
@property(strong, nonatomic) NSDictionary *demand;
/** 物流需求报价Model */
@property(strong, nonatomic) NSDictionary *demandPrice;
/** 运单Model */
@property(strong, nonatomic) NSDictionary *tranOrder;

@end
