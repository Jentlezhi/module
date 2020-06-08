//
//  CYTCommitCertificateModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTCommitCertificateModel : NSObject

/** 用户名称 */
@property(copy, nonatomic) NSString *userName;
/** 身份证号 */
@property(copy, nonatomic) NSString *idCard;
/** 身份证原图正面照片 */
@property(copy, nonatomic) NSString *frontIDCardOriginalPic;
/** 身份证反面原图照片 */
@property(copy, nonatomic) NSString *oppositeIDCardOriginalPic;
/** 手持身份证原图照片 */
@property(copy, nonatomic) NSString *holdIDCardOriginalPic;
/** 公司名称 */
@property(copy, nonatomic) NSString *companyName;
/** 城市名称 */
@property(assign, nonatomic) NSInteger countryId;
/** 注册地址 */
@property(copy, nonatomic) NSString *registerAddress;
/** 经销商类型ID */
@property(assign, nonatomic) NSInteger dealerMemberLevelId;
/** 主营品牌ID，以“,”分隔 */
@property(copy, nonatomic) NSString *carBrandIdStr;
/** 营业执照原图照片 */
@property(copy, nonatomic) NSString *businessLicenseOriginalPic;
/** 展厅照片 */
@property(copy, nonatomic) NSString *exhibitOriginalPic;

@end
