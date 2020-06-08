//
//  CYTLogisticsNeedCell.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/10.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendTableViewCell.h"
#import "CYTLogisticsNeedListModel.h"
#import "CYTLogisticsOrderListModel.h"
#import "CYTLogisticsNeedCell_ActionView.h"

@interface CYTLogisticsNeedCell : FFExtendTableViewCell
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) UILabel *subTitle;

//address
@property (nonatomic, strong) UILabel *sendLabel;
@property (nonatomic, strong) UILabel *receiveLabel;
@property (nonatomic, strong) UIImageView *topPointView;
@property (nonatomic, strong) UIImageView *vView;
@property (nonatomic, strong) UIImageView *botPointView;

///actionView
@property (nonatomic, strong) CYTLogisticsNeedCell_ActionView *actionView;
@property (nonatomic, copy) ffIndexBlock clickedBlock;
@property (nonatomic, strong) CYTLogisticsNeedListModel *needModel;
@property (nonatomic, strong) CYTLogisticsOrderListModel *orderModel;

@end
