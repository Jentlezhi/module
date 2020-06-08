//
//  CYTGetCashPwdSettingFirstCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/22.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTGetCashPwdSettingFirstCell.h"

@implementation CYTGetCashPwdSettingFirstCell

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
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.line];
    
    [self.flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(CYTAutoLayoutH(30));
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(CYTAutoLayoutH(100));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.contentView);
        make.left.equalTo(CYTAutoLayoutH(100));
        make.height.equalTo(CYTLineH);
    }];
}

#pragma mark- get
- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = kFFColor_line;
    }
    return _line;
}

- (UIImageView *)flagImageView {
    if (!_flagImageView) {
        _flagImageView = [UIImageView new];
        _flagImageView.contentMode = UIViewContentModeScaleAspectFit;
        _flagImageView.image = [UIImage imageNamed:@"me_pwd_phone"];
    }
    return _flagImageView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.font = CYTFontWithPixel(30);
        _contentLabel.textColor = kFFColor_title_L1;
    }
    return _contentLabel;
}


@end
