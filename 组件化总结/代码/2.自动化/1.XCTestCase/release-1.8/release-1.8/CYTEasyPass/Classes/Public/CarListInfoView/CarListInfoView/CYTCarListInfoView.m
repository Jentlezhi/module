//
//  CYTCarListInfoView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/8/2.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarListInfoView.h"
#import "CYTCarSourceListModel.h"
#import "CYTCarSourceInfo.h"
#import "CYTSeekCarListModel.h"
#import "CYTSeekCarInfo.h"
#import "CYTDealer.h"
#import "CYTCarModel.h"

@interface CYTCarListInfoView()

/** 类型 */
@property(assign, nonatomic) CYTCarListInfoType carListInfoType;
/** 是否隐藏分割条 */
@property(assign, nonatomic) BOOL hideTopBar;
/** 过期的标志 */
@property(strong, nonatomic) UIImageView *expiredIcon;
@end

@implementation CYTCarListInfoView
{
    //分割条
    UIView *_topBar;
    //标题
    UILabel *_titelLabel;
    //指导价
    UILabel *_guidePriceLabel;
    //上牌地区
    UILabel *_registrationAreaLabel;
    //报价基点
    UILabel *_priceBasicPointLabel;
    //副标题
    UILabel *_subTitleLabel;
    //报价
    UILabel *_officePriceLabel;
    //车源类型
    UILabel *_carsourceTypeLabel;
    //车源类型分割线
    UILabel *_carsourceTypeLine;
    //外观/内饰颜色
    UILabel *_exInColorLabel;
    //外观/内饰颜色分割线
    UILabel *_exInColorLine;
    //车源地
    UILabel *_carSourceAreaLabel;
    
    //成交价
    UILabel *_dealPriceLabel;
    //订金
    UILabel *_depositLabel;
    //已付
    UILabel *_payPartDescLabel;
}

- (UIImageView *)expiredIcon{
    if (!_expiredIcon) {
        _expiredIcon = [UIImageView ff_imageViewWithImageName:@"logistics_need_expired"];
        _expiredIcon.hidden = YES;
    }
    return _expiredIcon;
}

+ (instancetype)carListInfoWithType:(CYTCarListInfoType)carListInfoType hideTopBar:(BOOL)hide{
    CYTCarListInfoView *carListInfoView = [[CYTCarListInfoView alloc] initWithType:carListInfoType hideTopBar:hide];
    return carListInfoView;
}
- (instancetype)initWithType:(CYTCarListInfoType)carListInfoType hideTopBar:(BOOL)hide{
    if (self = [super init]) {
        [self carListInfoBasicConfigWithType:carListInfoType hideTopBar:hide];
        [self initCarListInfoComponentsWithType:carListInfoType hideTopBar:hide];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)carListInfoBasicConfigWithType:(CYTCarListInfoType)carListInfoType hideTopBar:(BOOL)hide{
    self.backgroundColor = [UIColor clearColor];
    self.carListInfoType = carListInfoType;
    self.hideTopBar = hide;
    self.clipsToBounds = YES;
}
/**
 *  初始化子控件
 */
- (void)initCarListInfoComponentsWithType:(CYTCarListInfoType)carListInfoType hideTopBar:(BOOL)hide{
    //分割条
    UIView *topBar = [[UIView alloc] init];
    topBar.hidden = hide;
    topBar.backgroundColor = kFFColor_bg_nor;
    [self addSubview:topBar];
    _topBar = topBar;
    
    //标题
    UILabel *titelLabel = [UILabel labelWithTextColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:30.f setContentPriority:NO];
    [self addSubview:titelLabel];
    _titelLabel = titelLabel;
    
    //指导价
    UILabel *guidePriceLabel = [UILabel labelWithTextColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:30.f setContentPriority:NO];
    guidePriceLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    [self addSubview:guidePriceLabel];
    _guidePriceLabel = guidePriceLabel;
    
    if (carListInfoType == CYTCarListInfoTypeCarSource) {
        //报价基点
        UILabel *priceBasicPointLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:YES];
        priceBasicPointLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [self addSubview:priceBasicPointLabel];
        _priceBasicPointLabel = priceBasicPointLabel;
        
        //报价
        UILabel *offerPeiceLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentRight fontPixel:26.f setContentPriority:YES];
        offerPeiceLabel.hidden = YES;
        [self addSubview:offerPeiceLabel];
        _officePriceLabel = offerPeiceLabel;
        
        //车源地
        UILabel *carSourceAreaLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
        [self addSubview:carSourceAreaLabel];
        _carSourceAreaLabel = carSourceAreaLabel;
        
        //成交价
        UILabel *dealPriceLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:YES];
        dealPriceLabel.hidden = YES;
        [self addSubview:dealPriceLabel];
        _dealPriceLabel = dealPriceLabel;
        
        //订金
        UILabel *depositLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:YES];
        depositLabel.hidden = YES;
        [self addSubview:depositLabel];
        _depositLabel = depositLabel;
    }else{
        //上牌地区
        UILabel *registrationAreaLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:YES];
        [self addSubview:registrationAreaLabel];
        _registrationAreaLabel = registrationAreaLabel;
    }
    
    //副标题
    UILabel *subTitleLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    [self addSubview:subTitleLabel];
    _subTitleLabel = subTitleLabel;
    
    //车源类型
    UILabel *carsourceTypeLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    [self addSubview:carsourceTypeLabel];
    _carsourceTypeLabel = carsourceTypeLabel;
    
    //车源类型分割线
    UILabel *carsourceTypeLine = [[UILabel alloc] init];
    carsourceTypeLine.backgroundColor = CYTHexColor(@"#B6B6B6");
    [self addSubview:carsourceTypeLine];
    _carsourceTypeLine = carsourceTypeLine;
    
    //外观/内饰颜色
    UILabel *exInColorLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    [self addSubview:exInColorLabel];
    _exInColorLabel = exInColorLabel;
    
    //外观/内饰颜色分割线
    UILabel *exInColorLine = [[UILabel alloc] init];
    exInColorLine.backgroundColor = carsourceTypeLine.backgroundColor;
    [self addSubview:exInColorLine];
    _exInColorLine = exInColorLine;
    
    
    //已付
    UILabel *payedLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentRight fontPixel:24.f setContentPriority:YES];
    payedLabel.hidden = YES;
    [self addSubview:payedLabel];
    _payPartDescLabel = payedLabel;
    
    //过期标识
    [self addSubview:self.expiredIcon];
    
    [self.expiredIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(CYTAutoLayoutV(120.f));
        make.top.equalTo(CYTItemMarginV*2);
        make.right.equalTo(-CYTMarginH);
    }];
    //测试数据
//    _titelLabel.text = @"吉利 博越";
//    _guidePriceLabel.text = @"12.38234567890万";
//    _registrationAreaLabel.text = @"上牌 尼古拉奥斯特洛夫斯基市";
//    _priceBasicPointLabel.text = @"下1.5万";
//    _subTitleLabel.text = @"2016款 1.8T 自动 智享版";
//    _officePriceLabel.text = @"报价：30.23万";
//    _carsourceTypeLabel.text = @"国产/合资";
//    _exInColorLabel.text = @"金色/玫瑰金";
//    _carSourceAreaLabel.text = @"北区";
}
#pragma make - 赋值(在售车源)
/**
 *  车源数据
 */
- (void)setCarSourceListModel:(CYTCarSourceListModel *)carSourceListModel{
    if (!carSourceListModel) return;
    _carSourceListModel = carSourceListModel;
    [self setValueWithcarSourceListModel:carSourceListModel];
    [self layoutWithcarSourceListModel:carSourceListModel];
}
- (void)setValueWithcarSourceListModel:(CYTCarSourceListModel *)carSourceListModel{
    CYTCarSourceInfo *carSourceInfo = carSourceListModel.carSourceInfo;
    CYTDealer *dealer = carSourceListModel.dealer;
    dealer.publishTime = carSourceInfo.publishTime;
    //标题
    NSString *brandName = carSourceInfo.brandName.length?carSourceInfo.brandName:@"";
    NSString *serialName = carSourceInfo.serialName.length?carSourceInfo.serialName:@"";
    NSString *titleContent = [NSString stringWithFormat:@"%@ %@",brandName,serialName];
    _titelLabel.text = titleContent;
    //指导价
    NSString *carReferPriceDesc = carSourceInfo.carReferPriceDesc.length?carSourceInfo.carReferPriceDesc:@"";
    if (!carReferPriceDesc.length && carSourceInfo.carReferPrice.length && ![carSourceInfo.carReferPrice isEqualToString:@"0"]) {
        carReferPriceDesc = [NSString stringWithFormat:@"%@ 万",carSourceInfo.carReferPrice];
    }
    _guidePriceLabel.text = carReferPriceDesc;
    //上牌地区
    NSString *egistrationContent = [NSString string];
    if (carSourceInfo.registCardCityName.length) {
        egistrationContent = carSourceInfo.registCardCityName.length?[NSString stringWithFormat:@"上牌 %@",carSourceInfo.registCardCityName]:@"";
    }else{
        egistrationContent = carSourceInfo.registCardProvinceName.length?carSourceInfo.registCardProvinceName:@"";
    }
    _registrationAreaLabel.text = egistrationContent;
    
    //报价基点
    _priceBasicPointLabel.attributedText = [self priceModeWithcarSourceListModel:carSourceListModel];
    //副标题
    NSString *fullCarName = carSourceInfo.fullCarName.length?carSourceInfo.fullCarName:@"";
    if (!fullCarName.length) {
        NSString *carYearType = (![carSourceInfo.carYearType isEqualToString:@""] && ![carSourceInfo.carYearType isEqualToString:@"0"] )?[NSString stringWithFormat:@"%@款 ",carSourceInfo.carYearType]:@"";
        
        NSString *carName = carSourceInfo.carName.length?carSourceInfo.carName:@"";
        fullCarName = [NSString stringWithFormat:@"%@%@",carYearType,carName];
    }
    _subTitleLabel.text = fullCarName;
    //报价
    NSString *salePrice = [NSString string];
    UIColor *salePriceColor = [[UIColor alloc] init];
    if ([carSourceInfo.salePrice isEqualToString:@"0"]) {
        salePrice = @"电议";
        salePriceColor = CYTHexColor(@"#F43244");
    }else{
        salePrice = [NSString stringWithFormat:@"报价：%@ 万",carSourceInfo.salePrice];
        salePriceColor = CYTHexColor(@"#666666");
    }
    _officePriceLabel.hidden = NO;
    _officePriceLabel.text = salePrice;
    _officePriceLabel.textColor = salePriceColor;
    
    
    //成交价
    if (carSourceInfo.customDealPrice.length) {
        _dealPriceLabel.hidden = NO;
        _officePriceLabel.hidden = YES;
        _dealPriceLabel.attributedText = [NSMutableAttributedString attributedStringWithContent:carSourceInfo.customDealPriceDes keyWord:carSourceInfo.customDealPrice keyFontPixel:30.f keyWordColor:CYTHexColor(@"#F43244")];
    }
    
    //订金
    if (carSourceInfo.customDeposit.length) {
        _depositLabel.hidden = NO;
        _depositLabel.text = carSourceInfo.customDeposit;
    }
    
    //车源类型
    NSString *carSourceType = carSourceInfo.carSourceTypeName.length?carSourceInfo.carSourceTypeName:@"";
    _carsourceTypeLabel.text = carSourceType;
    //外观、内饰颜色
    NSString *exteriorColor = carSourceInfo.exteriorColor.length?carSourceInfo.exteriorColor:@"";
    NSString *interiorColor = carSourceInfo.interiorColor.length?carSourceInfo.interiorColor:@"";
    NSInteger exteriorColorLength = exteriorColor.length;
    NSInteger interiorColorLength = interiorColor.length;
    NSInteger maxLength = 4;
    NSString *exteriorColorLimt = exteriorColorLength > maxLength ? [NSString stringWithFormat:@"%@...",[exteriorColor substringToIndex:maxLength]]:exteriorColor;
    NSString *interiorColorLimt = interiorColorLength > maxLength ? [NSString stringWithFormat:@"%@...",[interiorColor substringToIndex:maxLength]]:interiorColor;
    NSString *exInColor = [NSString stringWithFormat:@"%@/%@",exteriorColorLimt,interiorColorLimt];
    _exInColorLabel.text = exInColor;
    //车源地
    NSString *carSourceAddress = carSourceInfo.carSourceAddress.length?carSourceInfo.carSourceAddress:@"";
    _carSourceAreaLabel.text = carSourceAddress;
    
    //已付
    if (carSourceInfo.customPayparyDes.length) {
        _payPartDescLabel.hidden = NO;
        _payPartDescLabel.text = carSourceInfo.customPayparyDes;
    }else {
        _payPartDescLabel.hidden = YES;
    }
}

/**
 *  报价模式(1:优惠万元，2：优惠点数，3：加价万元，4：直接报价)
 */
- (NSMutableAttributedString *)priceModeWithcarSourceListModel:(CYTCarSourceListModel *)carSourceListModel{
    CYTCarSourceInfo *carSourceInfo = [CYTCarSourceInfo mj_objectWithKeyValues:carSourceListModel.carSourceInfo];
    NSString *priceModeContent = [NSString string];
    NSString *suffix = [NSString string];
    NSString *priceBasicPointContent = ![carSourceInfo.priceBasicPoint isEqualToString:@"0"] ?carSourceInfo.priceBasicPoint:@"";
    NSInteger priceMode = carSourceInfo.priceMode;
    switch (priceMode) {
        case 1:
        {
            priceModeContent = @"下";
            suffix = @"万";
        }
            break;
        case 2:
        {
            priceModeContent = @"下";
            suffix = @"点";
        }
            break;
        case 3:
        {
            priceModeContent = @"加";
            suffix = @"万";
        }
            break;
        default:
            return nil;
            break;
    }
    NSString *content = [NSString stringWithFormat:@"%@ %@ %@",priceModeContent,priceBasicPointContent,suffix];
    return [NSMutableAttributedString attributedStringWithContent:content keyWord:priceBasicPointContent keyFontPixel:30.f keyWordColor:CYTHexColor(@"#F43244")];
}



- (void)layoutWithcarSourceListModel:(CYTCarSourceListModel *)carSourceListModel{
    CYTCarListInfoType  carListInfoType = self.carListInfoType;
    //布局分隔条
    if (!self.hideTopBar) {
        [_topBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.right.equalTo(self);
            make.height.equalTo(CYTAutoLayoutV(20));
        }];
    }
    //布局标题
    [self layoutTitleLabelWithcarSourceListModel:carSourceListModel];
    CGFloat itemMargin = CYTAutoLayoutH(10.f);
    [_carsourceTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_subTitleLabel.mas_bottom).offset(CYTAutoLayoutV(15.f));
        make.left.equalTo(CYTItemMarginH);
        make.bottom.equalTo(-CYTMarginV);
    }];
    
    
    [_carsourceTypeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_carsourceTypeLabel);
        make.left.equalTo(_carsourceTypeLabel.mas_right).offset(itemMargin);
        make.width.equalTo(1.f);
        make.height.equalTo(CYTAutoLayoutV(20.f));
    }];
    
    [_exInColorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_carsourceTypeLabel);
        //        make.width.mas_lessThanOrEqualTo(maxWidth/3);
        make.left.equalTo(_carsourceTypeLine.mas_right).offset(itemMargin);
    }];
    
    if (carListInfoType == CYTCarListInfoTypeCarSource) {
        [_officePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titelLabel.mas_bottom).offset(CYTMarginV);
            make.right.equalTo(-CYTItemMarginH);
        }];
        [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_officePriceLabel);
            make.left.equalTo(_titelLabel);
            make.right.lessThanOrEqualTo(_officePriceLabel.mas_left).offset(-CYTItemMarginH);
            make.right.lessThanOrEqualTo(_depositLabel.mas_left).offset(-CYTItemMarginH);
        }];
        
        [_exInColorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_carsourceTypeLabel);
            make.left.equalTo(_exInColorLabel.mas_right).offset(itemMargin);
            make.width.height.equalTo(_carsourceTypeLine);
        }];
        
        [_carSourceAreaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_carsourceTypeLabel);
            make.left.equalTo(_exInColorLine.mas_right).offset(itemMargin);
            make.right.lessThanOrEqualTo(-CYTItemMarginH);
        }];
        
        [_priceBasicPointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_titelLabel);
            make.right.equalTo(-CYTItemMarginH);
        }];
        
        [_dealPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_titelLabel);
            make.right.equalTo(-CYTItemMarginH);
        }];
        
        [_depositLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_subTitleLabel);
            make.right.equalTo(-CYTItemMarginH);
        }];
        
        if (carSourceListModel.carSourceInfo.customPayparyDes.length) {
            [_payPartDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.greaterThanOrEqualTo(_carSourceAreaLabel.mas_right).offset(CYTItemMarginH);
                make.centerY.equalTo(_carSourceAreaLabel);
                make.right.equalTo(-CYTMarginH);
            }];
        }
    }else{
        [_registrationAreaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_titelLabel);
            make.right.equalTo(-CYTItemMarginH);
        }];
        
        [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titelLabel.mas_bottom).offset(CYTMarginV);
            make.left.equalTo(_titelLabel);
            make.right.equalTo(-CYTItemMarginH);
        }];
    }
    
    //过期标志的添加
    if (carSourceListModel.myContect && [carSourceListModel.carSourceInfo.carSourceStatus integerValue] == 0) {
        self.expiredIcon.hidden = NO;
    }else{
        self.expiredIcon.hidden = YES;
    }
}

- (void)layoutTitleLabelWithcarSourceListModel:(CYTCarSourceListModel *)carSourceListModel{
    CYTCarSourceInfo *carSourceInfo = [CYTCarSourceInfo mj_objectWithKeyValues:carSourceListModel.carSourceInfo];
    NSInteger priceMode = carSourceInfo.priceMode;
    NSString *carReferPriceDesc = carSourceInfo.carReferPriceDesc.length?carSourceInfo.carReferPriceDesc:@"";
    if (!carReferPriceDesc.length && carSourceInfo.carReferPrice.length && ![carSourceInfo.carReferPrice isEqualToString:@"0"]) {
        carReferPriceDesc = [NSString stringWithFormat:@"%@ 万",carSourceInfo.carReferPrice];
    }
    NSString *carReferPrice = carReferPriceDesc;
    BOOL hasPriceBasicPoint = priceMode == 1 || priceMode == 2 || priceMode == 3;
    BOOL hasDealPrice = carSourceInfo.customDealPrice.length;
    BOOL hasCarReferPrice = carReferPrice.length;
    
    [_titelLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        self.hideTopBar ? make.top.equalTo(CYTItemMarginV):make.top.equalTo(_topBar.mas_bottom).offset(CYTItemMarginV);
        make.left.equalTo(CYTItemMarginH);
        if (self.carListInfoType == CYTCarListInfoTypeSeekCar) {
            if (hasCarReferPrice) {
                make.right.equalTo(_guidePriceLabel.mas_left).offset(-CYTItemMarginH);
            }else{
                make.right.equalTo(_registrationAreaLabel.mas_left).offset(-CYTItemMarginH);
            }
        }else{
            if (!hasPriceBasicPoint && !hasCarReferPrice) {
                if (carSourceInfo.customDealPrice.length) {
                    make.right.equalTo(_dealPriceLabel.mas_left).offset(-CYTItemMarginH);
                }else{
                   make.right.equalTo(-CYTItemMarginH);
                }
            }else {
                make.right.equalTo(_guidePriceLabel.mas_left).offset(-CYTItemMarginH);
            }
        }
    }];
    
    [_guidePriceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (!hasCarReferPrice) return;
        if (self.carListInfoType == CYTCarListInfoTypeSeekCar) {
            make.right.lessThanOrEqualTo(_registrationAreaLabel.mas_left).offset(-CYTItemMarginH);
        }else{
            if (hasPriceBasicPoint) {
                make.right.lessThanOrEqualTo(_priceBasicPointLabel.mas_left).offset(-CYTItemMarginH);
            }else if (hasDealPrice){
                make.right.lessThanOrEqualTo(_dealPriceLabel.mas_left).offset(-CYTItemMarginH);
            }else{
                make.right.lessThanOrEqualTo(-CYTItemMarginH);
            }
        }
        make.centerY.equalTo(_titelLabel);
    }];
    
    [_priceBasicPointLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (!hasPriceBasicPoint) return;
        make.centerY.equalTo(_titelLabel);
        make.right.equalTo(-CYTItemMarginH);
    }];
}

/**
 *  寻车数据
 */
- (void)setSeekCarListModel:(CYTSeekCarListModel *)seekCarListModel{
    if (!seekCarListModel)return;
    _seekCarListModel = seekCarListModel;
    [self setValueWithSeekCarListModel:seekCarListModel];
    [self layoutWithSeekCarListModel:seekCarListModel];
    [self layoutTitleLabelWithSeekCarListModel:seekCarListModel];
}

- (void)setValueWithSeekCarListModel:(CYTSeekCarListModel *)seekCarListModel{
    CYTSeekCarInfo *seekCarInfo = seekCarListModel.seekCarInfo;
    CYTDealer *dealer = seekCarListModel.dealer;
    dealer.publishTime = seekCarInfo.publishTime;
    //标题
    NSString *brandName = seekCarInfo.brandName.length?seekCarInfo.brandName:@"";
    NSString *serialName = seekCarInfo.serialName.length?seekCarInfo.serialName:@"";
    NSString *titleContent = [NSString stringWithFormat:@"%@ %@",brandName,serialName];
    _titelLabel.text = titleContent;
    //指导价
    NSString *carReferPrice = seekCarInfo.carReferPriceDesc.length?seekCarInfo.carReferPriceDesc:@"";
    _guidePriceLabel.text = carReferPrice;
    //上牌地区
    NSString *egistrationContent = [NSString string];
    if (seekCarInfo.registCardCityName.length) {
        egistrationContent = seekCarInfo.registCardCityName.length?[NSString stringWithFormat:@"上牌 %@",seekCarInfo.registCardCityName]:@"";
    }else{
        egistrationContent = seekCarInfo.registCardProvinceName.length?seekCarInfo.registCardProvinceName:@"";
    }
    _registrationAreaLabel.text = egistrationContent;

    //副标题
    NSString *fullCarName = seekCarInfo.fullCarName.length?seekCarInfo.fullCarName:@"";
    _subTitleLabel.text = fullCarName;
    
    //车源类型
    NSString *carSourceType = seekCarInfo.carSourceTypeName.length?seekCarInfo.carSourceTypeName:@"";
    _carsourceTypeLabel.text = carSourceType;
    //外观、内饰颜色
    NSString *exteriorColor = seekCarInfo.exteriorColor.length?seekCarInfo.exteriorColor:@"";
    NSString *interiorColor = seekCarInfo.interiorColor.length?seekCarInfo.interiorColor:@"";
    NSInteger exteriorColorLength = exteriorColor.length;
    NSInteger interiorColorLength = interiorColor.length;
    NSInteger maxLength = 4;
    NSString *exteriorColorLimt = exteriorColorLength > maxLength ? [NSString stringWithFormat:@"%@...",[exteriorColor substringToIndex:maxLength]]:exteriorColor;
    NSString *interiorColorLimt = interiorColorLength > maxLength ? [NSString stringWithFormat:@"%@...",[interiorColor substringToIndex:maxLength]]:interiorColor;
    NSString *exInColor = [NSString stringWithFormat:@"%@/%@",exteriorColorLimt,interiorColorLimt];
    _exInColorLabel.text = exInColor;
}

- (void)layoutWithSeekCarListModel:(CYTSeekCarListModel *)seekCarListModel{
    //布局分隔条
    if (!self.hideTopBar) {
        [_topBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.right.equalTo(self);
            make.height.equalTo(CYTAutoLayoutV(20));
        }];
    }
    //布局标题
    [self layoutTitleLabelWithSeekCarListModel:seekCarListModel];
    CGFloat itemMargin = CYTAutoLayoutH(10.f);
    [_carsourceTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_subTitleLabel.mas_bottom).offset(CYTAutoLayoutV(15.f));
        make.left.equalTo(CYTItemMarginH);
        make.bottom.equalTo(-CYTMarginV);
    }];
    
    [_carsourceTypeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_carsourceTypeLabel);
        make.left.equalTo(_carsourceTypeLabel.mas_right).offset(itemMargin);
        make.width.equalTo(1.f);
        make.height.equalTo(CYTAutoLayoutV(20.f));
    }];
    
    [_exInColorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_carsourceTypeLabel);
        //        make.width.mas_lessThanOrEqualTo(maxWidth/3);
        make.left.equalTo(_carsourceTypeLine.mas_right).offset(itemMargin);
    }];
    [_registrationAreaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titelLabel);
        make.right.equalTo(-CYTItemMarginH);
    }];
    
    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titelLabel.mas_bottom).offset(CYTMarginV);
        make.left.equalTo(_titelLabel);
        make.right.equalTo(-CYTItemMarginH);
    }];
    
    //过期标志的添加
    if (seekCarListModel.myContect && [seekCarListModel.seekCarInfo.seekCarStatus integerValue] == 0) {
        self.expiredIcon.hidden = NO;
    }else{
        self.expiredIcon.hidden = YES;
    }
}


- (void)layoutTitleLabelWithSeekCarListModel:(CYTSeekCarListModel *)seekCarListModel{
    CYTSeekCarInfo *seekCarInfo = [CYTCarSourceInfo mj_objectWithKeyValues:seekCarListModel.seekCarInfo];
    NSString *carReferPrice = seekCarInfo.carReferPriceDesc;
    BOOL hasCarReferPrice = carReferPrice.length;
    [_titelLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        self.hideTopBar ? make.top.equalTo(CYTItemMarginV):make.top.equalTo(_topBar.mas_bottom).offset(CYTItemMarginV);
        make.left.equalTo(CYTItemMarginH);
        if (hasCarReferPrice) {
            make.right.equalTo(_guidePriceLabel.mas_left).offset(-CYTItemMarginH);
        }else{
            make.right.equalTo(_registrationAreaLabel.mas_left).offset(-CYTItemMarginH);
        }
    }];
    
    [_guidePriceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (!hasCarReferPrice) return;
        if (self.carListInfoType == CYTCarListInfoTypeSeekCar) {
            make.right.lessThanOrEqualTo(_registrationAreaLabel.mas_left).offset(-CYTItemMarginH);
        }else{
            make.right.lessThanOrEqualTo(-CYTItemMarginH);
        }
        make.centerY.equalTo(_titelLabel);
    }];
}

#pragma mark - 订单详情

- (void)setCarModel:(CYTCarModel *)carModel{
    _carModel = carModel;
    [self setValueWithCarModel:carModel];
    [self layoutWithCarModel:carModel];
    [self layoutTitleLabelWithCarModel:carModel];
}

- (void)setValueWithCarModel:(CYTCarModel *)carModel{
    //标题
    NSString *titleContent = carModel.carMainName.length?carModel.carMainName:@" ";
    _titelLabel.text = titleContent;
    //指导价
    NSString *carReferPrice = carModel.carReferPriceDesc.length?carModel.carReferPriceDesc:@"";
    _guidePriceLabel.text = carReferPrice;
    //成交价
    _dealPriceLabel.hidden = NO;
    NSString *dealPrice = carModel.dealPrice;
    NSString *dealPriceDes = [NSString stringWithFormat:@"成交总价：%@ 万",dealPrice];
    _dealPriceLabel.attributedText = [NSMutableAttributedString attributedStringWithContent:dealPriceDes keyWord:dealPrice keyFontPixel:30.f keyWordColor:CYTRedColor];
    
    //副标题
    NSString *fullCarName = carModel.carDetailName.length?carModel.carDetailName:@"";
    _subTitleLabel.text = fullCarName;
    
    //车源类型
    NSString *carSourceType = carModel.importTypeName.length?carModel.importTypeName:@"";
    _carsourceTypeLabel.text = carSourceType;
    //外观、内饰颜色
    NSString *exteriorColor = carModel.exColor.length?carModel.exColor:@"";
    NSString *interiorColor = carModel.inColor.length?carModel.inColor:@"";
    NSInteger exteriorColorLength = exteriorColor.length;
    NSInteger interiorColorLength = interiorColor.length;
    NSInteger maxLength = 4;
    NSString *exteriorColorLimt = exteriorColorLength > maxLength ? [NSString stringWithFormat:@"%@...",[exteriorColor substringToIndex:maxLength]]:exteriorColor;
    NSString *interiorColorLimt = interiorColorLength > maxLength ? [NSString stringWithFormat:@"%@...",[interiorColor substringToIndex:maxLength]]:interiorColor;
    NSString *exInColor = [NSString stringWithFormat:@"%@/%@",exteriorColorLimt,interiorColorLimt];
    _exInColorLabel.text = exInColor;
    
    //车源地
    NSString *carSourceAddress = carModel.carCityName.length?carModel.carCityName:@"";
    _carSourceAreaLabel.text = carSourceAddress;
    
    //订金
    if (carModel.depositAmount.length) {
        _depositLabel.hidden = NO;
        _depositLabel.text = [NSString stringWithFormat:@"订金总额：%@ 元",carModel.depositAmount];
    }
    //已付
    if (carModel.payPartDesc.length) {
        _payPartDescLabel.hidden = NO;
        _payPartDescLabel.text = carModel.payPartDesc;
    }
}
- (void)layoutWithCarModel:(CYTCarModel *)carModel{
    //布局分隔条
    if (!self.hideTopBar) {
        [_topBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.right.equalTo(self);
            make.height.equalTo(CYTAutoLayoutV(20));
        }];
    }

    
    //布局标题
    [self layoutTitleLabelWithCarModel:carModel];
    
    CGFloat itemMargin = CYTAutoLayoutH(10.f);
    [_carsourceTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_subTitleLabel.mas_bottom).offset(CYTAutoLayoutV(15.f));
        make.left.equalTo(CYTItemMarginH);
        make.bottom.equalTo(-CYTMarginV);
    }];
    
    [_carsourceTypeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_carsourceTypeLabel);
        make.left.equalTo(_carsourceTypeLabel.mas_right).offset(itemMargin);
        make.width.equalTo(1.f);
        make.height.equalTo(CYTAutoLayoutV(20.f));
    }];
    
    [_exInColorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_carsourceTypeLabel);
        make.left.equalTo(_carsourceTypeLine.mas_right).offset(itemMargin);
    }];
    
    [_exInColorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_carsourceTypeLabel);
        make.left.equalTo(_exInColorLabel.mas_right).offset(itemMargin);
        make.width.height.equalTo(_carsourceTypeLine);
    }];
    
    [_carSourceAreaLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_carsourceTypeLabel);
        make.left.equalTo(_exInColorLine.mas_right).offset(itemMargin);
    }];
    
    if (carModel.payPartDesc.length) {
        [_payPartDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.greaterThanOrEqualTo(_carSourceAreaLabel.mas_right).offset(CYTItemMarginH);
            make.centerY.equalTo(_carSourceAreaLabel);
            make.right.equalTo(-CYTMarginH);
        }];

    }
    
    [_dealPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(_guidePriceLabel.mas_right).offset(CYTItemMarginH);
        make.centerY.equalTo(_titelLabel);
        make.right.equalTo(-CYTItemMarginH);
    }];
    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titelLabel.mas_bottom).offset(CYTMarginV);
        make.left.equalTo(_titelLabel);
    }];
    
    [_depositLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_subTitleLabel);
        make.right.equalTo(-CYTItemMarginH);
        make.left.equalTo(_subTitleLabel.mas_right).offset(CYTItemMarginH);
    }];

}
- (void)layoutTitleLabelWithCarModel:(CYTCarModel *)carModel{
    NSString *carReferPrice = carModel.carReferPriceDesc;
    BOOL hasCarReferPrice = carReferPrice.length;
    [_titelLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        self.hideTopBar ? make.top.equalTo(CYTItemMarginV):make.top.equalTo(_topBar.mas_bottom).offset(CYTItemMarginV);
        make.left.equalTo(CYTItemMarginH);
        if (hasCarReferPrice) {
            make.right.equalTo(_guidePriceLabel.mas_left).offset(-CYTItemMarginH);
        }else{
            make.right.equalTo(_dealPriceLabel.mas_left).offset(-CYTItemMarginH);
        }
    }];
    
    [_guidePriceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (!hasCarReferPrice) return;
        if (self.carListInfoType == CYTCarListInfoTypeSeekCar) {
            make.right.lessThanOrEqualTo(_dealPriceLabel.mas_left).offset(-CYTItemMarginH);
        }else{
            make.right.lessThanOrEqualTo(-CYTItemMarginH);
        }
        make.centerY.equalTo(_titelLabel);
    }];

}
@end
