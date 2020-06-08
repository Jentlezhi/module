//
//  CYTMessageCategoryVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTMessageCategoryVM.h"

@implementation CYTMessageCategoryVM
@synthesize requestCommand = _requestCommand;

- (void)ff_initWithModel:(FFExtendModel *)model {
    [super ff_initWithModel:model];
    self.listArray = [NSMutableArray array];
}

- (void)handleRequestDataWithResponseModel:(FFBasicNetworkResponseModel *)responseModel {
    [self.listArray removeAllObjects];
    
    if (responseModel.resultEffective) {
        //填充数据
        self.listArray = [CYTMessageCategoryModel mj_objectArrayWithKeyValuesArray:responseModel.dataDictionary[@"list"]];
    }else {
        //使用默认数据
        CYTMessageCategoryModel *model0 = [CYTMessageCategoryModel new];
        model0.num = 0;
        model0.typeName = @"公告";
        model0.type = 1;
        model0.time = @"";
        model0.lastMessageTitle = @"暂无";
        
        CYTMessageCategoryModel *model1 = [CYTMessageCategoryModel new];
        model1.num = 0;
        model1.type = 2;
        model1.typeName = @"活动通知";
        model1.time = @"";
        model1.lastMessageTitle = @"暂无";
        
        CYTMessageCategoryModel *model2 = [CYTMessageCategoryModel new];
        model2.num = 0;
        model2.type = 3;
        model2.typeName = @"与我相关";
        model2.time = @"";
        model2.lastMessageTitle = @"暂无";
        
        [self.listArray addObject:model0];
        [self.listArray addObject:model1];
        [self.listArray addObject:model2];
    }
    
    //设置未读消息数量
    NSInteger total=0;
    for (CYTMessageCategoryModel *model in self.listArray) {
        total += model.num;
    }
    
    [CYTMessageCenterVM manager].badgeNumber = total;
}

- (void)clearAllMessageWithType:(NSInteger)type {
    for (CYTMessageCategoryModel *model in self.listArray) {
        if (model.type == type) {
            model.num = 0;
        }
    }
}

#pragma mark- get
- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.needHud = NO;
            model.methodType = NetRequestMethodTypeGet;
            model.requestURL = kURL.message_center_typeList;
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            //构建数据
            [self handleRequestDataWithResponseModel:resultModel];
        }];
    }
    return _requestCommand;
}

@end
