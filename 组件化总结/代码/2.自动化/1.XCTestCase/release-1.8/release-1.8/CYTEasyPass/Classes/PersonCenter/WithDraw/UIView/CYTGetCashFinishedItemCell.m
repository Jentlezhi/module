//
//  CYTGetCashFinishedItemCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/24.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTGetCashFinishedItemCell.h"

@implementation CYTGetCashFinishedItemCell

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
    [self.contentView addSubview:self.flagLabel];
    [self.contentView addSubview:self.contentLabel];
    
    [self.flagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(CYTAutoLayoutH(30));
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(-CYTAutoLayoutH(30));
    }];
}

#pragma mark- get
- (UILabel *)flagLabel {
    if (!_flagLabel) {
        _flagLabel = [UILabel new];
        _flagLabel.font = CYTFontWithPixel(26);
        _flagLabel.textColor = kFFColor_title_L1;
    }
    return _flagLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.font = CYTFontWithPixel(26);
        _contentLabel.textColor = kFFColor_title_L1;
    }
    return _contentLabel;
}

@end
