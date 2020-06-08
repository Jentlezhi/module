//
//  CYTLogisticsOrderVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/10.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticsOrderVM.h"
#import "CYTLogisticsOrderListModel.h"

@implementation CYTLogisticsOrderVM
@synthesize requestCommand = _requestCommand;

- (void)ff_initWithModel:(id)model {
    [super ff_initWithModel:model];
    self.listArray = [NSMutableArray array];
}

- (NSDictionary *)getParameters {
    NSDictionary *dic = @{@"orderStatus":@(self.state),
                          @"lastId":@(self.lastId)};
    
    return dic;
}

#pragma mark- get
- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.needHud = NO;
            model.methodType = NetRequestMethodTypeGet;
            model.requestURL = kURL.order_express_getOrderList;
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
                NSArray *dataArray = [CYTLogisticsOrderListModel mj_objectArrayWithKeyValuesArray:listDic[@"list"]];
                self.isMore = [listDic[@"isMore"] boolValue];
                [self.listArray addObjectsFromArray:dataArray];
                
                CYTLogisticsOrderListModel *lastModel = [self.listArray lastObject];
                if (lastModel) {
                    self.lastId = lastModel.rowId;
                }
            }
        }];
    }
    return _requestCommand;
}

- (RACCommand *)affirmReceiveCarCommand {
    if (!_affirmReceiveCarCommand) {
        _affirmReceiveCarCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.needHud = YES;
            model.requestURL = kURL.order_express_sureorderover;
            model.requestParameters = @{@"orderId":self.orderId};
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            
        }];
    }
    return _affirmReceiveCarCommand;
}

@end
