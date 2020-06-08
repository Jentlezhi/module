//
//  CYTCarSourceCommonCellView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/4/24.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSourceCommonCellView.h"
#import "CYTDealer.h"
#import "CYTDetailModel.h"
#import "CYTCarSourceListModel.h"

@implementation CYTCarSourceCommonCellView

- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self addSubview:self.separateView];
    [self addSubview:self.hopeLabel];
    [self addSubview:self.guidePriceLabel];
    [self addSubview:self.arrowImageView];
    
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
        make.right.lessThanOrEqualTo(self.hopeLabel.left).offset(CYTAutoLayoutH(-20));
    }];
    [self.hopeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.right.equalTo(-CYTItemMarginH);
    }];
    [self.guidePriceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTItemMarginH);
        make.top.equalTo(self.lineView.bottom).offset(CYTAutoLayoutV(20));
        make.bottom.lessThanOrEqualTo(self).offset(-CYTAutoLayoutV(20));
    }];
    
    [self.arrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.guidePriceLabel);
        make.left.equalTo(self.guidePriceLabel.right).offset(CYTAutoLayoutH(5));
    }];
}

- (void)setArrowImageWithHopePrice:(float)hopePrice guidePrice:(float)guidePrice {
    
    NSComparisonResult result = [FFCommonCode compareDecimalValue1:guidePrice andValue2:hopePrice];
    
    if (hopePrice == 0 || guidePrice == 0 || result == 0) {
        //指导价暂无，或没有报价，或者指导价报价相同时候 不显示箭头
        self.arrowImageView.hidden = YES;
    }else {
        self.arrowImageView.hidden = NO;
        if (result == NSOrderedAscending) {
            //指导价小于报价，加价
            self.arrowImageView.image = [UIImage imageNamed:@"commonCell_arrowV_up"];
        }else {
            //优惠
            self.arrowImageView.image = [UIImage imageNamed:@"commonCell_arrowV_down"];
        }
    }
}

#pragma mark- get
- (UIView *)separateView {
    if (!_separateView) {
        _separateView = [UIView new];
        _separateView.backgroundColor = kFFColor_bg_nor;
    }
    return _separateView;
}

- (UILabel *)hopeLabel {
    if (!_hopeLabel) {
        _hopeLabel = [UILabel labelWithFontPxSize:28 textColor:CYTRedColor];
    }
    return _hopeLabel;
}

- (UILabel *)guidePriceLabel {
    if (!_guidePriceLabel) {
        _guidePriceLabel = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L2];
    }
    return _guidePriceLabel;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [UIImageView new];
        _arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowImageView;
}

- (void)setCarSourceListModel:(CYTCarSourceListModel *)carSourceListModel{
    _carSourceListModel = carSourceListModel;
    CYTCarSourceInfo *carSourceInfo = carSourceListModel.carSourceInfo;
    NSString *carTitle = [NSString stringWithFormat:@"%@ %@",carSourceInfo.brandName,carSourceInfo.serialName];
    self.titleLabel.text = carTitle;
    self.typeButton.hidden = YES;
    float price = [carSourceInfo.salePrice floatValue];
    NSString *priceString;
    if (price == 0) {
        priceString = @"0";
    }else{
        priceString = [NSString stringWithFormat:@"%.2f",price];
    }
    
    if ([priceString isEqualToString:@"0"]) {
        priceString = @"电议";
        self.hopeLabel.font = CYTFontWithPixel(26);
        self.hopeLabel.text = priceString;
    }else{
        priceString = [NSString stringWithFormat:@"%@ 万",priceString];
        self.hopeLabel.text = priceString;
        self.hopeLabel.font = [UIFont boldSystemFontOfSize:CYTAutoLayoutH(28)];
        NSRange range = NSMakeRange(priceString.length-1, 1);
        [self.hopeLabel updateWithRange:range font:CYTFontWithPixel(24) color:kFFColor_title_L2];
        
    }
    if (carSourceInfo.carYearType && ![carSourceInfo.carYearType isEqualToString:@"0"]) {
        self.subTitleLabel.text = [NSString stringWithFormat:@"%@款 %@",carSourceInfo.carYearType,carSourceInfo.carName];
    }else{
        self.subTitleLabel.text = carSourceInfo.carName;
    }
    
    self.importView.title = carSourceInfo.carSourceTypeName;
    
    self.colorView.title = [self getDetailColor:carSourceInfo];
    self.cityLabel.text = carSourceInfo.carSourceAddress;
    self.colorView.showRight = (carSourceInfo.carSourceAddress.length>0);
    self.timeLabel.text = carSourceInfo.publishTime;
    
    NSArray *resultArray = [self getGuidePriceNewMethod:carSourceInfo];
    NSString *guidePriceNewStr = resultArray[0];
    NSRange priceRange;
    if (resultArray.count == 2) {
        priceRange = NSRangeFromString(resultArray[1]);
    }else {
        priceRange = NSMakeRange(0, 0);
    }
    self.guidePriceLabel.text = guidePriceNewStr;
    if (priceRange.location !=0) {
        [self.guidePriceLabel updateWithRange:priceRange font:[UIFont boldSystemFontOfSize:CYTAutoLayoutH(28)] color:CYTRedColor];
    }
    
    //设置箭头显示
    float hopePriceValue = [priceString floatValue];
    float guidePriceValue = [carSourceInfo.carReferPrice floatValue];
    [self setArrowImageWithHopePrice:hopePriceValue guidePrice:guidePriceValue];
}

/**
 * 颜色设置
 */
- (NSString *)getDetailColor:(CYTCarSourceInfo *)carSourceInfo {
    NSString *color;
    NSString *exColor = carSourceInfo.exteriorColor;
    NSString *inColor = carSourceInfo.interiorColor;
    
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


- (NSArray *)getGuidePriceNewMethod:(CYTCarSourceInfo *)carSourceInfo {
    NSString *result;
    NSString *guidePriceString;
    NSString *benefitString;
    
    if ([carSourceInfo.carReferPrice floatValue] == 0) {
        result = @"指导价：暂无";
        return @[result];
    }else {
        guidePriceString = [NSString stringWithFormat:@"指导价：%@万",carSourceInfo.carReferPrice];
    }
    
    //指导价+优惠
    NSInteger mode = carSourceInfo.priceMode;
    float point = [carSourceInfo.priceBasicPoint floatValue];
    if (mode ==1) {
        //优惠  万
        benefitString = [NSString stringWithFormat:@"/优惠 %.2f 万元",point];
        if (point ==0) {
            benefitString = @"";
        }
    }else if (mode == 2) {
        //优惠 点
        benefitString = [NSString stringWithFormat:@"/优惠 %.2f 点",point];
        if (point ==0) {
            benefitString = @"";
        }
    }else if ( mode == 3) {
        //加价 万
        benefitString = [NSString stringWithFormat:@"/加价 %.2f 万元",point];
        if (point ==0) {
            benefitString = @"";
        }
    }else if (mode == 4) {
        float offset = [carSourceInfo.carReferPrice floatValue]-point;
        if (offset>0) {
            benefitString = [NSString stringWithFormat:@"/优惠 %.2f 万元",offset];
        }else if(offset<0){
            benefitString = [NSString stringWithFormat:@"/加价 %.2f 万元",-offset];
        }else{
            benefitString = @"";
        }
    }else {
        benefitString = @"";
    }
    
    result = [NSString stringWithFormat:@"%@%@",guidePriceString,benefitString];
    
    NSMutableArray *resultArray = [NSMutableArray array];
    [resultArray addObject:result];
    
    if (benefitString.length !=0) {
        NSRange range = NSMakeRange(4+guidePriceString.length, benefitString.length-6);
        NSString *rangeString = NSStringFromRange(range);
        [resultArray addObject:rangeString];
    }
    
    return resultArray;
}

@end
