//
//  CYTLogisticsNeedDetailModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"

@interface CYTLogisticsNeedDetailModel : FFExtendModel

///需求Id
@property (nonatomic, assign) NSInteger demandId;
///订单id
@property (nonatomic, assign) NSInteger transportOrderId;
///状态,物流需求单状态（-1全部、1待下单，2已完成，3已过期,4已取消）
@property (nonatomic, assign) CYTLogisticsNeedStatus status;

///是否送车上门
@property (nonatomic, assign) BOOL isSendCarByDropIn;
///车辆数量
@property (nonatomic, assign) NSInteger carCount;
///车辆价值
@property (nonatomic, assign) double totalValues;

///品牌名称
@property (nonatomic, strong) NSString *bsName;
///车型名称
@property (nonatomic, strong) NSString *csName;
///车款年份
@property (nonatomic, strong) NSString *carYearType;
///车款名称
@property (nonatomic, strong) NSString *carName;

///需求有效期截止时间
@property (nonatomic, strong) NSString *expiredTime;
///需求（报价）有效期
@property (nonatomic, strong) NSString *quoteExpiredTime;

///地址
@property (nonatomic, strong) NSString *destinationCityName;
@property (nonatomic, strong) NSString *destinationProvinceName;
@property (nonatomic, strong) NSString *destinationCountyName;
@property (nonatomic, strong) NSString *destinationAddress;

@property (nonatomic, strong) NSString *startCityName;
@property (nonatomic, strong) NSString *startProvinceName;
@property (nonatomic, strong) NSString *startCountyName;
@property (nonatomic, strong) NSString *startAddress;


///报价数组
@property (nonatomic, strong) NSArray *quoteList;
///报价数量
@property (nonatomic, assign) NSInteger quoteCount;

@end
