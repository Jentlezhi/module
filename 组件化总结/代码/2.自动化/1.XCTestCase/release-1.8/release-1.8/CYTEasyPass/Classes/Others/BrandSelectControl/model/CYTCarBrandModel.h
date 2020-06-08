//
//  CYTCarBrandModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//
/*
 选择的车型对应的数据模型
 */

#import "FFExtendModel.h"

@interface CYTCarBrandModel : FFExtendModel
@property (nonatomic, copy) NSString *brandId;
@property (nonatomic, copy) NSString *seriesId;
@property (nonatomic, copy) NSString *carId;

@property (nonatomic, assign) BOOL customCar;
@property (nonatomic, copy) NSString *customCarName;
@property (nonatomic, copy) NSString *totalName;

@end
