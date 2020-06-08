//
//  CYTLogisticsNeedWritePreDetail.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/29.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"

@interface CYTLogisticsNeedWritePreDetail : FFExtendModel
@property (nonatomic, assign) NSInteger serialID;
@property (nonatomic, assign) NSInteger carYearType;
@property (nonatomic, assign) NSInteger carID;
@property (nonatomic, strong) NSString *carName;
@property (nonatomic, strong) NSString *carSerialName;
@property (nonatomic, assign) NSInteger brandID;
@property (nonatomic, strong) NSString *carBrandName;

@property (nonatomic, assign) NSInteger orderID;
@property (nonatomic, assign) NSInteger carNum;
@property (nonatomic, strong) NSString *carPrice;
///车辆单价（1.8增加）
@property (nonatomic, strong) NSString *carUnitPrice;

@end
