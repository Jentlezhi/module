//
//  CYTPoint.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct{
    float x;
    float y;
} CYTPoint;

@interface CYTBezier : NSObject

@property(assign, nonatomic) CYTPoint start;
@property(assign, nonatomic) CYTPoint first;
@property(assign, nonatomic) CYTPoint second;
@property(assign, nonatomic) CYTPoint end;

- (CYTPoint)pointWithDt:(CGFloat)dt;

@end
