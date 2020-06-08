//
//  FFToolView_type0.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"

@interface FFToolView_type0 : FFExtendView
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
///图片文字间距
@property (nonatomic, assign) float space;
@property (nonatomic, assign) UIEdgeInsets insect;

@property (nonatomic, copy) ffIDBlock clickedBlock;

@end
