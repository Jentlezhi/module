//
//  CYTCommitPriceInfoCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/8/30.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCommitPriceInfoCell.h"
#import "CYTOrderCommitViewController.h"

@implementation CYTCommitPriceInfoCell
{
    //分割条
    UIView *_topBar;
    //成交单价
    UILabel *_dealPriceLabel;
    //成交价格 万
    UILabel *_dealPriceInfoLabel;
    //成交价格 输入框
    UITextField *_dealPriceTF;
    //成交价格分割线
    UILabel *_dealPriceLineLabel;
    
    //成交数量
    UILabel *_dealNumberLabel;
    //成交 辆
    UILabel *_dealNumberInfoLabel;
    //成交辆 输入框
    UITextField *_dealNumberTF;
    //成交辆分割线
    UILabel *_dealNumberLineLabel;
    
    //成交总价
    UILabel *_dealTotalLabel;
    //成交总价
    UILabel *_dealTotalInfoLabel;
    //成交总价
    UITextField *_dealTotalTF;
    //成交总价分割线
    UILabel *_dealTotalLineLabel;
    
    //订金金额
    UILabel *_depositLabel;
    //订金金额 元
    UILabel *_depositInfoLabel;
    //订金金额 输入框
    UITextField *_depositTF;
    //订金说明
    UIButton *_depositDescriptionButton;
    //订金金额分割线
    UILabel *_depositLineLabel;
    //备注
    UIView *_remarkView;
    UILabel *_remarkTipLabel;
    UILabel *_placeHolderLabel;
    UILabel *_remarkLabel;
    //箭头
    UIImageView *_arrowImageView;
    UILabel *_remarkInfoLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commitPriceInfoBasicConfig];
        [self initCommitPriceInfoComponents];
        [self makeConstrains];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)commitPriceInfoBasicConfig{
    _commitType = -1;
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
/**
 *  初始化子控件
 */
- (void)initCommitPriceInfoComponents{
    //分割条
    UIView *topBar = [[UIView alloc] init];
    topBar.backgroundColor = kFFColor_bg_nor;
    [self.contentView addSubview:topBar];
    _topBar = topBar;
    
    //成交价格--------------------
    UILabel *dealPriceLabel = [UILabel labelWithText:@"成交单价" textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:YES];
    [self.contentView addSubview:dealPriceLabel];
    _dealPriceLabel = dealPriceLabel;
    
    //成交价格 万
    NSString *dealPriceString = @"万元";
    UILabel *dealPriceInfoLabel = [UILabel labelWithText:dealPriceString textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentRight fontPixel:26.f setContentPriority:YES];
    NSRange range = [dealPriceString rangeOfString:@"万"];
    [dealPriceInfoLabel updateWithRange:range font:CYTFontWithPixel(30) color:CYTRedColor];
    [self.contentView addSubview:dealPriceInfoLabel];
    _dealPriceInfoLabel = dealPriceInfoLabel;
    
    //成交价格 输入框
    UITextField *dealPriceTF = [UITextField textFieldWithTextColor:CYTHexColor(@"#666666") fontPixel:26.f textAlignment:NSTextAlignmentRight keyboardType:UIKeyboardTypeDecimalPad clearButtonMode:UITextFieldViewModeNever placeholder:@"请输入"];
    [dealPriceTF setValue:CYTHexColor(@"#B6B6B6") forKeyPath:@"_placeholderLabel.textColor"];
    [self.contentView addSubview:dealPriceTF];
    dealPriceTF.cantPast = YES;
    _dealPriceTF = dealPriceTF;
    @weakify(self);
    [[_dealPriceTF rac_textSignal] subscribeNext:^(id x) {
        @strongify(self);
        [self calculateTotalPriceWithTextField:_dealPriceTF];
    }];
    
    //成交价格分割线
    UILabel *dealPriceLineLabel = [UILabel dividerLineLabel];
    [self.contentView addSubview:dealPriceLineLabel];
    _dealPriceLineLabel = dealPriceLineLabel;
    
    
    //成交数量--------------------
    UILabel *dealNumberLabel = [UILabel labelWithText:@"成交数量" textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:YES];
    [self.contentView addSubview:dealNumberLabel];
    _dealNumberLabel = dealNumberLabel;
    
    //成交数量-辆
    NSString *dealNumberString = @"辆";
    UILabel *dealNumberInfoLabel = [UILabel labelWithText:dealNumberString textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentRight fontPixel:26.f setContentPriority:YES];
    [self.contentView addSubview:dealNumberInfoLabel];
    _dealNumberInfoLabel = dealNumberInfoLabel;
    
    //成交数量-输入
    UITextField *dealNumberTF = [UITextField textFieldWithTextColor:CYTHexColor(@"#666666") fontPixel:26.f textAlignment:NSTextAlignmentRight keyboardType:UIKeyboardTypeNumberPad clearButtonMode:UITextFieldViewModeNever placeholder:@"请输入"];
    [dealNumberTF setValue:CYTHexColor(@"#B6B6B6") forKeyPath:@"_placeholderLabel.textColor"];
    [self.contentView addSubview:dealNumberTF];
    dealNumberTF.cantPast = YES;
    _dealNumberTF = dealNumberTF;
    [[_dealNumberTF rac_textSignal] subscribeNext:^(id x) {
        @strongify(self);
        [self calculateTotalPriceWithTextField:_dealNumberTF];
    }];
    
    //成交辆分割线
    UILabel *dealNumberLineLabel = [UILabel dividerLineLabel];
    [self.contentView addSubview:dealNumberLineLabel];
    _dealNumberLineLabel = dealNumberLineLabel;
    
    
    //成交总价--------------------
    UILabel *dealTotalLabel = [UILabel labelWithText:@"成交总价" textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:YES];
    [self.contentView addSubview:dealTotalLabel];
    _dealTotalLabel = dealTotalLabel;
    
    //成交价格 万
    NSString *dealTotalString = @"万元";
    UILabel *dealTotalInfoLabel = [UILabel labelWithText:dealTotalString textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentRight fontPixel:26.f setContentPriority:YES];
    NSRange range2 = [dealTotalString rangeOfString:@"万"];
    [dealTotalInfoLabel updateWithRange:range2 font:CYTFontWithPixel(30) color:CYTRedColor];
    [self.contentView addSubview:dealTotalInfoLabel];
    _dealTotalInfoLabel = dealTotalInfoLabel;
    _dealTotalInfoLabel.hidden = YES;
    
    //成交价格 输入框
    UITextField *dealTotalTF = [UITextField textFieldWithTextColor:CYTHexColor(@"#666666") fontPixel:26.f textAlignment:NSTextAlignmentRight keyboardType:UIKeyboardTypeDecimalPad clearButtonMode:UITextFieldViewModeNever placeholder:@""];
    [dealTotalTF setValue:CYTHexColor(@"#B6B6B6") forKeyPath:@"_placeholderLabel.textColor"];
    [self.contentView addSubview:dealTotalTF];
    dealTotalTF.userInteractionEnabled = NO;
    _dealTotalTF = dealTotalTF;
    
    //成交价格分割线
    UILabel *dealTotalLineLabel = [UILabel dividerLineLabel];
    [self.contentView addSubview:dealTotalLineLabel];
    _dealTotalLineLabel = dealTotalLineLabel;
    
    
    //订金金额---------------------
    UILabel *depositLabel = [UILabel labelWithText:@"订金总额" textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:YES];
    [self.contentView addSubview:depositLabel];
    _depositLabel = depositLabel;
    
    //订金金额 元
    UILabel *depositInfoLabel = [UILabel labelWithText:@"元" textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentRight fontPixel:26.f setContentPriority:YES];
    [self.contentView addSubview:depositInfoLabel];
    _depositInfoLabel = depositInfoLabel;
    
    //订金金额 输入框
    UITextField *depositTF = [UITextField textFieldWithTextColor:CYTHexColor(@"#F43244") font:CYTBoldFontWithPixel(28.f) textAlignment:NSTextAlignmentRight keyboardType:UIKeyboardTypeNumberPad clearButtonMode:UITextFieldViewModeNever placeholder:@"请输入"];
    [depositTF setValue:CYTFontWithPixel(26.f) forKeyPath:@"_placeholderLabel.font"];
    [depositTF setValue:CYTHexColor(@"#B6B6B6") forKeyPath:@"_placeholderLabel.textColor"];
    [self.contentView addSubview:depositTF];
    _depositTF = depositTF;
    
    //订金提示
    UIButton *depositDescriptionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [depositDescriptionButton setImage:[UIImage imageNamed:@"order_commit_alert"] forState:UIControlStateNormal];
    
    [depositDescriptionButton setTitle:@" 您的订金将由平台为您保管，点击查看详情>>" forState:UIControlStateNormal];
    [depositDescriptionButton setTitleColor:kFFColor_title_L3 forState:UIControlStateNormal];
    depositDescriptionButton.titleLabel.font = CYTFontWithPixel(24);

    [[depositDescriptionButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        !self.clickDepositAlertBlock?:self.clickDepositAlertBlock();
    }];
    [self.contentView addSubview:depositDescriptionButton];
    _depositDescriptionButton = depositDescriptionButton;
    
    
    //订金金额分割线
    UILabel *depositLineLabel = [UILabel dividerLineLabel];
    [self.contentView addSubview:depositLineLabel];
    _depositLineLabel = depositLineLabel;
    
    //备注
    CYTWeakSelf
    UIView *remarkView = [[UIView alloc] init];
    [remarkView addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
        !weakSelf.remakeClick?:weakSelf.remakeClick(_remarkLabel.text);
    }];
    remarkView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:remarkView];
    _remarkView = remarkView;
    UILabel *remarkTipLabel = [UILabel labelWithText:@"备注（选填）" textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:YES];
    [remarkView addSubview:remarkTipLabel];
    _remarkTipLabel = remarkTipLabel;
    
    UILabel *placeHolderLabel = [UILabel labelWithText:@"请输入" textColor:CYTHexColor(@"#B6B6B6") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
//    placeHolderLabel.hidden = YES;
    [remarkView addSubview:placeHolderLabel];
    _placeHolderLabel = placeHolderLabel;
    
    UILabel *remarkLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    remarkLabel.numberOfLines = 0;
    [remarkView addSubview:remarkLabel];
    _remarkLabel = remarkLabel;
    
    //箭头
    UIImageView *arrowImageView = [UIImageView ff_imageViewWithImageName:@"arrow_right"];
    [self.contentView addSubview:arrowImageView];
    _arrowImageView = arrowImageView;
}
/**
 *  布局控件
 */
- (void)makeConstrains{
    [_topBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(CYTAutoLayoutV(20));
        
    }];
    
    [_dealPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(_topBar.mas_bottom).offset(CYTMarginV);
        
    }];
    
    [_dealPriceInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_dealPriceLabel);
        make.right.equalTo(-CYTMarginH);
    }];

    [_dealPriceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_dealPriceLabel);
        make.right.equalTo(_dealPriceInfoLabel.mas_left).offset(-CYTAutoLayoutH(14.f));
        make.left.equalTo(_dealPriceLabel.mas_right).offset(CYTMarginH/2.0);
    }];
    
    [_dealPriceLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.height.equalTo(CYTDividerLineWH);
        make.top.equalTo(_dealPriceInfoLabel.mas_bottom).offset(CYTMarginV);
    }];
    
    //成交量
    [_dealNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(_dealPriceLineLabel.mas_bottom).offset(CYTMarginV);
    }];
    [_dealNumberInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_dealNumberLabel);
        make.right.equalTo(-CYTMarginH);
    }];
    [_dealNumberTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_dealNumberLabel);
        make.right.equalTo(_dealNumberInfoLabel.mas_left).offset(-CYTAutoLayoutH(14.f));
        make.left.equalTo(_dealNumberLabel.mas_right).offset(CYTMarginH/2.0);
    }];
    [_dealNumberLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.height.equalTo(CYTDividerLineWH);
        make.top.equalTo(_dealNumberInfoLabel.mas_bottom).offset(CYTMarginV);
    }];
    
    //成交总价
    [_dealTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(_dealNumberLineLabel.mas_bottom).offset(CYTMarginV);
    }];
    [_dealTotalInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_dealTotalLabel);
        make.right.equalTo(-CYTMarginH);
    }];
    [_dealTotalTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_dealTotalLabel);
        make.right.equalTo(_dealTotalInfoLabel.mas_left).offset(-CYTAutoLayoutH(14.f));
        make.left.equalTo(_dealTotalLabel.mas_right).offset(CYTMarginH);
    }];
    [_dealTotalLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.height.equalTo(CYTDividerLineWH);
        make.top.equalTo(_dealTotalInfoLabel.mas_bottom).offset(CYTMarginV);
    }];
    
    //
    [_depositLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(_dealTotalLineLabel.mas_bottom).offset(CYTMarginV);
    }];

    [_depositInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_depositLabel);
        make.right.equalTo(-CYTMarginH);
    }];
    
    [_depositTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_depositLabel);
        make.right.equalTo(_depositInfoLabel.mas_left).offset(-CYTAutoLayoutH(14.f));
        make.left.equalTo(_depositLabel.mas_right).offset(CYTMarginH/2.0);
    }];
    [_depositDescriptionButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_depositLabel);
        make.right.lessThanOrEqualTo(-CYTMarginH);
        make.top.equalTo(_depositLabel.bottom).offset(CYTItemMarginV);
    }];
    [_depositLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.height.equalTo(CYTDividerLineWH);
        make.top.equalTo(_depositDescriptionButton.mas_bottom).offset(CYTMarginV);
    }];
    
    [_remarkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(_depositLineLabel.mas_bottom);
    }];
    
    [_remarkTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(_remarkView).offset(CYTMarginV);
    }];
    
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(CYTAutoLayoutV(44.f));
        make.centerY.equalTo(_remarkTipLabel);
        make.centerX.equalTo(_depositInfoLabel);
    }];
    
    [_placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(_remarkTipLabel.mas_right).offset(CYTItemMarginH);
        make.right.equalTo(_depositTF);
        make.top.equalTo(CYTMarginV);
        make.bottom.equalTo(-CYTMarginV);
    }];
    
    [_remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(_remarkTipLabel.mas_right).offset(CYTItemMarginH);
        make.right.equalTo(_depositTF);
        make.top.equalTo(_remarkTipLabel);
        make.bottom.equalTo(_remarkView.bottom).offset(-CYTMarginV);
    }];
    
}

/**
 *  获取成交总价
 */
- (NSString *)dealPrice{
    return _dealTotalTF.text;
}

/**
 *  获取成交数量
 */
- (NSString *)dealNumber{
    return _dealNumberTF.text;
}

/**
 *  获取成交单价
 */
- (NSString *)dealUnitPrice{
    return _dealPriceTF.text;
}

/**
 *  订金总额
 */
- (NSString *)depositAmount{
    return _depositTF.text;
}

#pragma mark- method
- (void)calculateTotalPriceWithTextField:(UITextField *)textField {
    if (self.commitType==-1) {
        return;
    }
    
    //如果数量输入0
    if ([textField isEqual:_dealNumberTF] && [_dealNumberTF.text integerValue]==0) {
        _dealNumberTF.text = @"";
    }
    
    double price = [_dealPriceTF.text doubleValue];
    long number = [_dealNumberTF.text longLongValue];
    double total = price*number;
    //保留两位有效数字
//    NSString *totalString = [FFCommonCode stringFromValue:total pointNumber:2];
    NSString *totalString = [NSString stringWithFormat:@"%.2f",total];
    
    if (_dealPriceTF.text.length==0 || _dealNumberTF.text.length==0) {
        totalString = @"";
        _dealTotalInfoLabel.hidden = YES;
    }else {
        _dealTotalInfoLabel.hidden = NO;
    }
    
    _dealTotalTF.text = totalString;
}

#pragma mark- set
- (void)setCommitType:(NSInteger)commitType {
    _commitType = commitType;
    //0-车源买车，1-寻车卖车
    NSString *depositString = (commitType==0)?@" 您的订金将由平台为您保管，点击查看详情>>":@" 输入和买家协商一致的金额，点击查看详情>>";
    [_depositDescriptionButton setTitle:depositString forState:UIControlStateNormal];
}

- (void)setTipsModel:(CYTCreateOrderTipsModel *)tipsModel {
    if (!tipsModel) {
        return;
    }
    _tipsModel = tipsModel;
    
    _dealPriceTF.placeholder = tipsModel.carUnitPriceTip;
    [self updateTextFiledFontWithText:tipsModel.carUnitPriceTip textField:_dealPriceTF fontSize:13];
    
    _dealNumberTF.placeholder = tipsModel.carNumTip;
    [self updateTextFiledFontWithText:tipsModel.carNumTip textField:_dealNumberTF fontSize:13];
    
    _depositTF.placeholder = tipsModel.depositTotalTip;
    [self updateTextFiledFontWithText:tipsModel.depositTotalTip textField:_depositTF fontSize:12];
}

- (void)updateTextFiledFontWithText:(NSString *)text textField:(UITextField *)textField fontSize:(float)fontSize{
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:text];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:fontSize]
                        range:NSMakeRange(0, text.length)];
    textField.attributedPlaceholder = placeholder;
}

#pragma mark- init
+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTCommitPriceInfoCell";
    CYTCommitPriceInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTCommitPriceInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setRemark:(NSString *)remark{
    _remark = remark;
    _remarkLabel.text = remark;
    _placeHolderLabel.hidden = remark.length;
}

@end
