//
//  CYTDealerCommentVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/2.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTDealerCommentVM.h"

@implementation CYTDealerCommentVM
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
            model.needHud = NO;
            model.requestURL = kURL.user_evaluation_getServiceEvalList;
            model.requestParameters = @{@"userId":self.userId,
                                        @"lastId":@(self.lastId),
                                        @"evalType":@(self.evalType)}.mutableCopy;
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            if (!resultModel.resultEffective) {
                return;
            }
            if (self.lastId == 0) {
                [self.listArray removeAllObjects];
            }
            //获取数量
            self.countModel = [CYTDealerCommentCountModel mj_objectWithKeyValues:resultModel.dataDictionary[@"count"]];
            
            //获取list
            NSArray *comment = [CYTDealerCommentListModel mj_objectArrayWithKeyValuesArray:resultModel.dataDictionary[@"list"]];
            [self.listArray addObjectsFromArray:comment];
            
            //获取lastId
            if (self.listArray.count>0) {
                CYTDealerCommentListModel *lastModel = [self.listArray lastObject];
                self.lastId = lastModel.lastId.integerValue;
            }
        }];
    }
    return _requestCommand;
}

@end
