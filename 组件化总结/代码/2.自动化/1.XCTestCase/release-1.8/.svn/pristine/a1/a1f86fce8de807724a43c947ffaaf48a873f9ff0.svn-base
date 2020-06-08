//
//  CYTCompanyCertificateView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTCompanyCertificateModel;
@class CYTPersonalCertificateModel;
@class CYTManageTypeModel;
@class CYTUserInfoModel;
@interface CYTCompanyCertificateView : UIView

/** 调起键盘 */
@property(assign, nonatomic) BOOL showKeyboard;
/** 注册地址回调 */
@property(copy, nonatomic) void(^registerAddressBack)();
/** 经营类型回调 */
@property(copy, nonatomic) void(^manageType)();
/** 添加营业执照回调 */
@property(copy, nonatomic) void(^addBusinessLicenseBack)();
/** 主营品牌回调 */
@property(copy, nonatomic) void(^manageBrand)();
/** 添加展厅照片回调 */
@property(copy, nonatomic) void(^addShrowroomBack)();
/** 下一步按钮 */
@property(copy, nonatomic) void(^companyCertificateNextStep)(NSString *message);
/** 图片的选择 */
@property(strong, nonatomic) CYTCompanyCertificateModel *companyCertificateModel;
/** 经营类型选择 */
@property(copy, nonatomic) NSString *companyManageType;
/** 主营品牌的选择 */
@property(strong, nonatomic) NSMutableArray *manageBrands;
/** 个人认证模型 */
@property(strong, nonatomic) CYTPersonalCertificateModel *personalCertificateModel;
/** 经营类型 */
@property(strong, nonatomic) CYTManageTypeModel *manageTypeModel;
/** 认证模型 */
@property(strong, nonatomic) CYTUserInfoModel *userAuthenticateInfoModel;
/** 驳回原因 */
@property(strong, nonatomic) NSMutableAttributedString *refuseReason;
/** 驳回原因条数 */
@property(assign, nonatomic) NSUInteger reasonLine;


@end
