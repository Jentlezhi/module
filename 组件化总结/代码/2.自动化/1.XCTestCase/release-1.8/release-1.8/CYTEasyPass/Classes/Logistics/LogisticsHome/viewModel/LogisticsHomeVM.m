//
//  LogisticsHomeVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/9.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "LogisticsHomeVM.h"
#import "LogisticsHomeModel.h"

@implementation LogisticsHomeVM
@synthesize requestCommand = _requestCommand;

- (void)ff_initWithModel:(FFExtendModel *)model {
    
}

#pragma mark- get
- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.requestURL = kURL.express_recommend_bestline;
            model.methodType = NetRequestMethodTypeGet;
            model.requestParameters = @{};
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            //none
            if (resultModel.resultEffective) {
                self.listArray = [LogisticsHomeModel mj_objectArrayWithKeyValuesArray:[resultModel.dataDictionary valueForKey:@"data"]];
            }
        }];
    }
    return _requestCommand;
}

- (RACCommand *)bannerCommand {
    if (!_bannerCommand) {
        _bannerCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.requestURL = kURL.basic_index_getBannerInfo;
            model.methodType = NetRequestMethodTypeGet;
            model.requestParameters = @{@"typeId":@(1)};
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            //none
            if (resultModel.resultEffective) {
                NSArray *list = [resultModel.dataDictionary valueForKey:@"list"];
                self.oriBannerList = [list copy];
                NSMutableArray *urlArray = [NSMutableArray array];
                for (NSDictionary *item in list) {
                    [urlArray addObject:[item valueForKey:@"bannerImageUrl"]];
                }
                self.bannerList = urlArray;
            }
        }];
    }
    return _bannerCommand;
}

@end
