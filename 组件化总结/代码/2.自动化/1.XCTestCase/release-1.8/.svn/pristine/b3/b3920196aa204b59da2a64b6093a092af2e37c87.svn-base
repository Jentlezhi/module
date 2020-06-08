//
//  FFBubbleView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/31.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFBubbleView.h"

@implementation FFBubbleView
- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.bubbleButton];
    [self.bubbleButton makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0.5, 0.5, 0.5, 0.5));
    }];
}

- (void)radius:(float)radius borderWidth:(float)width borderColor:(UIColor *)color {
    [super radius:radius borderWidth:width borderColor:color];
    [self.bubbleButton radius:(radius-0.5) borderWidth:0.5 borderColor:[UIColor clearColor]];
}

#pragma mark- get
- (UIButton *)bubbleButton {
    if (!_bubbleButton) {
        _bubbleButton = [UIButton buttonWithFontPxSize:28 textColor:[UIColor whiteColor] text:nil];
        _bubbleButton.backgroundColor = [UIColor redColor];
    }
    return _bubbleButton;
}

@end
