//
//  CYTLogisticsNeedDetailCarCell.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendTableViewCell.h"
#import "CYTLogisticsNeedDetailCarModel.h"

@interface CYTLogisticsNeedDetailCarCell : FFExtendTableViewCell

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) UILabel *subTitleLab;
@property (nonatomic, strong) UILabel *numberLab;
@property (nonatomic, strong) UILabel *expireLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UIButton *needService;

@property (nonatomic, strong) CYTLogisticsNeedDetailCarModel *model;

@end
