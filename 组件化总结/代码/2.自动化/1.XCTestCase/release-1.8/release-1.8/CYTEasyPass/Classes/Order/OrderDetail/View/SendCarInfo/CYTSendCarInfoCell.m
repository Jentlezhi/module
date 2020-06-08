//
//  CYTSendCarInfoCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/30.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTSendCarInfoCell.h"
#import "CYTExpressModel.h"

@implementation CYTSendCarInfoCell
{
    //分割条
    UIView *_topBar;
    //发车公司
    UILabel *_sendCompanyTipLabel;
    UILabel *_sendCompanyLabel;
    //发车公司分割线
    UILabel *_sendCompanylineLabel;
    //发车地址
    UILabel *_sendAddressTipLabel;
    UILabel *_sendAddressLabel;
    //发车公司分割线
    UILabel *_sendAddresslineLabel;
    //发车人
    UILabel *_senderTipLabel;
    UILabel *_senderLabel;
    //发车人分割线
    UILabel *_senderlineLabel;
    //卖家备注
    UILabel *_sellerRemarkTipLabel;
    UILabel *_sellerRemarkLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self sendCarInfoBasicConfig];
        [self initSendCarInfoComponents];
        [self makeConstrains];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)sendCarInfoBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
/**
 *  初始化子控件
 */
- (void)initSendCarInfoComponents{
    //分割条
    UIView *topBar = [[UIView alloc] init];
    topBar.backgroundColor = kFFColor_bg_nor;
    [self.contentView addSubview:topBar];
    _topBar = topBar;
    
    //发车公司
    UILabel *sendCompanyTipLabel = [UILabel labelWithText:@"发车公司：" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:YES];
    [self.contentView addSubview:sendCompanyTipLabel];
    _sendCompanyTipLabel = sendCompanyTipLabel;
    
    UILabel *sendCompanyLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    sendCompanyLabel.numberOfLines = 0;
    [self.contentView addSubview:sendCompanyLabel];
    _sendCompanyLabel = sendCompanyLabel;
    
    //发车公司分割线
    UILabel *sendCompanylineLabel = [UILabel dividerLineLabel];
    [self.contentView addSubview:sendCompanylineLabel];
    _sendCompanylineLabel = sendCompanylineLabel;
    
    //发车地址
    UILabel *sendAddressTipLabel = [UILabel labelWithText:@"发车地址：" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:YES];
    [self.contentView addSubview:sendAddressTipLabel];
    _sendAddressTipLabel = sendAddressTipLabel;
    
    UILabel *sendAddressLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    sendAddressLabel.numberOfLines = 0;
    [self.contentView addSubview:sendAddressLabel];
    _sendAddressLabel = sendAddressLabel;
    
    //发车公司分割线
    UILabel *sendAddresslineLabel = [UILabel dividerLineLabel];
    [self.contentView addSubview:sendAddresslineLabel];
    _sendAddresslineLabel = sendAddresslineLabel;
    
    //发车人
    UILabel *senderTipLabel = [UILabel labelWithText:@"发  车  人：" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:YES];
    [self.contentView addSubview:senderTipLabel];
    _senderTipLabel = senderTipLabel;
    
    UILabel *senderLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    senderLabel.numberOfLines = 0;
    [self.contentView addSubview:senderLabel];
    _senderLabel = senderLabel;
    
    //发车人分割线
    UILabel *senderlineLabel = [UILabel dividerLineLabel];
    [self.contentView addSubview:senderlineLabel];
    _senderlineLabel = senderlineLabel;
    
    //卖家备注
    UILabel *sellerRemarkTipLabel = [UILabel labelWithText:@"卖家备注：" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:YES];
    [self.contentView addSubview:sellerRemarkTipLabel];
    _sellerRemarkTipLabel = sellerRemarkTipLabel;
    
    UILabel *sellerRemarkLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    sellerRemarkLabel.numberOfLines = 0;
    [self.contentView addSubview:sellerRemarkLabel];
    _sellerRemarkLabel = sellerRemarkLabel;

}
/**
 *  布局控件
 */
- (void)makeConstrains{
    //布局间隔条
    [_topBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(CYTAutoLayoutV(20));
    }];
    [_sendCompanyTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topBar.mas_bottom).offset(CYTItemMarginV);
        make.left.equalTo(CYTMarginH);
    }];
    
    [_sendCompanyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_sendCompanyTipLabel.mas_right);
        make.right.equalTo(-CYTMarginH);
        make.top.equalTo(_topBar.mas_bottom).offset(CYTItemMarginV);
    }];
    
    [_sendCompanylineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sendCompanyLabel.mas_bottom).offset(CYTItemMarginV);
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    [_sendAddressTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sendCompanylineLabel.mas_bottom).offset(CYTItemMarginV);
        make.left.equalTo(_sendCompanyTipLabel);
    }];
    
    [_sendAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_sendAddressTipLabel.mas_right);
        make.right.equalTo(self.contentView).offset(-CYTItemMarginH);
        make.top.equalTo(_sendCompanyLabel.mas_bottom).offset(2*CYTItemMarginV);
        
    }];
    
    [_sendAddresslineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sendAddressLabel.mas_bottom).offset(CYTItemMarginV);
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.height.equalTo(CYTDividerLineWH);
        
    }];
    
    [_senderTipLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sendAddressLabel.mas_bottom).offset(2*CYTItemMarginV);
        make.left.equalTo(_sendCompanyTipLabel);
    }];
    

}

+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTSendCarInfoCell";
    CYTSendCarInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTSendCarInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setExpressModel:(CYTExpressModel *)expressModel{
    _expressModel = expressModel;
    [self setValueWithExpressModel:expressModel];
    [self layoutWithExpressModel:expressModel];
}
- (void)setValueWithExpressModel:(CYTExpressModel *)expressModel{
    NSString *sendCompanyName = expressModel.sendCompanyName.length?expressModel.sendCompanyName:@" ";
    _sendCompanyLabel.text = sendCompanyName;
    NSString *sendAddress = expressModel.sendAddress.length?expressModel.sendAddress:@" ";
    _sendAddressLabel.text = sendAddress;
    NSString *sendeiverDec = expressModel.sendInfo.length?expressModel.sendInfo:@" ";
    _senderLabel.text = sendeiverDec;
    NSString *senderRemark = expressModel.senderRemark.length?expressModel.senderRemark:@"";
    _sellerRemarkLabel.text = senderRemark;
}

- (void)layoutWithExpressModel:(CYTExpressModel *)expressModel{
    if (expressModel.senderRemark.length) {
        _sellerRemarkTipLabel.hidden = NO;
        _sellerRemarkLabel.hidden = NO;
        [_senderLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_senderTipLabel.mas_right);
            make.right.equalTo(-CYTMarginH);
            make.top.equalTo(_sendAddressLabel.mas_bottom).offset(2*CYTItemMarginV);
        }];
        
        [_senderlineLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_senderLabel.mas_bottom).offset(CYTItemMarginV);
            make.left.equalTo(CYTMarginH);
            make.right.equalTo(-CYTMarginH);
            make.height.equalTo(CYTDividerLineWH);
        }];
        [_sellerRemarkTipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_senderlineLabel.mas_bottom).offset(CYTItemMarginV);
            make.left.equalTo(_sendCompanyTipLabel);
        }];
        
        [_sellerRemarkLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_sellerRemarkTipLabel.mas_right);
            make.right.equalTo(-CYTMarginH);
            make.top.equalTo(_senderLabel.mas_bottom).offset(2*CYTItemMarginV);
            make.bottom.equalTo(-CYTItemMarginV);
        }];
        
    }else{
        _sellerRemarkTipLabel.hidden = YES;
        _sellerRemarkLabel.hidden = YES;
        [_senderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_senderTipLabel.mas_right);
            make.right.equalTo(-CYTMarginH);
            make.top.equalTo(_sendAddressLabel.mas_bottom).offset(2*CYTItemMarginV);
            make.bottom.equalTo(-CYTItemMarginV);
        }];
    }
}


@end
