//
//  CYTDealerHeadView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/9.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTDealerHeadView.h"

@implementation CYTDealerHeadView

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.bgImageView];
    [self addSubview:self.headImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.starView];
    [self addSubview:self.commentNumberLabel];
    
    [self.bgImageView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.headImageView radius:CYTAutoLayoutH(120)/2.0 borderWidth:0.5 borderColor:[UIColor clearColor]];
    [self.headImageView makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(CYTAutoLayoutH(120));
        make.left.equalTo(CYTAutoLayoutH(40));
        make.top.equalTo(CYTAutoLayoutV(118));
    }];
    [self.nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.right).offset(CYTItemMarginH);
        make.top.equalTo(self.headImageView).offset(CYTItemMarginV);
    }];
    [self.starView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.bottom).offset(CYTAutoLayoutV(26));
        make.width.equalTo(CYTAutoLayoutH(144));
        make.height.equalTo(CYTAutoLayoutH(24));
        extern CGFloat starWidth;
        extern CGFloat starHeight;
        
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(starWidth)*self.starView.starTotalNum, CYTAutoLayoutV(starHeight)));
    }];
    [self.commentNumberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.starView);
        make.left.equalTo(self.starView.right).offset(CYTAutoLayoutH(34));
        make.right.lessThanOrEqualTo(-CYTItemMarginH);
    }];
}

- (void)setModel:(CYTDealerHeadModel *)model {
    _model = model;
    
    self.nameLabel.text = model.userName;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"dealer_basic_head"]];
    self.commentNumberLabel.text = [NSString stringWithFormat:@"评价数量：%@",model.evalCount];
    self.starView.starValue = model.starScore;
}

#pragma mark- get
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [UIImageView ff_imageViewWithImageName:@"dealerHome_headBg"];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bgImageView;
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [UIImageView ff_imageViewWithImageName:@"dealer_basic_head"];
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFontPxSize:32 textColor:[UIColor whiteColor]];
        _nameLabel.text = @"";
    }
    return _nameLabel;
}

- (CYTStarView *)starView {
    if (!_starView) {
        _starView = [CYTStarView new];
        _starView.starTotalNum = 5;
    }
    return _starView;
}

- (UILabel *)commentNumberLabel {
    if (!_commentNumberLabel) {
        _commentNumberLabel = [UILabel labelWithFontPxSize:26 textColor:[UIColor whiteColor]];
        _commentNumberLabel.text = @"";
    }
    return _commentNumberLabel;
}

@end
