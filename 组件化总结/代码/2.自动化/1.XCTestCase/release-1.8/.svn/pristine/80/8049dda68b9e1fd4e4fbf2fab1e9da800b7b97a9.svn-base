//
//  CYTCoinHeaderView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/14.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCoinHeaderView.h"
#import "CYTCoinSectionModel.h"

@interface CYTCoinHeaderView()

/** 黑色条 */
@property(strong, nonatomic) UIView *barView;
/** 标题 */
@property(strong, nonatomic) UILabel *titleLabel;
/** 内容 */
@property(strong, nonatomic) UILabel *contentLabel;
/** 箭头 */
@property(strong, nonatomic) UIImageView *arrowIcon;

@end

@implementation CYTCoinHeaderView

- (void)basicConfig{
    CYTWeakSelf
    [self addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
        !weakSelf.clickCallBack?:weakSelf.clickCallBack();
    }];
}

- (void)initSubComponents{
    [self addSubview:self.barView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.arrowIcon];
}

- (void)makeSubConstrains{
    [self.barView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(CYTAutoLayoutH(6.f), CYTAutoLayoutH(34.f)));
        make.left.equalTo(CYTItemMarginH);
        make.centerY.equalTo(self);
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.barView.mas_right).offset(CYTAutoLayoutH(15.f));
        make.right.equalTo(self.contentLabel.mas_left).offset(-CYTItemMarginH);
    }];

    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowIcon.mas_left);
        make.centerY.equalTo(self);
    }];

    [self.arrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(CYTAutoLayoutV(44.f));
        make.right.equalTo(-CYTAutoLayoutH(10.f));
        make.centerY.equalTo(self);
    }];
}

#pragma mark - 懒加载
- (UIView *)barView{
    if (!_barView) {
        _barView = UIView.new;
        _barView.backgroundColor = CYTHexColor(@"#27272F");
    }
    return _barView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithTextColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    }
    return _titleLabel;
}
- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentRight fontPixel:24.f setContentPriority:NO];
        _contentLabel.hidden = YES;
    }
    return _contentLabel;
}

- (UIImageView *)arrowIcon{
    if (!_arrowIcon) {
        _arrowIcon = [UIImageView ff_imageViewWithImageName:@"arrow_right"];
        _arrowIcon.hidden = YES;
    }
    return _arrowIcon;
}

- (void)setSectionModel:(CYTCoinSectionModel *)sectionModel{
    _sectionModel = sectionModel;
    self.titleLabel.text = sectionModel.title;
    self.contentLabel.text = sectionModel.content.length?sectionModel.content:@"";
    self.contentLabel.hidden = !sectionModel.content.length;
    self.arrowIcon.hidden = !sectionModel.content.length;
}

@end
