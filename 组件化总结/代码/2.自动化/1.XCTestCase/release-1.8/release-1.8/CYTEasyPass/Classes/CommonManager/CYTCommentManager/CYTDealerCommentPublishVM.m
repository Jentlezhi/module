//
//  CYTDealerCommentPublishVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTDealerCommentPublishVM.h"

@implementation CYTDealerCommentPublishVM
@synthesize requestCommand = _requestCommand;

- (void)ff_initWithModel:(FFExtendModel *)model {
    [super ff_initWithModel:model];
    self.model = model;
}

#pragma mark- get
- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        
        _requestCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.needHud = YES;
            model.requestURL = (self.type==CommentViewTypeUser)?kURL.user_evaluation_postServiceEval:kURL.express_evaluate_add;
            model.requestParameters = self.model.mj_keyValues.mutableCopy;
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            //none
        }];
    }
    return _requestCommand;
}

@end
