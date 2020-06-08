//
//  CYTCarSourceStatusCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/24.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSourceStatusCell.h"
#import "CYTCarSourcePublishItemModel.h"

@interface CYTCarSourceStatusCell()

/** 标题 */
@property(strong, nonatomic) UILabel *titleLabel;
/** 现货 */
@property(strong, nonatomic) UIButton *spotBtn;
/** 期货 */
@property(strong, nonatomic) UIButton *futuresBtn;
/** 分割线 */
@property(strong, nonatomic) UILabel *dividerLine;

@end

@implementation CYTCarSourceStatusCell


- (void)initSubComponents{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.spotBtn];
    [self.contentView addSubview:self.futuresBtn];
    [self.contentView addSubview:self.dividerLine];
}

- (void)makeSubConstrains{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(CYTMarginV);
        make.bottom.equalTo(-CYTMarginV);
    }];
    [self.futuresBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-CYTMarginH);
        make.centerY.equalTo(self.contentView);
    }];
    [self.spotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.futuresBtn.mas_left).offset(-CYTAutoLayoutH(60.f));
        make.centerY.equalTo(self.contentView);
    }];
    [self.dividerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(CYTDividerLineWH);
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.bottom.equalTo(self.contentView);
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithTextColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:YES];
    }
    return _titleLabel;
}

- (UIButton *)spotBtn{
    if (!_spotBtn) {
        _spotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_spotBtn setTitle:@" 现货" forState:UIControlStateNormal];
        _spotBtn.titleLabel.font = CYTFontWithPixel(26.f);
        [_spotBtn setTitleColor:CYTHexColor(@"#B6B6B6") forState:UIControlStateNormal];
        [_spotBtn setTitleColor:CYTHexColor(@"#666666") forState:UIControlStateSelected];
        [_spotBtn setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
        [_spotBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
        @weakify(_spotBtn);
        @weakify(self);
        [[_spotBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(_spotBtn);
            @strongify(self);
            if (!self.spotBtn.selected) {
                _spotBtn.selected = YES;
                self.futuresBtn.selected = NO;
                self.carSourcePublishItemModel.carSourceStatus = 1;
                self.carSourcePublishItemModel.select = YES;
                !self.carSourceStatusBlock?:self.carSourceStatusBlock(CYTCarSourceStatusSpot);
            }
        }];
    }
    return _spotBtn;
}
- (UIButton *)futuresBtn{
    if (!_futuresBtn) {
        _futuresBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_futuresBtn setTitle:@" 期货" forState:UIControlStateNormal];
        _futuresBtn.titleLabel.font = CYTFontWithPixel(26.f);
        [_futuresBtn setTitleColor:CYTHexColor(@"#B6B6B6") forState:UIControlStateNormal];
        [_futuresBtn setTitleColor:CYTHexColor(@"#666666") forState:UIControlStateSelected];
        [_futuresBtn setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
        [_futuresBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
        @weakify(_futuresBtn);
        @weakify(self);
        [[_futuresBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(_futuresBtn);
            @strongify(self);
            if (!self.futuresBtn.selected) {
                _futuresBtn.selected = YES;
                self.spotBtn.selected = NO;
                self.carSourcePublishItemModel.carSourceStatus = 2;
                self.carSourcePublishItemModel.select = YES;
                !self.carSourceStatusBlock?:self.carSourceStatusBlock(CYTCarSourceStatusFutures);
            }
        }];
    }
    return _futuresBtn;
}

- (UILabel *)dividerLine{
    if (!_dividerLine) {
        _dividerLine = [UILabel dividerLineLabel];
    }
    return _dividerLine;
}
- (void)setCarSourcePublishItemModel:(CYTCarSourcePublishItemModel *)carSourcePublishItemModel{
    _carSourcePublishItemModel = carSourcePublishItemModel;
    
    if (carSourcePublishItemModel.carSourceStatus == 0) {
        self.spotBtn.selected = self.futuresBtn.selected = NO;
    }else if (carSourcePublishItemModel.carSourceStatus == 1){
        self.spotBtn.selected = YES;
        self.futuresBtn.selected = NO;
    }else{
        self.futuresBtn.selected = YES;
        self.spotBtn.selected = NO;
    }
    self.titleLabel.text = carSourcePublishItemModel.title;
}

@end
