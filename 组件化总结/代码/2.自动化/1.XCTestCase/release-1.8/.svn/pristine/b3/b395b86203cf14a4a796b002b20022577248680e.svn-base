//
//  CYTYiCheCoinInfoView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTYiCheCoinInfoView.h"
#import "UILabel+BeatLabel.h"
#import "CYTCoinSignResultModel.h"

static const CFTimeInterval rotationDutation  = 8.f;

@interface CYTYiCheCoinInfoView()
/** 易车币金币图标 */
@property(strong, nonatomic) UIImageView *coinIconImageView;
/** 金额 */
@property(strong, nonatomic) UILabel *coinValueLabel;
/** 上次金额 */
@property(assign, nonatomic) NSInteger lastAmount;
/** 箭头 */
@property(strong, nonatomic) UIImageView *rightArrow;
/** 当前易车币 */
@property(strong, nonatomic) UILabel *currentCoinTipLabel;
/** 签到区域 */
@property(strong, nonatomic) UIView *signBgView;
/** 签到易车币个数 */
@property(strong, nonatomic) UILabel *signCoinNumTipLabel;
/** 签到按钮 */
@property(strong, nonatomic) UIButton *signBtn;
/** 旋转顺 */
@property(strong, nonatomic) UIImageView *rotateViewClockwise;
/** 旋转逆 */
@property(strong, nonatomic) UIImageView *rotateViewAnticlockwise;

@end

@implementation CYTYiCheCoinInfoView

- (void)basicConfig{
    self.backgroundColor = CYTHexColor(@"#27272F");
}

- (void)initSubComponents{
    [self addSubview:self.coinIconImageView];
    [self addSubview:self.coinValueLabel];
    [self addSubview:self.rightArrow];
    [self addSubview:self.currentCoinTipLabel];
    [self addSubview:self.signCoinNumTipLabel];
    [self addSubview:self.signBgView];
    [self addSubview:self.rotateViewClockwise];
    [self addSubview:self.rotateViewAnticlockwise];
    [self addSubview:self.signBtn];
}
- (void)makeSubConstrains{
    [self.coinIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTItemMarginV);
        make.left.equalTo(CYTItemMarginH);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(24.f), CYTAutoLayoutV(30.f)));
    }];
    
    [self.coinValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.coinIconImageView);
        make.left.equalTo(self.coinIconImageView.mas_right).offset(CYTAutoLayoutH(10.f));
    }];
    
    [self.rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.coinIconImageView);
        make.left.equalTo(self.coinValueLabel.mas_right).offset(CYTAutoLayoutH(10.f));
        make.width.height.equalTo(CYTAutoLayoutV(44.f));
    }];
    
    [self.currentCoinTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTItemMarginH);
        make.top.equalTo(self.coinValueLabel.mas_bottom).offset(CYTAutoLayoutV(18.f));
    }];
    
    [self.signCoinNumTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.signBgView.mas_left).offset(-CYTItemMarginH);
        make.centerY.equalTo(self.signBgView);
    }];
    
    [self.signBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-CYTAutoLayoutH(35.f));
        make.bottom.equalTo(-CYTAutoLayoutV(43.f));
        make.width.height.equalTo(CYTAutoLayoutV(130.f));
    }];
    
    [self.rotateViewClockwise mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.signBgView);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(152.f), CYTAutoLayoutV(123.f)));
    }];
    
    [self.rotateViewAnticlockwise mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.signBgView);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(152.f), CYTAutoLayoutV(123.f)));
    }];
    [self.signBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.signBgView);
        make.width.height.equalTo(CYTAutoLayoutV(130.f));
    }];
}

#pragma mark - 懒加载
- (UIImageView *)coinIconImageView{
    if (!_coinIconImageView) {
        _coinIconImageView = [UIImageView ff_imageViewWithImageName:@"ic_coin_nor"];
        CYTWeakSelf
        [_coinIconImageView addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
            !weakSelf.amountClick ?:weakSelf.amountClick();
        }];
    }
    return _coinIconImageView;
}
- (UILabel *)coinValueLabel{
    if (!_coinValueLabel) {
        _coinValueLabel = UILabel.new;
        _coinValueLabel.font = CYTBoldFontWithPixel(66.f);
        _coinValueLabel.textColor = CYTHexColor(@"#D4B273");
        CYTWeakSelf
        [_coinValueLabel addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
            !weakSelf.amountClick ?:weakSelf.amountClick();
        }];
    }
    return _coinValueLabel;
}

- (UIImageView *)rightArrow{
    if (!_rightArrow) {
        UIImage *arrowImage = [[UIImage imageNamed:@"arrow_right"] drawImageWithColor:[UIColor whiteColor]];
        _rightArrow = [UIImageView imageViewWithImage:arrowImage];
        CYTWeakSelf
        [_rightArrow addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
            !weakSelf.amountClick ?:weakSelf.amountClick();
        }];
    }
    return _rightArrow;
}

- (UILabel *)currentCoinTipLabel{
    if (!_currentCoinTipLabel) {
        _currentCoinTipLabel = [UILabel labelWithText:@"当前易车币" textColor:CYTHexColor(@"#FFFFFF") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:YES];
    }
    return _currentCoinTipLabel;
}
- (UILabel *)signCoinNumTipLabel{
    if (!_signCoinNumTipLabel) {
        _signCoinNumTipLabel = [UILabel labelWithTextColor:CYTHexColor(@"#FFFFFF") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:YES];
    }
    return _signCoinNumTipLabel;
}
- (UIView *)signBgView{
    if (!_signBgView) {
        _signBgView = UIView.new;
        _signBgView.backgroundColor = [UIColor clearColor];
    }
    return _signBgView;
}

- (UIImageView *)rotateViewClockwise{
    if (!_rotateViewClockwise) {
        _rotateViewClockwise = [UIImageView ff_imageViewWithImageName:@"pic_click_2_nor"];
        [_rotateViewClockwise addRotationAnimationWithDuration:rotationDutation clockwise:YES];
    }
    return _rotateViewClockwise;
}

- (UIImageView *)rotateViewAnticlockwise{
    if (!_rotateViewAnticlockwise) {
        _rotateViewAnticlockwise = [UIImageView ff_imageViewWithImageName:@"pic_click_3_nor"];
        [_rotateViewAnticlockwise addRotationAnimationWithDuration:rotationDutation clockwise:NO];
    }
    return _rotateViewAnticlockwise;
}
- (UIButton *)signBtn{
    if (!_signBtn) {
        _signBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _signBtn.adjustsImageWhenHighlighted = NO;
        [_signBtn setBackgroundImage:[UIImage imageNamed:@"pic_click_1_nor"] forState:UIControlStateNormal];
        [_signBtn setBackgroundImage:[UIImage imageNamed:@"pic_click_1_unsel"] forState:UIControlStateDisabled];
        [_signBtn setTitle:@"签到" forState:UIControlStateNormal];
        [_signBtn setTitle:@"已签到" forState:UIControlStateDisabled];
        _signBtn.titleLabel.textColor = CYTHexColor(@"#FFFFFF");
        _signBtn.titleLabel.font = CYTBoldFontWithPixel(34.f);
        CYTWeakSelf
        [[_signBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            !weakSelf.signBtnClick?:weakSelf.signBtnClick();
        }];
    }
    return _signBtn;
}
/**
 *  移除旋转动画
 */
- (void)stopRotationAnimation{
    [self.rotateViewClockwise.layer removeAllAnimations];
    [self.rotateViewAnticlockwise.layer removeAllAnimations];
}

- (void)setSignResultModel:(CYTCoinSignResultModel *)signResultModel{
    _signResultModel = signResultModel;
    BOOL isSignIn = signResultModel.isSignIn;
    !isSignIn?:[self stopRotationAnimation];
    self.signBtn.enabled = !isSignIn;
    NSString *keyWord = [NSString stringWithFormat:@"+%@",signResultModel.nextRewardValue];
    NSString *signPro = isSignIn ? @"明日签到可得":@"签到可得";
    NSString *content = [NSString stringWithFormat:@"%@ %@ 易车币",signPro,keyWord];
    self.signCoinNumTipLabel.attributedText = [NSMutableAttributedString attributedStringWithContent:content keyWord:keyWord keyFontPixel:32.f keyWordColor:CYTHexColor(@"#D4B273")];
    [self.coinValueLabel animationFromValue:self.lastAmount toValue:[signResultModel.amount integerValue] duration:kAnimationDurationInterval];
    self.lastAmount = [signResultModel.amount integerValue];
}

@end
