//
//  CYTLogisticsNeedWriteServiceModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/15.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"
#import "CYTCarBrandModel.h"

@interface CYTLogisticsNeedWriteAddressModel : FFExtendModel
///省份id
@property (nonatomic, assign) NSInteger provinceId;
///市id
@property (nonatomic, assign) NSInteger cityId;
///区县id
@property (nonatomic, assign) NSInteger countyId;
///省市区县
@property (nonatomic, copy) NSString *mainAddress;
///详细地址
@property (nonatomic, copy) NSString *detailAddress;

@end

@interface CYTLogisticsNeedWriteCellModel : FFExtendModel
///标题
@property (nonatomic, copy) NSString *title;
///小标题
@property (nonatomic, copy) NSString *subtitle;
///标志图片
@property (nonatomic, copy) NSString *imageName;
///placeholder
@property (nonatomic, copy) NSString *placeholder;
///content
@property (nonatomic, copy) NSString *contentString;
///车型参数
@property (nonatomic, strong) CYTCarBrandModel *carModel;
///地址信息
@property (nonatomic, strong) CYTLogisticsNeedWriteAddressModel *addressModel;
///是否选中，或填写内容
@property (nonatomic, assign) BOOL select;
///cell偏移
@property (nonatomic ,assign) float bottomOffset;

@end
