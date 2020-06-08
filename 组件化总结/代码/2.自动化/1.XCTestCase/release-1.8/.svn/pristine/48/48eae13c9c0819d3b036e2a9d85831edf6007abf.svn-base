//
//  CarFilterVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/11.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CarFilterVM.h"
#import "CYTCarSourceListModel.h"
#import "CYTSeekCarListModel.h"

@implementation CarFilterVM
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
            model.methodType = NetRequestMethodTypeGet;
            model.requestURL = (self.source==CarViewSourceCarSource)?kURL.car_source_getListByConditions:kURL.car_seek_getListByConditions;
            model.requestParameters = self.listRequestModel.mj_keyValues;
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *responseModel) {
            if (self.listRequestModel.lastId == 0) {
                //刷新
                [self.listArray removeAllObjects];
            }
            //数据处理
            if (responseModel.resultEffective) {
                if (self.source == CarViewSourceCarSource) {
                    NSArray *dataArray = [CYTCarSourceListModel mj_objectArrayWithKeyValuesArray:responseModel.dataDictionary[@"list"]];
                    self.isMore = [responseModel.dataDictionary[@"isMore"] boolValue];
                    
                    [self.listArray addObjectsFromArray:dataArray];
                    CYTCarSourceListModel *lastModel = [self.listArray lastObject];
                    if (lastModel) {
                        self.listRequestModel.lastId = lastModel.carSourceInfo.rowId;
                    }
                }else {
                    NSArray *dataArray = [CYTSeekCarListModel mj_objectArrayWithKeyValuesArray:responseModel.dataDictionary[@"list"]];
                    self.isMore = [responseModel.dataDictionary[@"isMore"] boolValue];
                    
                    [self.listArray addObjectsFromArray:dataArray];
                    CYTSeekCarListModel *lastModel = [self.listArray lastObject];
                    if (lastModel) {
                        self.listRequestModel.lastId = lastModel.seekCarInfo.rowId;
                    }
                }
            }
        }];
    }
    return _requestCommand;
}

- (CarFilterConditonRequestModel *)requestModel {
    if (!_requestModel) {
        _requestModel = [CarFilterConditonRequestModel new];
    }
    return _requestModel;
}

- (CarFilterConditionModel *)listRequestModel {
    if (!_listRequestModel) {
        _listRequestModel = [CarFilterConditionModel new];
    }
    return _listRequestModel;
}

@end
