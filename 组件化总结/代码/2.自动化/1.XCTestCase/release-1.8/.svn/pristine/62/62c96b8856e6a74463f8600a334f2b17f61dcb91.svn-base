//
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
#import "CYTAddressDataWNCModel.h"

typedef NS_ENUM(NSInteger,AddressChooseType) {
    ///选择省、大区
    AddressChooseTypeProvince,
    ///选择市
    AddressChooseTypeCity,
    ///选择区县
    AddressChooseTypeCounty,
};


@interface CYTAddressDataWNCManager : CYTExtendViewModel
//title设置
@property (nonatomic, copy) NSString *titleString;
///是否显示大区
@property (nonatomic, assign) BOOL showArea;
///选择模式
@property (nonatomic, assign) AddressChooseType type;

///数据
@property (nonatomic, strong) CYTAddressDataWNCModel *addressModel;

///大区
@property (nonatomic, strong) CYTAddressDataProvinceModel *areaModel;
@property (nonatomic, strong) NSArray *areaListArray;
///直辖市
@property (nonatomic, strong) CYTAddressDataProvinceModel *plCityModel;
@property (nonatomic, strong) NSArray *plCityListArray;
///省份
@property (nonatomic, strong) CYTAddressDataProvinceModel *provinceModel;
@property (nonatomic, strong) NSArray *provinceListArray;


///单例
+ (instancetype)shareManager;

///返回section title
- (NSString *)sectionTitleWithIndex:(NSInteger)index;
///获取city
- (CYTAddressDataItemModel *)cityModelWithProvinceModel:(CYTAddressDataItemModel *)provinceModel andIndex:(NSInteger)index;
///获取县/区
- (CYTAddressDataItemModel *)countyModelWithCityModel:(CYTAddressDataItemModel *)cityModel andIndex:(NSInteger)index;


///清空所选则的省市区县数据
- (void)cleanChooseModel;
///清空除了地址以外的所有缓存
- (void)cleanAllModelCache;


@end
