//
//  CYTCarDealerChartMeView.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarDealerChartMeView.h"

@implementation CYTCarDealerChartMeView

- (void)ff_addSubViewAndConstraints {
    
    [self addSubview:self.bgImageView];
    [self addSubview:self.headImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.sortLabel];
    [self addSubview:self.assistanceLabel];
    
    [self.assistanceLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.bgImageView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.headImageView updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.width.height.equalTo(CYTAutoLayoutH(100));
        make.top.equalTo(CYTMarginV);
        make.bottom.equalTo(-CYTMarginV);
    }];
    [self.nameLabel updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.right).offset(CYTItemMarginH);
        make.top.equalTo(CYTMarginV);
        make.right.lessThanOrEqualTo(self.assistanceLabel.left).offset(-5);
    }];
    [self.sortLabel updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.bottom).offset(CYTAutoLayoutV(14));
        make.right.lessThanOrEqualTo(self.assistanceLabel.left).offset(-5);
    }];
    [self.assistanceLabel updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.right.equalTo(-CYTMarginH);
        make.width.greaterThanOrEqualTo(CYTAutoLayoutH(50));
    }];
}

- (void)setModel:(CYTCarDealerChartItemModel *)model {
    if (!model) {
        self.hidden = YES;
        return;
    }
    self.hidden = NO;
    _model = model;
    
    NSString *rankValue = (model.rankingId==-1)?@"暂无":[NSString stringWithFormat:@"%ld名",model.rankingId];
    NSString *ranking = [NSString stringWithFormat:@"当前排名：%@",rankValue];
    self.sortLabel.text = ranking;
    self.nameLabel.text = @"我";
    NSString *assistant = [NSString stringWithFormat:@"%ld",model.count];
    assistant = (self.type == CarDealerChartTypeSales)?[NSString stringWithFormat:@"%@ 辆",assistant]:[NSString stringWithFormat:@"%@ 条",assistant];
    self.assistanceLabel.text = assistant;
    [self.headImageView.bubbleButton sd_setImageWithURL:[NSURL URLWithString:model.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"dealer_basic_head"]];
}

#pragma mark- get
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [UIImageView new];
        _bgImageView.image = [UIImage imageNamed:@"discover_chartLine"];
        _bgImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _bgImageView;
}

- (UILabel *)sortLabel {
    if (!_sortLabel) {
        _sortLabel = [UILabel labelWithFontPxSize:28 textColor:[UIColor whiteColor]];
        _sortLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _sortLabel;
}

- (FFBubbleView *)headImageView {
    if (!_headImageView) {
        _headImageView = [FFBubbleView new];
        [_headImageView radius:CYTAutoLayoutH(50) borderWidth:2 borderColor:[UIColor whiteColor]];
        [_headImageView.bubbleButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
        _headImageView.bubbleButton.backgroundColor = [UIColor whiteColor];
        _headImageView.userInteractionEnabled = NO;
    }
    return _headImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFontPxSize:30 textColor:[UIColor whiteColor]];
    }
    return _nameLabel;
}

- (UILabel *)assistanceLabel {
    if (!_assistanceLabel) {
        _assistanceLabel = [UILabel labelWithFontPxSize:30 textColor:[UIColor whiteColor]];
    }
    return _assistanceLabel;
}

@end
