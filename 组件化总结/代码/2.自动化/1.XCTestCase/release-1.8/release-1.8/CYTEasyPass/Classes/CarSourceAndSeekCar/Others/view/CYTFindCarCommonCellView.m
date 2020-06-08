//
//  CYTFindCarCommonCellView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/4/24.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTFindCarCommonCellView.h"
#import "CYTSeekCarListModel.h"

@implementation CYTFindCarCommonCellView

- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    //////
    [self addSubview:self.separateView];
    [self addSubview:self.areaLabel];
    [self addSubview:self.guidePriceLabel];
    
    [self.separateView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(CYTAutoLayoutV(20));
    }];
    [self.titleLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.separateView.bottom);
        make.left.equalTo(CYTAutoLayoutH(20));
        make.height.equalTo(CYTAutoLayoutV(90));
    }];
    [self.typeButton remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.left.equalTo(self.titleLabel.right).offset(CYTAutoLayoutH(20));
        make.right.lessThanOrEqualTo(self.areaLabel.left).offset(CYTAutoLayoutH(-20));
    }];
    [self.areaLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.right.equalTo(-CYTItemMarginH);
    }];
    [self.guidePriceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTItemMarginH);
        make.top.equalTo(self.lineView.bottom).offset(CYTAutoLayoutV(20));
        make.bottom.lessThanOrEqualTo(self).offset(-CYTAutoLayoutV(20));
    }];
}

#pragma mark- get
- (UIView *)separateView {
    if (!_separateView) {
        _separateView = [UIView new];
        _separateView.backgroundColor = kFFColor_bg_nor;
    }
    return _separateView;
}

- (UILabel *)areaLabel {
    if (!_areaLabel) {
        _areaLabel = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L2];
    }
    return _areaLabel;
}

- (UILabel *)guidePriceLabel {
    if (!_guidePriceLabel) {
        _guidePriceLabel = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L2];
    }
    return _guidePriceLabel;
}

- (void)setSeekCarListModel:(CYTSeekCarListModel *)seekCarListModel{
    _seekCarListModel = seekCarListModel;
    CYTSeekCarInfo *seekCarInfo = seekCarListModel.seekCarInfo;
    //车型标题
    NSString *carTitle = [NSString stringWithFormat:@"%@ %@",seekCarInfo.brandName,seekCarInfo.serialName];
    self.titleLabel.text = carTitle;
    //经销商类型
    self.typeButton.hidden = YES;
    //卖区域
    NSString *areaString = [NSString string];
    if (seekCarInfo.registCardCityName.length) {
        areaString = [NSString stringWithFormat:@"上牌 %@",seekCarInfo.registCardCityName];
    }else{
        areaString = @"";
    }
    self.areaLabel.text = areaString;
    //子标题
    if (seekCarInfo.carYearType && ![seekCarInfo.carYearType isEqualToString:@"0"]) {
        self.subTitleLabel.text = [NSString stringWithFormat:@"%@款 %@",seekCarInfo.carYearType,seekCarInfo.carYearType];
    }else{
        self.subTitleLabel.text = seekCarInfo.carName;
    }
    //标签
    self.importView.title = seekCarInfo.carSourceTypeName;
    
    self.colorView.title = [self getDetailColor:seekCarInfo];
    self.cityLabel.hidden = YES;
    self.colorView.showRight = NO;
    
    //指导价
    NSString *carReferPriceDesc = seekCarInfo.carReferPriceDesc.length?seekCarInfo.carReferPriceDesc:@"暂无";
    self.guidePriceLabel.text = [NSString stringWithFormat:@"指导价：%@",carReferPriceDesc];
    //创建时间
    self.timeLabel.text = seekCarInfo.publishTime;
}

/**
 * 颜色设置
 */
- (NSString *)getDetailColor:(CYTSeekCarInfo *)seekCarInfo {
    NSString *color;
    NSString *exColor = seekCarInfo.exteriorColor;
    NSString *inColor = seekCarInfo.interiorColor;
    
    if (exColor.length>3) {
        NSString *tmp = [exColor substringToIndex:3];
        exColor = [NSString stringWithFormat:@"%@...",tmp];
    }
    
    if (inColor.length>3) {
        NSString *tmp = [inColor substringToIndex:3];
        inColor = [NSString stringWithFormat:@"%@...",tmp];
    }
    
    color = [NSString stringWithFormat:@"%@/%@",exColor,inColor];
    return color;
}




@end
