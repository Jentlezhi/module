//
//  CYTContactsContentView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAddressListContentView.h"
#import "CYTAddressModel.h"

@interface CYTAddressListContentView()


@end

@implementation CYTAddressListContentView
{
    //省市区地址
    UILabel *_proCityCountyLabel;
    //详细地址
    UILabel *_detailAddressLabel;
    //分割线
    UILabel *_lineLabel;
    //默认标识
    UILabel *_defaultIcon;

}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addressListContentBasicConfig];
        [self initAddressListContentComponents];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)addressListContentBasicConfig{
    self.backgroundColor = [UIColor clearColor];
}
/**
 *  初始化子控件
 */
- (void)initAddressListContentComponents{
    //省市区地址
    UILabel *proCityCountyLabel = [self itemLabelWithTextColor:CYTHexColor(@"#333333")];
    [self addSubview:proCityCountyLabel];
    _proCityCountyLabel = proCityCountyLabel;
    
    //默认标识
    UILabel *defaultIcon = [UILabel labelWithText:@"默认" textColor:CYTGreenNormalColor fontPixel:24.f cornerRadius:2.f borderWidth:1.0f];
    [self addSubview:defaultIcon];
    _defaultIcon = defaultIcon;
    
    //详细地址
    UILabel *detailAddressLabel = [self itemLabelWithTextColor:CYTHexColor(@"#666666")];
    [self addSubview:detailAddressLabel];
    _detailAddressLabel = detailAddressLabel;
    
    //分割线
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self addSubview:lineLabel];
    _lineLabel = lineLabel;

}
/**
 *  布局子控件
 */
- (void)makeConstrainsWithModel:(CYTAddressModel *)addressModel{
    CGFloat iconH = _defaultIcon.font.pointSize+4;
    [_proCityCountyLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        if (self.showDefaultIcon && addressModel.isDefault) {
            make.right.equalTo(-CYTMarginH*2-iconH*2);
        }else{
           make.right.equalTo(-CYTMarginH);
        }
        make.top.equalTo(CYTMarginV);
    }];
    
    [_detailAddressLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.top.equalTo(_proCityCountyLabel.mas_bottom).offset(CYTAutoLayoutV(30.f));
        make.bottom.equalTo(-CYTMarginH);
    }];
    
    [_lineLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTMarginH);
        make.right.equalTo(self).offset(-CYTMarginH);
        make.bottom.equalTo(self);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    //默认标识显示与隐藏
    if (self.showDefaultIcon && addressModel.isDefault) {
        [_defaultIcon remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-CYTMarginH);
            make.top.equalTo(_proCityCountyLabel);
            make.size.equalTo(CGSizeMake(iconH*2, iconH));
        }];
    }else{
        [_defaultIcon remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_proCityCountyLabel);
            make.right.width.height.equalTo(0);
        }];
    }
    

}



- (UILabel *)itemLabelWithTextColor:(UIColor *)textColor{
    UILabel *itemLabel = [[UILabel alloc] init];
    itemLabel.numberOfLines = 0;
    itemLabel.textColor = textColor;
    itemLabel.textAlignment = NSTextAlignmentLeft;
    itemLabel.font = CYTFontWithPixel(28);
    itemLabel.textColor = textColor;
    return itemLabel;
}

- (void)setAddressModel:(CYTAddressModel *)addressModel{
    _addressModel = addressModel;
    NSString *provinceName = addressModel.provinceName.length==0?@"":addressModel.provinceName;
    NSString *cityName = addressModel.cityName.length==0?@"":addressModel.cityName;
    NSString *countyName = addressModel.countyName.length==0?@"":addressModel.countyName;
    NSString *proCityCountyStr = [NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,countyName];
    _proCityCountyLabel.text = proCityCountyStr;
    _detailAddressLabel.text = addressModel.addressDetail;
    //分割线的显示与隐藏
    _lineLabel.hidden = self.showDefaultIcon;
    [self makeConstrainsWithModel:addressModel];
}

@end
