//
//  CYTLogisticsNeedDetailVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticsNeedDetailVM.h"

@implementation CYTLogisticsNeedDetailVM
@synthesize requestCommand = _requestCommand;

- (void)ff_initWithModel:(FFExtendModel *)model {
    [super ff_initWithModel:model];
    self.listArray = [NSMutableArray array];
}

- (void)handleData {
    //发车地址
    self.sendModel = [CYTLogisticsNeedWriteCellModel new];
    self.sendModel.select = YES;
    self.sendModel.imageName = @"logistic_need_cell_send";
    self.sendModel.addressModel.mainAddress = [NSString stringWithFormat:@"%@ %@ %@",self.detailModel.startProvinceName,self.detailModel.startCityName,self.detailModel.startCountyName];
    self.sendModel.addressModel.detailAddress = self.detailModel.startAddress;
    self.sendModel.bottomOffset = CYTAutoLayoutV(12);
    
    //收车地址
    self.receiveModel = [CYTLogisticsNeedWriteCellModel new];
    self.receiveModel.select = YES;
    self.receiveModel.imageName = @"logistic_need_cell_receive";
    self.receiveModel.addressModel.mainAddress = [NSString stringWithFormat:@"%@ %@ %@",self.detailModel.destinationProvinceName,self.detailModel.destinationCityName,self.detailModel.destinationCountyName];
    self.receiveModel.addressModel.detailAddress = self.detailModel.destinationAddress;
    self.receiveModel.bottomOffset = CYTAutoLayoutV(30);
    
    //车辆信息
    self.carModel = [CYTLogisticsNeedDetailCarModel new];
    self.carModel.title = [NSString stringWithFormat:@"%@ %@",self.detailModel.bsName,self.detailModel.csName];
    self.carModel.priceString = [NSString stringWithFormat:@"车辆总价：%g万",self.detailModel.totalValues];
    NSString *yearString = self.detailModel.carYearType;
    if (yearString && yearString.length != 0 && ![yearString isEqualToString:@"0"]) {
        yearString = [NSString stringWithFormat:@"%@款",yearString];
    }else {
        yearString = @"";
    }
    NSString *subTitle = [NSString stringWithFormat:@"%@%@",yearString,self.detailModel.carName];
    self.carModel.subTitle = subTitle;
    self.carModel.numberString = [NSString stringWithFormat:@"%ld辆",self.detailModel.carCount];
    self.carModel.timeString = self.detailModel.expiredTime;
    self.carModel.transportHome = self.detailModel.isSendCarByDropIn;
    
    //处理报价数组数据
    self.listArray = [CYTLogisticsNeedDetailOfferModel mj_objectArrayWithKeyValuesArray:self.detailModel.quoteList];
}

- (NSInteger)sectionNumber {
    return (self.detailModel)?2:0;
}

#pragma mark- get
- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.requestURL = kURL.express_purpose_demandinfo;
            model.needHud = YES;
            model.requestParameters = @{@"id":@(self.neeId)};
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            if (resultModel.resultEffective) {
                self.detailModel = [CYTLogisticsNeedDetailModel mj_objectWithKeyValues:resultModel.dataDictionary];
                self.status = self.detailModel.status;
                [self handleData];
            }else {
                self.detailModel = nil;
                [self.listArray removeAllObjects];
            }
        }];
    }
    return _requestCommand;
}

- (RACCommand *)cancelCommand {
    if (!_cancelCommand) {
        
        _cancelCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.requestURL = kURL.express_purpose_cancel;
            model.requestParameters = @{@"id":@(self.neeId)};
            model.needHud = YES;
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            self.cancelCommandResult = resultModel;
            //none
        }];
    }
    return _cancelCommand;
}

@end
