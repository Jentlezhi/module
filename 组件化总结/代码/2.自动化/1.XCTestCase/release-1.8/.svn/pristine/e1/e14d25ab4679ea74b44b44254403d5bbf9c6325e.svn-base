//
//  CYTLogisticsNeedWriteDesCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/23.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticsNeedWriteDesCell.h"

#define kFlagString     @"温馨提示："
#define kDescString0    @"物流报价为起运地至目的地市区自提点的价格，\n自提点由物流公司提供，"
#define kDescString1    @"如需要将车辆从自提点运输至门店，\n请自行与物流公司沟通询价。"

@interface CYTLogisticsNeedWriteDesCell ()

@end

@implementation CYTLogisticsNeedWriteDesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark- flow control
///cell加载子视图
- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.flagImageView,self.flagLabel,self.descLabel0,self.descLabel1];
    block(views,^{
        self.bottomHeight = 0;
        self.ffContentView.backgroundColor = kFFColor_bg_nor;
    });
}

///cell布局
- (void)updateConstraints {
    [self.flagImageView updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTAutoLayoutH(25));
        make.top.equalTo(CYTAutoLayoutV(25));
    }];
    [self.flagLabel updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.flagImageView);
        make.left.equalTo(CYTAutoLayoutH(70));
    }];
    [self.descLabel0 updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.flagLabel);
        make.top.equalTo(self.flagLabel.bottom).offset(CYTItemMarginV);
    }];
    [self.descLabel1 updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.flagLabel);
        make.top.equalTo(self.descLabel0.bottom).offset(4);
        make.bottom.equalTo(0);
    }];
    
    [super updateConstraints];
}

///自定义cell样式
- (void)setFfCustomizeCellModel:(FFExtendTableViewCellModel *)ffCustomizeCellModel {
    
}

#pragma mark- api

#pragma mark- method

#pragma mark- set
///cell赋值
- (void)setFfModel:(id)ffModel {
    
}

#pragma mark- get
- (UIImageView *)flagImageView {
    if (!_flagImageView) {
        _flagImageView = [UIImageView ff_imageViewWithImageName:@"logistics_need_write_des"];
    }
    return _flagImageView;
}

- (UILabel *)flagLabel {
    if (!_flagLabel) {
        _flagLabel = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L1];
        _flagLabel.text = kFlagString;
    }
    return _flagLabel;
}

- (UILabel *)descLabel0 {
    if (!_descLabel0) {
        _descLabel0 = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L1];
        _descLabel0.backgroundColor = kFFColor_bg_nor;
        _descLabel0.numberOfLines = 0;
        NSString *string0 = @"自提点";
        NSRange range0 = [kDescString0 rangeOfString:string0];
        [_descLabel0 updateWithString:kDescString0 space:5 range:range0 font:CYTFontWithPixel(26) color:CYTGreenNormalColor];
    }
    return _descLabel0;
}

- (UILabel *)descLabel1 {
    if (!_descLabel1) {
        _descLabel1 = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L1];
        _descLabel1.backgroundColor = kFFColor_bg_nor;
        _descLabel1.numberOfLines = 0;
        NSString *string1 = @"请自行";
        NSRange range1 = [kDescString1 rangeOfString:string1];
        [_descLabel1 updateWithString:kDescString1 space:5 range:range1 font:CYTFontWithPixel(26) color:CYTGreenNormalColor];
    }
    return _descLabel1;
}



@end
