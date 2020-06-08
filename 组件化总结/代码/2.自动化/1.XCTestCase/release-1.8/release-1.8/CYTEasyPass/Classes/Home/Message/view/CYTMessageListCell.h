//
//  CYTMessageListCell.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendTableViewCell.h"
#import "CYTMessageListModel.h"
#import "CYTMessageCategoryModel.h"

@interface CYTMessageListCell : FFExtendTableViewCell
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *linkButton;
///赋值
@property (nonatomic, strong) CYTMessageListModel *model;

@end
