//
//  CYTCouponMainViewCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/28.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCouponMainViewCell.h"

@implementation CYTCouponMainViewCell

- (void)setViewControllerView:(UIView *)viewControllerView{
    _viewControllerView = viewControllerView;
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.contentView addSubview:viewControllerView];
    viewControllerView.frame = self.bounds;
}

@end
