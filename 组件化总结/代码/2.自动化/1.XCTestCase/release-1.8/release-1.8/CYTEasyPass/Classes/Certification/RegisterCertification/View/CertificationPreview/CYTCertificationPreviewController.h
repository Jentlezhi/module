//
//  CYTCertificationPreviewController.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicViewController.h"

@interface CYTCertificationPreviewController : CYTBasicViewController

/** 认证状态 */
@property(assign, nonatomic) AccountState accountState;

/** 返回类型 */
@property(assign, nonatomic) CYTBackType backType;

@end
