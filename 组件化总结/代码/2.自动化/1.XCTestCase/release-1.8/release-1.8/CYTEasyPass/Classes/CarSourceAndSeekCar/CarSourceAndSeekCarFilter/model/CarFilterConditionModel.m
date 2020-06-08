//
//  CarFilterConditionModel.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/11.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CarFilterConditionModel.h"

@implementation CarFilterConditionModel

- (instancetype)init {
    if (self = [super init]) {
        _carSerialId = -1;
        _carId = -1;
        _locationGroupId = -1;
        _provinceId = -1;
        _sort = -1;
        _lastId = 0;
        _source = 0;
        _dealerMemberLevelId = -1;
        _query = @"";
        _exteriorColor = @"";
        _keyword = @"";
        
    }
    return self;
}

@end
