//
//  CYTDealerAuthImageVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/2.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTDealerAuthImageVM.h"

@implementation CYTDealerAuthImageVM
@synthesize requestCommand = _requestCommand;

- (void)ff_initWithModel:(FFExtendModel *)model {
    [super ff_initWithModel:model];
    
    self.listArray = [NSMutableArray array];
}

#pragma mark- get
- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.needHud = YES;
            model.requestURL = kURL.user_authorization_getAuthImageList;
            //返回类型：1=仅返回企业认证图片 2=实店认证图片 3=返回企业认证图片+实店认证图片
            NSString *type = (self.onlyEntityShow)?@"2":@"3";
            model.requestParameters = @{@"userId":self.userId,
                                        @"typeId":type}.mutableCopy;
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            [self.listArray removeAllObjects];
            if (resultModel.resultEffective) {
                self.listArray = [CYTDealerAuthImageModel mj_objectArrayWithKeyValuesArray:resultModel.dataDictionary[@"list"]];
            }
        }];
    }
    return _requestCommand;
}

@end
