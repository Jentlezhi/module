//
//  CYTWaitCommitUserInfoModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTWaitCommitUserInfoModel : NSObject

/** 姓名 */
@property(copy, nonatomic) NSString *userName;
/** 注册账号 */
@property(copy, nonatomic) NSString *userPhoneNum;
/** 区县Id 无区县Id传城市Id */
@property(copy, nonatomic) NSString *countryId;
/** 公司注册的详情地址；用户自己输入的地址 */
@property(copy, nonatomic) NSString *registerAddress;
/** 公司类型Id */
@property(copy, nonatomic) NSString *dealerMemberLevelId;
/** 公司类型名称 */
@property(copy, nonatomic) NSString *dealerMemberLeveName;
/** 主营品牌 ","拼接，最后一个值不需要拼接"," */
@property(copy, nonatomic) NSString *carBrandIdStr;
/** 图片guid */
@property(copy, nonatomic) NSString *faceOriginalPic;
/** 主营品牌模型 */
@property(strong, nonatomic) NSArray *manageBrands;
/** 省份Id */
@property(assign, nonatomic) NSUInteger provinceId;
/** 省份名称 */
@property(copy, nonatomic) NSString *provinceName;
/** 城市Id */
@property(assign, nonatomic) NSUInteger cityId;
/** 城市名称 */
@property(copy, nonatomic) NSString *cityName;
/** 区县Id */
@property(assign, nonatomic) NSUInteger countyId;
/** 区县名称 */
@property(copy, nonatomic) NSString *countyName;
/** 详细地址 */
@property(copy, nonatomic) NSString *address;
/** 拼接的全地址 */
@property(copy, nonatomic) NSString *addressDetail;

@end
