//
//  CYTProgressPieView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/10.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTProgressPieView.h"

@implementation CYTProgressPieView

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)setCircleColor:(UIColor *)circleColor{
    _circleColor = circleColor;
    self.secondaryColor = circleColor;
    
}

- (void)setProgressColor:(UIColor *)progressColor{
    _progressColor = progressColor;
    self.primaryColor = progressColor;
}

- (void)setPieProgressValue:(CGFloat)pieProgressValue{
    pieProgressValue = pieProgressValue<=0.0?0:pieProgressValue;
    _pieProgressValue = pieProgressValue;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setProgress:pieProgressValue animated:NO];
    });
    
}



@end
