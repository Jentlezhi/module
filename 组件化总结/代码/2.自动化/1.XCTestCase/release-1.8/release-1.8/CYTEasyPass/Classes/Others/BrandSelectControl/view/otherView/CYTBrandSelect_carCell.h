//
//  CYTBrandSelect_carCell.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/4.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendTableViewCell.h"

@interface CYTBrandSelect_carCell : FFExtendTableViewCell
///车系名
@property (nonatomic, strong) UILabel *contentLabel;
///指导价
@property (nonatomic, strong) UILabel *assistantLabel;
@property (nonatomic, assign) BOOL highlightedCell;

@end
