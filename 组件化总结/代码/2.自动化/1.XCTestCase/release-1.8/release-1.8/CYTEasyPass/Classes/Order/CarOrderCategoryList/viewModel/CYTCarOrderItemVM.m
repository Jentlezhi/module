//
//  CYTCarOrderItemVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/29.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarOrderItemVM.h"

@implementation CYTCarOrderItemVM
@synthesize requestCommand = _requestCommand;

- (void)ff_initWithModel:(FFExtendModel *)model {
    [super ff_initWithModel:model];
    self.listArray = [NSMutableArray array];
}

+ (CYTCarSourceListModel *)carInfoModelWithOrderModel:(CYTCarOrderItemModel_item *)model {
    
    CYTCarSourceListModel *carModel = [CYTCarSourceListModel new];
    carModel.dealer = nil;
    CYTCarSourceInfo *info = [CYTCarSourceInfo new];
    
    info.customPayparyDes = model.payPartDesc;
    info.carReferPrice = model.carReferPrice;
    info.brandName = model.carMainName;
    info.serialName = @"";
    info.fullCarName = model.carDetailName;
    info.carSourceTypeName = model.importTypeName;
    info.exteriorColor = model.exColor;
    info.interiorColor = model.inColor;
    info.carSourceAddress = model.carCityName;
    info.customDealPrice = model.price;
    NSString *price = ([model.price isEqualToString:@"0"] || [model.price isEqualToString:@""])?@"":[NSString stringWithFormat:@"成交总价: %@ 万",model.price];
    info.customDealPriceDes = price;
    NSString *deposit = ([model.depositAmount isEqualToString:@"0"] || [model.depositAmount isEqualToString:@""])?@"":[NSString stringWithFormat:@"订金总额: %@ 元",model.depositAmount];
    info.customDeposit = deposit;
    
    carModel.carSourceInfo = info;

    return carModel;
}

#pragma mark- get
- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.requestURL = kURL.order_car_GetOrderList;
            model.methodType = NetRequestMethodTypeGet;
            model.needHud = NO;
            //买车=1，卖车=2
            NSString *roal = (self.orderType==CarOrderTypeBought)?@"1":@"2";
            NSDictionary *parameters = @{@"orderRoleType":roal,
                                         @"lastId":@(self.lastId),
                                         @"orderStatus":@(self.orderState)};
            model.requestParameters = parameters;
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            
            if (self.lastId == 0) {
                [self.listArray removeAllObjects];
            }
            
            if (resultModel.resultEffective) {
                CYTCarOrderItemModel *dataModel = [CYTCarOrderItemModel mj_objectWithKeyValues:resultModel.dataDictionary];
                self.isMore = dataModel.isMore;
                [self.listArray addObjectsFromArray:dataModel.carlist];
                if (self.listArray.count>0) {
                    CYTCarOrderItemModel_item *lastModel = self.listArray[self.listArray.count-1];
                    self.lastId = lastModel.rowId;
                }
                self.stateNumberModel = dataModel.statistics;
            }
        }];
    }
    return _requestCommand;
}

- (RACCommand *)refundCommand {
    if (!_refundCommand) {
        _refundCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.requestURL = kURL.order_Refund_SellerRefundProc;
            model.needHud = YES;
            model.requestParameters = @{@"orderId":@(self.orderId),
                                        @"isAgree":@(self.agreeOrNot)};
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            //none
        }];
    }
    return _refundCommand;
}

@end
