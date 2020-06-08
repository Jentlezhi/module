//
//  CYTBrandSelectSeriesModel.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBrandSelectSeriesModel.h"

@implementation CYTBrandSelectSeriesModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"serialId" : @"modelId",
             @"serialName" : @"modelName",
             };
}

- (BOOL)isEqual:(id)object {
    CYTBrandSelectSeriesModel *obj = (CYTBrandSelectSeriesModel *)object;
    if (self.serialId == obj.serialId) {
        return YES;
    }
    return NO;
}

- (id)copyWithZone:(NSZone *)zone {
    CYTBrandSelectSeriesModel *model = [[[self class] allocWithZone:zone] init];
    model.serialId = self.serialId;
    model.serialName = [self.serialName copy];
    model.type = [self.type copy];
    model.typeName = [self.typeName copy];
    return model;
}

@end
