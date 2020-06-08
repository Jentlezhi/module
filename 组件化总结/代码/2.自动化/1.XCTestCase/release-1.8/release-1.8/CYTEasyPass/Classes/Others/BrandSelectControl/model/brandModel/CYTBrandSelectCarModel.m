//
//  CYTBrandSelectCarModel.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/4.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBrandSelectCarModel.h"

@implementation CYTBrandSelectCarModel

- (BOOL)isEqual:(id)object {
    CYTBrandSelectCarModel *obj = (CYTBrandSelectCarModel *)object;
    return (obj.carId == self.carId);
}

- (id)copyWithZone:(NSZone *)zone {
    CYTBrandSelectCarModel *model = [[[self class] allocWithZone:zone] init];
    model.carId = self.carId;
    model.carName = [self.carName copy];
    model.carReferPrice = [self.carReferPrice copy];
    model.type = [self.type copy];
    model.typeName = [self.typeName copy];
    return model;
}

@end
