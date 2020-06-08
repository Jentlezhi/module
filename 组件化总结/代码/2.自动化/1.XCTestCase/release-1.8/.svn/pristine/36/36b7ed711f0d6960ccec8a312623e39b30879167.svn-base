//
//  CYTFeedBackVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/11.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTFeedBackVM.h"

@implementation CYTFeedBackVM
@synthesize requestCommand = _requestCommand;
#pragma mark- get
- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.requestURL = kURL.user_feedback_add;
            model.requestParameters = @{@"title":@"意见反馈",
                                        @"content":self.content};
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *responseModel) {
            //
        }];
    }
    return _requestCommand;
}

@end
