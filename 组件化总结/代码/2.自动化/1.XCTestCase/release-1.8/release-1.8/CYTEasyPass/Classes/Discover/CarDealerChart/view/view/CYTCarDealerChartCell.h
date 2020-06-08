//
//  CYTCarDealerChartCell.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendTableViewCell.h"
#import "CYTCarDealerChartItemModel.h"
#import "CYTCarDealerChartItemVM.h"

@interface CYTCarDealerChartCell : FFExtendTableViewCell
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel *sortLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *assistanceLabel;
@property (nonatomic, strong) UIImageView *sortImageView;
@property (nonatomic, strong) FFBubbleView *headImageView;

@property (nonatomic, strong) CYTCarDealerChartItemModel *model;
@property (nonatomic, assign) CarDealerChartType type;

@end
