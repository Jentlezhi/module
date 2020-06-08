//
//  CYTLogisticsNeedDetailCarCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticsNeedDetailCarCell.h"

@implementation CYTLogisticsNeedDetailCarCell

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.titleLab,self.priceLab,self.subTitleLab,self.numberLab,self.expireLab,self.timeLab,self.needService];
    block(views,^{
        self.bottomHeight = 0;
    });
}

- (void)updateConstraints {
    [self.titleLab updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(self.ffContentView);
        make.height.equalTo(CYTAutoLayoutV(90));
        make.right.lessThanOrEqualTo(self.priceLab.left).offset(5);
    }];
    [self.priceLab updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLab);
        make.top.equalTo(0);
        make.right.equalTo((-CYTMarginH));
        make.height.equalTo(self.titleLab);
    }];
    [self.subTitleLab updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.top.equalTo(self.titleLab.bottom);
        make.right.lessThanOrEqualTo(self.numberLab).offset(-5);
    }];
    [self.numberLab updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.subTitleLab);
        make.right.equalTo((-CYTMarginH));
    }];
    [self.expireLab updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.top.equalTo(self.subTitleLab.bottom).offset(CYTAutoLayoutV(30));
    }];
    [self.timeLab updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.expireLab);
        make.right.equalTo((-CYTMarginH));
    }];
    [self.needService updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.top.equalTo(self.expireLab.bottom).offset(CYTAutoLayoutV(30));
        make.bottom.equalTo(-CYTAutoLayoutV(30));
    }];
    
    [super updateConstraints];
}

- (void)setModel:(CYTLogisticsNeedDetailCarModel *)model {
    _model = model;
    
    self.titleLab.text = model.title;
    self.priceLab.text = model.priceString;
    self.subTitleLab.text = model.subTitle;
    self.numberLab.text = model.numberString;
    self.timeLab.text = model.timeString;
    [self.needService setTitle:(model.transportHome)?@"需要送车上门":@"不需要送车上门" forState:UIControlStateNormal];
    
}

#pragma mark- get
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel labelWithFontPxSize:30 textColor:kFFColor_title_L1];
    }
    return _titleLab;
}

- (UILabel *)priceLab {
    if (!_priceLab) {
        _priceLab = [UILabel labelWithFontPxSize:24 textColor:kFFColor_title_L2];
        _priceLab.textAlignment = NSTextAlignmentRight;
    }
    return _priceLab;
}

- (UILabel *)subTitleLab {
    if (!_subTitleLab) {
        _subTitleLab = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L2];
    }
    return _subTitleLab;
}

- (UILabel *)numberLab {
    if (!_numberLab) {
        _numberLab = [UILabel labelWithFontPxSize:24 textColor:kFFColor_title_L2];
        _numberLab.textAlignment = NSTextAlignmentRight;
    }
    return _numberLab;
}

- (UILabel *)expireLab {
    if (!_expireLab) {
        _expireLab = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L2];
        _expireLab.text = @"需求有效期至";
    }
    return _expireLab;
}

- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = [UILabel labelWithFontPxSize:24 textColor:kFFColor_title_L2];
        _timeLab.textAlignment = NSTextAlignmentRight;
    }
    return _timeLab;
}

- (UIButton *)needService {
    if (!_needService) {
        _needService = [UIButton buttonWithType:UIButtonTypeCustom];
        [_needService setTitle:@"需要送车上门" forState:UIControlStateNormal];
        [_needService setTitleColor:kFFColor_title_L2 forState:UIControlStateNormal];
        [_needService setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
        _needService.titleLabel.font = CYTFontWithPixel(22);
        [_needService setImage:[UIImage imageNamed:@"logistic_need_service_image"] forState:UIControlStateNormal];
    }
    return _needService;
}

@end
