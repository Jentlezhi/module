//
//  CYTGetCashPwdSettingSecondCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/22.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTGetCashPwdSettingSecondCell.h"

@implementation CYTGetCashPwdSettingSecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    [self.contentView addSubview:self.flagImageView];
    [self.contentView addSubview:self.textFiled];
    [self.contentView addSubview:self.identifyButton];
    [self.contentView addSubview:self.line];
    
    [self.flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(CYTAutoLayoutH(30));
    }];
    [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(CYTAutoLayoutH(100));
        make.right.equalTo(-CYTAutoLayoutH(210));
        make.height.equalTo(CYTAutoLayoutV(40));
    }];
    [self.identifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(-CYTAutoLayoutH(30));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.contentView);
        make.left.equalTo(CYTAutoLayoutH(100));
        make.height.equalTo(CYTLineH);
    }];
    
}

#pragma mark- get
- (UIImageView *)flagImageView {
    if (!_flagImageView) {
        _flagImageView = [UIImageView new];
        _flagImageView.contentMode = UIViewContentModeScaleAspectFit;
        _flagImageView.image = [UIImage imageNamed:@"me_pwd_identify"];
    }
    return _flagImageView;
}

- (UITextField *)textFiled {
    if (!_textFiled) {
        _textFiled = [UITextField new];
        _textFiled.font = CYTFontWithPixel(26);
        _textFiled.textColor = kFFColor_title_L1;
        _textFiled.placeholder = @"验证码";
        _textFiled.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _textFiled;
}

- (UIButton *)identifyButton {
    if (!_identifyButton) {
        _identifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_identifyButton setTitle:@" 获取验证码 " forState:UIControlStateNormal];
        [_identifyButton setTitleColor:UIColorFromRGB(0x2287ff) forState:UIControlStateNormal];
        _identifyButton.titleLabel.font = CYTFontWithPixel(26);
    }
    return _identifyButton;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = kFFColor_line;
    }
    return _line;
}

@end
