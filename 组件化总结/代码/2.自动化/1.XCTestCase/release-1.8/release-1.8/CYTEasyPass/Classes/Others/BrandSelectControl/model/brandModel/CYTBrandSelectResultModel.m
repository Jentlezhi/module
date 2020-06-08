//
//  CYTBrandSelectResultModel.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/4.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBrandSelectResultModel.h"

@implementation CYTBrandSelectResultModel

- (id)copyWithZone:(NSZone *)zone {
    CYTBrandSelectResultModel *model = [[[self class] allocWithZone:zone] init];
    model.inBrandId = self.inBrandId;
    model.subBrandId = self.subBrandId;
    model.subBrandName = [self.subBrandName copy];
    model.seriesModel = [self.seriesModel copy];
    model.carModel = [self.carModel copy];
    return model;
}

@end
