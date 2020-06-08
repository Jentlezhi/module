//
//  CYTLogisticsNeedDetailOfferCell.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendTableViewCell.h"
#import "CYTLogisticsNeedDetailOfferModel.h"
#import "CYTStarView.h"

@interface CYTLogisticsNeedDetailOfferCell : FFExtendTableViewCell
@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) UILabel *subTitleLab;
@property (nonatomic, strong) UILabel *needTimeLab;
@property (nonatomic, strong) UILabel *transportComLab;
@property (nonatomic, strong) CYTStarView *starView;
@property (nonatomic, strong) UILabel *remarkLab;

@property (nonatomic, strong) UIButton *orderButton;
///过期
@property (nonatomic, assign) BOOL expired;

@property (nonatomic, strong) CYTLogisticsNeedDetailOfferModel *model;
///1 待下单   2已完成   3已过期 4已取消
@property (nonatomic, assign) CYTLogisticsNeedStatus state;
@property (nonatomic, copy) void (^clickedBlock) (CYTLogisticsNeedDetailOfferModel *model);


@end
