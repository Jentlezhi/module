//
//  CYTDiscoverVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTDiscoverVM.h"

@interface CYTDiscoverVM ()

@end

@implementation CYTDiscoverVM
@synthesize requestCommand = _requestCommand;

#pragma mark- flow control
- (void)ff_initWithModel:(id)model {
    [super ff_initWithModel:model];
    
    self.listArray = [NSMutableArray array];
    
    CYTDiscoverModel_cell *model0 = [CYTDiscoverModel_cell new];
    model0.imageName = @"discover_moments";
    model0.flagName = @"车商圈";
    [self.listArray addObject:model0];
    
    CYTDiscoverModel_cell *model1 = [CYTDiscoverModel_cell new];
    model1.imageName = @"discover_search";
    model1.flagName = @"找车商";
    [self.listArray addObject:model1];
    
    CYTDiscoverModel_cell *model2 = [CYTDiscoverModel_cell new];
    model2.imageName = @"discover_chart";
    model2.flagName = @"车商榜";
    [self.listArray addObject:model2];
    
    CYTDiscoverModel_cell *model3 = [CYTDiscoverModel_cell new];
    model3.imageName = @"discover_currency";
    model3.flagName = @"易车币商城";
    [self.listArray addObject:model3];
    
}

#pragma mark- handleResponse
- (void)handleResponseModel:(FFBasicNetworkResponseModel *)responseModel {
    
}

#pragma mark- get
- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.needHud = NO;
            model.methodType = NetRequestMethodTypeGet;
            model.requestURL = nil;
            model.requestParameters = nil;
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            [self handleResponseModel:resultModel];
        }];
    }
    return _requestCommand;
}

@end
