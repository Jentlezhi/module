//
//  CYTStockCarCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/26.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTStockCarCell.h"

@implementation CYTStockCarCell

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.sepView,self.titleLab,self.subTitleLab,self.typeLabel,self.priceLab,self.line];
    block(views,^{
        self.bottomHeight = 0;
    });
}

- (void)updateConstraints {
    [self.sepView updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.ffContentView);
        make.height.equalTo(CYTAutoLayoutV(20));
    }];
    [self.titleLab updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sepView.bottom).offset(CYTItemMarginV);
        make.left.equalTo(CYTMarginH);
        make.right.equalTo((-CYTMarginH));
    }];
    [self.line updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.bottom).offset(CYTItemMarginV);
        make.left.equalTo(self.titleLab);
        make.height.equalTo(CYTLineH);
        make.right.equalTo((-CYTMarginH));
    }];
    [self.subTitleLab updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.top.equalTo(self.line.bottom).offset(CYTItemMarginV);
        make.right.equalTo((-CYTMarginH));
    }];
    [self.typeLabel updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.top.equalTo(self.subTitleLab.bottom).offset(CYTItemMarginV);
        make.bottom.lessThanOrEqualTo(-CYTItemMarginV);
    }];
    [self.priceLab updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTitleLab.bottom).offset(CYTItemMarginV);
        make.right.equalTo((-CYTMarginH));
        make.bottom.lessThanOrEqualTo(-CYTItemMarginV);
        make.left.greaterThanOrEqualTo(self.typeLabel.right).offset(CYTItemMarginH);
    }];
    
    [super updateConstraints];
}

- (void)setModel:(CYTStockCarModel *)model {
    _model = model;
    
    NSString *title = [NSString stringWithFormat:@"%@ %@",model.brandName,model.serialName];
    NSString *year;
    if (model.carYearType == 0) {
        year = @"";
    }else {
        year = [NSString stringWithFormat:@"%ld 款",model.carYearType];
    }
    
    NSString *subTitle = [NSString stringWithFormat:@"%@%@",year,model.carName];
    
    NSString *carType = model.carSourceTypeName;
    
    self.titleLab.text = title;
    self.subTitleLab.text = subTitle;
    self.typeLabel.text = carType;
    NSString *priceStr = model.carReferPrice.length?[NSString stringWithFormat:@"指导价：%@万元",model.carReferPrice]:@"";
    self.priceLab.text = priceStr;
    
}

#pragma mark- get
- (UIView *)sepView {
    if (!_sepView) {
        _sepView = [UIView new];
        _sepView.backgroundColor = kFFColor_bg_nor;
    }
    return _sepView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel labelWithFontPxSize:30 textColor:kFFColor_title_L1];
    }
    return _titleLab;
}

- (UILabel *)subTitleLab {
    if (!_subTitleLab) {
        _subTitleLab = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L2];
        _subTitleLab.numberOfLines = 0;
    }
    return _subTitleLab;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L2];
    }
    return _typeLabel;
}

- (UILabel *)priceLab {
    if (!_priceLab) {
        _priceLab = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L2];
    }
    return _priceLab;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = kFFColor_line;
    }
    return _line;
}

@end
