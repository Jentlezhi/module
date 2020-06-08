//
//  CYTHomeDataViewModel.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTHomeDataViewModel.h"
#import "CYTBannerInfoModel.h"
#import "CYTFunctionModel.h"
#import "CYTHomeCarSourceInfoModel.h"
#import "CYTStoreAuthModel.h"

@interface CYTHomeDataViewModel()

/** 特价车源 */
@property(strong, nonatomic) NSMutableDictionary *getRecommendCarSourceListPar;
/** 靠谱车商数据模型 */
@property(strong, nonatomic) CYTRootResponseModel *storeAuthListtResponseModel;
/** 平行进口车广告数据模型 */
@property(strong, nonatomic) CYTRootResponseModel *recommendResponseModel;
/** 特价车源数据模型 */
@property(strong, nonatomic) CYTRootResponseModel *carSourceListRootResponseModel;
///** 靠谱车商数据请求信号 */
@property(strong, nonatomic) RACSignal *storeAuthListSignal;
/** 平行进口车广告数据请求信号 */
@property(strong, nonatomic) RACSignal *recommendListSignal;
/** 特价车源数据请求信号 */
@property(strong, nonatomic) RACSignal *recommendCarSourceListSignal;

@end

@implementation CYTHomeDataViewModel


- (instancetype)init{
    if (self = [super init]) {
        //获取功能按键数据
        [self getFuntionArrayData];
        [self homeDataBasicConfig];
    }
    return self;
}

- (void)getFuntionArrayData {
    NSArray *images =   @[@"home_publishCarSource",@"home_publishFindCar",@"home_transport",@"home_ycb",@"home_carSourceManage",@"home_connectedMe",@"home_helpService"];
    
    NSString *help = kURL.kURL_Home_help;
    NSArray *protocol = @[@"cxt://car_source/publish_carsource",
                          @"cxt://seek_car/publish_seekcar",
                          @"cxt://logistics/home",
                          @"cxt://ycb/personalHome",
                          @"cxt://car_source/my_carsource_list",
                          @"cxt://contact/contact_me?tab=0",
                          help];
    
    NSArray *btnText =  @[@"发布车源",@"发布寻车",@"物流服务",@"领易车币",@"车源管理",@"联系我的",@"客服帮助"];
    
    NSMutableArray *functionArray = [NSMutableArray array];
    for (int i=0; i<images.count; i++) {
        CYTFunctionModel *item = [CYTFunctionModel new];
        item.imageUrl = images[i];
        item.protocol = protocol[i];
        item.btnText = btnText[i];
        if (i==images.count-1) {
            item.isNeedAuth = NO;
            item.isNeedLogIn = NO;
        }
        [functionArray addObject:item];
    }
    
    self.functionArray = [functionArray copy];
}

- (void)homeDataBasicConfig{
    _getBannerInfoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [CYTNetworkManager GET:kURL.basic_index_getBannerInfo parameters:nil dataTask:nil showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
                NSArray *list = [responseObject.dataDictionary valueForKey:@"list"];
                NSArray *bannerInfoModels = [CYTBannerInfoModel mj_objectArrayWithKeyValuesArray:list];
                [subscriber sendNext:bannerInfoModels];
                [subscriber sendCompleted];
            }];
            return nil;
        }];
        
    }];
    
    _getUnreadCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [CYTNetworkManager GET:kURL.message_center_getUnread parameters:nil dataTask:nil showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
            }];
            return nil;
        }];
    }];
    
    _getRecommendListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [self requestCarSourceListDataWithSubscriber:subscriber];
            return nil;
        }];
    }];

}
- (void)requestOtherData{
    RACSignal *storeAuthListSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [CYTNetworkManager GET:kURL.basic_index_getIndexStoreAuthList parameters:nil dataTask:nil showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
            self.storeAuthListtResponseModel.networkError = !responseObject.resultEffective;
            NSArray *list = [responseObject.dataDictionary valueForKey:@"list"];
            NSArray *storeAuthModels = [CYTStoreAuthModel mj_objectArrayWithKeyValuesArray:list];
            if (storeAuthModels.count) {
                self.storeAuthListtResponseModel.arrayData = storeAuthModels;
            }
            [subscriber sendNext:self.storeAuthListtResponseModel];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
    
    RACSignal *recommendListSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [CYTNetworkManager GET:kURL.basic_index_getIndexRecommendList parameters:nil dataTask:nil showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
            self.recommendResponseModel.networkError = !responseObject.resultEffective;
            NSArray *list = [responseObject.dataDictionary valueForKey:@"list"];
            NSArray *recommendLists = [CYTFunctionModel mj_objectArrayWithKeyValuesArray:list];
            if (recommendLists.count) {
                self.recommendResponseModel.arrayData = recommendLists;
            }
            [subscriber sendNext:self.recommendResponseModel];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
    
    RACSignal *recommendCarSourceListSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self requestCarSourceListDataWithSubscriber:subscriber];
        return nil;
    }];
    
    [self rac_liftSelector:@selector(finishRequestWithStoreAuthListData:recommendListData:carSourceListData:) withSignalsFromArray:@[storeAuthListSignal,recommendListSignal,recommendCarSourceListSignal]];
}

- (void)requestCarSourceListDataWithSubscriber:(id<RACSubscriber>)subscriber{
    if (self.requestType == CYTRequestTypeRefresh) {
        [self.getRecommendCarSourceListPar setValue:@"-1" forKey:@"lastId"];
    }
    [CYTNetworkManager GET:kURL.car_source_getRecommendCarSourceList parameters:self.getRecommendCarSourceListPar dataTask:nil showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
        self.carSourceListRootResponseModel.networkError = !responseObject.resultEffective;
        if (responseObject.resultEffective) {
            if (self.requestType == CYTRequestTypeRefresh) {
                [self.carSourceListRootResponseModel.arrayData removeAllObjects];
            }
            NSArray *list = [responseObject.dataDictionary valueForKey:@"list"];
            self.carSourceListRootResponseModel.isMore = [[responseObject.dataDictionary valueForKey:@"isMore"] boolValue];
            NSMutableArray *keyValursArray = [NSMutableArray array];
            [list enumerateObjectsUsingBlock:^(NSDictionary  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [keyValursArray addObject:[obj valueForKey:@"carSourceInfo"]];
            }];
            NSArray *modelsArray = [CYTHomeCarSourceInfoModel mj_objectArrayWithKeyValuesArray:keyValursArray];
            [self.carSourceListRootResponseModel.arrayData addObjectsFromArray:modelsArray];
            self.carSourceListRootResponseModel.nodata = !self.carSourceListRootResponseModel.arrayData.count;
            CYTHomeCarSourceInfoModel *homeCarSourceInfoModel = [self.carSourceListRootResponseModel.arrayData lastObject];
            [self.getRecommendCarSourceListPar setValue:homeCarSourceInfoModel.rowId forKey:@"lastId"];
        }else{
            self.carSourceListRootResponseModel.isMore = NO;
            if (self.requestType == CYTRequestTypeLoadMore) {
                [CYTToast errorToastWithMessage:CYTNetworkError];
            }
        }
        [subscriber sendNext:self.carSourceListRootResponseModel];
        [subscriber sendCompleted];
    }];
}

- (void)finishRequestWithStoreAuthListData:(CYTRootResponseModel *)storeAuthListData recommendListData:(CYTRootResponseModel *)recommendListData carSourceListData:(CYTRootResponseModel *)carSourceListDataData{
    !self.finishRequestData?:self.finishRequestData(storeAuthListData,recommendListData,carSourceListDataData);
}
- (CYTRootResponseModel *)storeAuthListtResponseModel{
    if (!_storeAuthListtResponseModel) {
        _storeAuthListtResponseModel = [CYTRootResponseModel new];
    }
    return _storeAuthListtResponseModel;
}

- (CYTRootResponseModel *)recommendResponseModel{
    if (!_recommendResponseModel) {
        _recommendResponseModel = [CYTRootResponseModel new];
    }
    return _recommendResponseModel;
}
- (CYTRootResponseModel *)carSourceListRootResponseModel{
    if (!_carSourceListRootResponseModel) {
        _carSourceListRootResponseModel = [CYTRootResponseModel new];
    }
    return _carSourceListRootResponseModel;
}

- (NSMutableDictionary *)getRecommendCarSourceListPar{
    if (!_getRecommendCarSourceListPar) {
        _getRecommendCarSourceListPar = [NSMutableDictionary dictionary];
    }
    return _getRecommendCarSourceListPar;
}

@end
