//
//  UIImageView+Extension.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "UIImageView+Extension.h"

static const char *key = "localIdentifierKey";

@implementation UIImageView (Extension)

- (void)setLocalIdentifier:(NSString *)localIdentifier{
    objc_setAssociatedObject(self, key, localIdentifier, OBJC_ASSOCIATION_RETAIN);
}


- (NSString *)localIdentifier{
    return objc_getAssociatedObject(self, key);
}


+ (instancetype)imageViewWithImageName:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    return [self imageViewWithImage:image];
}

+ (instancetype)imageViewWithImage:(UIImage *)image{
    UIImageView *customImageView = [[UIImageView alloc] init];
    customImageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return customImageView;
}

- (void)addWatermarkWithImageName:(NSString *)weaterImageName{
    UIImageView *waterImageView = [[UIImageView alloc] init];
    UIImage *weaterImage = [UIImage imageNamed:weaterImageName];
    UIColor *background = [[UIColor alloc] initWithPatternImage:weaterImage];
    [waterImageView setBackgroundColor:background];
    [self addSubview:waterImageView];
    [waterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
}

- (void)addRotationAnimationWithDuration:(CFTimeInterval)duration clockwise:(BOOL)clockwise{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.removedOnCompletion = NO;
    if (clockwise) {
        animation.fromValue = [NSNumber numberWithFloat:0.f];
        animation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    }else{
        animation.fromValue = [NSNumber numberWithFloat:M_PI*2.0];
        animation.toValue = [NSNumber numberWithFloat:0.f];
    }

    animation.duration = duration;
    animation.cumulative = YES;
    animation.repeatCount = CGFLOAT_MAX;
    [self.layer addAnimation:animation forKey:nil];
}

@end
