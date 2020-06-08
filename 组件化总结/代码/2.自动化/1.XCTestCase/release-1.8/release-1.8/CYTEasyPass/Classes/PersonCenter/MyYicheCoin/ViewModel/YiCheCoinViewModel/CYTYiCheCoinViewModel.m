//
//  CYTYiCheCoinViewModel.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/22.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTYiCheCoinViewModel.h"
#import "CYTCoinSectionModel.h"
#import "CYTTaskModel.h"
#import "CYTGoodsModel.h"
#import "CYTIndicatorView.h"

@implementation CYTYiCheCoinViewModel

- (instancetype)init{
    if (self = [super init]){
        [self yiCheCoinBasicConfig];
    }
    return self;
}

- (void)yiCheCoinBasicConfig{
    //签到
    _signInCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            CYTIndicatorView *indicatorView =[CYTIndicatorView showIndicatorViewWithType:CYTIndicatorViewTypeEditNavBar];
            indicatorView.infoMessage = @"";
            [CYTNetworkManager POST:kURL.user_ycbhome_signin parameters:nil dataTask:nil showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
                [CYTIndicatorView hideIndicatorView];
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
            }];
            return nil;
        }];
    }];
}

- (void)requestData{
    RACSignal *signInStateSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [CYTNetworkManager GET:kURL.user_ycbhome_SignInState parameters:nil dataTask:nil showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        }];
        return nil;
    }];

    //清空数据
    [self.sectionModels removeAllObjects];

    RACSignal *goodsSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [CYTNetworkManager GET:kURL.user_ycbhome_goods parameters:nil dataTask:nil showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
            NSArray *goodsList = responseObject.dataDictionary[@"goods"];
            NSArray *goodsModels = [CYTGoodsModel mj_objectArrayWithKeyValuesArray:goodsList];
            if (goodsModels.count) {
                CYTCoinSectionModel *model0 = CYTCoinSectionModel.new;
                model0.title = @"兑换商品";
                model0.content = @"进入易车币商城";
                model0.items = @[goodsModels];
                [self.sectionModels insertObject:model0 atIndex:0];
            }
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        }];
        return nil;
    }];

    RACSignal *tasksSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [CYTNetworkManager GET:kURL.user_ycbhome_tasks parameters:nil dataTask:nil showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
            NSArray *tasks = responseObject.dataDictionary[@"tasks"];
            NSString *commonTaskDesc = responseObject.dataDictionary[@"commonTaskDesc"];
            NSArray <CYTTaskModel*>*taskModels = [CYTTaskModel mj_objectArrayWithKeyValuesArray:tasks];
            NSMutableArray *greenHandTaskModels = [NSMutableArray array];
            NSMutableArray *activityTaskModels = [NSMutableArray array];

//            CYTTaskModel * _Nonnull taskModel0 =  CYTTaskModel.new;
//            taskModel0.title = @"测试";
//            taskModel0.taskType = 1;
//            taskModel0.taskStatus = 2;
//            [greenHandTaskModels addObject:taskModel0];


            [taskModels enumerateObjectsUsingBlock:^(CYTTaskModel * _Nonnull taskModel, NSUInteger idx, BOOL * _Nonnull stop) {
                if (taskModel.taskType == 1) {
//                                            taskModel.taskStatus = 1;
                    [greenHandTaskModels addObject:taskModel];
                }else if (taskModel.taskType == 3){
//                                            taskModel.taskStatus = 2;
                    [activityTaskModels addObject:taskModel];
                }
            }];
            if (greenHandTaskModels.count) {
                CYTCoinSectionModel *model1 = CYTCoinSectionModel.new;
                model1.title = @"新手任务";
                model1.items = greenHandTaskModels;
                [self.sectionModels addObject:model1];
            }
            if (activityTaskModels.count) {
                CYTCoinSectionModel *model2 = CYTCoinSectionModel.new;
                model2.title = @"活动任务";
                model2.items = activityTaskModels;
                [self.sectionModels addObject:model2];
            }
            if (commonTaskDesc.length) {
                CYTCoinSectionModel *model3 = CYTCoinSectionModel.new;
                model3.title = @"常规奖励";
                CYTTaskModel *taskMode = CYTTaskModel.new;
                taskMode.rewardContent = commonTaskDesc;
                model3.items = @[taskMode];
                [self.sectionModels addObject:model3];
            }
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        }];
        return nil;
    }];

    [self rac_liftSelector:@selector(finishRequestWithSignInStateData:goodsData:tasks:) withSignalsFromArray:@[signInStateSignal,goodsSignal,tasksSignal]];
}

- (void)finishRequestWithSignInStateData:(CYTNetworkResponse *)signInStateData goodsData:(CYTNetworkResponse *)goodsData tasks:(CYTNetworkResponse *)tasksData{
    !self.finishRequestData?:self.finishRequestData(signInStateData,goodsData,tasksData);
}

#pragma mark - 懒加载
- (NSMutableArray *)sectionModels{
    if (!_sectionModels) {
        _sectionModels = [NSMutableArray array];
    }
    return _sectionModels;
}
@end
