//
//  CYTPaySecondCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/24.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPaySecondCell.h"

@implementation CYTPaySecondCell

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
        [self.contentView addSubview:self.flagImageView];
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.subTitleLab];
        [self.contentView addSubview:self.selectButton];
        
        [self.flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(CYTAutoLayoutV(20));
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(CYTAutoLayoutH(30));
            make.bottom.equalTo(CYTAutoLayoutV(-20));
        }];
       
        [self.titleLab makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.flagImageView);
            make.left.equalTo(self.flagImageView.right).offset(CYTAutoLayoutH(20));
        }];
        [self.subTitleLab makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLab);
            make.bottom.equalTo(self.flagImageView);
        }];
        [self.selectButton makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-CYTAutoLayoutH(30));
            make.centerY.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setModel:(CYTPayCellModel *)model {
    _model = model;
    
    self.flagImageView.image = [UIImage imageNamed:model.imageName];
    self.titleLab.text = model.title;
    self.subTitleLab.text = model.subTitle;
    NSString *selectImage = (model.selectState)?@"pay_box_select":@"pay_box_nor";
    [self.selectButton setImage:[UIImage imageNamed:selectImage] forState:UIControlStateNormal];
    
}

#pragma mark- get
- (UIImageView *)flagImageView {
    if (!_flagImageView) {
        _flagImageView = [UIImageView new];
        _flagImageView.contentMode = UIViewContentModeScaleAspectFit;
        _flagImageView.image = [UIImage imageNamed:@"ic_zhifubao_hl"];
    }
    return _flagImageView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel labelWithFontPxSize:30 textColor:kFFColor_title_L1];
    }
    return _titleLab;
}

- (UILabel *)subTitleLab {
    if (!_subTitleLab) {
        _subTitleLab = [UILabel labelWithFontPxSize:22 textColor:kFFColor_title_gray];
    }
    return _subTitleLab;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectButton.userInteractionEnabled = NO;
    }
    return _selectButton;
}

@end
