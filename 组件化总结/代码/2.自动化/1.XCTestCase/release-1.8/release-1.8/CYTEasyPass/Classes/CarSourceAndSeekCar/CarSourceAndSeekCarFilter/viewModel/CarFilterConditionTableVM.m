//
//  CarFilterConditionTableVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CarFilterConditionTableVM.h"
#import "CarFilterConditionSubbrandModel.h"
#import "CarFilterConditionAreaModel.h"
#import "CarFilterConditionSubbrand_seriesModel.h"
#import "CarFilterConditionArea_provinceModel.h"
#import "CarFilterConditionDealerTypeModel.h"
#import "CYTBrandSelectCarModel.h"
#import "CYTBrandSelectCarGroupModel.h"
#import "CarFilterConditionView.h"

@interface CarFilterConditionTableVM ()
@property (nonatomic, strong) NSIndexPath *seriesIndexPath;
@property (nonatomic, strong) NSIndexPath *inSeriesIndexPath;
@property (nonatomic, strong) NSIndexPath *carIndexPath;
@property (nonatomic, strong) NSIndexPath *colorIndexPath;
@property (nonatomic, strong) NSIndexPath *areaIndexPath;
@property (nonatomic, strong) NSIndexPath *dealerIndexPath;

@end

@implementation CarFilterConditionTableVM

- (void)ff_initWithModel:(FFExtendModel *)model {
    [super ff_initWithModel:model];
    
    self.seriesIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    self.carIndexPath
    self.colorIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.areaIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.dealerIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    CYTBrandSelectCarModel *carModel = [CYTBrandSelectCarModel new];
    carModel.carId = -1;
    carModel.carName = @"全部";
    self.selectCarModel = carModel;
    
    CYTBrandSelectCarGroupModel *carDefaultModel = [self carGroupModelWithCarId:-1];
    self.rightListArray = @[carDefaultModel];
}

#pragma mark- api
- (NSInteger)numberWithTableIndex:(NSInteger)index {
    switch (self.type) {
        case CarFilterConditionTableColor:
        case CarFilterConditionTableDealer:
            return 1;
        case CarFilterConditionTableArea:
            return self.leftListArray.count;
        case CarFilterConditionTableCar:
            return [self arrayWithIndex:index].count;
        default:
            return 0;
    }
}

- (NSInteger)numberWithSection:(NSInteger)section andTableIndex:(NSInteger)index {
    switch (self.type) {
        case CarFilterConditionTableColor:
        case CarFilterConditionTableDealer:
            return self.leftListArray.count;
        case CarFilterConditionTableCar:
        {
            NSArray *array = [self arrayWithIndex:index];
            if (index==0) {
                CarFilterConditionSubbrandModel *model = array[section];
                return model.models.count;
            }else {
                CYTBrandSelectCarGroupModel *model = array[section];
                return model.cars.count;
            }
        }
        case CarFilterConditionTableArea:
        {
            CarFilterConditionAreaModel *model = self.leftListArray[section];
            return model.provinces.count;
        }
        default:
            return 0;
    }
}

- (NSString *)titleWithIndexPath:(NSIndexPath *)indexPath andTableIndex:(NSInteger)index {
    switch (self.type) {
        case CarFilterConditionTableColor:
        {
            CarFilterConditionColorModel *model = self.leftListArray[indexPath.row];
            return model.name;
        }
        case CarFilterConditionTableDealer:
        {
            CarFilterConditionDealerTypeModel *model = self.leftListArray[indexPath.row];
            return model.levelName;
        }
        case CarFilterConditionTableArea:
        {
            CarFilterConditionAreaModel *model = self.leftListArray[indexPath.section];
            CarFilterConditionArea_provinceModel *provinceModel = model.provinces[indexPath.row];
            return provinceModel.name;
        }
        case CarFilterConditionTableCar:
        {
            NSArray *array = [self arrayWithIndex:index];
            if (index==0) {
                CarFilterConditionSubbrandModel *model = array[indexPath.section];
                CarFilterConditionSubbrand_seriesModel *seriesModel = model.models[indexPath.row];
                return seriesModel.modelName;
            }else {
                if (indexPath.section<array.count) {
                    CYTBrandSelectCarGroupModel *model = array[indexPath.section];
                    if (indexPath.row<model.cars.count) {
                        CYTBrandSelectCarModel *carModel = model.cars[indexPath.row];
                        return carModel.carName;
                    }
                }
            }
        }
        default:
            return @"";
    }
}

- (float)sectionHeightWithTableIndex:(NSInteger)index andSection:(NSInteger)section{
    if (self.type == CarFilterConditionTableCar) {
        if (section == 0) {
            return 0.001;
        }
        return CYTAutoLayoutV(40);
    }
    if (self.type == CarFilterConditionTableArea) {
        if (section == 0) {
            return 0.001;
        }
        return CYTAutoLayoutV(40);
    }
    return 0.001;
}

- (NSString *)sectionTitleWithTableIndex:(NSInteger)index andSection:(NSInteger)section {
    if (self.type == CarFilterConditionTableCar) {
        if (section == 0) {
            return @"";
        }
        NSArray *array = [self arrayWithIndex:index];
        if (index==0) {
            //车系分组
            CarFilterConditionSubbrandModel *model = array[section];
            return model.makeName;
        }else {
            //车款分组
            CYTBrandSelectCarGroupModel *model = array[section];
            return model.groupName;
        }
    }
    if (self.type == CarFilterConditionTableArea) {
        CarFilterConditionAreaModel *model = self.leftListArray[section];
        return model.groupName;
    }
    return @"";
}

#pragma mark- offset
- (void)saveTableOffsetWithTableIndex:(NSInteger)index andOffset:(NSIndexPath *)indexPath{
    if (self.type == CarFilterConditionTableCar) {
        if (index==0) {
            //车系
            self.inSeriesIndexPath = indexPath;
        }else {
            self.seriesIndexPath = self.inSeriesIndexPath;
            self.carIndexPath = indexPath;
        }
    }else if (self.type == CarFilterConditionTableColor) {
        self.colorIndexPath = indexPath;
    }else if (self.type == CarFilterConditionTableArea) {
        self.areaIndexPath = indexPath;
    }else if (self.type == CarFilterConditionTableDealer) {
        self.dealerIndexPath = indexPath;
    }
}

- (NSIndexPath *)tableOffsetWithTableIndex:(NSInteger)index {
    if (self.type == CarFilterConditionTableCar) {
        if (index==0) {
            return self.seriesIndexPath;
        }else {
            return self.carIndexPath;
        }
    }else if (self.type == CarFilterConditionTableColor) {
        return self.colorIndexPath;
    }else if (self.type == CarFilterConditionTableArea) {
        return self.areaIndexPath;
    }else if (self.type == CarFilterConditionTableDealer) {
        return self.dealerIndexPath;
    }
    return [NSIndexPath indexPathForRow:0 inSection:0];
}

#pragma mark- api
- (CYTBrandSelectCarModel *)carModelWithIndexPath:(NSIndexPath *)indexPath {
    CYTBrandSelectCarGroupModel *model = self.rightListArray[indexPath.section];
    CYTBrandSelectCarModel *carModel = model.cars[indexPath.row];
    return carModel;
}

- (CarFilterConditionSubbrand_seriesModel *)seriesModelWithIndex:(NSIndexPath *)indexPath {
    CarFilterConditionSubbrandModel *subbrandModel = self.leftListArray[indexPath.section];
    CarFilterConditionSubbrand_seriesModel *seriesModel = subbrandModel.models[indexPath.row];
    return seriesModel;
}

- (CarFilterConditionSubbrand_seriesModel *)singleSeriesModel {
    if (self.leftListArray.count==2) {
        CarFilterConditionSubbrandModel *model = self.leftListArray[1];
        CarFilterConditionSubbrand_seriesModel *seriesModel = model.models[0];
        return seriesModel;
    }
    return nil;
}

- (void)selectSeries:(CarFilterConditionSubbrand_seriesModel *)seriesModel {
    if (!seriesModel) {
        CarFilterConditionSubbrand_seriesModel *model = [CarFilterConditionSubbrand_seriesModel new];
        model.modelId = -1;
        model.modelName = @"全部";
        seriesModel = model;
        self.selectSeriesModel = seriesModel;
    }
    
    self.inSelectSeriesModel = seriesModel;
    
    if (seriesModel.modelId == -1) {
        //全部
        CYTBrandSelectCarGroupModel *carGroupModel = [self carGroupModelWithCarId:-1];
        self.rightListArray = @[carGroupModel];
        [self.reloadRightTableSubject sendNext:@"1"];
    }else {
        //请求数据
        [self.conditionCarCommand execute:nil];
    }
}

//保存筛选模型，更新condiitionView
- (void)saveFilterConditionWithTableIndex:(NSInteger)index andIndexPath:(NSIndexPath *)indexPath {
    id selectModel;
    
    if (self.type == CarFilterConditionTableCar) {
        if (index==1) {
            //保存车款信息
            CYTBrandSelectCarGroupModel *model = self.rightListArray[indexPath.section];
            CYTBrandSelectCarModel *carModel = model.cars[indexPath.row];
            selectModel = carModel;
        }else {
            //点击车系
            CarFilterConditionSubbrand_seriesModel *seriesModel = [self seriesModelWithIndex:indexPath];
            [self selectSeries:seriesModel];
            return;
        }
    }else if (self.type == CarFilterConditionTableColor) {
        CarFilterConditionColorModel *model = self.leftListArray[indexPath.row];
        selectModel = model;
    }else if (self.type == CarFilterConditionTableArea) {
        CarFilterConditionAreaModel *model = self.leftListArray[indexPath.section];
        CarFilterConditionArea_provinceModel *provinceModel = model.provinces[indexPath.row];
        selectModel = provinceModel;
    }else if (self.type == CarFilterConditionTableDealer) {
        CarFilterConditionDealerTypeModel *model = self.leftListArray[indexPath.row];
        selectModel = model;
    }
    
    self.selectSeriesModel = self.inSelectSeriesModel;
    //获取选中的model
    [self genSelectedModel:selectModel];
    //update segment
    [self.conditionViewRef updateSegmentTitleWithModel:selectModel andSeriesModel:(self.isSingleSeries)?nil:self.selectSeriesModel andType:self.type];
    //保存筛选条件
    [self genFilterConditionWithModel:selectModel];
}

- (void)genSelectedModel:(id)model {
    if ([model isKindOfClass:[CYTBrandSelectCarModel class]]) {
        CYTBrandSelectCarModel *carModel = (CYTBrandSelectCarModel *)model;
        self.selectCarModel = carModel;
    }else if ([model isKindOfClass:[CarFilterConditionColorModel class]]) {
        CarFilterConditionColorModel *colorModel = (CarFilterConditionColorModel *)model;
        self.selectColorModel = colorModel;
    }else if ([model isKindOfClass:[CarFilterConditionArea_provinceModel class]]) {
        CarFilterConditionArea_provinceModel *areaModel = (CarFilterConditionArea_provinceModel *)model;
        self.selectProvinceModel = areaModel;
    }else if ([model isKindOfClass:[CarFilterConditionDealerTypeModel class]]) {
        CarFilterConditionDealerTypeModel *dealerModel = (CarFilterConditionDealerTypeModel *)model;
        self.selectDealerModel = dealerModel;
    }
}

- (BOOL)selectedModelWithModel:(id)model {
    if ([model isKindOfClass:[CYTBrandSelectCarModel class]]) {
        CYTBrandSelectCarModel *carModel = (CYTBrandSelectCarModel *)model;
        return [self carIsEqualWithModel:carModel];
    }else if ([model isKindOfClass:[CarFilterConditionSubbrand_seriesModel class]]) {
        CarFilterConditionSubbrand_seriesModel *seriesModel = (CarFilterConditionSubbrand_seriesModel *)model;
        return [self selectId:self.inSelectSeriesModel.modelId equalToId:seriesModel.modelId];
    }else if ([model isKindOfClass:[CarFilterConditionColorModel class]]) {
        CarFilterConditionColorModel *colorModel = (CarFilterConditionColorModel *)model;
        return [self selectId:self.selectColorModel.colorId equalToId:colorModel.colorId];
    }else if ([model isKindOfClass:[CarFilterConditionArea_provinceModel class]]) {
        CarFilterConditionArea_provinceModel *areaModel = (CarFilterConditionArea_provinceModel *)model;
        return [self areaIsEqualWithModel:areaModel];
    }else if ([model isKindOfClass:[CarFilterConditionDealerTypeModel class]]) {
        CarFilterConditionDealerTypeModel *dealerModel = (CarFilterConditionDealerTypeModel *)model;
        return [self selectId:self.selectDealerModel.levelId equalToId:dealerModel.levelId];
    }
    return NO;
}

- (BOOL)selectId:(NSInteger)selectId equalToId:(NSInteger)theId {
    if (selectId == 0) {
        return (theId==-1);
    }else {
        return (selectId == theId);
    }
}

//包含单车款、单车系、多车系情况
- (BOOL)carIsEqualWithModel:(CYTBrandSelectCarModel *)model {
    if (self.isSingleSeries) {
        return [self carIdIsEqualWithModel:model];
    }else {
        if (self.inSelectSeriesModel.modelId == self.selectSeriesModel.modelId || (self.inSelectSeriesModel.modelId == -1 && !self.selectSeriesModel)) {
            //车系相同
            return [self carIdIsEqualWithModel:model];
        }
    }
    return NO;
}

- (BOOL)carIdIsEqualWithModel:(CYTBrandSelectCarModel *)model {
    if (self.selectCarModel.carId == model.carId) {
        return YES;
    }
    
    if (!self.isSingleSeries) {
        if (self.selectCarModel.carId == -1 && self.inSelectSeriesModel.modelId == model.carId) {
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)areaIsEqualWithModel:(CarFilterConditionArea_provinceModel *)model {
    if (!self.selectProvinceModel) {
        if (model.provinceId ==-1 && model.locationGroupID.integerValue == -1) {
            return YES;
        }
    }else {
        if (model.provinceId==self.selectProvinceModel.provinceId && model.locationGroupID.integerValue==self.selectProvinceModel.locationGroupID.integerValue) {
            return YES;
        }
    }
    return NO;
}

- (id)getModelWithIndexPath:(NSIndexPath *)indexPath andTableIndex:(NSInteger)index {
    switch (self.type) {
        case CarFilterConditionTableColor:
        {
            CarFilterConditionColorModel *model = self.leftListArray[indexPath.row];
            return model;
        }
        case CarFilterConditionTableDealer:
        {
            CarFilterConditionDealerTypeModel *model = self.leftListArray[indexPath.row];
            return model;
        }
        case CarFilterConditionTableArea:
        {
            CarFilterConditionAreaModel *model = self.leftListArray[indexPath.section];
            CarFilterConditionArea_provinceModel *provinceModel = model.provinces[indexPath.row];
            return provinceModel;
        }
        case CarFilterConditionTableCar:
        {
            NSArray *array = [self arrayWithIndex:index];
            if (index==0) {
                CarFilterConditionSubbrandModel *model = array[indexPath.section];
                CarFilterConditionSubbrand_seriesModel *seriesModel = model.models[indexPath.row];
                return seriesModel;
            }else {
                if (indexPath.section<array.count) {
                    CYTBrandSelectCarGroupModel *model = array[indexPath.section];
                    if (indexPath.row<model.cars.count) {
                        CYTBrandSelectCarModel *carModel = model.cars[indexPath.row];
                        return carModel;
                    }
                }
            }
        }
        default:
            return nil;
    }
}

- (float)heightOfCarList {
    if (self.invalid) {
        return CYTAutoLayoutV(80);
    }
    
    if (self.type == CarFilterConditionTableCar) {
        //获取两个列表的高度
        if (self.singleSeries) {
            return [self heightOfCar];
        }else {
            float height = MAX([self heightOfCar], [self heightOfCarSeries]);
            height = MIN(height, 350);
            return height;
        }
    }
    return 0;
}

//计算车系高度
- (float)heightOfCarSeries {
    if (self.leftListArray.count==0) {
        return 0;
    }
    NSInteger count = 0;
    NSInteger section = 0;
    for (CarFilterConditionSubbrandModel *subbrand in self.leftListArray) {
        section+=1;
        count+=subbrand.models.count;
    }
    
    return (count)*CYTAutoLayoutV(80)+(section-1)*CYTAutoLayoutV(40);
}

//计算车款高度
- (float)heightOfCar {
    if (self.rightListArray.count==0) {
        return 0;
    }
    NSInteger count = 0;
    NSInteger section = 0;
    for (CYTBrandSelectCarGroupModel *group in self.rightListArray) {
        section+=1;
        count+=group.cars.count;
    }
    return (count)*CYTAutoLayoutV(80)+(section-1)*CYTAutoLayoutV(40);
}

#pragma mark- method
//获取车款分组数据
- (CYTBrandSelectCarGroupModel *)carGroupModelWithCarId:(NSInteger)carId {
    CYTBrandSelectCarModel *carModel = [CYTBrandSelectCarModel new];
    carModel.carId = carId;
    carModel.carName = @"全部";
    carModel.carId = -1;
    
    CYTBrandSelectCarGroupModel *carGroup = [CYTBrandSelectCarGroupModel new];
    carGroup.groupName = @"";
    carGroup.cars = @[carModel];
    return carGroup;
}

- (NSArray *)arrayWithIndex:(NSInteger)index {
    if (index==1 && self.leftListArray.count==0) {
        return nil;
    }
    return (index==0)?self.leftListArray:self.rightListArray;
}

- (NSInteger)getSingleCarIdWithModel:(CYTBrandSelectCarModel *)model {
    if (model.carId==-1) {
        if (self.rightListArray.count>1) {
            CYTBrandSelectCarGroupModel *carGroup = self.rightListArray[1];
            if (carGroup.cars.count>0) {
                CYTBrandSelectCarModel *carModel = carGroup.cars[0];
                return carModel.carId;
            }
        }
    }else {
        return model.carId;
    }
    return -1;
}

- (NSInteger)getSingleCarSeriesIdWithModel:(CarFilterConditionSubbrand_seriesModel *)seriesModel {
    if (self.leftListArray.count>1) {
        CarFilterConditionSubbrandModel *subbrandModel = self.leftListArray[1];
        if (subbrandModel.models.count>0) {
            CarFilterConditionSubbrand_seriesModel *seriesModel = subbrandModel.models[0];
            return seriesModel.modelId;
        }
    }
    return -1;
}

- (void)genFilterConditionWithModel:(id)model {
    if ([model isKindOfClass:[CYTBrandSelectCarModel class]]) {
        CYTBrandSelectCarModel *carModel = (CYTBrandSelectCarModel *)model;
        //保存车系
        if (self.isSingleCar) {
            self.listRequestModel.carSerialId = [self getSingleCarSeriesIdWithModel:nil];
        }else {
            if (self.selectSeriesModel) {
                self.listRequestModel.carSerialId = self.selectSeriesModel.modelId;
            }
        }
        
        //保存车款
        if (self.isSingleCar) {
            self.listRequestModel.carId = [self getSingleCarIdWithModel:model];
        }else {
            self.listRequestModel.carId = carModel.carId;
            if ([carModel.carName isEqualToString:@"全部"]) {
                self.listRequestModel.carId = -1;
            }
        }
    }else if ([model isKindOfClass:[CarFilterConditionColorModel class]]) {
        CarFilterConditionColorModel *colorModel = (CarFilterConditionColorModel *)model;
        self.listRequestModel.exteriorColor = colorModel.name;
        if ([colorModel.name isEqualToString:@"全部"]) {
            self.listRequestModel.exteriorColor = @"";
        }
    }else if ([model isKindOfClass:[CarFilterConditionArea_provinceModel class]]) {
        CarFilterConditionArea_provinceModel *areaModel = (CarFilterConditionArea_provinceModel *)model;
        self.listRequestModel.provinceId = areaModel.provinceId;
        self.listRequestModel.locationGroupId = areaModel.locationGroupID.integerValue;
    }else if ([model isKindOfClass:[CarFilterConditionDealerTypeModel class]]) {
        CarFilterConditionDealerTypeModel *dealerModel = (CarFilterConditionDealerTypeModel *)model;
        self.listRequestModel.dealerMemberLevelId = dealerModel.levelId;
    }
    
    //只要选择了筛选条件，类型变为筛选
    self.listRequestModel.source = 2;
    //发送通知刷新列表
    [[NSNotificationCenter defaultCenter] postNotificationName:kCarFilterRefreshKey object:nil];
}

#pragma mark- set
- (void)setInvalid:(BOOL)invalid {
    _invalid = invalid;
    
    
}

#pragma mark- get
- (BOOL)isSingleSeries {
    if (self.invalid) {
        return YES;
    }
    if (self.leftListArray.count>1) {
        CarFilterConditionSubbrandModel *model = self.leftListArray[1];
        if (self.type == CarFilterConditionTableCar && model.models.count==1) {
            return YES;
        }
    }
    return NO;
}



- (RACCommand *)conditionCarCommand {
    if (!_conditionCarCommand) {
        _conditionCarCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.needHud = YES;
            model.requestURL = kURL.car_common_getGroupCarInfoListByModelId;
            model.methodType = NetRequestMethodTypeGet;
            model.requestParameters = @{@"serialId":@(self.inSelectSeriesModel.modelId)};
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            if (resultModel.resultEffective) {
                NSMutableArray *array = [CYTBrandSelectCarGroupModel mj_objectArrayWithKeyValuesArray:resultModel.dataDictionary[@"list"]];
                [array insertObject:[self carGroupModelWithCarId:self.selectSeriesModel.modelId] atIndex:0];
                self.rightListArray = array;
            }
        }];
    }
    return _conditionCarCommand;
}

- (RACSubject *)reloadRightTableSubject {
    if (!_reloadRightTableSubject) {
        _reloadRightTableSubject = [RACSubject new];
    }
    return _reloadRightTableSubject;
}

@end
