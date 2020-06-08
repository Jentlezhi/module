//
//  CYTManageTypeViewController.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicViewController.h"

@class CYTManageTypeModel;

@interface CYTManageTypeViewController : CYTBasicViewController

/** 公司类型回调 */
@property(copy, nonatomic) void(^companyTypeBack)(CYTManageTypeModel *);
/** 已选公司类型 */
@property(strong, nonatomic) CYTManageTypeModel *manageTypeModel;
/** 记录数据 */
@property(strong, nonatomic) NSArray *selectTypeData;

@end
