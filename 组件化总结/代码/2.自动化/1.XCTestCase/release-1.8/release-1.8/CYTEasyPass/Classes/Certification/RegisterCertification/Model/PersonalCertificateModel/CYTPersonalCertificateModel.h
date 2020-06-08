//
//  CYTPersonalCertificateModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTPersonalCertificateModel : NSObject

/** 姓名 */
@property(copy, nonatomic) NSString *UserName;
/** 身份证 */
@property(copy, nonatomic) NSString *IDCard;
/** 身份证原图正面照片url */
@property(copy, nonatomic) NSString *FrontIDCardOriginalPic;
/** 身份证反面原图照片url */
@property(copy, nonatomic) NSString *OppositeIDCardOriginalPic;
/** 手持身份证原图照片url */
@property(copy, nonatomic) NSString *HoldIDCardOriginalPic;

@end
