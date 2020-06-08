//
//  CYTAppManager.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYTAreaModel.h"

@interface CYTAppManager : NSObject
/** 是否显示引导页 */
@property(assign, nonatomic) BOOL showIntroPage;

/** 用户设置密码类型 */
@property(assign, nonatomic) CYTSetPwdType setPwdType;

/** 获取验证码类型 */
@property(assign, nonatomic) CYTGetCodeType getCodeType;

/** 用户填写的手机号*/
@property(copy, nonatomic) NSString *userPhoneNum;
/** 邀请人手机号 */
@property(copy, nonatomic) NSString *inviterPhone;

/** 用户名*/
@property(copy, nonatomic) NSString *UserName;
/** 身份证号*/
@property(copy, nonatomic) NSString *IDCard;
/** 身份证原图正面照片url */
@property(copy, nonatomic) NSString *FrontIDCardOriginalPic;
/** 身份证反面原图照片url */
@property(copy, nonatomic) NSString *OppositeIDCardOriginalPic;
/** 手持身份证原图照片url */
@property(copy, nonatomic) NSString *HoldIDCardOriginalPic;
/** 营业执照url */
@property(copy, nonatomic) NSString *BusinessLlicenseOriginalPic;
/** 展厅照片url */
@property(copy, nonatomic) NSString *ExhibitOriginalPic;
/** 省份ID */
@property(assign, nonatomic) NSInteger ProvinceID;
/** 手持身份证原图照片url */
@property(copy, nonatomic) NSString *ProvinceName;
/** 城市ID */
@property(assign, nonatomic) NSInteger CityID;
/** 城市名称 */
@property(copy, nonatomic) NSString *CityName;
/** 公司名称 */
@property(copy, nonatomic) NSString *CompanyName;
/** 经营类型 */
@property(assign, nonatomic) NSInteger LevelId;
/** 经营类型名称 */
@property(copy, nonatomic) NSString *LevelName;
/** 主营品牌 */
@property(copy, nonatomic) NSString *manageBrand;
/** 主营品牌id */
@property(copy, nonatomic) NSString *manageBrandId;
/** 详细地址 */
@property(copy, nonatomic) NSString *detailAddress;
/** 地区模型 */
@property(strong, nonatomic) CYTAreaModel *areaModel;

///** 输入的详情注册地址 */
//@property(copy, nonatomic) NSString *registerAddress;
/** 区县Id 无区县Id传城市Id */
@property(assign, nonatomic) NSInteger countryId;
#pragma mark - 网络实时监听
/** 网络状态：yes:通畅 ，no:无网络 */
@property(assign, nonatomic) BOOL reachable;
/** 网络切换的回调 */
@property(copy, nonatomic) void(^reachableBlock)(BOOL reachable);
/**
 *  项目管理者单例
 */
+ (instancetype)sharedAppManager;
/**
 *  设置是否显示引导
 */
- (BOOL)showNewfeature;
/**
 *  网络监测
 */
- (void)checkNetWork;


@end
