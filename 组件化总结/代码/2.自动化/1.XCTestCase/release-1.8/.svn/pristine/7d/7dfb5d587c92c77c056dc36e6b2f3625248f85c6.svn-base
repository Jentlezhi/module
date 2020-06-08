//
//  CYTSignTimeView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/9.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTSignTimeView.h"
#import "CYTDottedLine.h"
#import "MyYicheCoinConfig.h"
#import "CYTCoinSignModel.h"


static const CGFloat lineHeight = 0.5f;

@interface CYTSignTimeView()
/** 未签到天数 */
@property(strong, nonatomic) UILabel *noSignLabel;
/** 已签到天数 */
@property(strong, nonatomic) CYTRoundButton *signLabel;
/** 左虚线 */
@property(strong, nonatomic) CYTDottedLine *leftDottedLine;
/** 右虚线 */
@property(strong, nonatomic) CYTDottedLine *rightDottedLine;
/** 按钮虚线 */
@property(strong, nonatomic) CYTDottedLine *btnDottedLine;
@end

@implementation CYTSignTimeView

- (void)initSubComponents{
    [self addSubview:self.noSignLabel];
    [self addSubview:self.leftDottedLine];
    [self addSubview:self.rightDottedLine];
    [self addSubview:self.signLabel];
}

- (void)makeSubConstrains{
    [self.noSignLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    [self.leftDottedLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self.noSignLabel.mas_left).offset(-CYTAutoLayoutH(6));
        make.top.bottom.equalTo(self);
    }];
    
    [self.rightDottedLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.left.equalTo(self.noSignLabel.mas_right).offset(CYTAutoLayoutH(6));
        make.top.bottom.equalTo(self);
    }];
    
    [self.btnDottedLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.signLabel);
        make.left.right.equalTo(self.signLabel);
        make.height.equalTo(20.f);
    }];
}

#pragma mark - 懒加载

- (UILabel *)noSignLabel{
    if (!_noSignLabel) {
        _noSignLabel = [UILabel labelWithTextColor:CYTHexColor(@"#B6B6B6") textAlignment:NSTextAlignmentCenter fontPixel:28.f setContentPriority:NO];
        _noSignLabel.hidden = YES;
        _noSignLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _noSignLabel;
}

- (CYTRoundButton *)signLabel{
    if (!_signLabel) {
        _signLabel = [CYTRoundButton buttonWithType:UIButtonTypeCustom];
        _signLabel.hidden = YES;
        _signLabel.titleLabel.font = CYTFontWithPixel(28.f);
        [_signLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_signLabel setBackgroundImage:[UIImage imageWithColor:CYTHexColor(@"#6BCF78")] forState:UIControlStateNormal];
        _signLabel.frame = CGRectMake(0, 0, kSignViewWidth, CYTAutoLayoutV(kSignViewHeight));
        _signLabel.userInteractionEnabled = NO;
        _signLabel.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_signLabel addSubview:self.btnDottedLine];
    }
    return _signLabel;
}

- (CYTDottedLine *)leftDottedLine{
    if (!_leftDottedLine) {
        _leftDottedLine = CYTDottedLine.new;
        _leftDottedLine.hidden = YES;
        _leftDottedLine.lineHeight = lineHeight;
        _leftDottedLine.dotColor = CYTHexColor(@"#B6B6B6");
    }
    return _leftDottedLine;
}
- (CYTDottedLine *)rightDottedLine{
    if (!_rightDottedLine) {
        _rightDottedLine = CYTDottedLine.new;
        _rightDottedLine.hidden = YES;
        _rightDottedLine.lineHeight = lineHeight;
        _rightDottedLine.dotColor = CYTHexColor(@"#B6B6B6");
    }
    return _rightDottedLine;
}

- (CYTDottedLine *)btnDottedLine{
    if (!_btnDottedLine) {
        _btnDottedLine = CYTDottedLine.new;
        _btnDottedLine.hidden = YES;
        _btnDottedLine.lineHeight = lineHeight;
        _btnDottedLine.dotColor = CYTHexColor(@"#FFFFFF");
        _btnDottedLine.backgroundColor = CYTHexColor(@"#6BCF78");
    }
    return _btnDottedLine;
}

- (void)setCoinSignModel:(CYTCoinSignModel *)coinSignModel{
    _coinSignModel = coinSignModel;
    self.signLabel.hidden = !coinSignModel.hasSign;
    self.noSignLabel.hidden = coinSignModel.hasSign;
    if (coinSignModel.hasSign) {
        self.leftDottedLine.hidden = YES;
        self.rightDottedLine.hidden = YES;
        self.signLabel.cornerType = coinSignModel.cornerType;
        [self.signLabel setTitle:coinSignModel.title forState:UIControlStateNormal];
    }else{
        self.noSignLabel.text = coinSignModel.title ;
        self.leftDottedLine.hidden = coinSignModel.hideLeftDotLine;
        self.rightDottedLine.hidden = coinSignModel.hideRightDotLine;
    }
    self.btnDottedLine.hidden = !coinSignModel.btnShowDotLine;
}


@end
