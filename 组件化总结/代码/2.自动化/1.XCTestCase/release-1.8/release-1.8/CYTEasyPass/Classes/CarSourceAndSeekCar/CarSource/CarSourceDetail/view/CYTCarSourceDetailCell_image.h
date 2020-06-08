//
//  CYTCarSourceDetailCell_image.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/14.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendTableViewCell.h"
#import "CYTCarSourceDetailImageView.h"

@interface CYTCarSourceDetailCell_image : FFExtendTableViewCell
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) CYTCarSourceDetailImageView *imgView;
///共几张
@property (nonatomic, strong) UILabel *assistantLab;
@property (nonatomic, strong) UIImageView *arrowImageView;

//set
@property (nonatomic, strong) NSArray *urlArray;

@end
