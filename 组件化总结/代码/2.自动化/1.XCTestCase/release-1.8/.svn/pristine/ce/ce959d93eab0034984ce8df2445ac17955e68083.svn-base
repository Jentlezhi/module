//
//  CYTLogisticsNeedVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/10.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticsNeedVM.h"

@implementation CYTLogisticsNeedVM
@synthesize requestCommand = _requestCommand;

- (void)ff_initWithModel:(id)model {
    [super ff_initWithModel:model];
    self.listArray = [NSMutableArray array];
}

- (NSDictionary *)getParameters {
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    [result setObject:@(self.state) forKey:@"State"];
    [result setObject:@(self.lastId) forKey:@"LastId"];
    [result setObject:@(20) forKey:@"Ps"];
    return result;
}

#pragma mark- get
- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.needHud = NO;
            model.requestURL = kURL.express_purpose_list;
            model.requestParameters = [self getParameters].mutableCopy;
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            if (self.lastId == 0) {
                //刷新
                [self.listArray removeAllObjects];
            }
            
            if (resultModel.resultEffective) {
                //数据处理
                NSDictionary *listDic = resultModel.dataDictionary;
                NSArray *dataArray = [CYTLogisticsNeedListModel mj_objectArrayWithKeyValuesArray:listDic[@"list"]];
                self.isMore = [listDic[@"isMore"] boolValue];
                [self.listArray addObjectsFromArray:dataArray];
                
                CYTLogisticsNeedListModel *lastModel = [self.listArray lastObject];
                if (lastModel) {
                    self.lastId = lastModel.rowId;
                }
            }
        }];
    }
    return _requestCommand;
}

@end
