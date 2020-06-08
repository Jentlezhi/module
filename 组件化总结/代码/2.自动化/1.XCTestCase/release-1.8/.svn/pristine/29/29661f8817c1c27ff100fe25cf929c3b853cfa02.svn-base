//
//  CYTCarSourceTypeVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/31.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSourceTypeVM.h"

@implementation CYTCarSourceTypeVM
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
            model.methodType = NetRequestMethodTypeGet;
            model.requestURL = kURL.car_common_GetParallelImportCarTypeList;
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            if (resultModel.resultEffective) {
                //处理数组数据
                if (self.parallelImportCar) {
                    NSArray *list = resultModel.dataDictionary[@"list"];
                    NSMutableArray *tempArray = [NSMutableArray array];
                    [list enumerateObjectsUsingBlock:^(NSDictionary  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        CYTCarSourceTypeModel *model = CYTCarSourceTypeModel.new;
                        model.carSourceTypeId = [[obj valueForKey:@"value"] integerValue];
                        model.carSourceTypeName = [obj valueForKey:@"name"];
                        [tempArray addObject:model];
                    }];
                    [self.listArray addObject:tempArray];
                }else{
                    self.listArray = [CYTCarSourceTypeModel mj_objectArrayWithKeyValuesArray:resultModel.dataDictionary[@"list"]];
                    if (self.showAll) {
                        CYTCarSourceTypeModel *model = [CYTCarSourceTypeModel new];
                        model.carSourceTypeId = -1;
                        model.carSourceTypeName = @"全部";
                        [self.listArray insertObject:@[model] atIndex:0];
                    }

                }
            }
        }];
    }
    return _requestCommand;
}

@end
