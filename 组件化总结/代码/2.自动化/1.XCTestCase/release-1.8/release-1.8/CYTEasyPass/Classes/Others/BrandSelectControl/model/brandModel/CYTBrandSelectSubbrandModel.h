//
//  CYTBrandSelectSubbrandModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//
/*
 子品牌
 */
#import "FFExtendModel.h"

@interface CYTBrandSelectSubbrandModel : FFExtendModel
@property (nonatomic, assign) NSInteger makeId;
@property (nonatomic, copy) NSString *makeName;
@property (nonatomic, strong) NSArray *models;

@end
