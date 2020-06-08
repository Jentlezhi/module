//
//  CYTLogisticTranOrderModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/23.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTLogisticTranOrderModel : NSObject

/** 运单号 */
@property(copy, nonatomic) NSString *expressCode;
/** 相关物流日志list */
@property(strong, nonatomic) NSArray *logs;

@end
