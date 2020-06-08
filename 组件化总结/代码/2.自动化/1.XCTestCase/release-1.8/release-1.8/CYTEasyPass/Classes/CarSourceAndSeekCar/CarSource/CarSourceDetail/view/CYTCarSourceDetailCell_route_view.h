//
//  CYTCarSourceDetailCell_route_view.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/10.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"
#import "CarSourceDetailItemModel.h"
#import "CYTCarSourceDetailRouteItemView.h"

@interface CYTCarSourceDetailCell_route_view : FFExtendView
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) CarSourceDetailItemModel *model;

@end
