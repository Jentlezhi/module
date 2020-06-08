//
//  CYTDealerCommentCellView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/2.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTDealerCommentCellView.h"

@implementation CYTDealerCommentCellView

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.sepView];
    [self addSubview:self.headImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.commentLevelImageView];
    [self addSubview:self.commentLevelLabel];
    [self addSubview:self.commentContentLabel];
    [self addSubview:self.sourceLabel];
    [self addSubview:self.timeLabel];
    
    
    [self.sepView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(0);
        make.height.equalTo(0);
    }];
    [self.headImageView radius:CYTAutoLayoutH(20) borderWidth:0.5 borderColor:[UIColor clearColor]];
    [self.headImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTItemMarginH);
        make.top.equalTo(self.sepView.bottom).offset(CYTItemMarginV);
        make.width.height.equalTo(CYTAutoLayoutH(40));
    }];
    [self.nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headImageView);
        make.left.equalTo(self.headImageView.right).offset(CYTAutoLayoutH(10));
    }];

    [self.commentLevelImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headImageView);
        make.right.equalTo(self.commentLevelLabel.left).offset(-CYTAutoLayoutH(10));
        make.width.height.equalTo(CYTAutoLayoutH(40));
    }];

    [self.commentLevelLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headImageView);
        make.right.equalTo(-CYTItemMarginH);
    }];

    [self.commentContentLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.headImageView.bottom).offset(CYTAutoLayoutV(10));
        make.right.lessThanOrEqualTo(-CYTItemMarginH);
    }];

    [self.sourceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.commentContentLabel.bottom).offset(CYTItemMarginV);
        make.bottom.lessThanOrEqualTo(-CYTItemMarginV);
    }];

    [self.timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.sourceLabel);
        make.right.equalTo(-CYTItemMarginH);
        make.bottom.lessThanOrEqualTo(-CYTItemMarginV);
    }];

}

- (void)setNeedSep:(BOOL)needSep {
    _needSep = needSep;
    float height = (needSep)?CYTItemMarginV:0;
    [self.sepView updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(height);
    }];
}

- (void)setModel:(CYTDealerCommentListModel *)model {
    _model = model;
    
    if (!model) {
        return;
    }

    //evalType:1=好评、2=中评、3=差评
    NSString *levelString;
    NSString *leveImage;
    if (model.evalType.integerValue == 1) {
        levelString = @"好评";
        leveImage = @"dealer_comment_good_sel";
    }else if (model.evalType.integerValue == 2) {
        levelString = @"中评";
        leveImage = @"dealer_comment_mid_sel";
    }else {
        levelString = @"差评";
        leveImage = @"dealer_comment_bad_sel";
    }
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"dealer_comment_head"]];
    self.nameLabel.text = model.evaluator;
    self.commentLevelLabel.text = levelString;
    self.commentLevelImageView.image = [UIImage imageNamed:leveImage];
    self.commentContentLabel.text = model.content;
    self.sourceLabel.text = [NSString stringWithFormat:@"来源：%@",model.sourceTypeName];
    self.timeLabel.text = model.evalTime;
}

#pragma mark- get

- (UIView *)sepView {
    if (!_sepView) {
        _sepView = [UIView new];
        _sepView.backgroundColor = kFFColor_bg_nor;
    }
    return _sepView;
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
        _nameLabel = [UILabel labelWithFontPxSize:24 textColor:kFFColor_title_L2];
    }
    return _nameLabel;
}

- (UIImageView *)commentLevelImageView {
    if (!_commentLevelImageView) {
        _commentLevelImageView = [UIImageView ff_imageViewWithImageName:nil];
    }
    return _commentLevelImageView;
}

- (UILabel *)commentLevelLabel {
    if (!_commentLevelLabel) {
        _commentLevelLabel = [UILabel labelWithFontPxSize:22 textColor:CYTRedColor];
    }
    return _commentLevelLabel;
}

- (UILabel *)commentContentLabel {
    if (!_commentContentLabel) {
        _commentContentLabel = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L1];
        _commentContentLabel.numberOfLines = 0;
    }
    return _commentContentLabel;
}

- (UILabel *)sourceLabel {
    if (!_sourceLabel) {
        _sourceLabel = [UILabel labelWithFontPxSize:24 textColor:kFFColor_title_L3];
    }
    return _sourceLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithFontPxSize:24 textColor:kFFColor_title_L3];
    }
    return _timeLabel;
}

@end
