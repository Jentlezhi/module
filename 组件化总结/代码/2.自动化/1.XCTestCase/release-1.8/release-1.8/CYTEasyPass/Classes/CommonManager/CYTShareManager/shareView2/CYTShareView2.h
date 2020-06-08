//
//  CYTShareView2.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/14.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"

@interface CYTShareView2 : FFExtendView
@property (nonatomic, strong) UIImageView *lineImageView;
@property (nonatomic, strong) UILabel *shareLabel;
@property (nonatomic, copy) void (^clickBlock) (NSInteger index);

@end
