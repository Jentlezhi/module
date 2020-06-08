//
//  CYTLogisticsNeedDetailOfferHeaderCell.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendTableViewCell.h"

@interface CYTLogisticsNeedDetailOfferHeaderCell : FFExtendTableViewCell
@property (nonatomic, assign) NSInteger number;

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *expireLabel;
///过期
@property (nonatomic, assign) BOOL expired;

@end
