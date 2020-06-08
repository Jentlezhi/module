//
//  CYTCarSourceCommonCellView.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/4/24.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarInfoCommonView.h"
@class CYTCarSourceListModel;

@interface CYTCarSourceCommonCellView : CYTCarInfoCommonView
@property (nonatomic, strong) UIView *separateView;
///期望成交价
@property (nonatomic, strong) UILabel *hopeLabel;
@property (nonatomic, strong) UILabel *guidePriceLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
/** 数据模型 */
@property(strong, nonatomic) CYTCarSourceListModel *carSourceListModel;

@end
