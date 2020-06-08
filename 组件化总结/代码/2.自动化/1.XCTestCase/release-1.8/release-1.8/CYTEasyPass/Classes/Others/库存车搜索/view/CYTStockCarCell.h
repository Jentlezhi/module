//
//  CYTStockCarCell.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/26.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendTableViewCell.h"
#import "CYTStockCarModel.h"

@interface CYTStockCarCell : FFExtendTableViewCell

@property (nonatomic, strong) UIView *sepView;

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *subTitleLab;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) CYTStockCarModel *model;

@end
