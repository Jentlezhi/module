//
//  CYTGetMyContactListViewModel.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTGetMyContactListViewModel.h"
#import "CYTGetMyContactListPar.h"
#import "CYTCarSourceListModel.h"
#import "CYTSeekCarListModel.h"
#import "CYTCarSourceInfo.h"
#import "CYTSeekCarInfo.h"

@interface CYTGetMyContactListViewModel()

/** 数据 */
@property(strong, nonatomic) CYTRootResponseModel *myContactListResponseModel;
/** 请求参数 */
@property(strong, nonatomic) CYTGetMyContactListPar *myContactCarSourcePar;
/** 请求参数 */
@property(strong, nonatomic) CYTGetMyContactListPar *myContactSeekCarPar;

@end

@implementation CYTGetMyContactListViewModel

- (instancetype)init{
    if (self = [super init]) {
        [self getMyContactList];
    }
    return self;
}

- (void)getMyContactList{
    _getMyContactedCarSourceListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [self requestWithCarSource:YES subscriber:subscriber];
            return nil;
        }];
    }];
    
    _getMyContactedSeekCarListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [self requestWithCarSource:NO subscriber:subscriber];
            return nil;
        }];
    }];
}

- (void)requestWithCarSource:(BOOL)carSource subscriber:(id<RACSubscriber>)subscriber{
    if (self.requestType == CYTRequestTypeRefresh) {
        self.myContactSeekCarPar.lastId = @"-1";
        self.myContactCarSourcePar.lastId = @"-1";
    }
    NSString *requestUrl;
    NSDictionary *requestParDict;
    if (carSource) {
        requestUrl = kURL.car_source_contactList;
        requestParDict = self.myContactCarSourcePar.mj_keyValues;
    }else{
        requestUrl = kURL.car_seek_GetMyContactedSeekCarList;
        requestParDict = self.myContactSeekCarPar.mj_keyValues;
    }
    [CYTNetworkManager GET:requestUrl parameters:requestParDict dataTask:nil showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
        NSArray *list = [responseObject.dataDictionary valueForKey:@"list"];
        BOOL isMore = [[responseObject.dataDictionary valueForKey:@"isMore"] boolValue];
        if (!self.myContactListResponseModel.arrayData.count && !responseObject.resultEffective) {
            self.myContactListResponseModel.showNoNetworkView = YES;
        }else{
            self.myContactListResponseModel.showNoNetworkView = NO;
        }
        if (responseObject.resultEffective) {
            self.myContactListResponseModel.isMore = isMore;
            self.myContactListResponseModel.showNoDataView = !list.count;
            if (self.requestType == CYTRequestTypeRefresh) {
                [self.myContactListResponseModel.arrayData removeAllObjects];
            }
            if (carSource) {
                NSArray *requestArray = [CYTCarSourceListModel mj_objectArrayWithKeyValuesArray:list];
                [self.myContactListResponseModel.arrayData addObjectsFromArray:requestArray];
                CYTCarSourceListModel *carSourceListModel = [self.myContactListResponseModel.arrayData lastObject];
                self.myContactCarSourcePar.lastId = [NSString stringWithFormat:@"%ld",(long)carSourceListModel.carSourceInfo.rowId];
                
            }else{
                NSArray *requestArray  = [CYTSeekCarListModel mj_objectArrayWithKeyValuesArray:list];
                [self.myContactListResponseModel.arrayData addObjectsFromArray:requestArray];
                CYTSeekCarListModel *seekCarListModel = [self.myContactListResponseModel.arrayData lastObject];
                self.myContactSeekCarPar.lastId = [NSString stringWithFormat:@"%ld",(long)seekCarListModel.seekCarInfo.rowId];
            }
        }else{
            self.myContactListResponseModel.isMore = YES;
            if (self.myContactListResponseModel.arrayData.count) {
                [CYTToast errorToastWithMessage:CYTNetworkError];
            }
        }
        [subscriber sendNext:self.myContactListResponseModel];
        [subscriber sendCompleted];
    }];
}

- (CYTGetMyContactListPar *)myContactCarSourcePar{
    if (!_myContactCarSourcePar) {
        _myContactCarSourcePar = [CYTGetMyContactListPar new];
        _myContactCarSourcePar.lastId = @"-1";
    }
    return _myContactCarSourcePar;
}

- (CYTGetMyContactListPar *)myContactSeekCarPar{
    if (!_myContactSeekCarPar) {
        _myContactSeekCarPar = [CYTGetMyContactListPar new];
        _myContactSeekCarPar.lastId = @"-1";
    }
    return _myContactSeekCarPar;
}

- (CYTRootResponseModel *)myContactListResponseModel{
    if (!_myContactListResponseModel) {
        _myContactListResponseModel = [CYTRootResponseModel new];
    }
    return _myContactListResponseModel;
}

@end
