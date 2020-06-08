//
//  CYTCarModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CYTOrderModel;

@interface CYTCarModel : NSObject

/** 品牌名称+车型名称 */
@property(copy, nonatomic) NSString *carMainName;
/** 年款+车款名称 */
@property(copy, nonatomic) NSString *carDetailName;
/** 车源类型名称(优先二级显示)*/
@property(copy, nonatomic) NSString *importTypeName;
/** 外观颜色 */
@property(copy, nonatomic) NSString *exColor;
/** 内饰颜色 */
@property(copy, nonatomic) NSString *inColor;
/** 车源地 */
@property(copy, nonatomic) NSString *carCityName;
/** 成交价：eg:15.00 */
@property(copy, nonatomic) NSString *dealPrice;
/** 订金 eg:1000 */
@property(copy, nonatomic) NSString *depositAmount;
/** 指导价12.34万 */
@property(copy, nonatomic) NSString *carReferPriceDesc;
/** 应付，实付，退款金额(同意退款之后) */
@property(copy, nonatomic) NSString *payDesc;
/** 支付一部分描述（已付：500元）*/
@property(copy, nonatomic) NSString *payPartDesc;
/** 订单 */
@property(strong, nonatomic) CYTOrderModel *orderModel;

@end
