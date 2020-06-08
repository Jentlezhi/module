//
//  CYTPayFirstCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/24.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPayFirstCell.h"

@implementation CYTPayFirstCell

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
        [self.contentView addSubview:self.flagLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.flagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(CYTAutoLayoutV(20));
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(CYTAutoLayoutH(30));
            make.bottom.equalTo(-CYTAutoLayoutV(20));
        }];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.flagLabel.mas_right).offset(5);
        }];
    }
    return self;
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
