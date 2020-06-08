//
//  CYTCouponView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/4.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCouponView.h"
#import "CYTConfirmOrderInfoModel.h"

@implementation CYTCouponView
{
    //上分隔条
    UIView *_topBar;
    //下分隔条
    UIView *_bottomBar;
    //可用券
    UILabel *_couponTipLabel;
    UILabel *_couponLabel;
    //箭头
    UIImageView *_arrow;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self couponViewBasicConfig];
        [self initCouponViewComponents];
        [self makeConstrains];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)couponViewBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    CYTWeakSelf
    [self addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
        !weakSelf.availableCouponClick?:weakSelf.availableCouponClick();
    }];
}
/**
 *  初始化子控件
 */
- (void)initCouponViewComponents{
    //上分隔条
    UIView *topBar = [[UIView alloc] init];
    topBar.backgroundColor = kFFColor_bg_nor;
    [self addSubview:topBar];
    _topBar = topBar;
    
    //下分隔条
    UIView *bottomBar = [[UIView alloc] init];
    bottomBar.backgroundColor = kFFColor_bg_nor;
    [self addSubview:bottomBar];
    _bottomBar = bottomBar;
    
    //可用券
    UILabel *couponTipLabel = [UILabel labelWithText:@"可用券" textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:YES];
    [self addSubview:couponTipLabel];
    _couponTipLabel = couponTipLabel;

    UILabel *couponLabel = [UILabel labelWithTextColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentRight fontPixel:26.f setContentPriority:NO];
    [self addSubview:couponLabel];
    _couponLabel = couponLabel;
    
    //箭头
    UIImageView *arrow = [UIImageView ff_imageViewWithImageName:@"arrow_right"];
    [self addSubview:arrow];
    _arrow = arrow;
    
    
    
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    [_topBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(CYTItemMarginV);
    }];
    
    [_bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.equalTo(CYTItemMarginV);
    }];
    [_couponTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.centerY.equalTo(self);
    }];
    
    [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(CYTAutoLayoutV(44.f));
        make.centerY.equalTo(self);
        make.right.equalTo(-CYTMarginH);
    }];
    
    [_couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_couponTipLabel.mas_right).offset(CYTItemMarginV);
        make.centerY.equalTo(self);
        make.right.equalTo(_arrow.mas_left);
    }];
}
/**
 *  物流需求页面 传入数据模型
 */
- (void)setConfirmOrderInfoModel:(CYTConfirmOrderInfoModel *)confirmOrderInfoModel{
    _confirmOrderInfoModel = confirmOrderInfoModel;
    if (confirmOrderInfoModel.reduceMoney) {
        _couponLabel.textColor = CYTHexColor(@"#F43244");
        _couponLabel.text = [NSString stringWithFormat:@"-%@元",confirmOrderInfoModel.reduceMoney];
        return;
    }
    if (confirmOrderInfoModel.couponNum == 0) {
        _couponLabel.textColor = CYTHexColor(@"#999999");
        _couponLabel.text = @"暂无";
    }else{
        _couponLabel.textColor = CYTHexColor(@"#F43244");
        _couponLabel.text = [NSString stringWithFormat:@"%ld张",confirmOrderInfoModel.couponNum];
    }
}

@end
