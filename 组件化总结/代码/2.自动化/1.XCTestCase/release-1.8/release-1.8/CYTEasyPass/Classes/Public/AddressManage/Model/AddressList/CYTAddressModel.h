//
//  CYTAddressModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTAddressModel : NSObject

/** 详细地址 */
@property(copy, nonatomic) NSString *address;
/** 拼接的全地址 */
@property(copy, nonatomic) NSString *addressDetail;
/** 城市Id */
@property(copy, nonatomic) NSString *cityId;
/** 城市名称 */
@property(copy, nonatomic) NSString *cityName;
/** 城市编码 */
@property(assign, nonatomic) int code;
/** 是否默认 */
@property(assign, nonatomic) BOOL isDefault;
/** 省份Id */
@property(copy, nonatomic) NSString *provinceId;
/** 省份名称 */
@property(copy, nonatomic) NSString *provinceName;
/** 地址Id */
@property(copy, nonatomic) NSString *receivingId;
/** 用户Id */
@property(assign, nonatomic) NSInteger userId;
/** 区县Id */
@property(assign, nonatomic) NSInteger countyId;
/** 区县名称 */
@property(copy, nonatomic) NSString *countyName;
/** 被选中 */
@property(assign, nonatomic) BOOL hasSelected;
/** 信息地址 */
@property(copy, nonatomic) NSString *customDetailAddress;


@end
