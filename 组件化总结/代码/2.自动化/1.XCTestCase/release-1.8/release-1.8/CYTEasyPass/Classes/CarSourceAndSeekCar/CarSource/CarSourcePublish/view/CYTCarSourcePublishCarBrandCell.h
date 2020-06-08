//
//  CYTCarSourcePublishCarBrandCell.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendTableViewCell.h"

@interface CYTCarSourcePublishCarBrandCell : FFExtendTableViewCell
@property (nonatomic, strong) UILabel *flagLab;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIView *subTitleView;
@property (nonatomic, strong) UILabel *subTitleLab;
///隐藏箭头
@property (nonatomic, assign) BOOL hideArrow;

- (void)title:(NSString *)title subtitle:(NSString *)subtitle placeholder:(NSString *)placeholder;

@end
