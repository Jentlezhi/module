//
//  FFCellView_Style_SimpleShow.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"

@interface FFCellView_Style_SimpleShow : FFExtendView
@property (nonatomic, strong) UILabel *flagLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIView *line;
///设置content显示几行
@property (nonatomic, assign) BOOL singleLine;
///设置是否显示箭头
@property (nonatomic, assign) BOOL showArrow;
///设置contentLabel右侧偏移
@property (nonatomic, assign) float contentRightOffset;

@end
