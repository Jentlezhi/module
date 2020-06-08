//
//  CYTCarTradeCircleViewModel.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/22.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarTradeCircleViewModel.h"

@implementation CYTCarTradeCircleViewModel

- (RACCommand *)submitCommand {
    if (!_submitCommand) {
        _submitCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.requestURL = kURL.user_moments_post;
            model.needHud = YES;
            NSString *userId = CYTUserId;
            NSArray *imageURLs = [self getImageIDArray];
            NSDictionary *parameters = @{@"mediaProps":imageURLs,
                                         @"content":self.contentString,
                                         @"userId":userId};
            model.requestParameters = parameters;
            
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            //none
        }];
    }
    return _submitCommand;
}

- (RACCommand *)deleteCommand {
    if (!_deleteCommand) {
        _deleteCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.requestURL = kURL.user_moments_delete;
            model.needHud = YES;
            model.requestParameters = @{@"momentId":self.momentId};
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            //none
        }];
    }
    return _deleteCommand;
}

- (NSArray *)getImageIDArray{
    NSMutableArray *mulArray = [NSMutableArray array];
    
    for (int i=0; i<self.imageIdArray.count; i++) {
        NSString *string = self.imageIdArray[i];
        NSDictionary *dic = @{@"FileID":string};
        [mulArray addObject:dic];
    }
    
    return mulArray;
}

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

@end
