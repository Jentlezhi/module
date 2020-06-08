//
//  CYTMessageCategoryCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTMessageCategoryCell.h"

#define kBubbleWH   (CYTAutoLayoutH(32))

@implementation CYTMessageCategoryCell

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    [self.bubbleView addSubview:self.bubbleLabel];
    
    NSArray *views = @[self.iconImageView,self.bubbleView,self.titleLabel,self.timeLabel,self.contentLabel];
    block(views,^{
        self.bottomHeight = 0;
        self.topHeight = CYTAutoLayoutV(20);
        self.ffTopLineColor = kFFColor_bg_nor;
        [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    });
}

- (void)updateConstraints {

    [self.iconImageView updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ffContentView).offset(CYTAutoLayoutV(25));
        make.left.equalTo(CYTAutoLayoutH(20));
        make.width.height.equalTo(CYTAutoLayoutH(90));
        make.bottom.lessThanOrEqualTo(self.ffContentView).offset(-CYTAutoLayoutV(25));
    }];
    [self.bubbleView updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.right).offset(-CYTAutoLayoutH(26+3));
        make.top.equalTo(self.iconImageView.top).offset(-CYTAutoLayoutV(8+3));
    }];
    [self.titleLabel updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.right).offset(CYTItemMarginH);
        make.top.equalTo(self.iconImageView);
        make.right.lessThanOrEqualTo(self.timeLabel.left).offset(-CYTItemMarginH);
    }];
    [self.timeLabel updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-CYTAutoLayoutH(20));
        make.centerY.equalTo(self.titleLabel);
    }];
    [self.contentLabel updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(self.iconImageView);
    }];
    [self.bubbleLabel updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bubbleView).insets(UIEdgeInsetsMake(1.5, 1.5, 1.5, 1.5));
        make.height.equalTo(kBubbleWH);
        make.width.greaterThanOrEqualTo(kBubbleWH);
    }];
    
    [super updateConstraints];
}

//消息类型(1:公告，2：活动通知，3：与我相关)
- (NSString *)getImageWithModel:(CYTMessageCategoryModel *)model {
    NSString *name = @"";
    if (model.type == 1) {
        name = @"mess_ca_pub";
    }else if (model.type == 2) {
        name = @"mess_ca_activity";
    }else if (model.type == 3) {
        name = @"mess_ca_relative";
    }
    
    return name;
}

- (void)setFfCustomizeCellModel:(FFExtendTableViewCellModel *)ffCustomizeCellModel {
    //使用方法如下
    //针对可复用的cell，自定义样式,如果有多个地方对该cell进行了自定义那么使用字符区分
    if ([ffCustomizeCellModel.ffDescription isEqualToString:@"type0"]) {
        
    }else if ([ffCustomizeCellModel.ffDescription isEqualToString:@"type1"]) {
        
    }
}

- (void)setFfModel:(id)ffModel {
    self.model = ffModel;
}

- (void)setModel:(CYTMessageCategoryModel *)model {
    _model = model;

    if (model.icon.length>0) {
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:kDefaultPlaceholderImage];
    }else {
        self.iconImageView.image = [UIImage imageNamed:[self getImageWithModel:model]];
    }
    
    NSString *number;
    if (model.num == 0) {
        number = @"";
    }else if (model.num>99) {
        number = @" 99+ ";
    }else {
        number = [NSString stringWithFormat:@"%ld",model.num];
    }
    
    self.bubbleLabel.text = number;
    self.bubbleLabel.hidden = ([number isEqualToString:@""]);
    self.bubbleView.hidden = ([number isEqualToString:@""]);
    self.titleLabel.text = model.typeName;
    self.timeLabel.text = model.time;
    self.contentLabel.text = model.lastMessageTitle;
    
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

- (UILabel *)bubbleLabel {
    if (!_bubbleLabel) {
        _bubbleLabel = [UILabel labelWithFontPxSize:18 textColor:[UIColor whiteColor]];
        _bubbleLabel.backgroundColor = CYTRedColor;
        [_bubbleLabel radius:kBubbleWH/2.0 borderWidth:1 borderColor:CYTRedColor];
        _bubbleLabel.layer.shouldRasterize = YES;
        _bubbleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _bubbleLabel;
}

- (UIView *)bubbleView {
    if (!_bubbleView) {
        _bubbleView = [UIView new];
        _bubbleView.backgroundColor = [UIColor whiteColor];
        float radius = (kBubbleWH+1.5*2)/2.0;
        [_bubbleView radius:radius borderWidth:0.5 borderColor:[UIColor whiteColor]];
    }
    return _bubbleView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithFontPxSize:30 textColor:kFFColor_title_L1];
    }
    return _titleLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithFontPxSize:24 textColor:kFFColor_title_L3];
    }
    return _timeLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L2];
    }
    return _contentLabel;
}

@end
