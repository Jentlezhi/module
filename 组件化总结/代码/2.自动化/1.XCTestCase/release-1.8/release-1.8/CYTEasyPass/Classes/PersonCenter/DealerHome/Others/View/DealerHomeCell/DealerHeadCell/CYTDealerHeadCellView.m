//
//  CYTDealerHeadCellView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTDealerHeadCellView.h"

@interface CYTDealerHeadCellView ()

@end

@implementation CYTDealerHeadCellView

- (void)ff_addSubViewAndConstraints {
    
    [self addSubview:self.companyNameLabel];
    [self addSubview:self.nameContentLabel];
    [self addSubview:self.flagLabel];
    [self addSubview:self.addressLabel];
    [self addSubview:self.addressContentLabel];
    [self addSubview:self.brandLabel];
    [self addSubview:self.brandContentLabel];
        
    [self.companyNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTAutoLayoutH(40));
        make.top.equalTo(CYTItemMarginV);
    }];
    [self.nameContentLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.companyNameLabel);
        make.left.equalTo(CYTAutoLayoutH(170));
    }];
    [self.flagLabel radius:1 borderWidth:0.5 borderColor:[UIColor clearColor]];
    [self.flagLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.companyNameLabel);
        make.left.equalTo(self.nameContentLabel.right).offset(CYTItemMarginH);
        make.right.lessThanOrEqualTo(-CYTItemMarginH);
        make.height.equalTo(CYTAutoLayoutV(32));
    }];
    [self.addressLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.companyNameLabel);
        make.top.greaterThanOrEqualTo(self.companyNameLabel.bottom).offset(CYTItemMarginV);
        make.top.greaterThanOrEqualTo(self.nameContentLabel.bottom).offset(CYTItemMarginV);
    }];
    [self.addressContentLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addressLabel);
        make.left.equalTo(self.nameContentLabel);
        make.right.lessThanOrEqualTo(-CYTItemMarginH);
    }];
    [self.brandLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.companyNameLabel);
        make.top.greaterThanOrEqualTo(self.addressLabel.bottom).offset(CYTItemMarginV);
        make.top.greaterThanOrEqualTo(self.addressContentLabel.bottom).offset(CYTItemMarginV);
        make.bottom.lessThanOrEqualTo(-CYTItemMarginV);
    }];
    [self.brandContentLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.brandLabel);
        make.left.equalTo(self.nameContentLabel);
        make.right.lessThanOrEqualTo(-CYTItemMarginH);
        make.bottom.lessThanOrEqualTo(-CYTItemMarginV);
    }];
    
}

- (void)setModel:(CYTDealerHeadModel *)model {
    _model = model;
    
    NSString *flagString;
    if (model.businessModel.length>0) {
        flagString = [NSString stringWithFormat:@" %@ ",model.businessModel];
    }else {
        flagString = @"";
    }
    
    self.flagLabel.text = flagString;
    self.nameContentLabel.text = model.companyName;
    self.addressContentLabel.text = model.location;
    self.brandContentLabel.text = model.carBrandName;
}

#pragma mark- get
- (UILabel *)companyNameLabel {
    if (!_companyNameLabel) {
        _companyNameLabel = [UILabel labelWithFontPxSize:24 textColor:kFFColor_title_L2];
        _companyNameLabel.text = @"公司全称";
    }
    return _companyNameLabel;
}

- (UILabel *)nameContentLabel {
    if (!_nameContentLabel) {
        _nameContentLabel = [UILabel labelWithFontPxSize:24 textColor:kFFColor_title_L1];
        _nameContentLabel.numberOfLines = 0;
    }
    return _nameContentLabel;
}

- (UILabel *)flagLabel {
    if (!_flagLabel) {
        _flagLabel = [UILabel labelWithFontPxSize:24 textColor:[UIColor whiteColor]];
        _flagLabel.backgroundColor = UIColorFromRGB(0x3EC0FD);
    }
    return _flagLabel;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [UILabel labelWithFontPxSize:24 textColor:kFFColor_title_L2];
        _addressLabel.text = @"所在地区";
    }
    return _addressLabel;
}

- (UILabel *)addressContentLabel {
    if (!_addressContentLabel) {
        _addressContentLabel = [UILabel labelWithFontPxSize:24 textColor:kFFColor_title_L1];
        _addressContentLabel.numberOfLines = 0;
    }
    return _addressContentLabel;
}

- (UILabel *)brandLabel {
    if (!_brandLabel) {
        _brandLabel = [UILabel labelWithFontPxSize:24 textColor:kFFColor_title_L2];
        _brandLabel.text = @"主营品牌";
    }
    return _brandLabel;
}

- (UILabel *)brandContentLabel {
    if (!_brandContentLabel) {
        _brandContentLabel = [UILabel labelWithFontPxSize:24 textColor:kFFColor_title_L1];
        _brandContentLabel.numberOfLines = 0;
    }
    return _brandContentLabel;
}

@end
