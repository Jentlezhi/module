//
//  CYTBrandCacheVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBrandCacheVM.h"

@interface CYTBrandCacheVM ()
@property (nonatomic, strong) NSNumber *version;

@end

@implementation CYTBrandCacheVM
@synthesize requestCommand = _requestCommand;

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static CYTBrandCacheVM *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[CYTBrandCacheVM alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        //判断本地缓存是否存在，如果不存在则把初始化数据写入本地，否则无任何操作。
        NSFileManager *manager = [NSFileManager defaultManager];
        if (![manager fileExistsAtPath:[self brandCachePath]]) {
            NSString *txtPath = [[NSBundle mainBundle] pathForResource:@"MasterBrandMakeModelData" ofType:@"json"];
            NSData *data = [NSData dataWithContentsOfFile:txtPath];
            [self saveBrandDataToLocal:data];
        }
    }
    return self;
}

- (void)handleBrandCacheResponse:(FFBasicNetworkResponseModel *)responseModel {
    if (responseModel.resultEffective) {
        //删除外层数据，存储到本地
        NSDictionary *dic = responseModel.dataDictionary;
        NSData *data= [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        [self saveBrandDataToLocal:data];
    }
}

- (NSDictionary *)getBrandDictionaryFromLocal {
    NSData *data = [NSData dataWithContentsOfFile:[self brandCachePath]];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return dic;
}

//写入数据到本地
- (void)saveBrandDataToLocal:(NSData *)data {
    if (data) {
        [data writeToFile:[self brandCachePath] atomically:YES];
    }
}

- (NSNumber *)version {
    NSString *path = [self brandCachePath];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return [dic valueForKey:@"version"];
}

- (NSString *)brandCachePath {
    return [CYTTools filePath:kBrandsCachePath bindUser:NO];
}

- (NSArray *)groupNamesWithBrands {
    if (!self.brandArray) {
        return nil;
    }
    
    NSMutableArray *mutArray = [NSMutableArray array];
    for (int i=0; i<self.brandArray.count; i++) {
        CYTBrandGroupModel *item = self.brandArray[i];
        [mutArray addObject:item.groupName];
    }
    return mutArray;
}

#pragma mark- api
- (NSArray *)brandArray {
    if (!_brandArray) {
        NSDictionary *brandDic = [self getBrandDictionaryFromLocal];
        if (!brandDic) {
            return nil;
        }
        _brandArray = [CYTBrandGroupModel mj_objectArrayWithKeyValuesArray:[brandDic valueForKey:@"list"]];
    }
    return _brandArray;
}

- (NSArray *)groupNameArray {
    if (!_groupNameArray) {
        _groupNameArray = [self groupNamesWithBrands];
    }
    return _groupNameArray;
}

#pragma mark- get
- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.methodType = NetRequestMethodTypeGet;
            model.requestURL = kURL.car_common_getCarBrandSerialData;
            model.requestParameters = @{@"version":self.version};
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *responseModel) {
            [self handleBrandCacheResponse:responseModel];
        }];
    }
    return _requestCommand;
}


@end
