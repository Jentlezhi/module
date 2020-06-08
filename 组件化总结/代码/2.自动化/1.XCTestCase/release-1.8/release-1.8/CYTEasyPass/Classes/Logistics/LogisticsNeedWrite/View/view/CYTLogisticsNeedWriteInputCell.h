//
//  CYTLogisticsNeedWriteInputCell.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/22.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFCell_Style_Input.h"
#import "CYTLogisticsNeedWriteCellModel.h"

@interface CYTLogisticsNeedWriteInputCell : FFCell_Style_Input
@property (nonatomic, strong) CYTLogisticsNeedWriteCellModel *model;
@property (nonatomic, assign) BOOL callLogisticsService;

@end
