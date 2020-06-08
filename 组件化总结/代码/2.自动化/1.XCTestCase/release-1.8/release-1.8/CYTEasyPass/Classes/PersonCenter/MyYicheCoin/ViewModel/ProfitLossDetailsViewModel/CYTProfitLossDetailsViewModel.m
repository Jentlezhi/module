//
//  CYTProfitLossDetailsViewModel.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/22.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTProfitLossDetailsViewModel.h"
#import "CYTCoinRecordPar.h"

@interface CYTProfitLossDetailsViewModel()
/** 收支明细数据 */
@property(strong, nonatomic) CYTRootResponseModel *detailsResponseModel;
/** 请求参数 */
@property(strong, nonatomic) CYTCoinRecordPar *coinRecordPar;

@end

@implementation CYTProfitLossDetailsViewModel

- (instancetype)init{
    if (self = [super init]){
        [self profitLossDetailsBasicConfig];
    }
    return self;
}

- (void)profitLossDetailsBasicConfig{
    //获取收支明细
    _getCoinRecordsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            if (self.requestType == CYTRequestTypeRefresh) {
                self.coinRecordPar.lastId = @"-1";
            }
            [CYTNetworkManager GET:kURL.user_ycbhome_ycbRecords parameters:self.coinRecordPar.mj_keyValues dataTask:nil showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
                self.detailsResponseModel.networkError = !responseObject.resultEffective;
                if (responseObject.resultEffective) {
                    if (self.requestType == CYTRequestTypeRefresh) {
                        [self.detailsResponseModel.arrayData removeAllObjects];
                    }
                    NSArray *list = [responseObject.dataDictionary valueForKey:@"records"];
                    self.detailsResponseModel.isMore = [[responseObject.dataDictionary valueForKey:@"isMore"] boolValue];
                    NSArray *modelsArray = [CYTCoinRecordModel mj_objectArrayWithKeyValuesArray:list];
                    [self.detailsResponseModel.arrayData addObjectsFromArray:modelsArray];
                    self.detailsResponseModel.nodata = !self.detailsResponseModel.arrayData.count;
                    CYTCoinRecordModel *recordModel = [self.detailsResponseModel.arrayData lastObject];
                    self.coinRecordPar.lastId = recordModel.rowId;
                }else{
                    self.detailsResponseModel.isMore = NO;
                    if (!self.detailsResponseModel.arrayData) {
                        [CYTToast errorToastWithMessage:CYTNetworkError];
                    }
                }
                [subscriber sendNext:self.detailsResponseModel];
                [subscriber sendCompleted];
            }];
            return nil;
        }];
    }];
}

- (CYTRootResponseModel *)detailsResponseModel{
    if (!_detailsResponseModel) {
        _detailsResponseModel = CYTRootResponseModel.new;
    }
    return _detailsResponseModel;
}

- (CYTCoinRecordPar *)coinRecordPar{
    if (!_coinRecordPar) {
        _coinRecordPar = CYTCoinRecordPar.new;
    }
    return _coinRecordPar;
}

@end
