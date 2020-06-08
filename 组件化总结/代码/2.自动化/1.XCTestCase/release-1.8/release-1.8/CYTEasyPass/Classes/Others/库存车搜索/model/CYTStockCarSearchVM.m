//
//  CYTStockCarSearchVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/26.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTStockCarSearchVM.h"

@implementation CYTStockCarSearchVM
@synthesize requestCommand = _requestCommand;

- (void)ff_initWithModel:(id)model {
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
            model.requestURL = kURL.car_common_carReferPriceQuery;
            model.requestParameters = @{@"keyword":self.searchString,
                                        @"lastId":@(self.lastId),
                                        @"ps":@"20",}.mutableCopy;
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            if (self.lastId == 0) {
                //刷新
                [self.listArray removeAllObjects];
            }
            if (resultModel.resultEffective) {
                //数据处理
                NSDictionary *listDic = resultModel.dataDictionary;
                NSArray *dataArray = [CYTStockCarModel mj_objectArrayWithKeyValuesArray:listDic[@"list"]];
                self.isMore = [listDic[@"isMore"] boolValue];
                [self.listArray addObjectsFromArray:dataArray];
                CYTStockCarModel *lastModel = [self.listArray lastObject];
                if (lastModel) {
                    self.lastId = lastModel.lastId;
                }
            }
        }];
    }
    return _requestCommand;
}

@end
