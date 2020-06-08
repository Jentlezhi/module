//
//  CYTProgressView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTProgressView.h"

@interface CYTProgressView()

/** 进度 */
@property(strong, nonatomic) CAShapeLayer *progressLayer;

@end

@implementation CYTProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self progressViewBasicConfig];
        [self initProgressViewComponents];
    }
    return self;
}
/**
 *  基本设置
 */
- (void)progressViewBasicConfig{
    
}

/**
 *  初始化子控件
 */
- (void)initProgressViewComponents{
    //添加控件
    [self.layer addSublayer:self.progressLayer];
}

/**
 *  懒加载
 */

- (CAShapeLayer *)progressLayer{
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.fillColor = [[UIColor clearColor] CGColor];
        _progressLayer.strokeColor = [[UIColor whiteColor] CGColor];
        _progressLayer.opacity = 1;
        _progressLayer.lineCap = kCALineCapRound;
        _progressLayer.lineWidth = 5;
        [_progressLayer setShadowColor:[UIColor blackColor].CGColor];
        [_progressLayer setShadowOffset:CGSizeMake(1, 1)];
        [_progressLayer setShadowOpacity:0.5];
        [_progressLayer setShadowRadius:2];
    }
    return _progressLayer;
}

- (void)drawRect:(CGRect)rect {
    CGPoint center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    CGFloat radius = rect.size.width / 2;
    CGFloat startA = - M_PI_2;
    CGFloat endA = - M_PI_2 + M_PI * 2 * _progressValue;
    _progressLayer.frame = self.bounds;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    _progressLayer.path =[path CGPath];
    
    [_progressLayer removeFromSuperlayer];
    [self.layer addSublayer:_progressLayer];
}

- (void)setProgressValue:(CGFloat)progressValue{
    _progressValue = progressValue;
    [self setNeedsDisplay];
}


@end
