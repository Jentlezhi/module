//
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAddressDataWNCManager.h"

@interface CYTAddressDataWNCManager()
///path
@property (nonatomic, copy) NSString *path;
///文件版本号
@property (nonatomic, assign) NSInteger version;

@end

@implementation CYTAddressDataWNCManager
@synthesize requestCommand = _requestCommand;

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static CYTAddressDataWNCManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[CYTAddressDataWNCManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        self.addressModel = [CYTAddressDataWNCModel new];
        self.addressModel.oriAreaId = -10;
        self.showArea = YES;
        //获取路径
        self.path = [CYTTools filePath:kCitiesCachePath bindUser:NO];
        
        //如果本地文件不存在则写入
        NSFileManager *manager = [NSFileManager defaultManager];
        if (![manager fileExistsAtPath:self.path]) {
            NSString *txtPath = [[NSBundle mainBundle] pathForResource:@"provinceCityWNC" ofType:@"json"];
            NSData *data = [NSData dataWithContentsOfFile:txtPath];
            [data writeToFile:self.path atomically:YES];
        }
        
        //解析本地数据
        [self handleModelFromLoacal];
        
    }
    return self;
}

- (void)handleModelFromLoacal {
    //获取大区数据
    [self getAreaData];

    //获取直辖市，省份数据
    NSData *addressData = [NSData dataWithContentsOfFile:self.path];
    NSDictionary *addressDic = [NSJSONSerialization JSONObjectWithData:addressData options:NSJSONReadingMutableContainers error:nil];
    CYTRequestResponseModel *responseModel = [CYTRequestResponseModel mj_objectWithKeyValues:addressDic];
    if (responseModel.result) {
        NSInteger version = [responseModel.data[@"version"] integerValue];
        self.version = version;
        NSArray *listArray = [CYTAddressDataProvinceModel mj_objectArrayWithKeyValuesArray:responseModel.data[@"list"]];
        if (listArray && listArray.count == 2) {
            self.plCityModel = listArray[0];
            self.plCityListArray = [self.plCityModel.provinces mutableCopy];
            self.provinceModel = listArray[1];
            self.provinceListArray = [self.provinceModel.provinces mutableCopy];
        }
    }
}

- (void)getAreaData {
    self.areaListArray = [NSMutableArray array];
    
    CYTAddressDataItemModel *itemModel0 = [CYTAddressDataItemModel new];
    itemModel0.name = @"全国";
    itemModel0.locationGroupID = 0;
    itemModel0.idCode = -1;
    
    CYTAddressDataItemModel *itemModel1 = [CYTAddressDataItemModel new];
    itemModel1.name = @"东区";
    itemModel1.locationGroupID = 3;
    itemModel1.idCode = -1;
    
    CYTAddressDataItemModel *itemModel2 = [CYTAddressDataItemModel new];
    itemModel2.name = @"南区";
    itemModel2.locationGroupID = 2;
    itemModel2.idCode = -1;
    
    CYTAddressDataItemModel *itemModel3 = [CYTAddressDataItemModel new];
    itemModel3.name = @"西区";
    itemModel3.locationGroupID = 4;
    itemModel3.idCode = -1;
    
    CYTAddressDataItemModel *itemModel4 = [CYTAddressDataItemModel new];
    itemModel4.name = @"北区";
    itemModel4.locationGroupID = 1;
    itemModel4.idCode = -1;
    
    CYTAddressDataProvinceModel *areaModel = [CYTAddressDataProvinceModel new];
    areaModel.groupName = @"选择大区";
    areaModel.provinces = @[itemModel0,itemModel1,itemModel2,itemModel3,itemModel4];
    
    self.areaListArray = areaModel.provinces;
    self.areaModel = areaModel;
}

#pragma mark- method
- (void)cleanAllModelCache {
    self.titleString = @"";
    self.showArea = YES;
    self.type = AddressChooseTypeCounty;
    //清空选择的省市区县数据
    [self cleanChooseModel];
}

#pragma mark- method
- (NSString *)sectionTitleWithIndex:(NSInteger)index {
    if (index == 0) {
        return @"直辖市";
    }else {
        return @"省  份";
    }
}

- (CYTAddressDataItemModel *)cityModelWithProvinceModel:(CYTAddressDataItemModel *)provinceModel andIndex:(NSInteger)index {
    NSArray *cityArray = [CYTAddressDataItemModel mj_objectArrayWithKeyValuesArray:provinceModel.citys];
    return cityArray[index];
}

- (CYTAddressDataItemModel *)countyModelWithCityModel:(CYTAddressDataItemModel *)cityModel andIndex:(NSInteger)index {
    NSArray *county = [CYTAddressDataItemModel mj_objectArrayWithKeyValuesArray:cityModel.citys];
    return county[index];
}

- (void)cleanChooseModel {
    self.addressModel.selectProvinceModel = nil;
    self.addressModel.selectCityModel = nil;
    self.addressModel.selectCountyModel = nil;
    
    self.addressModel.oriProvinceId = -1;
    self.addressModel.oriCityId = -1;
    self.addressModel.oriAreaId = -1;
    self.addressModel.oriCountyId = -1;
}

#pragma mark- get
- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.requestURL = kURL.car_common_getNoGroupProvinceCity;
            model.methodType = NetRequestMethodTypeGet;
            model.requestParameters = @{@"version":@(self.version)};
            model.needHud = NO;
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            if (resultModel.resultEffective) {
                if (!resultModel.responseObject) {resultModel.responseObject = @{};}
                NSData *data = [NSJSONSerialization dataWithJSONObject:resultModel.responseObject options:NSJSONWritingPrettyPrinted error:nil];
                [data writeToFile:self.path atomically:YES];
                
                //重新获取数据模型
                [self handleModelFromLoacal];
            }
        }];
    }
    return _requestCommand;
}

@end
