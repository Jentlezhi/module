//
//  CYTSeekCarInfo.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTSeekCarInfo : NSObject
/** 品牌名称 */
@property(copy, nonatomic) NSString *brandName;
/** 车型名称 */
@property(copy, nonatomic) NSString *serialName;
/** 车款年份 */
@property(copy, nonatomic) NSString *carYearType;
/** 车款名称 */
@property(copy, nonatomic) NSString *carName;
/** 车款年份+车款名称 */
@property(copy, nonatomic) NSString *fullCarName;
/** 车源类型 */
@property(copy, nonatomic) NSString *carSourceTypeName;
/** 外观颜色 */
@property(copy, nonatomic) NSString *exteriorColor;
/** 内饰颜色 */
@property(copy, nonatomic) NSString *interiorColor;
/** 发布时间 */
@property(copy, nonatomic) NSString *publishTime;
/** 车辆指导价 */
@property(copy, nonatomic) NSString *carReferPrice;
/** 指导价描述 */
@property(copy, nonatomic) NSString *carReferPriceDesc;
/** 报价 */
@property(copy, nonatomic) NSString *salePrice;
/** 车源地 */
@property(copy, nonatomic) NSString *carSourceAddress;
///上牌省份
@property(copy, nonatomic) NSString *registCardProvinceName;
///上牌城市
@property(copy, nonatomic) NSString *registCardCityName;
/** 当前数据行Id */
@property(assign, nonatomic) NSInteger rowId;
///寻车id
@property(copy, nonatomic) NSString *seekCarId;
/** 寻车状态；0：下架，1：上架 */
@property(copy, nonatomic) NSString *seekCarStatus;

@end
