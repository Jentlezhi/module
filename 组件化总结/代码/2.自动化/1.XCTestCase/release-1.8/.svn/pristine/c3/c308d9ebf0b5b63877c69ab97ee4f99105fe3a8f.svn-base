//
//  CYTFindCarListViewModel.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/4/27.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTFindCarListViewModel.h"

@implementation CYTFindCarListViewModel
@synthesize requestCommand = _requestCommand;

- (void)ff_initWithModel:(id)model {
    [super ff_initWithModel:model];
    
    self.listArray = [NSMutableArray array];
    self.requestModel = [CYTFindCarListRequestModel new];
}

- (NSString *)filterString:(NSDictionary *)filterDic {
    NSString *resultString = @"";
    
    NSArray *titleArray = @[@"",@"车系",@"省份",@"品牌",@"城市",@"车源类型"];
    NSArray *contentArray = [filterDic.allValues copy];
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
            model.requestURL = kURL.car_seek_list;
            NSDictionary *parameters = @{@"serialId":@(self.requestModel.serialId),
                                         @"sourceTypeId":@(self.requestModel.sourceTypeId),
                                         @"lastId":@(self.requestModel.lastId)};
            model.requestParameters = parameters;
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            if (self.requestModel.lastId == 0) {
                //刷新
                [self.listArray removeAllObjects];
            }
            
            //数据处理
            if (resultModel.resultEffective) {
                NSArray *dataArray = [CYTSeekCarListModel mj_objectArrayWithKeyValuesArray:resultModel.dataDictionary[@"list"]];
                self.isMore = [resultModel.dataDictionary[@"isMore"] boolValue];
                
                [self.listArray addObjectsFromArray:dataArray];
                CYTSeekCarListModel *lastModel = [self.listArray lastObject];
                if (lastModel) {
                    self.requestModel.lastId = lastModel.seekCarInfo.rowId;
                }
            }
        }];
    }
    return _requestCommand;
}

@end
