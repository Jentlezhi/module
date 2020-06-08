//
//  CYTDealerHisHomeVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/28.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTDealerHisHomeVM.h"

@interface CYTDealerHisHomeVM ()
@property (nonatomic, assign) NSInteger commentCount;
@property (nonatomic, assign) NSInteger carFriendsCount;
@property (nonatomic, assign) NSInteger onSaleCarCount;

@end

@implementation CYTDealerHisHomeVM
@synthesize requestCommand = _requestCommand;

- (void)ff_initWithModel:(FFExtendModel *)model {
    [super ff_initWithModel:model];
    
    _sectionNumber = 0;
}

- (NSInteger)rowNumberWithSection:(NSInteger)section {
    switch (section) {
        case 0:
        case 1:
            return 1;
        case 2:
            return self.commentArray.count;
        case 3:
            return self.carFriendsArray.count;
        case 4:
            return self.onSaleCarArray.count;
        default:
            return 0;
    }
}

- (NSString *)titleForSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"认证信息";
        case 1:
        {
            return [NSString stringWithFormat:@"服务评价（%ld）",self.commentCount];
        }
        case 2:
        {
            return [NSString stringWithFormat:@"车商圈（%ld）",self.carFriendsCount];
        }
        case 3:
        {
            return [NSString stringWithFormat:@"在售车源（%ld）",self.onSaleCarCount];
        }
        default:
            break;
    }
    return @"";
}

#pragma mark- get
- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.needHud = YES;
            model.requestURL = kURL.user_info_getpersonalhomepageinfo;
            model.requestParameters = @{@"userId":self.userId,
                                        @"typeId":@(31)}.mutableCopy;
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            if (!resultModel.resultEffective) {
                self.sectionNumber = 0;
                return ;
            }
            
            //获取数据模型
            self.sectionNumber = 5;
            
            self.homeModel = [CYTDealerHomeModel mj_objectWithKeyValues:resultModel.dataDictionary];
            self.commentArray = [self.homeModel.serviceEval.list copy];
            self.carFriendsArray = [self.homeModel.moment.list copy];
            self.onSaleCarArray = [self.homeModel.inSaleCar.list copy];
            
            self.commentCount = self.homeModel.serviceEval.totalCount.integerValue;
            self.carFriendsCount = self.homeModel.moment.totalCount.integerValue;
            self.onSaleCarCount = self.homeModel.inSaleCar.totalCount.integerValue;
        }];
    }
    return _requestCommand;
}

@end
