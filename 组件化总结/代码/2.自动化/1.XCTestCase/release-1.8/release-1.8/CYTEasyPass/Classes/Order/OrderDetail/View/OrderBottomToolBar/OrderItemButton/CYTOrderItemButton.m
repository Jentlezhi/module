//
//  OrderItemButton.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTOrderItemButton.h"

@implementation CYTOrderItemButton

+ (instancetype)buttonWithImageName:(NSString *)imageName title:(NSString *)title buttonClickWithBtn:(void(^)(CYTOrderItemButton *customButton))clickBlock{
    CYTOrderItemButton *customButton = [[CYTOrderItemButton alloc] init];
    customButton.backgroundColor = [UIColor whiteColor];
    [customButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [customButton setImage:[UIImage imageWithColor:CYTBtnDisableColor] forState:UIControlStateDisabled];
    [customButton setTitle:title forState:UIControlStateNormal];
    [[customButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        !clickBlock?:clickBlock(customButton);
    }];
    return customButton;
}

+ (instancetype)buttonWithImageName:(NSString *)imageName title:(NSString *)title buttonClick:(void(^)())clickBlock{
    return [self buttonWithImageName:imageName title:title buttonClickWithBtn:^(CYTOrderItemButton *customButton) {
        !clickBlock?:clickBlock();
    }];;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:CYTGreenNormalColor forState:UIControlStateNormal];
        self.titleLabel.font = CYTFontWithPixel(18.f);
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setImageEdgeInsets:UIEdgeInsetsMake(-10, 0, 0, 0)];
    CGRect imageViewFrame = self.imageView.frame;
    CGPoint imageViewCenter = self.imageView.center;
    imageViewCenter.x = self.bounds.size.width * 0.5;
    self.imageView.frame = imageViewFrame;
    self.imageView.center = imageViewCenter;
    
    CGRect titleLabelFrame = self.titleLabel.frame;
    titleLabelFrame.size.width = self.bounds.size.width;
    titleLabelFrame.origin.y = CGRectGetMaxY(self.imageView.frame) + CYTAutoLayoutV(12);
    titleLabelFrame.origin.x = 0;
    self.titleLabel.frame = titleLabelFrame;
}




@end
