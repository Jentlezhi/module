//
//  CYTPayZeroCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/2.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPayZeroCell.h"

@interface CYTPayZeroCell ()
@property (nonatomic, strong) UILabel *firstLabel;
@property (nonatomic, strong) UILabel *secondLabel;

@end

@implementation CYTPayZeroCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark- get

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.firstLabel];
        [self.contentView addSubview:self.secondLabel];
        [self.firstLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(CYTAutoLayoutV(30));
            make.left.equalTo(CYTAutoLayoutH(30));
            make.right.equalTo(CYTAutoLayoutH(-30));
        }];
        
        [self.secondLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.firstLabel);
            make.right.equalTo(self.firstLabel);
            make.top.equalTo(self.firstLabel.bottom).offset(CYTAutoLayoutV(15));
            make.bottom.equalTo(CYTAutoLayoutV(-30));
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.firstLabel.text = title;
}

- (void)setSubTitle:(NSString *)subTitle {
    _subTitle = subTitle;
    
    self.secondLabel.text = subTitle;
    if (!subTitle ||[subTitle isEqualToString:@""]) {
        [self.secondLabel updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.firstLabel.bottom);
        }];
    }else {
        [self.secondLabel updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.firstLabel.bottom).offset(CYTAutoLayoutV(15));
        }];
    }
}

- (UILabel *)firstLabel {
    if (!_firstLabel) {
        _firstLabel = [UILabel labelWithFontPxSize:30 textColor:UIColorFromRGB(0xf43244)];
    }
    return _firstLabel;
}

- (UILabel *)secondLabel {
    if (!_secondLabel) {
        _secondLabel = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L2];
    }
    return _secondLabel;
}

@end
