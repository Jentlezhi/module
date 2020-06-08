//
//  CYTGoodsExchangeView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/14.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTGoodsExchangeView.h"
#import "CYTDottedLine.h"
#import "CYTGoodsModel.h"
#import "CYTCoinCardView.h"
#import "CYTIndicatorView.h"

static const CGFloat lineHeight = 0.35f;

@interface CYTGoodsExchangeView()

/** 左半圆 */
@property(strong, nonatomic) UIImageView *leftSemicircle;
/** 右半圆 */
@property(strong, nonatomic) UIImageView *rightSemicircle;
/** 虚线 */
@property(strong, nonatomic) CYTDottedLine *dottedLine;
/** 币种 */
@property(strong, nonatomic) UILabel *valueTypeLabel;
/** 券价值 */
@property(strong, nonatomic) UILabel *couponvalueLabel;
/** 券类型 */
@property(strong, nonatomic) UILabel *couponTypeLabel;
/** 使用条件 */
@property(strong, nonatomic) UILabel *usingConditionLabel;
/** 兑换按钮 */
@property(strong, nonatomic) UIButton *exchangeBtn;

@end

@implementation CYTGoodsExchangeView

- (void)basicConfig{
    self.backgroundColor = CYTHexColor(@"#FCFAF1");
    CYTWeakSelf
    [self addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
        !weakSelf.clickCallback?:weakSelf.clickCallback(weakSelf.goodsModel);
    }];
}

- (void)initSubComponents{
    [self addSubview:self.leftSemicircle];
    [self addSubview:self.rightSemicircle];
    [self addSubview:self.dottedLine];
    [self addSubview:self.valueTypeLabel];
    [self addSubview:self.couponvalueLabel];
    [self addSubview:self.couponTypeLabel];
    [self addSubview:self.usingConditionLabel];
    [self addSubview:self.exchangeBtn];
}

- (void)makeSubConstrains{
    [self.leftSemicircle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(20.f), CYTAutoLayoutV(40.f)));
        make.left.equalTo(self);
        make.centerY.equalTo(self);
    }];
    [self.rightSemicircle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(20.f), CYTAutoLayoutV(40.f)));
        make.right.equalTo(self);
        make.centerY.equalTo(self);
    }];
    [self.dottedLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.centerY.equalTo(self);
        make.height.equalTo(1);
    }];

    [self.valueTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTAutoLayoutH(23.f));
        make.top.equalTo(CYTAutoLayoutV(22.f));
    }];

    [self.couponvalueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.valueTypeLabel);
        make.left.equalTo(self.valueTypeLabel.mas_right);
    }];

    [self.couponTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(CYTAutoLayoutV(5.f));;
        make.height.equalTo(CYTAutoLayoutV(37.5f));
        make.left.equalTo(self.couponvalueLabel.mas_right);
        make.right.equalTo(-CYTAutoLayoutH(10));
    }];

    [self.usingConditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.couponTypeLabel.mas_bottom);
        make.left.right.height.equalTo(self.couponTypeLabel);
    }];

    [self.exchangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dottedLine.mas_bottom).offset(CYTAutoLayoutV(9));
        make.bottom.equalTo(-CYTAutoLayoutV(11.f));
        make.centerX.equalTo(self);
        make.left.mas_lessThanOrEqualTo(CYTItemMarginH);
        make.right.mas_lessThanOrEqualTo(-CYTItemMarginH);
    }];
}

#pragma mark - 懒加载
- (UIImageView *)leftSemicircle{
    if (!_leftSemicircle) {
        _leftSemicircle = [UIImageView ff_imageViewWithImageName:@"pic_yuan_2"];
    }
    return _leftSemicircle;
}
- (UIImageView *)rightSemicircle{
    if (!_rightSemicircle) {
        _rightSemicircle = [UIImageView ff_imageViewWithImageName:@"pic_yuan_1"];
    }
    return _rightSemicircle;
}

- (CYTDottedLine *)dottedLine{
    if (!_dottedLine) {
        _dottedLine = CYTDottedLine.new;
        _dottedLine.backgroundColor = UIColor.clearColor;
        _dottedLine.lineHeight = lineHeight;
        _dottedLine.dotColor = CYTHexColor(@"#C2B48");
    }
    return _dottedLine;
}

- (UILabel *)valueTypeLabel{
    if (!_valueTypeLabel) {
        _valueTypeLabel = [UILabel labelWithText:@"￥" textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:YES];
    }
    return _valueTypeLabel;
}

- (UILabel *)couponvalueLabel{
    if (!_couponvalueLabel) {
        _couponvalueLabel = [UILabel labelWithTextColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft font:CYTBoldFontWithPixel(46.f) setContentPriority:YES];
    }
    return _couponvalueLabel;
}
- (UILabel *)couponTypeLabel{
    if (!_couponTypeLabel) {
        _couponTypeLabel = [UILabel labelWithTextColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentCenter fontPixel:25.f setContentPriority:NO];
    }
    return _couponTypeLabel;
}
- (UILabel *)usingConditionLabel{
    if (!_usingConditionLabel) {
        _usingConditionLabel = [UILabel labelWithTextColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentCenter fontPixel:25.f setContentPriority:NO];
    }
    return _usingConditionLabel;
}
- (UIButton *)exchangeBtn{
    if (!_exchangeBtn) {
        _exchangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_exchangeBtn setBackgroundImage:[UIImage resizedImageWithName:@"btn_yichebi"] forState:UIControlStateNormal];
        _exchangeBtn.titleLabel.font = CYTFontWithPixel(26.f);
        [_exchangeBtn setTitleColor:CYTHexColor(@"#FFFFFF") forState:UIControlStateNormal];
        _exchangeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, CYTItemMarginH, 0, CYTItemMarginH);
        CYTWeakSelf
        [[_exchangeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [CYTAlertView alertViewWithTitle:@"提示" message:@"请确认是否兑换？" confirmAction:^{
                [weakSelf exchangeGoods];
            } cancelAction:nil];
        }];
    }
    return _exchangeBtn;
}

- (void)exchangeGoods{
    NSMutableDictionary *par = NSMutableDictionary.new;
    [par setValue:_goodsModel.goodId forKey:@"goodsId"];
    CYTIndicatorView *indicatorView = [CYTIndicatorView showIndicatorViewWithType:CYTIndicatorViewTypeEditNavBar];
    indicatorView.infoMessage = @"";
    [CYTNetworkManager POST:kURL.user_YCBGoods_exchange parameters:par dataTask:nil showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
        [CYTIndicatorView hideIndicatorView];
        if (responseObject.resultEffective) {
            NSString *userBitautoCoin = responseObject.dataDictionary[@"userBitautoCoin"];
            [CYTCoinCardView showSuccessWithType:CYTCoinCardTypeExchangeSuccess model:_goodsModel];
            !self.exchangeCallback?:self.exchangeCallback(userBitautoCoin);
        }else{
            [CYTToast messageToastWithMessage:responseObject.resultMessage];
        }
    }];
}

- (void)setGoodsModel:(CYTGoodsModel *)goodsModel{
    _goodsModel = goodsModel;
    self.couponvalueLabel.text = goodsModel.faceValue;
    self.couponTypeLabel.text = goodsModel.name;
    self.usingConditionLabel.text = goodsModel.condition;
    NSString *btnTitle = [NSString stringWithFormat:@"%@易车币兑换",goodsModel.exchangePrice];
    [self.exchangeBtn setTitle:btnTitle forState:UIControlStateNormal];
}


@end
