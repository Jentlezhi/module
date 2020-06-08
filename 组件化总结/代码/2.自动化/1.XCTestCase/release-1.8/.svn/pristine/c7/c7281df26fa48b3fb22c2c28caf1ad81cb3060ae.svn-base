//
//  CYTOrderOtherInfoView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/8/30.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTOrderBottomInfoView.h"

@implementation CYTOrderBottomInfoView
{
    //分割线
    UILabel *_lineLabel;
    //下单时间
    UILabel *_createOrderTimeLabel;
    //付款金额
    UILabel *_paymentLabel;
    
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
    //分割线
    UILabel *lineLabel = [UILabel dividerLineLabel];
    [self addSubview:lineLabel];
    _lineLabel = lineLabel;
    
    //下单时间
    UILabel *createOrderTimeLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft font:CYTFontWithPixel(24.f) setContentPriority:NO];
    [self addSubview:createOrderTimeLabel];
    _createOrderTimeLabel = createOrderTimeLabel;
    
    //付款金额
    UILabel *paymentLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentRight font:CYTFontWithPixel(24.f) setContentPriority:YES];
    [self addSubview:paymentLabel];
    _paymentLabel = paymentLabel;
    
    //测试数据
    createOrderTimeLabel.text = @"下单时间：2017.06.26";
    paymentLabel.text = @"实付：1000元";
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTItemMarginH);
        make.right.equalTo(self).offset(-CYTItemMarginH);
        make.top.equalTo(self);
        make.height.equalTo(CYTDividerLineWH);
    }];
    CGFloat vMargin = CYTAutoLayoutV(23.f);
    [_createOrderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vMargin);
        make.bottom.equalTo(-vMargin);
        make.left.equalTo(CYTItemMarginH);
    }];
    
    [_paymentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_createOrderTimeLabel);
        make.left.equalTo(_createOrderTimeLabel.mas_right);
        make.right.equalTo(-CYTItemMarginH);
    }];
}

- (void)setCreateOrderTime:(NSString *)createOrderTime{
    _createOrderTime = createOrderTime;
    NSString *createOrderTimeContent = [NSString stringWithFormat:@"下单时间：%@",createOrderTime.length?createOrderTime:@""];
    _createOrderTimeLabel.text = createOrderTimeContent;
    
}

- (void)setPayment:(NSString *)payment{
    _payment = payment;
    _paymentLabel.text = payment;
}

@end
