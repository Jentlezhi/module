//
//  CYTCarDealerChartItemVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarDealerChartItemVM.h"

@interface CYTCarDealerChartItemVM ()

@end

@implementation CYTCarDealerChartItemVM
@synthesize requestCommand = _requestCommand;

#pragma mark- flow control
- (void)ff_initWithModel:(id)model {
    [super ff_initWithModel:model];
    
    self.listArray = [NSMutableArray array];
}

#pragma mark- handleResponse
- (void)handleResponseModel:(FFBasicNetworkResponseModel *)responseModel {
    [self.listArray removeAllObjects];
    
    if (responseModel.resultEffective) {
        self.listArray = [CYTCarDealerChartItemModel mj_objectArrayWithKeyValuesArray:responseModel.dataDictionary[@"list"]];
        self.meSortModel = [CYTCarDealerChartItemModel mj_objectWithKeyValues:responseModel.dataDictionary[@"currentUser"]];
        if ([self.listArray containsObject:self.meSortModel]) {
            self.meSortModel = nil;
        }
    }
}

#pragma mark- get
- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.needHud = YES;
            model.methodType = NetRequestMethodTypeGet;
            model.requestURL = (self.type==CarDealerChartTypeGoodComment)?kURL.user_ranking_GetPraiseCountList:kURL.user_ranking_GetSaleCountList;
            model.requestParameters = @{};
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            [self handleResponseModel:resultModel];
        }];
    }
    return _requestCommand;
}

@end
