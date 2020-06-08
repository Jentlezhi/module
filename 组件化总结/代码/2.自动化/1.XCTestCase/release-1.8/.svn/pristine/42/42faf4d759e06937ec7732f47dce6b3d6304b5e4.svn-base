//
//  CYTSendCarDetailInfoCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTSendCarDetailInfoCell.h"
#import "CYTLogisticDemandModel.h"

@implementation CYTSendCarDetailInfoCell
{
    //分割条
    UIView *_topBar;
    //发车人
    UILabel *_senderNameTipLabel;
    UILabel *_senderNameLabel;
    //发车地址
    UILabel *_sendAddressTipLabel;
    UILabel *_sendAddressLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self sendCarDetailInfoBasicConfig];
        [self initSendCarDetailInfoComponents];
        [self makeConstrains];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)sendCarDetailInfoBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
/**
 *  初始化子控件
 */
- (void)initSendCarDetailInfoComponents{
    //分割条
    UIView *topBar = [[UIView alloc] init];
    topBar.backgroundColor = kFFColor_bg_nor;
    [self.contentView addSubview:topBar];
    _topBar = topBar;
    
    //发车人
    UILabel *senderNameTipLabel = [UILabel labelWithText:@"发车人：" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:NO];
    [self.contentView addSubview:senderNameTipLabel];
    _senderNameTipLabel = senderNameTipLabel;
    
    UILabel *senderNameLabel = [UILabel labelWithText:@"" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    senderNameLabel.numberOfLines = 0;
    [self.contentView addSubview:senderNameLabel];
    _senderNameLabel = senderNameLabel;
    
    //发车地址
    UILabel *sendAddressTipLabel = [UILabel labelWithText:@"发车地址：" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:NO];
    [self.contentView addSubview:sendAddressTipLabel];
    _sendAddressTipLabel = sendAddressTipLabel;
    
    UILabel *sendAddressLabel = [UILabel labelWithText:@"" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    sendAddressLabel.numberOfLines = 0;
    [self.contentView addSubview:sendAddressLabel];
    _sendAddressLabel = sendAddressLabel;
    
//    //测试数据
//    _senderNameLabel.text = @"智俊涛 13121782105 智俊涛 13121782105 智俊涛 13121782105";
//    _sendAddressLabel.text = @"近日，人气女演员张天爱一组最新夏日写真大片曝光。与以往的英气率性大相径庭，大片中张天爱首次挑战嫁衣，身着简洁清爽白蕾丝长裙，露出“微笑”锁骨、充满浪漫的姿态感。不同的发型和妆容选择，轻易组合出多层次造型。披肩长卷发，轻熟女精致优雅风情充分显示出来；凌乱的碎发，让整体变得甜美活泼，秒变青春元气的明眸少女。与此同时，深受父母相濡以沫爱情影响的张天爱娓娓吐露心声“只希望自己能嫁给爱情”。";
//    NSAttributedString *aString = [NSAttributedString attributedWithLabel:_senderNameLabel lineSpacing:_senderNameLabel.font.pointSize*0.3];
//    _senderNameLabel.attributedText = aString;
//    
//    NSAttributedString *bString = [NSAttributedString attributedWithLabel:_sendAddressLabel lineSpacing:_sendAddressLabel.font.pointSize*0.3];
//    _sendAddressLabel.attributedText = bString;
//    //处理对齐方式
//    _senderNameLabel.textAlignment = [self textAlignmentWithLabel:_senderNameLabel forwardNum:5];
//    
//    _sendAddressLabel.textAlignment = [self textAlignmentWithLabel:_sendAddressLabel forwardNum:5];

}
/**
 * 对齐方式
 */
- (NSTextAlignment)textAlignmentWithLabel:(UILabel *)label forwardNum:(NSUInteger)fontNum{
    CGFloat expCompanyMarkLabelH = [label.text sizeWithFont:label.font maxSize:CGSizeMake(kScreenWidth - 3*CYTMarginH - (_senderNameTipLabel.font.pointSize+2)*fontNum, CGFLOAT_MAX)].height;
    CYTLog(@"%f",label.font.pointSize)
    if (expCompanyMarkLabelH>=label.font.pointSize*2) {
        return NSTextAlignmentLeft;
    }else{
        return NSTextAlignmentRight;
    }
}
/**
 *  布局控件
 */
- (void)makeConstrains{
    //布局间隔条
    [_topBar makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(CYTAutoLayoutV(20));
    }];
    CGFloat senderNameTipLabelH  = _senderNameTipLabel.font.pointSize+2;
    [_senderNameTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(_topBar.mas_bottom).offset(CYTMarginV);
        make.size.equalTo(CGSizeMake(senderNameTipLabelH*5, senderNameTipLabelH));
    }];
    
    [_senderNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_senderNameTipLabel.mas_right).offset(CYTMarginH);
        make.top.equalTo(_senderNameTipLabel).offset(-CYTAutoLayoutV(2.f));
        make.right.equalTo(-CYTMarginH);
    }];
    
    [_sendAddressTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(_senderNameLabel.mas_bottom).offset(CYTAutoLayoutV(40.f));
        make.size.equalTo(CGSizeMake(senderNameTipLabelH*5, senderNameTipLabelH));
    }];
    
    [_sendAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_sendAddressTipLabel.mas_right).offset(CYTMarginH);
        make.top.equalTo(_sendAddressTipLabel).offset(-CYTAutoLayoutV(2.f));
        make.right.equalTo(-CYTMarginH);
        make.bottom.equalTo(-CYTAutoLayoutV(20.f));
    }];
    
    
}
+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTSendCarDetailInfoCell";
    CYTSendCarDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTSendCarDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
/**
 * 物流订单详情 传入数据
 */
- (void)setLogisticDemandModel:(CYTLogisticDemandModel *)logisticDemandModel{
    if (!logisticDemandModel) return;
    _logisticDemandModel = logisticDemandModel;
    //发车人
    NSString *senderNameStr = [NSString stringWithFormat:@"%@ %@",logisticDemandModel.senderName,logisticDemandModel.senderPhone];
    _senderNameLabel.text = senderNameStr;
    //处理对齐方式
    _senderNameLabel.textAlignment = [self textAlignmentWithLabel:_senderNameLabel forwardNum:5];
    
    //发车地址
    NSString *startProvinceName = logisticDemandModel.startProvinceName.length?logisticDemandModel.startProvinceName:@"";
    NSString *startCityName = logisticDemandModel.startCityName.length?logisticDemandModel.startCityName:@"";
    NSString *startCountyName = logisticDemandModel.startCountyName.length?logisticDemandModel.startCountyName:@"";
    NSString *startAddress = logisticDemandModel.startAddress.length?logisticDemandModel.startAddress:@"";
    NSString *sendAddress = [NSString stringWithFormat:@"%@ %@ %@ %@",startProvinceName,startCityName,startCountyName,startAddress];
    _sendAddressLabel.text = sendAddress;
    //设置行间距
    NSAttributedString *bString = [NSAttributedString attributedWithLabel:_sendAddressLabel lineSpacing:_sendAddressLabel.font.pointSize*0.2];
    _sendAddressLabel.attributedText = bString;
    //处理对齐方式
    _sendAddressLabel.textAlignment = [self textAlignmentWithLabel:_sendAddressLabel forwardNum:5];
    
}

@end
