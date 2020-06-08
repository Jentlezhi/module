//
//  CYTGetContactedMeListViewModel.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTGetContactedMeListViewModel.h"
#import "CYTGetContactedMeListModel.h"
#import "CYTContactRecordCarInfoModel.h"

@interface CYTGetContactedMeListViewModel()

/** 数据 */
@property(strong, nonatomic) CYTRootResponseModel *contactedMeListResponseModel;

@end

@implementation CYTGetContactedMeListViewModel

- (instancetype)init{
    if (self = [super init]) {
        [self getContactedMeList];
    }
    return self;
}

- (void)getContactedMeList{
    _getContactedMeListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            if (self.requestType == CYTRequestTypeRefresh) {
                self.getContactedMeListPar.lastId = @"-1";
            }
            [CYTNetworkManager GET:kURL.car_contactRecord_getContactedMeList parameters:self.getContactedMeListPar.mj_keyValues dataTask:nil showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
                NSArray *list = [responseObject.dataDictionary valueForKey:@"list"];
                BOOL isMore = [[responseObject.dataDictionary valueForKey:@"isMore"] boolValue];
                if (!self.contactedMeListResponseModel.arrayData.count && !responseObject.resultEffective) {
                    self.contactedMeListResponseModel.showNoNetworkView = YES;
                }else{
                    self.contactedMeListResponseModel.showNoNetworkView = NO;
                }
                
                if (responseObject.resultEffective) {
                    self.contactedMeListResponseModel.isMore = isMore;
                    self.contactedMeListResponseModel.showNoDataView = !list.count;
                    if (self.requestType == CYTRequestTypeRefresh) {
                        [self.contactedMeListResponseModel.arrayData removeAllObjects];
                    }

                    NSArray *requestArray = [CYTGetContactedMeListModel mj_objectArrayWithKeyValuesArray:list];
                    [self.contactedMeListResponseModel.arrayData addObjectsFromArray:requestArray];
                    CYTGetContactedMeListModel *contactedMeListModel = [self.contactedMeListResponseModel.arrayData lastObject];
                    self.getContactedMeListPar.lastId = contactedMeListModel.carInfo.rowId;
                    
                }else{
                    self.contactedMeListResponseModel.isMore = YES;
                    if (self.contactedMeListResponseModel.arrayData.count) {
                        [CYTToast errorToastWithMessage:CYTNetworkError];
                    }
                }
                [subscriber sendNext:self.contactedMeListResponseModel];
                [subscriber sendCompleted];
            }];
            return nil;
        }];
    }];
}

- (CYTGetContactedMeListPar *)getContactedMeListPar{
    if (!_getContactedMeListPar) {
        _getContactedMeListPar = [CYTGetContactedMeListPar new];
        _getContactedMeListPar.lastId = @"-1";
    }
    return _getContactedMeListPar;
}

- (CYTRootResponseModel *)contactedMeListResponseModel{
    if (!_contactedMeListResponseModel) {
        _contactedMeListResponseModel = [CYTRootResponseModel new];
    }
    return _contactedMeListResponseModel;
}

@end
