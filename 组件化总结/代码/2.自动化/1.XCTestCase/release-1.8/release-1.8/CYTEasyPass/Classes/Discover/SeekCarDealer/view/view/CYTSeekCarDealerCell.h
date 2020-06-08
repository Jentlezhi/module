//
//  CYTSeekCarDealerCell.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendTableViewCell.h"
#import "CYTStarView.h"
#import "CYTDealer.h"

@interface CYTSeekCarDealerCell : FFExtendTableViewCell
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nameLabel;
///车商类型
@property (nonatomic, strong) UILabel *typeLabel;
///实体店认证
@property (nonatomic, strong) UILabel *realStoreLabel;
@property (nonatomic, strong) CYTStarView *starView;
@property (nonatomic, strong) UILabel *companyNameLabel;
///主营品牌
@property (nonatomic, strong) UILabel *mainBusinessLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) CYTDealer *model;

@end
