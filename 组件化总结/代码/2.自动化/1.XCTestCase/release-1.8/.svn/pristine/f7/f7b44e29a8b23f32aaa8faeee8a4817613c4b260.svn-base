//
//  CYTProfitLossDetailsCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/21.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTProfitLossDetailsCell.h"
#import "CYTCoinRecordModel.h"

@interface CYTProfitLossDetailsCell()
/** 标题 */
@property(strong, nonatomic) UILabel *titleLabel;
/** 金币 */
@property(strong, nonatomic) UIImageView *iconImageView;
/** 时间 */
@property(strong, nonatomic) UILabel *timeLabel;
/** 金币值 */
@property(strong, nonatomic) UILabel *coinValueLabel;
/** 分割线 */
@property(strong, nonatomic) UILabel *dividerLine;

@end

@implementation CYTProfitLossDetailsCell

- (void)initSubComponents{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.coinValueLabel];
    [self.contentView addSubview:self.dividerLine];

    //
    self.titleLabel.text = @"签到领易车币";
    self.timeLabel.text = @"2017-10-11 09:37:04";
    NSString *type = @"收入";
    self.coinValueLabel.text = [NSString stringWithFormat:@"%@%@",type,@"10"];
}

- (void)makeSubConstrains{
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(CYTAutoLayoutV(38.f));
        make.right.equalTo(-CYTAutoLayoutH(40.f));
        make.centerY.equalTo(self.contentView);
    }];
    [self.coinValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.iconImageView.mas_left).offset(-CYTAutoLayoutH(10.f));
        make.centerY.equalTo(self.contentView);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTMarginV);
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(self.coinValueLabel.mas_left).offset(-CYTItemMarginH);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(CYTMarginV);
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(self.titleLabel);
        make.bottom.equalTo(-CYTMarginV);
    }];

    [self.dividerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(CYTItemMarginH);
        make.right.equalTo(-CYTItemMarginH);
        make.height.equalTo(CYTDividerLineWH);
    }];
}
#pragma mark - 懒加载
- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [UILabel labelWithTextColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:32.f setContentPriority:NO];
    }
    return _titleLabel;
}
- (UIImageView *)iconImageView{
    if(!_iconImageView){
        _iconImageView = [UIImageView imageViewWithImageName:@"ic_coin_38_nor"];
    }
    return _iconImageView;
}
- (UILabel *)timeLabel{
    if(!_timeLabel){
        _timeLabel = [UILabel labelWithTextColor:CYTHexColor(@"#B6B6B6") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    }
    return _timeLabel;
}
- (UILabel *)coinValueLabel{
    if(!_coinValueLabel){
        _coinValueLabel = [UILabel labelWithTextColor:CYTHexColor(@"#A98C4F") textAlignment:NSTextAlignmentRight fontPixel:50.f setContentPriority:YES];
    }
    return _coinValueLabel;
}

- (UILabel *)dividerLine{
    if(!_dividerLine){
        _dividerLine = [UILabel dividerLineLabel];
    }
    return _dividerLine;
}
- (void)setCoinRecordModel:(CYTCoinRecordModel *)coinRecordModel{
    _coinRecordModel = coinRecordModel;
    self.titleLabel.text = coinRecordModel.recDescription;
    self.timeLabel.text = coinRecordModel.time;
    NSString *type = coinRecordModel.type == 1 ? @"+":@"-";
    self.coinValueLabel.text = [NSString stringWithFormat:@"%@%@",type,coinRecordModel.amount];
    self.dividerLine.hidden = coinRecordModel.hideDividerLine;
}

@end
