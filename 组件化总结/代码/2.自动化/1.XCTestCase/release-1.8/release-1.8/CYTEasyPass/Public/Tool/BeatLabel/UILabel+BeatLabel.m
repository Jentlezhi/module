//
//  UILabel+BeatLabel.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "UILabel+BeatLabel.h"
#import "CYTBezier.h"

static const NSInteger maxTimes = 100;

@implementation UILabel (BeatLabel)
//记录点
NSMutableArray *_totalPoints;
//动画样式
CYTBezier *_bezier;
//动画间隔
float _duration;
//起始值
float _fromNum;
//最后值
float _toNum;
//动画间隔
float _lastTime;
//索引
NSInteger _index;

- (void)animationFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue duration:(float)duration{
    _lastTime = 0;
    _index = 0;
    _bezier = CYTBezier.new;
    _duration = duration;
    _fromNum = fromValue;
    _toNum = toValue;
    
    _totalPoints = [NSMutableArray array];
    float dt = 1.0 / (maxTimes - 1);
    for (NSInteger index = 0; index < maxTimes; index ++ ) {
        CYTPoint point = [_bezier  pointWithDt:dt*index];
        float currTime = point.x * _duration;
        float currValue = point.y * (_toNum - _fromNum) + _fromNum;
        
        NSArray *array = [NSArray arrayWithObjects:[NSNumber numberWithFloat:currTime] , [NSNumber numberWithFloat:currValue], nil];
        [_totalPoints addObject:array];
    }
    [self valueChange];
}

- (void)valueChange{
    if (_index>= maxTimes) {
        self.text = [NSString stringWithFormat:@"%.0f",_toNum];
        return;
    } else {
        NSArray *pointValues = [_totalPoints objectAtIndex:_index];
        _index++;
        float value = [(NSNumber *)[pointValues objectAtIndex:1] intValue];
        float currentTime = [(NSNumber *)[pointValues objectAtIndex:0] floatValue];
        float timeDuration = currentTime - _lastTime;
        _lastTime = currentTime;
        self.text = [NSString stringWithFormat:@"%.0f",value];
        [self performSelector:@selector(valueChange) withObject:nil afterDelay:timeDuration];
    }
}

@end
