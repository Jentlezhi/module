//
//  CYTRecCarDetailInfoCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTRecCarDetailInfoCell.h"
#import "CYTLogisticDemandModel.h"

@implementation CYTRecCarDetailInfoCell
{
    //分割条
    UIView *_topBar;
    //收车人
    UILabel *_recerNameTipLabel;
    UILabel *_recerNameLabel;
    //收车地址
    UILabel *_recerAddressTipLabel;
    UILabel *_recerAddressLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self recCarDetailInfoBasicConfig];
        [self initRecCarDetailInfoComponents];
        [self makeConstrains];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)recCarDetailInfoBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
/**
 *  初始化子控件
 */
- (void)initRecCarDetailInfoComponents{
    //分割条
    UIView *topBar = [[UIView alloc] init];
    topBar.backgroundColor = kFFColor_bg_nor;
    [self.contentView addSubview:topBar];
    _topBar = topBar;
    
    //收车人
    UILabel *recerNameTipLabel = [UILabel labelWithText:@"收车人：" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:NO];
    [self.contentView addSubview:recerNameTipLabel];
    _recerNameTipLabel = recerNameTipLabel;
    
    UILabel *recerNameLabel = [UILabel labelWithText:nil textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    recerNameLabel.numberOfLines = 0;
    [self.contentView addSubview:recerNameLabel];
    _recerNameLabel = recerNameLabel;
    
    //收车地址
    UILabel *recerAddressTipLabel = [UILabel labelWithText:@"收车地址：" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:NO];
    [self.contentView addSubview:recerAddressTipLabel];
    _recerAddressTipLabel = recerAddressTipLabel;
    
    UILabel *recerAddressLabel = [UILabel labelWithText:nil textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    recerAddressLabel.numberOfLines = 0;
    [self.contentView addSubview:recerAddressLabel];
    _recerAddressLabel = recerAddressLabel;
    
//    //测试数据
//    _recerNameLabel.text = @"智俊涛 13121782105 智俊涛 13121782105 智俊涛 13121782105";
//    _recerAddressLabel.text = @"近日，人气女演员张天爱一组最新夏日写真大片曝光。与以往的英气率性大相径庭，大片中张天爱首次挑战嫁衣，身着简洁清爽白蕾丝长裙，露出“微笑”锁骨、充满浪漫的姿态感。不同的发型和妆容选择，轻易组合出多层次造型。披肩长卷发，轻熟女精致优雅风情充分显示出来；凌乱的碎发，让整体变得甜美活泼，秒变青春元气的明眸少女。与此同时，深受父母相濡以沫爱情影响的张天爱娓娓吐露心声“只希望自己能嫁给爱情”。";
//    NSAttributedString *aString = [NSAttributedString attributedWithLabel:_recerNameTipLabel lineSpacing:_recerNameTipLabel.font.pointSize*0.3];
//    _recerNameTipLabel.attributedText = aString;
//    
//    NSAttributedString *bString = [NSAttributedString attributedWithLabel:_recerAddressLabel lineSpacing:_recerAddressLabel.font.pointSize*0.3];
//    _recerAddressLabel.attributedText = bString;
//    //处理对齐方式
//    _recerNameLabel.textAlignment = [self textAlignmentWithLabel:_recerNameLabel forwardNum:5];
//    
//    _recerAddressLabel.textAlignment = [self textAlignmentWithLabel:_recerAddressLabel forwardNum:5];

}

/**
 * 对齐方式
 */
- (NSTextAlignment)textAlignmentWithLabel:(UILabel *)label forwardNum:(NSUInteger)fontNum{
    CGFloat expCompanyMarkLabelH = [label.text sizeWithFont:label.font maxSize:CGSizeMake(kScreenWidth - 3*CYTMarginH - (_recerNameTipLabel.font.pointSize+2)*fontNum, CGFLOAT_MAX)].height;
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
    
    CGFloat recerNameTipLabelH  = _recerNameTipLabel.font.pointSize+2;
    [_recerNameTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(_topBar.mas_bottom).offset(CYTMarginV);
        make.size.equalTo(CGSizeMake(recerNameTipLabelH*5, recerNameTipLabelH));
    }];
    
    [_recerNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_recerNameTipLabel.mas_right).offset(CYTMarginH*0.5);
        make.top.equalTo(_recerNameTipLabel).offset(-CYTAutoLayoutV(2.f));
        make.right.equalTo(-CYTMarginH);
    }];
    
    [_recerAddressTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(_recerNameLabel.mas_bottom).offset(CYTAutoLayoutV(40.f));
        make.size.equalTo(CGSizeMake(recerNameTipLabelH*5, recerNameTipLabelH));
    }];
    
    [_recerAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_recerAddressTipLabel.mas_right).offset(CYTMarginH*0.5);
        make.top.equalTo(_recerAddressTipLabel).offset(-CYTAutoLayoutV(2.f));
        make.right.equalTo(-CYTMarginH);
        make.bottom.equalTo(-CYTAutoLayoutV(20.f));
    }];
}
+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTRecCarDetailInfoCell";
    CYTRecCarDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTRecCarDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setLogisticDemandModel:(CYTLogisticDemandModel *)logisticDemandModel{
    if (!logisticDemandModel)return;
    //收车人
    NSString *receiverName = logisticDemandModel.receiverName.length?logisticDemandModel.receiverName:@"";
    NSString *receiverPhone = logisticDemandModel.receiverPhone.length?logisticDemandModel.receiverPhone:@"";
    NSString *receiverCerNumber = logisticDemandModel.receiverCerNumber.length?logisticDemandModel.receiverCerNumber:@"";
    NSString *receiverNameStr = [NSString stringWithFormat:@"%@ %@ %@",receiverName,receiverPhone,receiverCerNumber];
    _recerNameLabel.text = receiverNameStr;
    //处理对齐方式
    _recerNameLabel.textAlignment = [self textAlignmentWithLabel:_recerNameLabel forwardNum:5];
    
    //收车地址
    NSString *provinceName = logisticDemandModel.destinationProvinceName.length?logisticDemandModel.destinationProvinceName:@"";
    NSString *cityName = logisticDemandModel.destinationCityName.length?logisticDemandModel.destinationCityName:@"";
    NSString *countyName = logisticDemandModel.destinationCountyName.length?logisticDemandModel.destinationCountyName:@"";
    NSString *address = logisticDemandModel.destinationAddress.length?logisticDemandModel.destinationAddress:@"";
    NSString *recAddress = [NSString stringWithFormat:@"%@ %@ %@ %@",provinceName,cityName,countyName,address];
    _recerAddressLabel.text = recAddress;
    //设置行间距
    NSAttributedString *bString = [NSAttributedString attributedWithLabel:_recerAddressLabel lineSpacing:_recerAddressLabel.font.pointSize*0.2];
    _recerAddressLabel.attributedText = bString;
    //处理对齐方式
    _recerAddressLabel.textAlignment = [self textAlignmentWithLabel:_recerAddressLabel forwardNum:5];
}

@end
