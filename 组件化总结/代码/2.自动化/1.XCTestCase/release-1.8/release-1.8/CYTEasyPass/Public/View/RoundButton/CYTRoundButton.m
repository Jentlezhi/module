//
//  CYTRoundButton.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/9.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTRoundButton.h"


@implementation CYTRoundButton

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
    }
    return self;
}

- (void)setCornerType:(CYTBtnCornerType)cornerType{
    _cornerType = cornerType;
    UIRectCorner corners;
    CGFloat margin = 1.f;
    switch (cornerType){
        case CYTBtnCornerTypeNone:
            return;
            break;
        case CYTBtnCornerTypeTopBottomLeft:
        {
            corners = UIRectCornerBottomLeft | UIRectCornerTopLeft;
            margin = 0.f;
        }
            break;
        case CYTBtnCornerTypeTopBottomRight:
            corners = UIRectCornerBottomRight | UIRectCornerTopRight;
            break;
        case CYTBtnCornerTypeAll:{
            corners = UIRectCornerAllCorners;
            margin = 0.f;
        }
            break;
        default:
            return;
            break;
    }
    CGRect rect  = CGRectMake(self.bounds.origin.x-margin, self.bounds.origin.y, self.bounds.size.width+margin,self.bounds.size.height);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect
                              byRoundingCorners:corners
                              cornerRadii:CGSizeMake(CYTAutoLayoutV(25), CYTAutoLayoutV(25))];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path  = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end
