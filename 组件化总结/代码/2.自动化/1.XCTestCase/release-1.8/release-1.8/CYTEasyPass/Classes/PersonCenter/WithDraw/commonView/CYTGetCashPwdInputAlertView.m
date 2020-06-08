//
//  CYTGetCashPwdInputAlertView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/23.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTGetCashPwdInputAlertView.h"

@implementation CYTGetCashPwdInputAlertView

- (void)ff_initWithViewModel:(id)viewModel {
    self.backgroundColor = [UIColor whiteColor];
}

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.cancelButton];
    [self addSubview:self.titleLabel];
    [self addSubview:self.line];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTAutoLayoutH(30));
        make.top.equalTo(CYTAutoLayoutH(20));
        make.size.equalTo(CGSizeMake(22, 22));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cancelButton);
        make.centerX.equalTo(self);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(CYTAutoLayoutH(90));
        make.height.equalTo(1);
    }];
    
    [self addSubview:self.flagLabel];
    [self addSubview:self.cashLabel];
    [self addSubview:self.desLabel];
    
    [self.flagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.cashLabel.mas_left).offset(-CYTAutoLayoutH(30));
        make.bottom.equalTo(-CYTAutoLayoutH(210));
    }];
    [self.cashLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-CYTAutoLayoutH(195));
        make.centerX.equalTo(self);
    }];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.flagLabel.mas_bottom);
        make.height.equalTo(CYTAutoLayoutH(100));
    }];
    
    [self addSubview:self.inputView];
    [self addSubview:self.alertLabel];
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(CYTAutoLayoutH(300));
        make.height.equalTo(CYTAutoLayoutH(70));
        make.left.equalTo(CYTAutoLayoutH(50));
        make.right.equalTo(-CYTAutoLayoutH(50));
    }];
    [self.alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.inputView.mas_bottom);
        make.height.equalTo(CYTAutoLayoutH(40));
    }];
}

- (void)setCashWillGet:(NSString *)cashWillGet {
    _cashWillGet = cashWillGet;
    self.cashLabel.text = cashWillGet;
//    float benefit = [cashWillGet floatValue]*0.006;
//    self.desLabel.text = [NSString stringWithFormat:@"额外扣除￥%.2f元手续费",benefit];
    self.desLabel.text = @"提现手续费平台已全额垫付";
}

- (void)setError:(NSString *)error {
    self.alertLabel.text = error;
    self.alertLabel.hidden = (error.length==0);
    
    if (error.length!=0) {
        [self.inputView clearAll];
    }
}

#pragma mark- get
- (UILabel *)alertLabel {
    if (!_alertLabel) {
        _alertLabel = [UILabel new];
        _alertLabel.font = CYTFontWithPixel(22);
        _alertLabel.textColor = CYTRedColor;
        _alertLabel.textAlignment = NSTextAlignmentCenter;
        _alertLabel.text = @"xxxxx";
        _alertLabel.hidden  = YES;
    }
    return _alertLabel;
}

- (CYTCommonPwdInputView *)inputView {
    if (!_inputView) {
        _inputView = [CYTCommonPwdInputView new];
        @weakify(self);
        [_inputView setFinishedBlock:^(NSString *pwd) {
            @strongify(self);
            if (self.finishedBlock) {
                self.finishedBlock(pwd);
            }
        }];
        [_inputView clearAll];
    }
    return _inputView;
}

#pragma mark- get
- (UILabel *)flagLabel {
    if (!_flagLabel) {
        _flagLabel = [UILabel new];
        _flagLabel.font = CYTFontWithPixel(30);
        _flagLabel.textColor = kFFColor_green;
        _flagLabel.textAlignment = NSTextAlignmentCenter;
        _flagLabel.text = @"￥";
    }
    return _flagLabel;
}

- (UILabel *)cashLabel {
    if (!_cashLabel) {
        _cashLabel = [UILabel new];
        _cashLabel.font = CYTFontWithPixel(82);
        _cashLabel.textColor = kFFColor_green;
        _cashLabel.text = @"xxxx";
    }
    return _cashLabel;
}

- (UILabel *)desLabel {
    if (!_desLabel) {
        _desLabel = [UILabel new];
        _desLabel.font = CYTFontWithPixel(24);
        _desLabel.textColor = kFFColor_title_L3;
        _desLabel.textAlignment = NSTextAlignmentCenter;
        _desLabel.text = @"xxxx";
    }
    return _desLabel;
}

#pragma mark- get
- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setImage:[UIImage imageNamed:@"cash_getCash_cancel"] forState:UIControlStateNormal];
        @weakify(self);
        [[_cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.cancelBlock) {
                self.cancelBlock();
            }
        }];
    }
    return _cancelButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = CYTFontWithPixel(32);
        _titleLabel.textColor = kFFColor_title_L1;
        _titleLabel.text = @"请输入提现密码";
    }
    return _titleLabel;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = kFFColor_line;
    }
    return _line;
}

@end
