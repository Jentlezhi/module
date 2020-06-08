//
//  CYTTipLabel.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/4/25.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTTipLabel.h"

#define kBgColor [[UIColor colorWithHexColor:@"#000000"] colorWithAlphaComponent:0.7f];

@interface CYTTipLabel()

/** 字体内边距 */
@property(assign, nonatomic) UIEdgeInsets textInsets;

/** 最大宽度 */
@property(assign, nonatomic) CGFloat maxWidth;
/** 最小宽度 */
@property(assign, nonatomic) CGFloat minWidth;

@end

@implementation CYTTipLabel

- (instancetype)initWithText:(NSString *)text{
    if([self initWithFrame:CGRectZero]){
        self.text = text;
        [self sizeToFit];
    }
    
    return self;
}

- (instancetype)initWithText:(NSString *)text textEdgeInsets:(UIEdgeInsets)textInsets maxWidth:(CGFloat)maxWidth minWidth:(CGFloat)minWidth{
    if([self initWithFrame:CGRectZero]){
        self.textInsets = textInsets;
        self.maxWidth = maxWidth;
        self.minWidth = minWidth;
        self.text = text;
        [self sizeToFit];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if([super initWithFrame:frame]){
        [self tipLabelBasicConfig];
        [self initTipLabelComponents];
        [self makeConstrains];
    }
    
    return self;
}


/**
 *  基本配置
 */
- (void)tipLabelBasicConfig{
    self.backgroundColor = kBgColor;
    self.numberOfLines = 0;
    self.textAlignment = NSTextAlignmentCenter;
    self.font = [UIFont systemFontOfSize:14.f];
    self.backgroundColor = kBgColor;
    self.textColor = [UIColor colorWithHexColor:@"#FFFFFF"];
}

/**
 *  初始化子控件
 */
- (void)initTipLabelComponents{
    
}

/**
 *  布局
 */
- (void)makeConstrains{

}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.textInsets)];
}

- (void)sizeToFit{
    [super sizeToFit];
    CGRect frame = self.frame;
    CGFloat width = CGRectGetWidth(self.bounds) + self.textInsets.left + self.textInsets.right;
    frame.size.width = width > self.maxWidth?self.maxWidth : width;
    frame.size.width = width < self.minWidth?self.minWidth : width;
    frame.size.height = CGRectGetHeight(self.bounds) + self.textInsets.top + self.textInsets.bottom;
    self.frame = frame;
}

/**
 *  窗口的大小
 */
- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines{
    bounds.size = [self.text boundingRectWithSize:CGSizeMake(self.maxWidth - self.textInsets.left - self.textInsets.right,CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
    if (bounds.size.width<self.minWidth) {
        bounds.size.width=self.minWidth;
    }
    return bounds;
}

@end
