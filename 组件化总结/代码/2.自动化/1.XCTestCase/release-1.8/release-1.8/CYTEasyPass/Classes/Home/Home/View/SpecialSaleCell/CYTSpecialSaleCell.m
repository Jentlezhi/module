//
//  CYTSpecialSaleCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTSpecialSaleCell.h"

@interface CYTSpecialSaleCell()
/** 标题 */
@property(strong, nonatomic) UILabel *titelLabel;
/** 指导价 */
@property(strong, nonatomic) UILabel *guidePriceLabel;
/** 副标题 */
@property(strong, nonatomic) UILabel *subTitleLabel;
/** 车源类型 */
@property(strong, nonatomic) UILabel *carsourceTypeLabel;
/** 车源类型分割线 */
@property(strong, nonatomic) UILabel *carsourceTypeLine;
/** 外观/内饰颜色 */
@property(strong, nonatomic) UILabel *exInColorLabel;
/** 外观/内饰颜色分割线 */
@property(strong, nonatomic) UILabel *exInColorLine;
/** 车源地*/
@property(strong, nonatomic) UILabel *carSourceAreaLabel;
/** 车款图片 */
@property(strong, nonatomic) UIImageView *carImageView;
/** 分割线 */
@property(strong, nonatomic) UILabel *bottomLineLabel;
/** 直降图标 */
@property(strong, nonatomic) UIImageView *discountIcon;
/** 报价方式 */
@property(strong, nonatomic) UILabel *priceModeDescLabel;
/** 报价价格 */
@property(strong, nonatomic) UILabel *priceValueLabel;
/** 直降 */
@property(strong, nonatomic) UIButton *discountImageView;

@end

@implementation CYTSpecialSaleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self homeCarListBarBasicConfig];
        [self initHomeCarListComponents];
        [self makeConstrains];
    }
    return self;
}

/**
 *  基本配置
 */
- (void)homeCarListBarBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.clipsToBounds = YES;
}
/**
 *  初始化子控件
 */
- (void)initHomeCarListComponents{
    [self.contentView addSubview:self.titelLabel];
    [self.contentView addSubview:self.guidePriceLabel];
    [self.contentView addSubview:self.subTitleLabel];
    [self.contentView addSubview:self.carsourceTypeLabel];
    [self.contentView addSubview:self.carsourceTypeLine];
    [self.contentView addSubview:self.exInColorLabel];
    [self.contentView addSubview:self.exInColorLine];
    [self.contentView addSubview:self.carSourceAreaLabel];
    [self.contentView addSubview:self.carImageView];
    [self.contentView addSubview:self.bottomLineLabel];
    [self.contentView addSubview:self.discountImageView];
    [self.discountImageView addSubview:self.priceModeDescLabel];
    [self.discountImageView addSubview:self.priceValueLabel];
    
    //测试数据
    self.titelLabel.text = @"吉利 博越";
    self.guidePriceLabel.text = @"14.4万";
    self.subTitleLabel.text = @"2016款 1.8T 自动 四驱 智慧型";
    self.carsourceTypeLabel.text = @"国产/合资";
    self.exInColorLabel.text = @"钛铂金/色全钛铂金/色全钛铂金/色全";
    self.carSourceAreaLabel.text = @"全国全国全国全国全国全国全国全国全国全国全国";
    self.carImageView.image = [UIImage imageWithColor:[UIColor randomColor]];
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    [self.titelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTMarginV);
        make.left.equalTo(CYTItemMarginH);
    }];
    [self.guidePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTMarginV);
        make.right.lessThanOrEqualTo(self.carImageView.mas_left).offset(-CYTItemMarginH);
        make.left.equalTo(self.titelLabel.mas_right).offset(CYTAutoLayoutH(10.f));
    }];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titelLabel);
        make.top.equalTo(self.titelLabel.mas_bottom).offset(CYTMarginV);
        make.right.lessThanOrEqualTo(self.carImageView.mas_left).offset(-CYTMarginH);
    }];
    [self.carsourceTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTitleLabel.mas_bottom).offset(CYTAutoLayoutV(18.f));
        make.left.equalTo(self.titelLabel);
    }];

     CGFloat itemMargin = CYTAutoLayoutH(10.f);

    [self.carsourceTypeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.carsourceTypeLabel);
        make.left.equalTo(self.carsourceTypeLabel.mas_right).offset(itemMargin);
        make.width.equalTo(1.f);
        make.height.equalTo(CYTAutoLayoutV(20.f));
    }];
    [self.exInColorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.carsourceTypeLabel);
        make.left.equalTo(self.carsourceTypeLine.mas_right).offset(itemMargin);
    }];
    [self.exInColorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.carsourceTypeLabel);
        make.left.equalTo(self.exInColorLabel.mas_right).offset(itemMargin);
        make.width.height.equalTo(self.carsourceTypeLine);
    }];
    [self.carSourceAreaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.carsourceTypeLabel);
        make.left.equalTo(self.exInColorLine.mas_right).offset(itemMargin);
        make.right.lessThanOrEqualTo(self.carImageView.mas_left).offset(-CYTMarginH);
    }];
    [self.carImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-CYTItemMarginH);
        make.top.equalTo(CYTMarginV);
        make.width.equalTo(CYTAutoLayoutV(220.f));
        make.height.equalTo(CYTAutoLayoutV(140.f));
    }];
    [self.bottomLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.carSourceAreaLabel.mas_bottom).offset(CYTMarginV);
        make.left.equalTo(CYTItemMarginH);
        make.right.equalTo(-CYTItemMarginH);
        make.height.equalTo(CYTDividerLineWH);
        make.bottom.equalTo(self.contentView);
    }];
    [self.discountImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.right.equalTo(-CYTItemMarginH);
    }];
    
    [self.priceModeDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTAutoLayoutV(8.f));
        make.left.equalTo(CYTAutoLayoutH(10.f));
        make.right.equalTo(-CYTAutoLayoutH(10.f));
    }];
    
    [self.priceValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceModeDescLabel.mas_bottom).offset(CYTAutoLayoutV(2.f));
        make.left.equalTo(CYTAutoLayoutH(4.f));
        make.right.equalTo(-CYTAutoLayoutH(4.f));
    }];
}
#pragma mark - 懒加载

- (UIImageView *)titelLabel{
    if (!_titelLabel) {
        _titelLabel = [UILabel labelWithTextColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:30.f setContentPriority:NO];
    }
    return _titelLabel;
}
- (UILabel *)guidePriceLabel{
    if (!_guidePriceLabel) {
        _guidePriceLabel = [UILabel labelWithTextColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:30.f setContentPriority:YES];
    }
    return _guidePriceLabel;
}
- (UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    }
    return _subTitleLabel;
}
- (UILabel *)carsourceTypeLabel{
    if (!_carsourceTypeLabel) {
        _carsourceTypeLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:YES];
    }
    return _carsourceTypeLabel;
}
- (UILabel *)carsourceTypeLine{
    if (!_carsourceTypeLine) {
        _carsourceTypeLine = [UILabel dividerLineLabel];
    }
    return _carsourceTypeLine;
}
- (UILabel *)exInColorLabel{
    if (!_exInColorLabel) {
        _exInColorLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:YES];
    }
    return _exInColorLabel;
}
- (UILabel *)exInColorLine{
    if (!_exInColorLine) {
        _exInColorLine = [UILabel dividerLineLabel];
    }
    return _exInColorLine;
}
- (UILabel *)carSourceAreaLabel{
    if (!_carSourceAreaLabel) {
        _carSourceAreaLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    }
    return _carSourceAreaLabel;
}

- (UIImageView *)carImageView{
    if (!_carImageView) {
        _carImageView = [[UIImageView alloc] init];
//        _carImageView.contentMode = UIViewContentModeRedraw;
        _carImageView.clipsToBounds = YES;
    }
    return _carImageView;
}
- (UILabel *)bottomLineLabel{
    if (!_bottomLineLabel) {
        _bottomLineLabel = [UILabel dividerLineLabel];
    }
    return _bottomLineLabel;
}
- (UIImageView *)discountIcon{
    if (!_discountIcon) {
        _discountIcon = [UIImageView ff_imageViewWithImageName:@"pic_red_nor"];
    }
    return _discountIcon;
}

- (UIButton *)discountImageView{
    if (!_discountImageView) {
        _discountImageView = [UIButton buttonWithType:UIButtonTypeCustom];
        _discountImageView.userInteractionEnabled = NO;
        [_discountImageView setBackgroundImage:[UIImage imageNamed:@"pic_red_nor"] forState:UIControlStateNormal];
        _discountImageView.contentEdgeInsets = UIEdgeInsetsMake(CYTAutoLayoutV(5.f), CYTAutoLayoutH(10.f), CYTAutoLayoutH(40.f), CYTAutoLayoutH(10.f));
    }
    return _discountImageView;
}

- (UILabel *)priceModeDescLabel{
    if (!_priceModeDescLabel) {
        _priceModeDescLabel = [UILabel labelWithTextColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter fontPixel:26.f setContentPriority:NO];
    }
    return _priceModeDescLabel;
}
- (UILabel *)priceValueLabel{
    if (!_priceValueLabel) {
        _priceValueLabel = [UILabel labelWithTextColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter fontPixel:24.f setContentPriority:NO];
    }
    return _priceValueLabel;
}

+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTSpecialSaleCell";
    CYTSpecialSaleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTSpecialSaleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setCarSourceInfoModel:(CYTHomeCarSourceInfoModel *)carSourceInfoModel{
    _carSourceInfoModel = carSourceInfoModel;
    [self setValueWithCarSourceInfoModel:carSourceInfoModel];
}
- (void)setValueWithCarSourceInfoModel:(CYTHomeCarSourceInfoModel *)carSourceInfoModel{
    //标题
    NSString *brandName = carSourceInfoModel.brandName.length?carSourceInfoModel.brandName:@"";
    NSString *serialName = carSourceInfoModel.serialName.length?carSourceInfoModel.serialName:@"";
    NSString *titleContent = [NSString stringWithFormat:@"%@ %@",brandName,serialName];
    self.titelLabel.text = titleContent;
    //指导价
    self.guidePriceLabel.text = carSourceInfoModel.carReferPriceDesc;
    //副标题
    NSString *fullCarName = carSourceInfoModel.fullCarName.length?carSourceInfoModel.fullCarName:@"";
    self.subTitleLabel.text = fullCarName;
    //车源类型
    NSInteger carSourceMaxLength = 8;
    NSString *carSourceTypeLimt = carSourceInfoModel.carSourceTypeName.length > carSourceMaxLength ? [NSString stringWithFormat:@"%@...",[carSourceInfoModel.carSourceTypeName substringToIndex:carSourceMaxLength]]:carSourceInfoModel.carSourceTypeName;
    self.carsourceTypeLabel.text = carSourceTypeLimt;
    //外观、内饰颜色
    NSString *exteriorColor = carSourceInfoModel.exteriorColor.length?carSourceInfoModel.exteriorColor:@"";
    NSString *interiorColor = carSourceInfoModel.interiorColor.length?carSourceInfoModel.interiorColor:@"";
    NSInteger exteriorColorLength = exteriorColor.length;
    NSInteger interiorColorLength = interiorColor.length;
    NSInteger maxLength = 3;
    NSString *exteriorColorLimt = exteriorColorLength > maxLength ? [NSString stringWithFormat:@"%@...",[exteriorColor substringToIndex:maxLength]]:exteriorColor;
    NSString *interiorColorLimt = interiorColorLength > maxLength ? [NSString stringWithFormat:@"%@...",[interiorColor substringToIndex:maxLength]]:interiorColor;
    NSString *exInColor = [NSString stringWithFormat:@"%@/%@",exteriorColorLimt,interiorColorLimt];
    self.exInColorLabel.text = exInColor;
    //车源地
    NSString *carSourceAddress = carSourceInfoModel.carSourceAddress.length?carSourceInfoModel.carSourceAddress:@"";
    self.carSourceAreaLabel.text = carSourceAddress;
    //车款图片
    UIImage *placeHolderImage = [UIImage imageNamed:@"pic_220x140_nor"];
    [self.carImageView sd_setImageWithURL:[NSURL URLWithString:carSourceInfoModel.carImageUrl] placeholderImage:placeHolderImage];
    //优惠价格(直降：xx元)
    if ([carSourceInfoModel.discountMoney floatValue] == 0) {
        self.discountImageView.hidden = YES;
    }else{
        self.discountImageView.hidden = NO;
        self.priceModeDescLabel.text = [self priceModelDescWithCarSourceInfoModel:carSourceInfoModel];
        NSString *keyWord = carSourceInfoModel.discountMoney;
        NSString *content = keyWord.length?[NSString stringWithFormat:@"%@ 万",keyWord]:@"";
        self.priceValueLabel.attributedText = [NSMutableAttributedString attributedStringWithContent:content keyWord:keyWord keyFontPixel:28.f keyWordColor:[UIColor whiteColor]];
    }

    
}

- (NSString *)priceModelDescWithCarSourceInfoModel:(CYTHomeCarSourceInfoModel *)carSourceInfoModel{
    NSInteger priceMode = carSourceInfoModel.priceMode;
    switch (priceMode) {
        case 1:
            return @"直降";
            break;
        case 2:
            return @"直降";
            break;
        case 3:
            return @"加价";
            break;
        case 4:
            return @"报价";
            break;
        default:
            return @"直降";
            break;
    }
}

@end

