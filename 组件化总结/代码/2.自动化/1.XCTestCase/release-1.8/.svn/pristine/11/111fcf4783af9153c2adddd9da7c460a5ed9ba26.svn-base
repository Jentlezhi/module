//
//  CYTCarSourceInfoModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"

@interface CYTCarSourceInfoModel : FFExtendModel
//id
@property (nonatomic, assign) NSInteger carSourceId;

//下架
@property (nonatomic, assign) NSInteger carSourceStatus;

//车
@property (nonatomic, copy)   NSString *brandName;
@property (nonatomic, strong) NSString *serialName;
@property (nonatomic, assign) NSInteger serialId;
@property (nonatomic, strong) NSString *carName;
@property (nonatomic, assign) NSInteger carYearType;
@property (nonatomic, strong) NSString *carInfo;

@property (nonatomic, assign) NSInteger arrivalDate;
@property (nonatomic, copy)   NSString *arrivalDateDesc;
@property (nonatomic, copy)   NSString *locationGroupId;
@property (nonatomic, copy)   NSString *provinceId;
///是否是国产合资
@property (nonatomic, assign) BOOL isDomestic;

//钱
@property (nonatomic, strong) NSString *carReferPrice;
@property (nonatomic, strong) NSString *carReferPriceDesc;
@property (nonatomic, strong) NSString *salePrice;

//颜色
@property (nonatomic, strong) NSString *exteriorColor;
@property (nonatomic, strong) NSString *interiorColor;

//其他
@property (nonatomic, strong) NSString *carSourceAddress;
@property (nonatomic, strong) NSString *carConfigure;
@property (nonatomic, strong) NSString *carSourceTypeName;
@property (nonatomic, strong) NSString *salableArea;
@property (nonatomic, strong) NSString *publishTime;
@property (nonatomic, strong) NSString *carProcedures;
@property (nonatomic, strong) NSString *remark;
/**
 *  1.7新增
 */
/** 货物状态 1：现货 2：期货 */
@property(assign, nonatomic) NSInteger goodsStatus;
/** 货物类型, 国产/合资车：1, 中规：3, 美规：201, 欧规：202, 中东：203, 加版：204, 墨版：205 */
@property(copy, nonatomic) NSString *goodsType;

///1.8新增，车源编号
@property (nonatomic, copy) NSString *sourceCode;

@end
