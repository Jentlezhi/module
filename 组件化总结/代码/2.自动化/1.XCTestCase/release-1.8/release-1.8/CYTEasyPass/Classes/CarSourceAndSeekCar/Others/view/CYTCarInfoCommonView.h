//
//  CYTCarInfoCommonView.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/4/24.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"
#import "FFLabel_Type_WithRightView.h"

@interface CYTCarInfoCommonView : FFExtendView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *typeButton;

@property (nonatomic, strong) UILabel *subTitleLabel;

@property (nonatomic, strong) FFLabel_Type_WithRightView *importView;
@property (nonatomic, strong) FFLabel_Type_WithRightView *colorView;
@property (nonatomic, strong) UILabel *cityLabel;

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *timeLabel;

@end
