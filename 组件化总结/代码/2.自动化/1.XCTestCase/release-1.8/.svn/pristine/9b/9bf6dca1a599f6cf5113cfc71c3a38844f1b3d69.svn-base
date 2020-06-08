//
//  CYTPublishProcedureVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPublishProcedureVM.h"

@implementation CYTPublishProcedureVM
@synthesize requestCommand = _requestCommand;

- (void)ff_initWithModel:(FFExtendModel *)model {
    [super ff_initWithModel:model];

    self.sectionNumber = 1;
    self.listArray = [NSMutableArray array];
    self.lastTitle = @"自定义手续时间";
}

- (NSString *)titleWithIndex:(NSIndexPath *)indexPath {
    if (self.sectionNumber == 1) {
        return self.lastTitle;
    }else {
        if (indexPath.section == 0) {
            NSDictionary *dic = self.listArray[indexPath.row];
            return dic[@"name"];
        }else {
            return self.lastTitle;
        }
    }
}

#pragma mark- get
- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.needHud = YES;
            model.methodType = NetRequestMethodTypeGet;
            model.requestURL = kURL.car_common_getCarProcedures;
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            [self.listArray removeAllObjects];
            self.sectionNumber = 1;
            if (resultModel.resultEffective) {
                self.listArray = [resultModel.dataDictionary[@"list"] mutableCopy];
                
                if (self.listArray.count == 0) {
                    self.sectionNumber = 1;
                }else {
                    self.sectionNumber = 2;
                }
            }
        }];
        
    }
    return _requestCommand;
}

@end
