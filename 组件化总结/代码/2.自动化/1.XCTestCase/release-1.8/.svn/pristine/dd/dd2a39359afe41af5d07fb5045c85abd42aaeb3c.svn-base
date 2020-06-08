//
//  CYTCompanyCertificateViewModel.h
//  CYTEasyPass
//
//  Created by Juniort on 2017/3/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CYTCommitCertificateModel;

@interface CYTCompanyCertificateViewModel : NSObject

/** 公司名称 */
@property(copy, nonatomic) NSString *companyName;
/** 输入的详情注册地址 */
@property(copy, nonatomic) NSString *registerAddress;

/** 下一步按钮能否点击 */
@property (nonatomic, strong, readonly) RACSignal *netStepEnableSiganl;
/** 下一步按钮命令 */
@property (nonatomic, strong, readonly) RACCommand *netStepCommand;
/** 认证图片资源 */
@property(strong, nonatomic) NSMutableArray *certificatePhotos;

@end
