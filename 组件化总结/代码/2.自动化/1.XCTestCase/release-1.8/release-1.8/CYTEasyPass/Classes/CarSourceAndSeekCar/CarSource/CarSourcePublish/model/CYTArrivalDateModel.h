//
//  CYTArrivalDateModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"

@interface CYTArrivalDateItemModel : FFExtendModel
@property (nonatomic, assign) NSInteger idCode;
@property (nonatomic, copy) NSString *name;
///增加字段，选择后自己添加月份
@property (nonatomic, strong) NSString *month;

@end

@interface CYTArrivalDateModel : FFExtendModel
@property (nonatomic, strong) NSString *month;
@property (nonatomic, strong) NSArray *items;

@end


