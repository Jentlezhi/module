//
//  CYTDealerHomeAuthInfoModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/31.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"

@interface CYTDealerHomeAuthInfoModel : CYTExtendViewModel

@property (nonatomic, assign) BOOL isMore;
///身份证
@property (nonatomic, assign) BOOL isIdCardAuth;
///营业执照
@property (nonatomic, assign) BOOL isBusinessLicenseAuth;
///实店认证
@property (nonatomic, assign) BOOL isStoreAuth;

@end
