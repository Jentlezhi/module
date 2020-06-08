//
//  CYTComonRewardCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTComonRewardCell.h"
#import "CYTTaskModel.h"


@interface CYTComonRewardCell()
/** 分割线 */
@property(strong, nonatomic) UILabel *dividerLine;
/** 背景 */
@property(strong, nonatomic) UIView *bgView;
/** 内容 */
@property(strong, nonatomic) UILabel *contentLabel;


@end

@implementation CYTComonRewardCell

- (void)initSubComponents{
    [self.contentView addSubview:self.dividerLine];
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.contentLabel];
}

- (void)makeSubConstrains{
    [self.dividerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(CYTItemMarginH);
        make.right.equalTo(-CYTItemMarginH);
        make.height.equalTo(CYTDividerLineWH);
    }];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(CYTItemMarginV, CYTItemMarginH, CYTAutoLayoutV(40.f), CYTItemMarginH));
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTMarginV);
        make.left.equalTo(CYTItemMarginH);
        make.right.equalTo(-CYTItemMarginH);
        make.bottom.equalTo(-CYTAutoLayoutV(28.f));
    }];
}
- (UILabel *)dividerLine{
    if (!_dividerLine) {
        _dividerLine = [UILabel dividerLineLabel];
    }
    return _dividerLine;
}
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = UIView.new;
        _bgView.backgroundColor = CYTHexColor(@"#FCFAF1");
    }
    return _bgView;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithTextColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:NO];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (void)setTaskModel:(CYTTaskModel *)taskModel{
    _taskModel = taskModel;
    self.contentLabel.text = taskModel.rewardContent;
    NSAttributedString *aString = [NSAttributedString attributedWithLabel:self.contentLabel lineSpacing:self.contentLabel.font.pointSize*0.1];
     self.contentLabel.attributedText = aString;
}

@end
