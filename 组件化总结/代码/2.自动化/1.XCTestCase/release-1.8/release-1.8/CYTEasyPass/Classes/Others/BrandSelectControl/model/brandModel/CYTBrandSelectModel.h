//
//  CYTBrandSelectModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//
/*
 品牌数据模型--->子品牌--->车系
 */

#import "FFExtendModel.h"

@interface CYTBrandSelectModel : FFExtendModel
@property (nonatomic, copy) NSString *logoUrl;
@property (nonatomic, copy) NSString *masterBrandName;
@property (nonatomic, assign) NSInteger masterBrandId;
@property (nonatomic, strong) NSArray *makes;

@end
