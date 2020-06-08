//
//  CYTLogisticsNeedWriteVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/15.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticsNeedWriteVM.h"
#import "CYTLogisticsNeedWritePreModel.h"

@implementation CYTLogisticsNeedWriteVM
@synthesize requestCommand = _requestCommand;

- (void)ff_initWithModel:(FFExtendModel *)model {
    [super ff_initWithModel:model];
    
    self.cellModelArray = [NSMutableArray array];
    [self initCellArray];
    self.agreeProtocal = YES;
}

- (void)initCellArray {
    CYTLogisticsNeedWriteCellModel *model0 = [CYTLogisticsNeedWriteCellModel new];
    model0.imageName = @"logistic_need_cell_send";
    model0.addressModel.mainAddress = @"发车地：";
    model0.placeholder = @"请选择";
    model0.bottomOffset = CYTAutoLayoutV(12);
    model0.select = NO;
    [self.cellModelArray addObject:model0];
    
    CYTLogisticsNeedWriteCellModel *model1 = [CYTLogisticsNeedWriteCellModel new];
    model1.imageName = @"logistic_need_cell_receive";
    model1.addressModel.mainAddress = @"收车地：";
    model1.placeholder = @"请选择";
    model1.bottomOffset = CYTAutoLayoutV(30);
    model1.select = NO;
    [self.cellModelArray addObject:model1];
    
    CYTLogisticsNeedWriteCellModel *model2 = [CYTLogisticsNeedWriteCellModel new];
    model2.title = @"车型";
    model2.contentString = @"请选择";
    model2.select = NO;
    [self.cellModelArray addObject:model2];
    
    CYTLogisticsNeedWriteCellModel *model3 = [CYTLogisticsNeedWriteCellModel new];
    model3.title = @"数量";
    model3.placeholder = @"请输入托运数量";
    model3.select = NO;
    model3.subtitle = @"    辆";
    [self.cellModelArray addObject:model3];
    
    CYTLogisticsNeedWriteCellModel *model4 = [CYTLogisticsNeedWriteCellModel new];
    model4.title = @"车辆单价";
    model4.placeholder = @"请输入车辆单价";
    model4.subtitle = @"  万元";
    model4.select = NO;
    [self.cellModelArray addObject:model4];
    
    CYTLogisticsNeedWriteCellModel *model5 = [CYTLogisticsNeedWriteCellModel new];
    model5.title = @"车辆总价";
    model5.placeholder = @"";
    model5.subtitle = @"  万元";
    model5.select = NO;
    [self.cellModelArray addObject:model5];
    
    CYTLogisticsNeedWriteCellModel *model6 = [CYTLogisticsNeedWriteCellModel new];
    model6.title = @"送车上门服务shu0oming惺惺惜惺惺想寻寻寻寻寻";
    [self.cellModelArray addObject:model6];
}

- (BOOL)valid {
    for (int i=0; i<self.cellModelArray.count; i++) {
        if (i==5 || i==6) {
            continue;
        }
        
        CYTLogisticsNeedWriteCellModel *model = self.cellModelArray[i];
        if (!model.select) {
            return NO;
        }
        if (i==3 && model.contentString.integerValue == 0) {
            return NO;
        }
    }
    
    if (!self.agreeProtocal) {
        return NO;
    }
    
    return YES;
}

#pragma mark- 叫个物流数据填充
- (void)fillLogisticData {
    CYTLogisticsNeedWritePreModel *logisticModel = [CYTLogisticsNeedWritePreModel mj_objectWithKeyValues:self.logisticInfoResult.dataDictionary];
    CYTLogisticsNeedWritePreDetail *detailModel = logisticModel.detail;
    CYTLogisticsNeedWritePreAddress *addressModel = logisticModel.address;

    //发车地址
    CYTLogisticsNeedWriteCellModel *model0 = self.cellModelArray[0];
    model0.addressModel.mainAddress = [NSString stringWithFormat:@"%@ %@ %@",addressModel.senderProvinceName,addressModel.senderCityName,addressModel.senderCountyName];
    model0.addressModel.detailAddress = addressModel.senderAddress;
    model0.addressModel.provinceId = addressModel.senderProvinceId;
    model0.addressModel.cityId = addressModel.senderCityId;
    model0.addressModel.countyId = addressModel.senderCountyId;//如果没有借口默认返回-1
    model0.select = YES;
    //如果是空的，
    if (addressModel.senderProvinceId==0 && addressModel.senderCityId==0) {
        model0.imageName = @"logistic_need_cell_send";
        model0.addressModel.mainAddress = @"发车地：";
        model0.placeholder = @"请选择";
        model0.bottomOffset = CYTAutoLayoutV(12);
        model0.select = NO;
    }
    
    //收车地址
    CYTLogisticsNeedWriteCellModel *model1 = self.cellModelArray[1];
    model1.addressModel.mainAddress = [NSString stringWithFormat:@"%@ %@ %@",addressModel.receiverProvinceName,addressModel.receiverCityName,addressModel.receiverCountyName];
    model1.addressModel.detailAddress = addressModel.receiverAddress;
    model1.addressModel.provinceId = addressModel.receiverProvinceId;
    model1.addressModel.cityId = addressModel.receiverCityId;
    model1.addressModel.countyId = addressModel.receiverCountyId;//如果没有借口默认返回-1
    
    model1.select = YES;

    //车型
    CYTLogisticsNeedWriteCellModel *model2 = self.cellModelArray[2];
    CYTCarBrandModel *carModel = [CYTCarBrandModel new];
    carModel.brandId = [NSString stringWithFormat:@"%ld",detailModel.brandID];
    carModel.seriesId = [NSString stringWithFormat:@"%ld",detailModel.serialID];
    carModel.carId = [NSString stringWithFormat:@"%ld",detailModel.carID];
    model2.carModel = carModel;
    model2.select = YES;
    NSString *year = (detailModel.carYearType == 0)?@"":[NSString stringWithFormat:@"%ld 款",detailModel.carYearType];
    model2.contentString = [NSString stringWithFormat:@"%@ %@ %@ %@",detailModel.carBrandName,year,detailModel.carSerialName,detailModel.carName];
    
    //数量
    CYTLogisticsNeedWriteCellModel *model3 = self.cellModelArray[3];
    model3.select = YES;
    model3.contentString = [NSString stringWithFormat:@"%ld",detailModel.carNum];
    
    //车辆单价
    CYTLogisticsNeedWriteCellModel *model4 = self.cellModelArray[4];
    model4.select = YES;
    model4.contentString = detailModel.carUnitPrice;
    
    //车辆总价
    CYTLogisticsNeedWriteCellModel *model5 = self.cellModelArray[5];
    model5.select = YES;
    model5.contentString = detailModel.carPrice;
}

#pragma mark- method
- (void)saveAndCalculatePriceWithText:(NSString *)text andIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        CYTLogisticsNeedWriteCellModel *model = self.cellModelArray[3];
        model.select = (text.length>0);
        model.contentString = text;
    }else if (indexPath.row == 2) {
        CYTLogisticsNeedWriteCellModel *model = self.cellModelArray[4];
        model.select = (text.length>0);
        model.contentString = text;
    }
    
    CYTLogisticsNeedWriteCellModel *model3 = self.cellModelArray[3];
    CYTLogisticsNeedWriteCellModel *model4 = self.cellModelArray[4];
    
    long number = [model3.contentString longLongValue];
    double price = [model4.contentString doubleValue];
    double total = number * price;
    NSString *totalString;
    if (total == 0) {
        totalString = @"";
    }else {
        totalString = [NSString stringWithFormat:@"%.2f",total];
    }
    CYTLogisticsNeedWriteCellModel *model5 = self.cellModelArray[5];
    model5.contentString = totalString;
    
}

- (void)saveCarInfoAndGuidePriceWithModel:(CYTBrandSelectResultModel *)brandModel {
    CYTCarBrandModel *carModel = [CYTCarBrandModel new];
    
    carModel.brandId = [NSString stringWithFormat:@"%ld",brandModel.subBrandId];
    carModel.seriesId = [NSString stringWithFormat:@"%ld",brandModel.seriesModel.serialId];
    carModel.carId = [NSString stringWithFormat:@"%ld",brandModel.carModel.carId];
    
    if (brandModel.carModel.carId == -1) {
        //自定义车款
        carModel.customCar = YES;
        carModel.customCarName = brandModel.carModel.carName;
        carModel.totalName = [NSString stringWithFormat:@"%@ %@",brandModel.seriesModel.serialName,brandModel.carModel.carName];
    }else {
        //不是自定义车款
        carModel.customCar = NO;
        carModel.totalName = [NSString stringWithFormat:@"%@ %@",brandModel.seriesModel.serialName,brandModel.carModel.carName];
    }
    
    CYTLogisticsNeedWriteCellModel *model = self.cellModelArray[2];
    model.carModel = carModel;
    model.select = YES;
    model.contentString = carModel.totalName;
    
    //指导价带入
    NSString *guidePrice = brandModel.carModel.carReferPrice;
    if ([guidePrice floatValue]==0) {
        guidePrice = @"";
    }
    CYTLogisticsNeedWriteCellModel *priceModel = self.cellModelArray[4];
    priceModel.select = YES;
    priceModel.contentString = guidePrice;
    
    //计算
    [self saveAndCalculatePriceWithText:guidePrice andIndexPath:[NSIndexPath indexPathForItem:2 inSection:1]];
}

- (NSDictionary *)getParameters {
    NSDictionary *dic;
    
    CYTLogisticsNeedWriteCellModel *model0 = self.cellModelArray[0];
    model0 = self.cellModelArray[0];
    if (!model0.select) {
        return nil;
    }
    
    CYTLogisticsNeedWriteCellModel *model1 = self.cellModelArray[1];
    if (!model1.select) {
        return nil;
    }
    
    CYTLogisticsNeedWriteCellModel *model = self.cellModelArray[2];
    if (!model.select) {
        return nil;
    }
    NSString *csid = model.carModel.seriesId;
    NSString *carId = model.carModel.carId;
    NSString *brandId = model.carModel.brandId;
    NSString *customName = (model.carModel.customCarName)?:@"";
    
    //数量
    model = self.cellModelArray[3];
    if (!model.select) {
        return nil;
    }
    NSString *count = model.contentString;
    if (count.integerValue == 0) {
        [CYTToast errorToastWithMessage:@"请输入数量"];
    }
    
    //单价
//    model = self.cellModelArray[4];
//    NSString *carPrice = model.contentString;
    
    //总价
    model = self.cellModelArray[5];
    NSString *totalPrice = model.contentString;
    
    //其他 写死
    NSInteger deliverInt = 0;
    NSInteger putCarModeInt = 1;
    
    NSInteger orderId = (self.needGetLogisticInfo)?self.orderId:(-1);
    dic = [NSDictionary dictionaryWithObjectsAndKeys:
           brandId,@"BrandId",
           csid,@"CsId",
           carId,@"CarId",
           customName,@"CustomCarName",
           count,@"Count",
           totalPrice,@"TotalValues",
           @(deliverInt),@"DeliverDoorstep",
           @(putCarModeInt),@"PutCarMode",
           @(orderId),@"OrderID",//
           @(model0.addressModel.provinceId),@"SendCarProvinceId",
           @(model0.addressModel.cityId),@"SendCarCityId",
           @(model0.addressModel.countyId),@"SendCarCountryId",
           model0.addressModel.detailAddress,@"SendCarAddressDetail",
           @(model1.addressModel.provinceId),@"ReceiveCarProvinceId",
           @(model1.addressModel.cityId),@"ReceiveCarCityId",
           @(model1.addressModel.countyId),@"ReceiveCarCountryId",
           model1.addressModel.detailAddress,@"ReceiveCarAddressDetail",
           nil];
    
    return dic;
}

#pragma mark- get
- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.needHud = YES;
            model.requestURL = kURL.express_purpose_add;
            model.requestParameters = [self getParameters].mutableCopy;
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            //none
        }];
    }
    return _requestCommand;
}

- (RACCommand *)requestLogisticInfo {
    if (!_requestLogisticInfo) {
        _requestLogisticInfo = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.needHud = YES;
            model.methodType = NetRequestMethodTypeGet;
            model.requestURL = kURL.order_express_callExpress;
            model.requestParameters = @{@"orderId":@(self.orderId)}.mutableCopy;
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            self.logisticInfoResult = resultModel;
            if (resultModel.resultEffective) {
                [self fillLogisticData];
            }
        }];
    }
    return _requestLogisticInfo;
}

@end
