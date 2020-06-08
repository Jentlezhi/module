//
//  CarFilterConditionSubbrandModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/18.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"

@interface CarFilterConditionSubbrandModel : FFExtendModel
@property (nonatomic, assign) NSInteger makeId;
@property (nonatomic, copy) NSString *makeName;
@property (nonatomic, strong) NSArray *models;

@end
