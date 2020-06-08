//
//  CYTMessageListVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTMessageListVM.h"

@implementation CYTMessageListVM
@synthesize requestCommand = _requestCommand;

- (void)ff_initWithModel:(FFExtendModel *)model {
    [super ff_initWithModel:model];
    self.listArray = [NSMutableArray array];
    
}

- (NSInteger)getNewestMessageId {
    if (self.listArray.count>0) {
        CYTMessageListModel *model = self.listArray[0];
        return model.messageId;
    }
    return 0;
}

#pragma mark- get
- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.needHud = NO;
            model.methodType = NetRequestMethodTypeGet;
            model.requestURL = kURL.message_center_list;
            model.requestParameters = @{@"type":@(self.categoryModel.type),
                                        @"lastId":@(self.lastId)}.mutableCopy;
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            if (self.lastId == 0) {
                [self.listArray removeAllObjects];
            }
            
            if (resultModel.resultEffective) {
                //解析数据
                NSArray *messageList = [CYTMessageListModel mj_objectArrayWithKeyValuesArray:resultModel.dataDictionary[@"list"]];
                self.isMore = [resultModel.dataDictionary[@"isMore"] integerValue];
                
                [self.listArray addObjectsFromArray:messageList];
                
                if (self.listArray.count>0) {
                    CYTMessageListModel *lastModel = [self.listArray lastObject];
                    self.lastId = lastModel.rowId;
                }
            }
        }];
    }
    return _requestCommand;
}

- (RACCommand *)sendStateCommand {
    if (!_sendStateCommand) {
        _sendStateCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.needHud = NO;
            model.requestURL = kURL.message_center_read;
            model.requestParameters = @{@"messageId":@(self.messageModel.messageId),
                                        @"type":@(self.categoryModel.type),
                                        @"isAll":@(self.isAll)}.mutableCopy;
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            if (resultModel.resultEffective) {
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:kMessageReadStateSendSuccceed object:nil];
            }
        }];
    }
    return _sendStateCommand;
}

@end
