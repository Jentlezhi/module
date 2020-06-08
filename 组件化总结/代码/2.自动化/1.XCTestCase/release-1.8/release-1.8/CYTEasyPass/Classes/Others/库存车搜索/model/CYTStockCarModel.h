//
//  CYTStockCarModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/26.
//  Copyright © 2017年 EasyPass. All rights reserved.
//  carReferPrice字段修改为NSString类型

#import "FFExtendModel.h"

@interface CYTStockCarModel : FFExtendModel
///最后一条数据Id
@property (nonatomic, assign) NSInteger lastId;
@property (nonatomic, assign) NSInteger carId;
@property (nonatomic, assign) NSInteger brandId;
@property (nonatomic, assign) NSInteger serialId;
@property (nonatomic, assign) NSInteger carYearType;

@property (nonatomic, copy) NSString *carName;
@property (nonatomic, copy) NSString *serialName;
@property (nonatomic, copy) NSString *brandName;

///车源类型Id
@property (nonatomic, assign) NSInteger carSourceTypeId;
@property (nonatomic, copy) NSString *carSourceTypeName;

///指导价
@property (nonatomic, copy) NSString *carReferPrice;
///搜索的字符串
@property (nonatomic, copy) NSString *searchString;


@end
