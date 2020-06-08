//
//  CYTCompanyCertificateModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTCompanyCertificateModel : NSObject

/** 企业认证照片类型 */
@property(assign, nonatomic) CYTCompanyCertificateType certificateType;
/** 图片 */
@property(strong, nonatomic) UIImage *selectedImage;

@end
