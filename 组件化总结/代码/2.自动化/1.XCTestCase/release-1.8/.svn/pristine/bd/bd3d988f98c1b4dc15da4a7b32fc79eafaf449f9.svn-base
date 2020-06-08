//
//  CYTCommitReceiverInfoCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/8/30.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCommitReceiverInfoCell.h"
#import "CYTReceiveContacts.h"

@implementation CYTCommitReceiverInfoCell
{
    //分割条
    UIView *_topBar;
    //收车公司
    UILabel *_recCpyTipLabel;
    UILabel *_recCpyNameLabel;
    UILabel *_recCpyLineLabel;
    //收车地址
    UIView *_recerAddressView;
    UILabel *_recAddressPlaceholderLabel;
    UILabel *_recAddressLabel;
    //收车人
    UIView *_recerView;
    UILabel *_recerPlaceholderLabel;
    UILabel *_recerLabel;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style type:(CYTReceiveContactsType)receiveContactsType reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commitReceiverInfoBasicConfig];
        [self initCommitReceiverInfoComponentsWithType:receiveContactsType];
        [self makeConstrainsWithType:receiveContactsType];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)commitReceiverInfoBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.translatesAutoresizingMaskIntoConstraints = YES;
}
/**
 *  初始化子控件
 */
- (void)initCommitReceiverInfoComponentsWithType:(CYTReceiveContactsType)receiveContactsType{
    //分割条
    UIView *topBar = [[UIView alloc] init];
    topBar.backgroundColor = kFFColor_bg_nor;
    [self.contentView addSubview:topBar];
    _topBar = topBar;
    
    //收车公司
    UILabel *recCpyTipLabel = [UILabel labelWithText:@"收车公司" textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:YES];
    [self.contentView addSubview:recCpyTipLabel];
    _recCpyTipLabel = recCpyTipLabel;
    
    UILabel *recCpyNameLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    recCpyNameLabel.numberOfLines = 0;
    [self.contentView addSubview:recCpyNameLabel];
    _recCpyNameLabel = recCpyNameLabel;
    
    //收车公司分割线
    UILabel *recCpyLineLabel = [UILabel dividerLineLabel];
    [self.contentView addSubview:recCpyLineLabel];
    _recCpyLineLabel = recCpyLineLabel;
    
    //收车地址
    UIView *recerAddressView = [self cellViewWithTitle:@"收车地址" withType:receiveContactsType showDividerLine:YES placeholder:^(UILabel *placeholderLabel) {
        _recAddressPlaceholderLabel = placeholderLabel;
    } content:^(UILabel *contentLabel) {
        _recAddressLabel = contentLabel;
    }];
    CYTWeakSelf
    [recerAddressView addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
        !weakSelf.recAddressClick?:weakSelf.recAddressClick();
    }];
    [self.contentView addSubview:recerAddressView];
    recerAddressView.userInteractionEnabled = receiveContactsType == CYTReceiveContactsTypeBuyer;
    _recerAddressView = recerAddressView;


    //收车人
    UIView *recerView = [self cellViewWithTitle:@"收车人" withType:receiveContactsType showDividerLine:NO placeholder:^(UILabel *placeholderLabel) {
        _recerPlaceholderLabel = placeholderLabel;
    } content:^(UILabel *contentLabel) {
        _recerLabel = contentLabel;
    }];
    [recerView addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
        !weakSelf.recerClick?:weakSelf.recerClick();
    }];
    recerView.userInteractionEnabled = receiveContactsType == CYTReceiveContactsTypeBuyer;
    [self.contentView addSubview:recerView];
    _recerView = recerView;
    

    //测试数据
    _recCpyNameLabel.text = @"北京市 海淀区 腾达大厦 易车互联信息技术股份有限公司";
    
    _recAddressLabel.text = @"北京市 海淀区 新世纪 写字楼 6层 651室内";

    _recerLabel.text = @"智俊涛 13121782105";
}
/**
 *  信息
 */
- (UIView *)cellViewWithTitle:(NSString *)title withType:(CYTReceiveContactsType)receiveContactsType showDividerLine:(BOOL)show placeholder:(void(^)(UILabel *placeholderLabel))placeholder content:(void(^)(UILabel *contentLabel))content{
    UIView *customView = [[UIView alloc] init];
    customView.backgroundColor = [UIColor clearColor];
    
    UILabel *tipInfoLabel = [UILabel labelWithText:title textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:YES];
    [customView addSubview:tipInfoLabel];
    [tipInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(CYTMarginV);
    }];
    
    //箭头
    UIImageView *arrowImageView = [UIImageView ff_imageViewWithImageName:@"arrow_right"];
    arrowImageView.hidden = receiveContactsType == CYTReceiveContactsTypeSeller;
    [customView addSubview:arrowImageView];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(CYTAutoLayoutV(44.f));
        make.centerY.equalTo(tipInfoLabel);
        make.right.equalTo(-CYTMarginH);
    }];
    
    UILabel *placeholderLabel = [UILabel labelWithText:@"请选择" textColor:CYTHexColor(@"#B6B6B6") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:YES];
    [customView addSubview:placeholderLabel];
    if (receiveContactsType == CYTReceiveContactsTypeBuyer) {//可修改地址
        [placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(arrowImageView.mas_left).offset(-CYTAutoLayoutH(5));
            make.top.equalTo(CYTMarginV);
            make.bottom.equalTo(-CYTMarginV);
        }];
    }else{
        [placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-CYTMarginH);
            make.top.equalTo(CYTMarginV);
            make.bottom.equalTo(-CYTMarginV);
        }];
    }

    !placeholder?:placeholder(placeholderLabel);
    
    
    UILabel *contentLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    contentLabel.numberOfLines = 0;
    [customView addSubview:contentLabel];
    if (receiveContactsType == CYTReceiveContactsTypeBuyer) {//可修改地址
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(arrowImageView.mas_left).offset(-CYTAutoLayoutH(5));
            make.top.equalTo(tipInfoLabel);
            make.left.greaterThanOrEqualTo(tipInfoLabel.mas_right).offset(CYTItemMarginH);
            make.bottom.equalTo(-CYTMarginV);
        }];
    
    }else{
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-CYTMarginH);
            make.top.equalTo(tipInfoLabel);
            make.left.greaterThanOrEqualTo(tipInfoLabel.mas_right).offset(CYTItemMarginH);
            make.bottom.equalTo(-CYTMarginV);
        }];
    }

    
    !content?:content(contentLabel);
    
    UILabel *lineLabel = [UILabel dividerLineLabel];
    lineLabel.hidden = !show;
    [customView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.height.equalTo(CYTDividerLineWH);
        make.bottom.equalTo(customView);
    }];
    return customView;
}
/**
 *  布局控件
 */
- (void)makeConstrainsWithType:(CYTReceiveContactsType)receiveContactsType{
    [_topBar makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(CYTAutoLayoutV(20));
    }];
    
    [_recCpyTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(_topBar.mas_bottom).offset(CYTMarginV);
    }];
    
    [_recCpyNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(_recCpyTipLabel.mas_right).offset(CYTItemMarginH);
        make.top.equalTo(_recCpyTipLabel);
        make.right.equalTo(-CYTMarginH);
    }];
    
    [_recCpyLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.height.equalTo(CYTDividerLineWH);
        make.top.equalTo(_recCpyNameLabel.mas_bottom).offset(CYTMarginV);
    }];
    
    [_recerAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(_recCpyLineLabel.mas_bottom);
    }];
    
    [_recerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_recerAddressView);
        make.top.equalTo(_recerAddressView.mas_bottom);
        make.bottom.equalTo(self.contentView);
    }];
    
}

+ (instancetype)cellForTableView:(UITableView *)tableView type:(CYTReceiveContactsType)receiveContactsType indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTCommitReceiverInfoCell";
    CYTCommitReceiverInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTCommitReceiverInfoCell alloc] initWithStyle:UITableViewCellStyleDefault type:receiveContactsType reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setReceiveContacts:(CYTReceiveContacts *)receiveContacts{
    if (!receiveContacts) return;
    _receiveContacts = receiveContacts;
    NSString *companyName = receiveContacts.companyName.length?receiveContacts.companyName:@"";
    _recCpyNameLabel.text = companyName;
    
    NSString *address = receiveContacts.address.length?receiveContacts.address:@"";
    _recAddressLabel.text = address;
    
    NSString *name = receiveContacts.name.length?receiveContacts.name:@"";
    NSString *phone = receiveContacts.phone.length?receiveContacts.phone:@"";
    _recerLabel.text = [NSString stringWithFormat:@"%@ %@",name,phone];
    
    _recAddressPlaceholderLabel.hidden = address.length;
    _recerPlaceholderLabel.hidden = name.length;
    
}

@end
