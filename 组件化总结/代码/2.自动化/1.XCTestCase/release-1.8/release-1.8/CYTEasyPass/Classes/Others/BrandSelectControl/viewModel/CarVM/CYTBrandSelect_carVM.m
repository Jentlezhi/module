//
//  CYTBrandSelect_carVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/4.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBrandSelect_carVM.h"
#import "CYTBrandSelectCarGroupModel.h"

@implementation CYTBrandSelect_carVM
@synthesize requestCommand = _requestCommand;

#pragma mark- get
- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.needHud = YES;
            model.requestURL = kURL.car_common_getGroupCarInfoListByModelId;
            model.methodType = NetRequestMethodTypeGet;
            model.requestParameters = @{@"serialId":@(self.seriesId)};
            
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            if (resultModel.resultEffective) {
                self.listArray = [CYTBrandSelectCarGroupModel mj_objectArrayWithKeyValuesArray:resultModel.dataDictionary[@"list"]];
            }
        }];
    }
    return _requestCommand;
}

@end
