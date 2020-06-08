//
//  CYTOrderOtherInfoView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/8/30.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTOrderTopInfoView.h"

@implementation CYTOrderTopInfoView
{
    //绿条
    UIView *_greenBarView;
    //订单号
    UILabel *_orderNumLabel;
    //订单状态
    UILabel *_orderStatusLabel;
    //分割线
    UILabel *_lineLabel;
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self orderOtherInfoBasicConfig];
        [self initOrderOtherInfoComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)orderOtherInfoBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}
/**
 *  初始化子控件
 */
- (void)initOrderOtherInfoComponents{
    //绿条
    UIView *greenBarView = [[UIView alloc] init];
    greenBarView.backgroundColor = CYTGreenNormalColor;
    [self addSubview:greenBarView];
    _greenBarView = greenBarView;
    
    //订单号
    UILabel *orderNumLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft font:CYTFontWithPixel(24.f) setContentPriority:NO];
    [self addSubview:orderNumLabel];
    _orderNumLabel = orderNumLabel;
    
    //订单状态
    UILabel *orderStatusLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentRight font:CYTFontWithPixel(24.f) setContentPriority:YES];
    [self addSubview:orderStatusLabel];
    _orderStatusLabel = orderStatusLabel;
    
    //分割线
    UILabel *lineLabel = [UILabel dividerLineLabel];
    [self addSubview:lineLabel];
    _lineLabel = lineLabel;
    
    //测试数据
    orderNumLabel.text = @"订单号：2379324804444dddddddddddddd";
    orderStatusLabel.text = @"待买家支付";
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    
    [_greenBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(CYTAutoLayoutH(6.f));
        make.height.equalTo(CYTAutoLayoutV(34.f));
        make.left.equalTo(CYTItemMarginH);
        make.centerY.equalTo(self);
    }];
    
    CGFloat vMargin = CYTAutoLayoutV(23.f);
    [_orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vMargin);
        make.bottom.equalTo(-vMargin);
        make.left.equalTo(_greenBarView).offset(CYTAutoLayoutH(14.f));
    }];
    
    [_orderStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_orderNumLabel);
        make.right.equalTo(-CYTItemMarginH);
        make.left.equalTo(_orderNumLabel.mas_right);
    }];
    
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_greenBarView).offset(CYTAutoLayoutH(14.f));
        make.right.equalTo(self).offset(-CYTItemMarginH);
        make.bottom.equalTo(self);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
}

@end
