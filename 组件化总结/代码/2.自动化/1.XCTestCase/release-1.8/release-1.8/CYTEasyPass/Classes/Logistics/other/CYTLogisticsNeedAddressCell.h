//
//  CYTLogisticsNeedAddressCell.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/11.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendTableViewCell.h"
#import "CYTLogisticsNeedWriteCellModel.h"

@interface CYTLogisticsNeedAddressCell : FFExtendTableViewCell
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIImageView *flagImageView;
@property (nonatomic, strong) UILabel *flagLab;
@property (nonatomic, strong) UILabel *assistantLab;
@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UIView *botView;
@property (nonatomic, strong) UIView *vBgView;
@property (nonatomic, strong) UIImageView *vImageView;
@property (nonatomic, strong) UIView *contentBgView;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UIView *sepaView;

@property (nonatomic, strong) UIImageView *stateImageView;

@property (nonatomic, strong) CYTLogisticsNeedWriteCellModel *model;

@end
