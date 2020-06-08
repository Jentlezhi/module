//
//  CYTPoint.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBezier.h"

@implementation CYTBezier

- (instancetype)init{
    if (self = [super init]) {
        [self bezierBasicConfig];
    }
    return self;
}

/**
 *  基本配置
 */
- (void)bezierBasicConfig{
    
    CYTPoint start;
    start.x = 0;
    start.y = 0;
    self.start = start;
    
    CYTPoint first;
    first.x = 0;
    first.y = 0.57f;
    self.first = first;
    
    CYTPoint second;
    second.x = 0.44f;
    second.y = 1.0f;
    self.second = second;
    
    CYTPoint end;
    end.x = 1;
    end.y = 1;
    self.end = end;
}

//贝塞尔 算法
//y=y0·(1-t)³+3·y1·t·(1-t)²+3·y2·t²·(1-t)+y3·t³
//x=x0·(1-t)³+3·x1·t·(1-t)²+3·x2·t²·(1-t)+x3·t³
- (CYTPoint)pointWithDt:(CGFloat)dt{
    CYTPoint result;
    float t = 1 - dt;
    float tSqure = t * t;
    float tCube = t * tSqure;
    float dtSqure = dt * dt;
    float dtCube = dtSqure * dt;
    result.x = self.start.x * tCube + 3 * self.first.x * dt * tSqure  +  3 * self.second.x * dtSqure * t + self.end.x * dtCube;
    result.y = self.start.y * tCube + 3 * self.first.y * dt * tSqure  +  3 * self.second.y * dtSqure * t + self.end.y * dtCube;
    return result;
}


@end
