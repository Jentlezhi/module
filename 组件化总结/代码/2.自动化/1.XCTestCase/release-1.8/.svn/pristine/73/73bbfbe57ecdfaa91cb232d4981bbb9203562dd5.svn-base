//
//  CYTAddressAddOrModifyVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/23.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAddressAddOrModifyVM.h"

@implementation CYTAddressAddOrModifyVM
@synthesize requestCommand = _requestCommand;

- (void)ff_initWithModel:(FFExtendModel *)model {
    [super ff_initWithModel:model];
}

- (NSString *)chooseContent {
    if (self.addressModel) {
        NSString *province = (self.addressModel.provinceName)?:@"";
        NSString *city = (self.addressModel.cityName)?:@"";
        NSString *couty = (self.addressModel.countyName)?:@"";
        if (province.length ==0 &&city.length == 0 && couty.length ==0) {
            return @"";
        }
        return [NSString stringWithFormat:@"%@ %@ %@",province,city,couty];
    }
    return @"";
}

- (NSString *)detailContent {
    if (self.addressModel) {
        return (self.addressModel.addressDetail)?:@"";
    }
    return @"";
}

- (NSDictionary *)getParameters {
    
    NSInteger receivingId = (self.addressAdd)?0:self.addressModel.receivingId.integerValue;
    BOOL isDefault = (self.addressAdd)?NO:self.addressModel.isDefault;
    
    NSDictionary *parameters = @{@"address":self.addressModel.addressDetail,
                                 @"isDefault":@(isDefault),
                                 @"cityId":self.addressModel.cityId,
                                 @"countyId":@(self.addressModel.countyId),
                                 @"receivingId":@(receivingId),
                                 };
    return parameters;
}

#pragma mark- get
- (RACCommand *)requestCommand {
    if (!_requestCommand) { 
        _requestCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.needHud = YES;
            model.requestURL = kURL.user_address_addOrUpdate;
            model.requestParameters = [self getParameters].mutableCopy;
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            //none
        }];
    }
    return _requestCommand;
}

@end
