//
//  CYTArrivalDateVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTArrivalDateVM.h"

@implementation CYTArrivalDateVM
@synthesize requestCommand = _requestCommand;

- (void)ff_initWithModel:(FFExtendModel *)model {
    [super ff_initWithModel:model];
    self.listArray = [NSMutableArray array];
}

#pragma mark- get
- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.needHud = YES;
            model.methodType = NetRequestMethodTypeGet;
            model.requestURL = kURL.car_common_getArrivalPortDate;
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            if (resultModel.resultEffective) {
                self.listArray = [CYTArrivalDateModel mj_objectArrayWithKeyValuesArray:resultModel.dataDictionary[@"list"]];
            }
        }];
    }
    return _requestCommand;
}

@end
