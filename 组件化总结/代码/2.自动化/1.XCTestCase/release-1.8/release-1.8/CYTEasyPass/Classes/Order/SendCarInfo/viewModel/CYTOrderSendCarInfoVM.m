//
//  CYTOrderSendCarInfoVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTOrderSendCarInfoVM.h"

@implementation CYTOrderSendCarInfoVM
@synthesize requestCommand = _requestCommand;

- (void)ff_initWithModel:(FFExtendModel *)model {
    [super ff_initWithModel:model];
    self.flagArray = @[@"车  架  号：",@"随车手续：",@"随车附件：",@"承运公司：",@"司机姓名：",@"联系电话：",@"备\u3000\u3000注："];
}

- (NSString *)itemInfoWithIndex:(NSInteger)index {
    if (index == 0) {
        return self.infoModel.vin;
    }else if (index == 1) {
        return self.infoModel.carDocuments;
    }else if (index == 2) {
        return self.infoModel.carGoods;
    }else if (index == 3) {
        return self.infoModel.expressCompanyName;
    }else if (index == 4) {
        return self.infoModel.expressDriverName;
    }else if (index == 5) {
        return self.infoModel.expressDriverMobile;
    }else if (index == 6) {
        return self.infoModel.remark;
    }else {
        return @"";
    }
}

#pragma mark- get
- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.requestURL = kURL.order_car_getSendCarInfo;
            model.methodType = NetRequestMethodTypeGet;
            model.requestParameters = @{@"orderId":self.orderId};
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            //none
            if (resultModel.resultEffective) {
                self.dataCount = 7;
                self.infoModel = [CYTOrderSendCarInfoModel mj_objectWithKeyValues:resultModel.dataDictionary];
            }
        }];
    }
    return _requestCommand;
}

@end
