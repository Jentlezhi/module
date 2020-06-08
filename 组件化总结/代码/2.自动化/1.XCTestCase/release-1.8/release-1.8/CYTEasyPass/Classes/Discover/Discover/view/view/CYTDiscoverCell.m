//
//  CYTDiscoverCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTDiscoverCell.h"

@interface CYTDiscoverCell ()

@end

@implementation CYTDiscoverCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark- flow control
///cell加载子视图
- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.flagImageView,self.flagLabel,self.arrowImageView];
    block(views,^{
        self.topHeight = CYTItemMarginV;
        self.ffTopLineColor = kFFColor_bg_nor;
        self.bottomHeight = 0;
    });
}

///cell布局
- (void)updateConstraints {
    [self.flagImageView updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTItemMarginH);
        make.width.height.equalTo(CYTAutoLayoutH(80));
        make.centerY.equalTo(0);
    }];
    [self.flagLabel updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(CYTAutoLayoutV(120));
        make.top.bottom.equalTo(0);
        make.left.equalTo(self.flagImageView.right).offset(CYTItemMarginH);
    }];
    [self.arrowImageView updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.flagImageView);
        make.right.equalTo(-CYTItemMarginH/2.0);
    }];
    
    [super updateConstraints];
}

///自定义cell样式
- (void)setFfCustomizeCellModel:(FFExtendTableViewCellModel *)ffCustomizeCellModel {
    
}

#pragma mark- 赋值
///cell赋值
- (void)setFfModel:(id)ffModel {
    self.model = ffModel;
}

- (void)setModel:(CYTDiscoverModel_cell *)model {
    self.flagImageView.image = [UIImage imageNamed:model.imageName];
    self.flagLabel.text = model.flagName;
}

#pragma mark- get
- (UILabel *)flagLabel {
    if (!_flagLabel) {
        _flagLabel = [UILabel labelWithFontPxSize:34 textColor:kFFColor_title_L1];
    }
    return _flagLabel;
}

- (UIImageView *)flagImageView {
    if (!_flagImageView) {
        _flagImageView = [UIImageView ff_imageViewWithImageName:nil];
    }
    return _flagImageView;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [UIImageView new];
        _arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
        _arrowImageView.image = [UIImage imageNamed:@"arrow_right"];
    }
    return _arrowImageView;
}



@end
