//
//  CYTMessageListCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTMessageListCell.h"

@interface CYTMessageListCell()
@property (nonatomic, assign) BOOL haveLink;

@end

@implementation CYTMessageListCell

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.iconImageView,self.titleLabel,self.contentLabel,self.timeLabel,self.linkButton];
    block(views,^{
        self.bottomHeight = 0;
        self.topHeight = CYTAutoLayoutV(20);
        self.ffTopLineColor = kFFColor_bg_nor;
        [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    });
}

- (void)updateConstraints {
    [self.iconImageView updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(CYTItemMarginV);
        make.width.height.equalTo(CYTAutoLayoutH(60));
    }];
    [self.titleLabel updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImageView);
        make.left.equalTo(self.iconImageView.right).offset(CYTItemMarginH);
        make.right.lessThanOrEqualTo(self.timeLabel.left).offset(-CYTItemMarginH);
    }];
    [self.timeLabel updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-CYTMarginH);
        make.centerY.equalTo(self.iconImageView);
    }];
    [self.contentLabel updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.bottom).offset(CYTItemMarginV);
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
    }];
    
    float height = (self.haveLink)?CYTAutoLayoutV(80):0;
    float space = (self.haveLink)?0:CYTItemMarginV;
    [self.linkButton updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.bottom).offset(space);
        make.height.equalTo(height);
        make.right.equalTo(self.contentLabel);
        make.bottom.equalTo(0);
    }];

    [super updateConstraints];
}

- (void)setFfModel:(id)ffModel {
    self.model = ffModel;
}

//消息类型(1:公告，2：活动通知，3：与我相关)
- (NSString *)getImageWithModel:(CYTMessageListModel *)model {
    NSString *name = @"";
    if (model.type == 1) {
        name = (model.isRead)?@"mess_ca_pub_gray":@"mess_ca_pub";
    }else if (model.type == 2) {
        name = (model.isRead)?@"mess_ca_activity_gray":@"mess_ca_activity";
    }else if (model.type == 3) {
        name = (model.isRead)?@"mess_ca_relative_gray":@"mess_ca_relative";
    }
    
    return name;
}

- (void)setModel:(CYTMessageListModel *)model {
    _model = model;
    
    self.titleLabel.text = model.title;
    self.timeLabel.text = model.time;
    self.contentLabel.text = model.content;
    self.iconImageView.image = [UIImage imageNamed:[self getImageWithModel:model]];
    
    //已读未读设置
    if (model.isRead) {
        self.titleLabel.textColor = kFFColor_title_L3;
        self.contentLabel.textColor = kFFColor_title_L3;
    }else {
        self.titleLabel.textColor = kFFColor_title_L1;
        self.contentLabel.textColor = kFFColor_title_L2;
    }
    
    //设置linkButton
    self.haveLink = (model.url && model.url.length>0);
    self.linkButton.hidden = !(self.haveLink);
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark- get
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [UIImageView ff_imageViewWithImageName:nil];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithFontPxSize:30 textColor:kFFColor_title_L1];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L2];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithFontPxSize:24 textColor:kFFColor_title_L3];
    }
    return _timeLabel;
}

- (UIButton *)linkButton {
    if (!_linkButton) {
        _linkButton = [UIButton buttonWithFontPxSize:24 textColor:kFFColor_green text:@"查看详情 >"];
        _linkButton.userInteractionEnabled = NO;
    }
    return _linkButton;
}

@end
