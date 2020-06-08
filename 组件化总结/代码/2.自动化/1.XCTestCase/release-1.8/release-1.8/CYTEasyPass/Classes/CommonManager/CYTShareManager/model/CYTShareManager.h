//
//  CYTShareManager.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/31.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "CYTShareRequestModel.h"
#import "CYTShareResponseModel.h"

@interface CYTShareManager : NSObject
///分享
+ (void)shareWithRequestModel:(CYTShareRequestModel *)requestModel;
///反馈分享结果
+ (void)feedBackShareResultWithType:(ShareTypeId)type andBusinessId:(NSInteger)businessId;

@end
