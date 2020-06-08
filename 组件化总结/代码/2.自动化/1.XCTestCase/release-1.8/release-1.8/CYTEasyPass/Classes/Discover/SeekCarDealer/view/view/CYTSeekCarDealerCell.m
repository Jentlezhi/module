//
//  CYTSeekCarDealerCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTSeekCarDealerCell.h"

@interface CYTSeekCarDealerCell ()

@end

@implementation CYTSeekCarDealerCell

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
    NSArray *views = @[self.headImageView,self.nameLabel,self.typeLabel,self.realStoreLabel,self.starView,self.companyNameLabel,self.mainBusinessLabel,self.arrowImageView];
    block(views,^{
        self.bottomHeight = 0;
        self.topHeight = CYTItemMarginV;
        self.ffTopLineColor = kFFColor_bg_nor;
        [self.nameLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    });
}

///cell布局
- (void)updateConstraints {
    [self.headImageView updateConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(CYTAutoLayoutH(90));
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(CYTMarginV);
    }];
    [self.nameLabel updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView);
        make.left.equalTo(self.headImageView.right).offset(CYTItemMarginH);
        make.width.lessThanOrEqualTo(kScreenWidth-CYTAutoLayoutH(400));
    }];
    [self.typeLabel updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel);
        make.left.equalTo(self.nameLabel.right).offset(5);
        make.height.equalTo(CYTAutoLayoutH(34));
        make.width.greaterThanOrEqualTo(CYTAutoLayoutH(34));
    }];
    [self.realStoreLabel updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel);
        make.left.equalTo(self.typeLabel.right).offset(5);
        make.height.equalTo(CYTAutoLayoutH(34));
        make.width.greaterThanOrEqualTo(CYTAutoLayoutH(34));
    }];
    
    extern CGFloat starWidth;
    extern CGFloat starHeight;
    [self.starView updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel);
        if (self.model.isStoreAuth) {
            //认证通过
            make.left.equalTo(self.realStoreLabel.right).offset(5);
        }else {
            make.left.equalTo(self.typeLabel.right).offset(5);
        }
        make.right.lessThanOrEqualTo(-CYTMarginH);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(starWidth)*5, CYTAutoLayoutV(starHeight)));
    }];
    [self.companyNameLabel updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.bottom).offset(CYTItemMarginV);
        make.right.lessThanOrEqualTo(-CYTAutoLayoutH(50));
    }];
    [self.mainBusinessLabel updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.companyNameLabel.bottom).offset(CYTItemMarginV);
        make.right.lessThanOrEqualTo(-CYTAutoLayoutH(50));
        make.bottom.lessThanOrEqualTo(-CYTMarginV);
    }];
    [self.arrowImageView updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-CYTAutoLayoutH(15));
        make.centerY.equalTo(0);
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

- (void)setModel:(CYTDealer *)model {
    _model = model;
    NSString *url = model.avatar;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"dealer_basic_head"]];
    self.nameLabel.text = model.userName;
    self.typeLabel.text = model.businessModel;
    
    if (model.isStoreAuth) {
        //实体认证通过
        self.realStoreLabel.text = @"实";
        self.realStoreLabel.hidden = NO;
    }else {
        self.realStoreLabel.text = @"";
        self.realStoreLabel.hidden = YES;
    }
    self.starView.starValue = model.starScore;
    self.companyNameLabel.text = [NSString stringWithFormat:@"公司：%@",model.companyName];
    self.mainBusinessLabel.text = [NSString stringWithFormat:@"主营：%@",model.carBrandName];
}

#pragma mark- get
- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [UIImageView ff_imageViewWithImageName:nil];
        [_headImageView radius:CYTAutoLayoutH(45) borderWidth:0.5 borderColor:kFFColor_line];
    }
    return _headImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFontPxSize:32 textColor:kFFColor_title_L1];
    }
    return _nameLabel;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [UILabel labelWithFontPxSize:24 textColor:[UIColor whiteColor]];
        [_typeLabel radius:1 borderWidth:0.5 borderColor:[UIColor clearColor]];
        _typeLabel.backgroundColor = UIColorFromRGB(0x3ec0fd);
        _typeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _typeLabel;
}

- (UILabel *)realStoreLabel {
    if (!_realStoreLabel) {
        _realStoreLabel = [UILabel labelWithFontPxSize:24 textColor:[UIColor whiteColor]];
        [_realStoreLabel radius:1 borderWidth:0.5 borderColor:[UIColor clearColor]];
        _realStoreLabel.backgroundColor = CYTRedColor;
        _realStoreLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _realStoreLabel;
}

- (CYTStarView *)starView {
    if (!_starView) {
        _starView = [CYTStarView new];
        _starView.starTotalNum = 5;
    }
    return _starView;
}

- (UILabel *)companyNameLabel {
    if (!_companyNameLabel) {
        _companyNameLabel = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L2];
    }
    return _companyNameLabel;
}

- (UILabel *)mainBusinessLabel {
    if (!_mainBusinessLabel) {
        _mainBusinessLabel = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L2];
    }
    return _mainBusinessLabel;
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
