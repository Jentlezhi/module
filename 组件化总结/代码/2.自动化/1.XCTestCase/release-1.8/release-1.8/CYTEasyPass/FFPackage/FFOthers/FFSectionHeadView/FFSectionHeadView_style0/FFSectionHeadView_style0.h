//
//  FFSectionHeadView_style0.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/9.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"

@interface FFSectionHeadView_style0 : FFExtendView
@property (nonatomic, strong) UIView *ffBgView;
@property (nonatomic, strong) UIView *ffVLine;
@property (nonatomic, strong) UILabel *ffServeNameLabel;
@property (nonatomic, strong) UILabel *ffMoreLabel;
@property (nonatomic, strong) UIImageView *ffMoreImageView;
@property (nonatomic, strong) UIView *ffHLine;
@property (nonatomic, copy) ffIDBlock ffClickedBlock;
///设置顶部距离
@property (nonatomic, assign) float topOffset;
///设置底部线左右偏移
@property (nonatomic, assign) float hLineOffset;
///设置左侧偏移
@property (nonatomic, assign) float leftOffset;
///设置moreLabel左对齐
@property (nonatomic, assign) BOOL moreLabelLeftAlig;

@end
