//
//  CarFilterConditionVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CarFilterConditionVM.h"
#import "CarFilterConditionSubbrandModel.h"
#import "CarFilterConditionSubbrand_seriesModel.h"
#import "CarFilterConditionDealerTypeModel.h"
#import "CarFilterConditionAreaModel.h"
#import "CarFilterConditionColorModel.h"
#import "CYTBrandSelectCarGroupModel.h"
#import "CYTBrandSelectCarModel.h"
#import "CarFilterConditionArea_provinceModel.h"

@implementation CarFilterConditionVM

- (void)ff_initWithModel:(FFExtendModel *)model {
    [super ff_initWithModel:model];
}

- (id)getAllItemWithType:(NSInteger)type {
    if (type==0) {
        CarFilterConditionSubbrandModel *model = [CarFilterConditionSubbrandModel new];
        model.makeId = -1;
        model.makeName = @"";
        CarFilterConditionSubbrand_seriesModel *seriesModel = [CarFilterConditionSubbrand_seriesModel new];
        seriesModel.modelId = -1;
        seriesModel.modelName = @"全部";
        model.models = @[seriesModel];
        return model;
    }else if (type == 1) {
        CarFilterConditionColorModel *color = [CarFilterConditionColorModel new];
        color.name = @"全部";
        color.value = @"";
        color.colorId = -1;
        return color;
    }else if (type == 2) {
        CarFilterConditionAreaModel *area = [CarFilterConditionAreaModel new];
        area.groupName = @"";
        CarFilterConditionArea_provinceModel *province = [CarFilterConditionArea_provinceModel new];
        province.provinceId = -1;
        province.name = @"全部";
        province.locationGroupID = @"-1";
        area.provinces = @[province];
        return area;
    }else if (type == 3) {
        CarFilterConditionDealerTypeModel *model = [CarFilterConditionDealerTypeModel new];
        model.levelId = -1;
        model.levelName = @"全部";
        return model;
    }else if (type == -1) {
        //车款
        CYTBrandSelectCarGroupModel *carGroup = [CYTBrandSelectCarGroupModel new];
        carGroup.groupName = @"";
        CYTBrandSelectCarModel *car = [CYTBrandSelectCarModel new];
        car.carId = -1;
        car.carName = @"全部";
        carGroup.cars = @[car];
        return carGroup;
    }
    return nil;
}

///处理筛选条件分组
- (void)handleFilterConditionGroup:(FFBasicNetworkResponseModel *)responseModel {
    //获取4组数据：车型、颜色、区域、车上类型
    //车系
    NSMutableArray *carArray = [NSMutableArray array];
    if (responseModel.resultEffective) {
        carArray = [CarFilterConditionSubbrandModel mj_objectArrayWithKeyValuesArray:[responseModel.dataDictionary valueForKey:@"makeModels"]].mutableCopy;
        if (!carArray) {
            carArray = [NSMutableArray array];
        }
    }
    [carArray insertObject:[self getAllItemWithType:0] atIndex:0];
    self.carArray = carArray;
    
    //单车款
    NSMutableArray *singleCar = [NSMutableArray array];
    if (responseModel.resultEffective) {
        singleCar = [CYTBrandSelectCarGroupModel mj_objectArrayWithKeyValuesArray:[responseModel.dataDictionary valueForKey:@"groupCars"]];
        if (!singleCar) {
            singleCar = [NSMutableArray array];
        }
    }
    if (singleCar.count>0) {
        self.singleCar = YES;
        [singleCar insertObject:[self getAllItemWithType:-1] atIndex:0];
        self.singleCarArray = singleCar;
    }
    
    //颜色
    NSMutableArray *colorArray = [NSMutableArray array];
    if (responseModel.resultEffective) {
        colorArray = [CarFilterConditionColorModel mj_objectArrayWithKeyValuesArray:[responseModel.dataDictionary valueForKey:@"exteriorColors"]].mutableCopy;
        if (!colorArray) {
            colorArray = [NSMutableArray array];
        }
    }
    [colorArray insertObject:[self getAllItemWithType:1] atIndex:0];
    self.colorArray = colorArray;
    
    //区域
    NSMutableArray *areaArray = [NSMutableArray array];
    if (responseModel.resultEffective) {
        areaArray = [CarFilterConditionAreaModel mj_objectArrayWithKeyValuesArray:[responseModel.dataDictionary valueForKey:@"area"]].mutableCopy;
        if (!areaArray) {
            areaArray = [NSMutableArray array];
        }
    }
    [areaArray insertObject:[self getAllItemWithType:2] atIndex:0];
    self.areaArray = areaArray;
    
    //经销商类型
    NSMutableArray *dealerArray = [NSMutableArray array];
    if (responseModel.resultEffective) {
        dealerArray = [CarFilterConditionDealerTypeModel mj_objectArrayWithKeyValuesArray:[responseModel.dataDictionary valueForKey:@"memberLevels"]].mutableCopy;
        if (!dealerArray) {
            dealerArray = [NSMutableArray array];
        }
    }
    [dealerArray insertObject:[self getAllItemWithType:3] atIndex:0];
    self.dealerArray = dealerArray;
    
}

#pragma mark- get
- (RACCommand *)conditionGroupCommand {
    if (!_conditionGroupCommand) {
        _conditionGroupCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.needHud = YES;
            model.methodType = NetRequestMethodTypeGet;
            model.requestURL = kURL.car_source_getFilterCondition;
            model.requestParameters = self.requestModel.mj_keyValues;
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *responseModel) {
            if (!responseModel.dataDictionary) {
                self.invalid = YES;
            }
            [self handleFilterConditionGroup:responseModel];
        }];
    }
    return _conditionGroupCommand;
}

@end
