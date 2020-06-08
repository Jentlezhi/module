//
//  CYTPaySecondCell.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/24.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYTPayCellModel.h"

@interface CYTPaySecondCell : UITableViewCell
@property (nonatomic, strong) UIImageView *flagImageView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *subTitleLab;
@property (nonatomic, strong) UIButton *selectButton;

@property (nonatomic, strong) CYTPayCellModel *model;

@end
