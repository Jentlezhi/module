//
//  CYTPersonalCertificateViewModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CYTPersonalCertificateModel;

@interface CYTPersonalCertificateViewModel : NSObject

/** 姓名 */
@property(copy, nonatomic) NSString *name;
/** 身份证号码 */
@property(copy, nonatomic) NSString *idCardNum;

/** 下一步按钮能否点击 */
@property (nonatomic, strong, readonly) RACSignal *netStepEnableSiganl;
/** 下一步按钮命令 */
@property (nonatomic, strong, readonly) RACCommand *netStepCommand;

/** 认证图片资源 */
@property(strong, nonatomic) NSMutableArray *certificatePhotos;

/** 个人认证模型 */
@property(strong, nonatomic) CYTPersonalCertificateModel *personalCertificateModel;

@end
