//
//  CYTCarSourceListViewModel.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/4/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSourceListViewModel.h"

@implementation CYTCarSourceListViewModel
@synthesize requestCommand = _requestCommand;

- (void)ff_initWithModel:(id)model {
    [super ff_initWithModel:model];
    
    self.listArray = [NSMutableArray array];
    self.requestModel = [CYTCarSourceListRequestModel new];
}

- (NSString *)filterString:(NSDictionary *)filterDic {
    NSString *resultString = @"";
    NSMutableDictionary *mulDic = [filterDic mutableCopy];
    
    if ([filterDic objectForKey:@"bucunzaiziduan"]) {
        [mulDic removeObjectForKey:@"bucunzaiziduan"];
    }
    
    NSArray *titleArray = @[@"城市",@"车源类型",@"外饰颜色",@"内饰颜色",@"品牌",@"车系",@"价格"];
    NSArray *contentArray = [mulDic.allValues copy];
    for (int i=0; i<contentArray.count; i++) {
        NSString *str = contentArray[i];
        if (![str isEqualToString:@"全部"] && ![str isEqualToString:@""]) {
            str = [NSString stringWithFormat:@"%@:%@/ ",titleArray[i],str];
            resultString = [NSString stringWithFormat:@"%@%@",resultString,str];
        }
        
    }
    
    NSInteger len = resultString.length;
    if (len>2) {
        resultString = [resultString substringToIndex:len-2];
    }
    return resultString;
}

#pragma mark- get
- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.needHud = NO;
            model.methodType = NetRequestMethodTypeGet;
            model.requestURL = (self.type==ListTypeCarSource)?kURL.car_source_list:kURL.car_source_contactList;
            NSDictionary *par1 = self.requestModel.mj_keyValues;
            NSDictionary *par2 = @{@"lastId":@(self.requestModel.lastId)};
            model.requestParameters = (self.type==ListTypeCarSource)?par1.mutableCopy:par2.mutableCopy;
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            if (self.requestModel.lastId == 0) {
                //刷新
                [self.listArray removeAllObjects];
            }
            //数据处理
            if (resultModel.resultEffective) {
                NSArray *dataArray = [CYTCarSourceListModel mj_objectArrayWithKeyValuesArray:resultModel.dataDictionary[@"list"]];
                self.isMore = [resultModel.dataDictionary[@"isMore"] boolValue];
                
                [self.listArray addObjectsFromArray:dataArray];
                CYTCarSourceListModel *lastModel = [self.listArray lastObject];
                if (lastModel) {
                    self.requestModel.lastId = lastModel.carSourceInfo.rowId;
                }
            }
        }];
    }
    return _requestCommand;
}

@end
