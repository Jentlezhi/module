//
//  CYTProgressRingView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/10.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTProgressRingView.h"

@implementation CYTProgressRingView

- (void)setCircleColor:(UIColor *)circleColor{
    _circleColor = circleColor;
    self.primaryColor = circleColor;
}

- (void)setProgressColor:(UIColor *)progressColor{
    _progressColor = progressColor;
    self.secondaryColor = progressColor;
}

- (void)setRingProgressValue:(CGFloat)ringProgressValue{
    ringProgressValue = ringProgressValue<=0.0?0:ringProgressValue;
    _ringProgressValue = ringProgressValue;
    [self setProgress:ringProgressValue animated:NO];
}

@end
