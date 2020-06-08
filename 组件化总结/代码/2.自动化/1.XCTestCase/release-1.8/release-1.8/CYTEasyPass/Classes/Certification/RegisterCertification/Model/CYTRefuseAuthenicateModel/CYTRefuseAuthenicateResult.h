//
//  CYTRefuseAuthenicateResult.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/27.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTResultModel.h"

@interface CYTRefuseAuthenicateResult : CYTResultModel

/** 驳回原因字典 */
@property(strong, nonatomic) NSArray *Data;

@end
