//
//  CYTDottedLine.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/9.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTDottedLine.h"

@implementation CYTDottedLine

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    UIBezierPath *line = [UIBezierPath bezierPath];
    line.lineWidth = self.lineHeight;
    CGFloat toY = rect.size.height*0.5f;
    [line moveToPoint:CGPointMake(0, toY)];
    [line addLineToPoint:CGPointMake(CGRectGetWidth(rect), toY)];
    [self.dotColor setStroke];
    CGFloat lengths[] = {2,3};
    [line setLineDash:lengths count:1 phase:1];
    [line stroke];
}

@end
