//
//  CYTLogisticsNeedAddressCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/11.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticsNeedAddressCell.h"

@implementation CYTLogisticsNeedAddressCell

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    [self.topView addSubview:self.flagImageView];
    [self.topView addSubview:self.flagLab];
    [self.topView addSubview:self.assistantLab];
    [self.topView addSubview:self.arrowImageView];
    [self.botView addSubview:self.vBgView];
    [self.botView addSubview:self.contentBgView];
    [self.botView addSubview:self.sepaView];
    [self.contentBgView addSubview:self.contentLab];
    
    NSArray *views = @[self.topView,self.botView,self.stateImageView];
    block(views,^{
        self.bottomLeftOffset = CYTMarginH;
        self.bottomRightOffset = (-CYTMarginH);
        self.backgroundColor = [UIColor whiteColor];
        
        [self.topView radius:1 borderWidth:1 borderColor:[UIColor clearColor]];
        [self.botView radius:1 borderWidth:1 borderColor:[UIColor clearColor]];
        
//    [self.flagLab setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        [self.flagImageView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.arrowImageView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    });
}

- (void)updateConstraints {
    [self.topView updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.ffContentView);
        make.bottom.equalTo(self.botView.top);
    }];
    [self.botView updateConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.ffContentView);
        make.top.equalTo(self.topView.bottom);
    }];
    [self.stateImageView updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTAutoLayoutV(30));
        make.right.equalTo((-CYTMarginH));
    }];
    [self.flagImageView updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topView);
        make.left.equalTo(CYTAutoLayoutH(20));
    }];
    [self.flagLab updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTAutoLayoutV(20));
        make.bottom.equalTo(-CYTAutoLayoutV(20));
        make.left.equalTo(self.flagImageView.right).offset(CYTAutoLayoutH(20));
        make.centerY.equalTo(self.flagImageView);
        make.right.lessThanOrEqualTo(self.arrowImageView.left).offset(-CYTAutoLayoutH(20));
    }];
    [self.assistantLab updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.flagImageView);
        make.right.equalTo(self.arrowImageView.left).offset(-CYTAutoLayoutH(20));
    }];
    [self.arrowImageView updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.flagImageView);
        make.right.equalTo(-CYTAutoLayoutH(30));
    }];
    [self.vBgView updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTAutoLayoutH(38));
        make.top.equalTo(self.botView);
        make.width.equalTo(CYTAutoLayoutH(4));
        make.height.equalTo(self.contentBgView);
    }];
    [self.contentBgView updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vBgView.right).offset(CYTAutoLayoutH(18));
        make.top.equalTo(0);
        make.right.equalTo(-CYTAutoLayoutH(60));
    }];
    [self.sepaView updateConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.botView);
        make.top.equalTo(self.contentBgView.bottom);
        make.height.equalTo(0);
    }];
    [self.contentLab updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentBgView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    
    UIEdgeInsets insect = UIEdgeInsetsZero;
    float space = 0;
    
    if (self.model && self.model.select && self.model.addressModel.detailAddress.length > 0) {
        insect = UIEdgeInsetsMake(10, 10, 10, 10);
        space = self.model.bottomOffset;
    }
    
    [self.sepaView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.botView);
        make.top.equalTo(self.contentBgView.bottom);
        make.height.equalTo(space);
    }];
    
    [self.contentLab remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentBgView).insets(insect);
    }];
    
    [super updateConstraints];
}

- (void)setModel:(CYTLogisticsNeedWriteCellModel *)model {
    _model = model;
    
    self.flagImageView.image = [UIImage imageNamed:model.imageName];
    self.flagLab.text = model.addressModel.mainAddress;
    
    self.botView.hidden = !model.select;
    self.hideBottomLine = model.select;
    self.contentLab.text = (model.select)?model.addressModel.detailAddress:@"";
    self.assistantLab.text = (model.select)?@"":model.placeholder;
    
    if (model.ffIndex == 99) {
        //显示bottomline
        self.hideBottomLine = NO;
    }
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark- get
- (UIView *)topView {
    if (!_topView) {
        _topView = [UIView new];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}

- (UIView *)botView {
    if (!_botView) {
        _botView = [UIView new];
        _botView.backgroundColor = [UIColor whiteColor];
        _botView.hidden = YES;
    }
    return _botView;
}

- (UIView *)sepaView {
    if (!_sepaView) {
        _sepaView = [UIView new];
        _sepaView.backgroundColor = [UIColor whiteColor];
    }
    return _sepaView;
}

- (UIImageView *)flagImageView {
    if (!_flagImageView) {
        _flagImageView = [UIImageView new];
        _flagImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _flagImageView;
}

- (UILabel *)flagLab {
    if (!_flagLab) {
        _flagLab = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L1];
        _flagLab.numberOfLines = 0;
    }
    return _flagLab;
}

- (UILabel *)assistantLab {
    if (!_assistantLab) {
        _assistantLab = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_gray];
    }
    return _assistantLab;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [UIImageView new];
        _arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
        _arrowImageView.image = [UIImage imageNamed:@"arrow_right"];
    }
    return _arrowImageView;
}

- (UIView *)vBgView {
    if (!_vBgView) {
        _vBgView = [UIView new];
        _vBgView.backgroundColor = [UIColor whiteColor];
        _vBgView.layer.masksToBounds = YES;
        
        [_vBgView addSubview:self.vImageView];
        [self.vImageView makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(_vBgView);
        }];
    }
    return _vBgView;
}

- (UIImageView *)vImageView {
    if (!_vImageView) {
        _vImageView = [UIImageView new];
        _vImageView.contentMode = UIViewContentModeScaleAspectFit;
        _vImageView.image = [UIImage imageNamed:@"logistic_nee_point"];
        _vImageView.layer.masksToBounds = YES;
    }
    return _vImageView;
}

- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L2];
        _contentLab.numberOfLines = 0;
    }
    return _contentLab;
}

- (UIView *)contentBgView {
    if (!_contentBgView) {
        _contentBgView = [UIView new];
        _contentBgView.backgroundColor = UIColorFromRGB(0xf8f8f8);
        [_contentBgView radius:1 borderWidth:1 borderColor:[UIColor clearColor]];
    }
    return _contentBgView;
}

- (UIImageView *)stateImageView {
    if (!_stateImageView ) {
        _stateImageView = [UIImageView new];
        _stateImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _stateImageView;
}

@end
