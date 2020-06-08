//
//  CYTCarSourceDetailRouteItemView.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/10.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"
#import "CarSourceDetailRoutModel.h"

@interface CYTCarSourceDetailRouteItemView : FFExtendView
@property (nonatomic, strong) UILabel *startLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UILabel *endLabel;
@property (nonatomic, strong) UIView *borderView;
@property (nonatomic, strong) UIImageView *assisImageView;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) CarSourceDetailRoutModel *model;

@end
