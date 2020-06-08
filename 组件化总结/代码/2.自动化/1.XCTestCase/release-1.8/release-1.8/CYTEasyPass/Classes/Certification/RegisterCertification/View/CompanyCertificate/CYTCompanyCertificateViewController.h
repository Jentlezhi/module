//
//  CYTCompanyCertificateViewController.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicViewController.h"

@class CYTPersonalCertificateModel;
@class CYTUserInfoModel;

@interface CYTCompanyCertificateViewController : CYTBasicViewController

/** 个人认证模型 */
@property(strong, nonatomic) CYTPersonalCertificateModel *personalCertificateModel;

/** 认证信息模型 */
@property(strong, nonatomic) CYTUserInfoModel *userAuthenticateInfoModel;

/** 返回方式 */
@property(assign, nonatomic) CYTBackType backType;

/** 企业原因条数 */
@property(assign, nonatomic) NSUInteger reasonline;

/** 驳回原因 */
@property(strong, nonatomic) NSMutableAttributedString *refuseString;

@end
