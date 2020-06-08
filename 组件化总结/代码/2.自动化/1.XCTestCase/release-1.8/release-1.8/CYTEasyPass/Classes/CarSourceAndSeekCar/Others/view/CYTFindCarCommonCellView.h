//
//  CYTFindCarCommonCellView.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/4/24.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarInfoCommonView.h"
@class CYTSeekCarListModel;

@interface CYTFindCarCommonCellView : CYTCarInfoCommonView
@property (nonatomic, strong) UIView *separateView;
@property (nonatomic, strong) UILabel *areaLabel;
@property (nonatomic, strong) UILabel *guidePriceLabel;
/** 数据模型 */
@property(strong, nonatomic) CYTSeekCarListModel *seekCarListModel;

@end
