//
//  LogisticsHomeCell.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/9.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendTableViewCell.h"
#import "LogisticsHomeModel.h"

@interface LogisticsHomeCell : FFExtendTableViewCell
@property (nonatomic, strong) UILabel *startLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UILabel *endLabel;
@property (nonatomic, strong) UIImageView *assisImageView;
@property (nonatomic, strong) UILabel *descriptionLabel;

@property (nonatomic, strong) LogisticsHomeModel *model;

@end
