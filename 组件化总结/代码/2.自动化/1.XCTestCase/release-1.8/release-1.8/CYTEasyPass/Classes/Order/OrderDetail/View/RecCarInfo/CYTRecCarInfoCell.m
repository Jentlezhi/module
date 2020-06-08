//
//  CYTRecCarInfoCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/30.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTRecCarInfoCell.h"
#import "CYTExpressModel.h"


#import "CYTOrderModel.h"

@implementation CYTRecCarInfoCell
{
    //分割条
    UIView *_topBar;
    //收车公司
    UILabel *_recCompanyTipLabel;
    UILabel *_recCompanyLabel;
    //收车公司分割线
    UILabel *_recCompanylineLabel;
    //收车地址
    UILabel *_recAddressTipLabel;
    UILabel *_recAddressLabel;
    //收车公司分割线
    UILabel *_recAddresslineLabel;
    //收车人
    UILabel *_recerTipLabel;
    UILabel *_recerLabel;
    //收车人分割线
    UILabel *_recerlineLabel;
    
    //买家备注
    UILabel *_buyerRemarkTipLabel;
    //买家备注
    UILabel *_buyerRemarkLabel;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self recCarInfoBasicConfig];
        [self initRecCarInfoComponents];
        [self makeConstrains];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)recCarInfoBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
/**
 *  初始化子控件
 */
- (void)initRecCarInfoComponents{
    //分割条
    UIView *topBar = [[UIView alloc] init];
    topBar.backgroundColor = kFFColor_bg_nor;
    [self.contentView addSubview:topBar];
    _topBar = topBar;
    
    //收车公司
    UILabel *recCompanyTipLabel = [UILabel labelWithText:@"收车公司：" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:YES];
    [self.contentView addSubview:recCompanyTipLabel];
    _recCompanyTipLabel = recCompanyTipLabel;
    
    UILabel *recCompanyLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666")  textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    recCompanyLabel.numberOfLines = 0;
    [self.contentView addSubview:recCompanyLabel];
    _recCompanyLabel = recCompanyLabel;
    
    //收车公司分割线
    UILabel *recCompanylineLabel = [UILabel dividerLineLabel];
    [self.contentView addSubview:recCompanylineLabel];
    _recCompanylineLabel = recCompanylineLabel;
    
    //收车地址
    UILabel *recAddressTipLabel = [UILabel labelWithText:@"收车地址：" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:YES];
    [self.contentView addSubview:recAddressTipLabel];
    _recAddressTipLabel = recAddressTipLabel;
    
    UILabel *recAddressLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666")  textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    recAddressLabel.numberOfLines = 0;
    [self.contentView addSubview:recAddressLabel];
    _recAddressLabel = recAddressLabel;
    
    //收车公司分割线
    UILabel *recAddresslineLabel = [UILabel dividerLineLabel];
    [self.contentView addSubview:recAddresslineLabel];
    _recAddresslineLabel = recAddresslineLabel;
    
    //收车人
    UILabel *recerTipLabel = [UILabel labelWithText:@"收  车  人：" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:YES];
    [self.contentView addSubview:recerTipLabel];
    _recerTipLabel = recerTipLabel;
    
    UILabel *recerLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    recerLabel.numberOfLines = 0;
    [self.contentView addSubview:recerLabel];
    _recerLabel = recerLabel;
    
    //收车人分割线
    UILabel *recerlineLabel = [UILabel dividerLineLabel];
    [self.contentView addSubview:recerlineLabel];
    _recerlineLabel = recerlineLabel;
    
    //买家备注
    UILabel *buyerRemarkTipLabel = [UILabel labelWithText:@"买家备注：" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:YES];
    [self.contentView addSubview:buyerRemarkTipLabel];
    _buyerRemarkTipLabel = buyerRemarkTipLabel;
    
    UILabel *buyerRemarkLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    buyerRemarkLabel.numberOfLines = 0;
    [self.contentView addSubview:buyerRemarkLabel];
    _buyerRemarkLabel = buyerRemarkLabel;
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
    [_recCompanyTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topBar.mas_bottom).offset(CYTItemMarginV);
        make.left.equalTo(CYTMarginH);
    }];
    
    [_recCompanyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_recCompanyTipLabel.mas_right);
        make.right.equalTo(-CYTMarginH);
        make.top.equalTo(_recCompanyTipLabel);
    }];
    
    [_recCompanylineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_recCompanyLabel.mas_bottom).offset(CYTItemMarginV);
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    [_recAddressTipLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_recCompanylineLabel.mas_bottom).offset(CYTItemMarginV);
        make.left.equalTo(_recCompanyTipLabel);
    }];
    
    [_recAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_recAddressTipLabel.mas_right);
        make.right.equalTo(-CYTMarginH);
        make.top.equalTo(_recCompanyLabel.mas_bottom).offset(2*CYTItemMarginV);
    }];
    
    [_recAddresslineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_recAddressLabel.mas_bottom).offset(CYTItemMarginV);
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    [_recerTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_recAddresslineLabel.mas_bottom).offset(CYTItemMarginV);
        make.left.equalTo(_recCompanyTipLabel);
    }];
}

+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTRecCarInfoCell";
    CYTRecCarInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTRecCarInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
- (void)setExpressModel:(CYTExpressModel *)expressModel{
    _expressModel = expressModel;
    [self setValueWithExpressModel:expressModel];
    [self layoutWithExpressModel:expressModel];
}

- (void)setValueWithExpressModel:(CYTExpressModel *)expressModel{
    NSString *receiveCompanyName = expressModel.receiveCompanyName.length?expressModel.receiveCompanyName:@" ";
    _recCompanyLabel.text = receiveCompanyName;
    NSString *recAddress = expressModel.receiveAddress.length?expressModel.receiveAddress:@" ";
    _recAddressLabel.text = recAddress;
    NSString *receiverName = expressModel.receiverInfo.length?expressModel.receiverInfo:@" ";
    _recerLabel.text = receiverName;
    NSString *receiverRemark = expressModel.receiverRemark.length?expressModel.receiverRemark:@"";
    _buyerRemarkLabel.text = receiverRemark;
    
}

- (void)layoutWithExpressModel:(CYTExpressModel *)expressModel{
    if (expressModel.receiverRemark.length) {
        [_recerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_recerTipLabel.mas_right);
            make.right.equalTo(-CYTMarginH);
            make.top.equalTo(_recAddressLabel.mas_bottom).offset(2*CYTItemMarginV);
        }];
        
        [_recerlineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_recerLabel.mas_bottom).offset(CYTItemMarginV);
            make.left.equalTo(CYTMarginH);
            make.right.equalTo(-CYTMarginH);
            make.height.equalTo(CYTDividerLineWH);
        }];
        [_buyerRemarkTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_recerlineLabel.mas_bottom).offset(CYTItemMarginV);
            make.left.equalTo(_recCompanyTipLabel);
        }];
        
        [_buyerRemarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_buyerRemarkTipLabel.mas_right);
            make.right.equalTo(-CYTMarginH);
            make.top.equalTo(_recerLabel.mas_bottom).offset(2*CYTItemMarginV);
            make.bottom.equalTo(-CYTItemMarginV);
        }];
        
    }else{
        [_recerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_recerTipLabel.mas_right);
            make.right.equalTo(-CYTMarginH);
            make.top.equalTo(_recAddressLabel.mas_bottom).offset(2*CYTItemMarginV);
            make.bottom.equalTo(-CYTItemMarginV);
        }];
    }
}



@end
