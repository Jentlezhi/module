//
//  CarFilterConditionTabelCell_text.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendTableViewCell.h"
#import "CarFilterConditionTableVM.h"

@interface CarFilterConditionTabelCell_text : FFExtendTableViewCell
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, assign) CarFilterConditionTableType type;

@end
