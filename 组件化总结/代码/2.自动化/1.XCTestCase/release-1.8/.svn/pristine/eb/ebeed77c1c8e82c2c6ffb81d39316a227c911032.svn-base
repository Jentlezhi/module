//
//  CYTLogisticOrderProgress.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>
//订单进度
typedef enum : NSUInteger {
    CYTOrderProgressStatusTypeCarsource = 1,      //车源
    CYTOrderProgressStatusTypeSeekcar,           //寻车
} CYTOrderProgressStatusType;


//物流订单进度
typedef enum : NSUInteger {
    CYTLogisticOrderStatusCommitOrder = 0,      //提交订单
    CYTLogisticOrderStatusWaitForDistribution,  //待配货
    CYTLogisticOrderStatusWaitForDriver,        //待司机上门
    CYTLogisticOrderStatusTransporting,         //运输中
    CYTLogisticOrderStatusFinish,               //已完成
} CYTLogisticOrderStatus;

typedef enum : NSUInteger {
    CYTOrderStatusStyleNormal = 0,      //正常订单
    CYTOrderStatusStyleCancel,          //已取消订单
} CYTOrderStatusStyle;

@interface CYTCommonOrderProgress : UIView
/**
 * 通用进度
 */
+ (instancetype)orderProgressWithStatus:(NSUInteger)status highlightColor:(UIColor *)highlightColor titlesArray:(NSArray *)titlesArray;
/**
 * 订单进度
 */
+ (instancetype)orderProgressWithOrderType:(CYTOrderProgressStatusType)orderProgressStatusType status:(NSInteger)orderStatus orderStatusStyle:(CYTOrderStatusStyle)orderStatusStyle;
/**
 * 物流订单进度
 */
+ (instancetype)logisticOrderProgressWithStatus:(CYTLogisticOrderStatus)logisticOrderStatus orderStatusStyle:(CYTOrderStatusStyle)orderStatusStyle;




@end
