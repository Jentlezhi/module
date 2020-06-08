//
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSourceSearchVM.h"
#import "CYTCarSourceListModel.h"
#import "CYTSeekCarListModel.h"

#define kHistoryMaxNumber   (10)

@interface CYTCarSearchVM ()

@end

@implementation CYTCarSearchVM

- (void)ff_initWithModel:(id)model {
    [super ff_initWithModel:model];
    
    self.listArray = [NSMutableArray array];
    self.historyList = [self getHistoryFromLocal].mutableCopy;
    self.type = SearchViewShowTypeHistory;
}

- (void)saveToLocalWithArray:(NSArray *)array {
    NSArray *jsonArray = [CYTCarSearchAssociateModel mj_keyValuesArrayWithObjectArray:array];
    [jsonArray writeToFile:[self getFilePath] atomically:YES];
}

- (NSArray *)getHistoryFromLocal {
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:[self getFilePath]]) {
        return @[];
    }else {
        return [CYTCarSearchAssociateModel mj_objectArrayWithFile:[self getFilePath]];
    }
}

- (NSString *)getFilePath {
    return [CYTTools filePath:CYTCarSourceSearchHistoryPath bindUser:YES];
}

#pragma mark- api
- (void)setSearchString:(NSString *)searchString {
    _searchString = searchString;
    [self.searchFinishedSubject sendNext:@"0"];
    [self beginSearching];
}

- (void)clearHistoryData {
    [self.historyList removeAllObjects];
    [self saveToLocalWithArray:self.historyList];
}

- (void)addSearchHistoryWithModel:(CYTCarSearchAssociateModel *)model {
    //判断是否有搜索记录，如果没有则增加。如果有不做任何处理
    if ([self.historyList indexOfObject:model] == NSNotFound) {
        [self.historyList insertObject:model atIndex:0];
    }
    
    //限制搜索历史保存数量最大值为 kHistoryMaxNumber
    NSInteger length = (self.historyList.count>10)?10:self.historyList.count;
    self.historyList = [self.historyList subarrayWithRange:NSMakeRange(0, length)].mutableCopy;
    //保存数据到本地
    [self saveToLocalWithArray:self.historyList];
}

- (void)beginSearching {
    FFBasicNetworkRequestModel *reqMod = [FFBasicNetworkRequestModel new];
    reqMod.needHud = NO;
    reqMod.requestURL = kURL.indexer_carmodel_search;
    reqMod.requestParameters = @{@"keyword":self.searchString};
    reqMod.httpHeadFiledDictionary = [CYTTools headFiledDictionary];
    
    [self.searchFinishedSubject sendNext:@"0"];
    @weakify(self);
    [self.request getWithModel:reqMod result:^(FFBasicNetworkResponseModel *responseObj1) {
        @strongify(self);
        
        CYTRequestResponseModel *cytResponse = [CYTRequestResponseModel mj_objectWithKeyValues:responseObj1.responseObject];
        FFBasicNetworkResponseModel * responseObject = responseObj1;
        responseObject.resultEffective = cytResponse.result;
        responseObject.resultMessage = cytResponse.message;
        responseObject.dataDictionary = cytResponse.data;
        responseObject.httpCode = cytResponse.errorCode;;
        
        //判断如果返回数据，对应于当前正在搜索的关键词则显示，否则不做任何操作。
        NSDictionary *requestDic = responseObj1.requestParameters.requestParameters;
        NSString *requestString = [requestDic valueForKey:@"keyword"];
        if ([self.searchString isEqualToString:requestString]) {
            [self.searchFinishedSubject sendNext:@"1"];
            self.listArray = [CYTCarSearchAssociateModel mj_objectArrayWithKeyValuesArray:responseObject.dataDictionary[@"list"]];
        }
        if (self.searchResultBlock) {
            self.searchResultBlock(responseObject);
        }
    }];
}

#pragma mark- get
- (RACSubject *)searchFinishedSubject {
    if (!_searchFinishedSubject) {
        _searchFinishedSubject = [RACSubject new];
    }
    return _searchFinishedSubject;
}

@end
