//
//  CYTStarView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/8/2.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTStarView.h"

static NSString *const starFull    = @"ic_starfull_nor";
static NSString *const unStarFull  = @"ic_starfull_unsel";
static NSString *const halfStar    = @"ic_starhalf_nor";
CGFloat const starWidth  = 25.f;
CGFloat const starHeight = 23.f;

@implementation CYTStarView
{
    NSInteger _starTotalNum;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self starViewBasicConfig];
        [self initStarViewComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)starViewBasicConfig{
    self.backgroundColor = [UIColor clearColor];
}
/**
 *  初始化子控件
 */
- (void)initStarViewComponents{
    
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    
}

#pragma 设置

- (void)setStarValue:(CGFloat)starValue{
    _starValue = starValue;
    [self removeAllSubviews];
    NSInteger starInteger = floor(starValue);
    CGFloat starFloat = starValue - starInteger;
    
    for (NSInteger index = 0; index < self.starTotalNum; index++) {
        UIImageView *star = [[UIImageView alloc] init];
        if (index<starInteger) {
            star.image = [UIImage imageNamed:starFull];
        }else if(starFloat>0.f){
            if (index == starInteger) {
                star.image = [UIImage imageNamed:halfStar];
            }else{
                star.image = [UIImage imageNamed:unStarFull];
            }
        }else{
            star.image = [UIImage imageNamed:unStarFull];
        }
        CGFloat starW = CYTAutoLayoutV(starWidth);
        CGFloat starH = CYTAutoLayoutV(starHeight);
        CGFloat starX = index*starW;
        CGFloat starY = 0;
        star.frame = CGRectMake(starX, starY, starW, starH);
        [self addSubview:star];
    }
    
}


@end
