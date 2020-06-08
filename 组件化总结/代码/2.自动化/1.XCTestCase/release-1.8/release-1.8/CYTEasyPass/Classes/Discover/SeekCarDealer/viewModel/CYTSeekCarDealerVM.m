//
//  CYTSeekCarDealerVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTSeekCarDealerVM.h"

@interface CYTSeekCarDealerVM ()

@end

@implementation CYTSeekCarDealerVM
@synthesize requestCommand = _requestCommand;

#pragma mark- flow control
- (void)ff_initWithModel:(id)model {
    [super ff_initWithModel:model];
    
    self.type = SeekCarDealerTypeHistory;
    self.listArray = [NSMutableArray array];
    self.historyList = [self getHistoryFromLocal].mutableCopy;
}

- (void)saveToLocalWithArray:(NSArray *)array {
    [array writeToFile:[self getFilePath] atomically:YES];
}

- (NSArray *)getHistoryFromLocal {
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:[self getFilePath]]) {
        return @[];
    }else {
        return [NSArray arrayWithContentsOfFile:[self getFilePath]];
    }
}

- (NSString *)getFilePath {
    return [CYTTools filePath:CYTSeekCarDealerSearchHistoryPath bindUser:YES];
}

- (void)clearHistoryData {
    [self.historyList removeAllObjects];
    [self saveToLocalWithArray:self.historyList];
}

#pragma mark- set
- (void)setSearchString:(NSString *)searchString {
    _searchString = searchString;
    //排序、排重保存搜索历史
    [self handleSearchString:searchString];
}

- (void)handleSearchString:(NSString *)string {
    NSInteger index = [self.historyList indexOfObject:string];
    if (index!=NSNotFound) {
        [self.historyList removeObject:string];
    }
    [self.historyList insertObject:string atIndex:0];
    NSRange range = NSMakeRange(0, MIN(10, self.historyList.count));
    self.historyList = [self.historyList subarrayWithRange:range].mutableCopy;
    [self saveToLocalWithArray:self.historyList];
}

#pragma mark- handleResponse
- (void)handleResponseModel:(FFBasicNetworkResponseModel *)responseModel {
    if (self.lastId==-1) {
        [self.listArray removeAllObjects];
    }
    
    if (responseModel.resultEffective) {
        NSArray *dealerArray = [CYTDealer mj_objectArrayWithKeyValuesArray:responseModel.dataDictionary[@"list"]];
        [self.listArray addObjectsFromArray:dealerArray];
        if (self.listArray.count>0) {
            CYTDealer *lastObj = self.listArray[self.listArray.count-1];
            self.lastId = lastObj.rowId;
        }
        self.isMore = [[responseModel.dataDictionary objectForKey:@"isMore"] boolValue];
    }
}

#pragma mark- get
- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.needHud = YES;
            model.methodType = NetRequestMethodTypeGet;
            model.requestURL = kURL.user_info_searchDealer;
            model.requestParameters = @{@"keyword":self.searchString,
                                        @"lastId":@(self.lastId),
                                        };
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            [self handleResponseModel:resultModel];
        }];
    }
    return _requestCommand;
}

@end
