//
//  CarFilterConditionModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/11.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"

@interface CarFilterConditionModel : FFExtendModel
///来源：1：搜索，2：筛选
@property (nonatomic, assign) NSInteger source;

///车系Id
@property (nonatomic, assign) NSInteger carSerialId;
@property (nonatomic, assign) NSInteger  carId;

@property (nonatomic, assign) NSInteger locationGroupId;
@property (nonatomic, assign) NSInteger provinceId;

@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, assign) NSInteger lastId;
///车商类型
@property (nonatomic, assign) NSInteger dealerMemberLevelId;

@property (nonatomic, copy) NSString *query;
@property (nonatomic, copy) NSString *exteriorColor;
///搜索关键字
@property (nonatomic, copy) NSString *keyword;

@end
