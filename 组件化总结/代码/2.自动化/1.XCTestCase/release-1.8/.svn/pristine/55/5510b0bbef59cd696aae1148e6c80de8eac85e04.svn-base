//
//  CYTSeekCarDetailFlowCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTSeekCarDetailFlowCell.h"

@interface CYTSeekCarDetailFlowCell ()

@end

@implementation CYTSeekCarDetailFlowCell

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
    NSArray *views = @[self.vline,self.flagLabel,self.hline,self.flowImageView];
    block(views,^{
        self.bottomHeight = 0;
        self.topHeight = CYTItemMarginV;
        self.ffTopLineColor = kFFColor_bg_nor;
    });
}

///cell布局
- (void)updateConstraints {
    [self.vline updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(CYTAutoLayoutV(18));
        make.height.equalTo(CYTAutoLayoutV(34));
        make.width.equalTo(CYTAutoLayoutH(6));
    }];
    [self.flagLabel updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vline.right).offset(CYTAutoLayoutH(14));
        make.top.equalTo(0);
        make.height.equalTo(CYTAutoLayoutV(70));
    }];
    [self.hline updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTItemMarginH);
        make.bottom.equalTo(self.flagLabel);
        make.height.equalTo(kFFLayout_line);
    }];
    [self.flowImageView updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.top.equalTo(self.hline.bottom);
        make.height.equalTo(CYTAutoLayoutV(240));
    }];
    
    [super updateConstraints];
}

///自定义cell样式
- (void)setFfCustomizeCellModel:(FFExtendTableViewCellModel *)ffCustomizeCellModel {
    
}

#pragma mark- api

#pragma mark- method

#pragma mark- set
///cell赋值
- (void)setFfModel:(id)ffModel {
    self.model = ffModel;
}

- (void)setModel:(CarSourceDetailDescModel *)model {
    _model = model;
    self.flagLabel.text = model.title;
    [self.flowImageView sd_setImageWithURL:[NSURL URLWithString:model.graphUrl] placeholderImage:[UIImage imageNamed:@"home_banner_placeholder"]];
}

#pragma mark- get
- (UIView *)vline {
    if (!_vline) {
        _vline = [UIView new];
        _vline.backgroundColor = CYTGreenNormalColor;
    }
    return _vline;
}

- (UILabel *)flagLabel {
    if (!_flagLabel) {
        _flagLabel = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L1];
    }
    return _flagLabel;
}

- (UIView *)hline {
    if (!_hline) {
        _hline = [UIView new];
        _hline.backgroundColor = kFFColor_line;
    }
    return _hline;
}

- (UIImageView *)flowImageView {
    if (!_flowImageView) {
        _flowImageView = [UIImageView ff_imageViewWithImageName:nil];
        _flowImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _flowImageView;
}


@end
