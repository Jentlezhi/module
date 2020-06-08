//
//  CYTSendCarInfoCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/18.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticSendCarInfoCell.h"
#import "CYTConfirmOrderInfoModel.h"
#import "CYTTextView.h"


@implementation CYTLogisticSendCarInfoCell
{
    //发车信息
    UIView *_sendCarInfoTipView;
    UILabel *_sendCarInfoTipLabel;
    //发车地
    UILabel *_sendCarAddTipLabel;
    UILabel *_sendCarAddLabel;
    UILabel *_sendCarAddlineLabel;
    
    //发车地址
    CYTTextView *_sendAddressDetail;
    //发车详细地址分割线
    UILabel *_sendAddressDetaillineLabel;
    //发车人姓名
    UILabel *_senderNameTipLabel;
    //发车人姓名输入
    UITextField *_senderNameTF;
    UILabel *_senderNamelineLabel;
    
    //发车人手机号
    UILabel *_senderPhoneNumTipLabel;
    //发车人姓名输入
    UITextField *_senderPhoneNumTF;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self sendCarInfoBasicConfig];
        [self initSendCarInfoComponents];
        [self handelTextField];
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
    self.contentView.backgroundColor = [UIColor clearColor];
}
/**
 *  初始化子控件
 */
- (void)initSendCarInfoComponents{
    //发车信息
    UIView *sendCarInfoTipView = [[UIView alloc] init];
    sendCarInfoTipView.backgroundColor = CYTLightGrayColor;
    [self.contentView addSubview:sendCarInfoTipView];
    _sendCarInfoTipView = sendCarInfoTipView;
    
    UILabel *sendCarInfoTipLabel = [UILabel labelWithText:@"发车信息" textColor:CYTHexColor(@"#5A5A5A") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:NO];
    [sendCarInfoTipView addSubview:sendCarInfoTipLabel];
    _sendCarInfoTipLabel = sendCarInfoTipLabel;
    
    //发车地
    UILabel *sendCarAddTipLabel = [UILabel labelWithText:@"发车地：" textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:NO];
    [self.contentView addSubview:sendCarAddTipLabel];
    _sendCarAddTipLabel = sendCarAddTipLabel;
    
    UILabel *sendCarAddLabel = [UILabel labelWithText:nil textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    sendCarAddLabel.numberOfLines = 0;
    [self.contentView addSubview:sendCarAddLabel];
    _sendCarAddLabel = sendCarAddLabel;
    
    UILabel *sendCarAddlineLabel = [[UILabel alloc] init];
    sendCarAddlineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self.contentView addSubview:sendCarAddlineLabel];
    _sendCarAddlineLabel = sendCarAddlineLabel;
    
    //发车地址
    CYTTextView *sendAddressDetail = [[CYTTextView alloc] init];
    sendAddressDetail.placeholder = @"请输入详细地址";
    sendAddressDetail.placeholderColor = CYTHexColor(@"#999999");
    sendAddressDetail.font = CYTFontWithPixel(26.f);
    sendAddressDetail.backgroundColor = [UIColor clearColor];
    sendAddressDetail.delegate = self;
    [self.contentView addSubview:sendAddressDetail];
    _sendAddressDetail = sendAddressDetail;
    
    //发车详细地址分割线
    UILabel *sendAddressDetaillineLabel = [[UILabel alloc] init];
    sendAddressDetaillineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self.contentView addSubview:sendAddressDetaillineLabel];
    _sendAddressDetaillineLabel = sendAddressDetaillineLabel;
    
    //发车人姓名
    UILabel *senderNameTipLabel = [UILabel labelWithText:@"发车人姓名：" textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:NO];
    [self.contentView addSubview:senderNameTipLabel];
    _senderNameTipLabel = senderNameTipLabel;
    
    //发车人姓名输入
    UITextField *senderNameTF = [UITextField textFieldWithTextColor:CYTHexColor(@"#333333") fontPixel:26.f textAlignment:NSTextAlignmentRight keyboardType:UIKeyboardTypeDefault clearButtonMode:UITextFieldViewModeWhileEditing placeholder:@"请输入姓名"];
     [senderNameTF addTarget:self action:@selector(senderNameTextChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:senderNameTF];
    _senderNameTF = senderNameTF;
    
    UILabel *senderNamelineLabel = [[UILabel alloc] init];
    senderNamelineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self.contentView addSubview:senderNamelineLabel];
    _senderNamelineLabel = senderNamelineLabel;
    
    //发车人手机号
    UILabel *senderPhoneNumTipLabel = [UILabel labelWithText:@"发车人手机号：" textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:NO];
    
    [self.contentView addSubview:senderPhoneNumTipLabel];
    _senderPhoneNumTipLabel = senderPhoneNumTipLabel;
    
    //发车人手机号输入
    UITextField *senderPhoneNumTF = [UITextField textFieldWithTextColor:CYTHexColor(@"#333333") fontPixel:26.f textAlignment:NSTextAlignmentRight keyboardType:UIKeyboardTypeNumberPad clearButtonMode:UITextFieldViewModeWhileEditing placeholder:@"请输入手机号"];
    [senderPhoneNumTF addTarget:self action:@selector(senderPhoneNumTextChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:senderPhoneNumTF];
    _senderPhoneNumTF = senderPhoneNumTF;
    
    //测试数据
//    _sendCarAddLabel.text = @"长沙城区80多平方米的房子，被八旬老人以29万的低价出售，急得儿子打官司讨回。因为老人被诊断患了老年性痴呆，他儿子认为签订的合同无效，应予以撤销。近日，长沙市芙蓉区人民法院公布了该起案件，因购房合同显失公平，法院依法撤销了该合同。";
//    NSAttributedString *aString = [NSAttributedString attributedWithLabel:_sendCarAddLabel lineSpacing:_sendCarAddLabel.font.pointSize*0.3];
//    _sendCarAddLabel.attributedText = aString;
//    //处理对齐方式
//    _sendCarAddLabel.textAlignment = [self textAlignmentWithLabel:_sendCarAddLabel];
}
/**
 *  发车详细地址
 */
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.markedTextRange == nil) {
        _confirmOrderInfoModel.customSDetailedAddress = textView.text;
    }
}
- (void)sendAddressDetailDidChange:(NSNotification *)note{
    CYTTextView *sendAddressDetail = (CYTTextView *)note.object;
    _confirmOrderInfoModel.customSDetailedAddress = sendAddressDetail.text;
}
/**
 *  发车人姓名
 */
- (void)senderNameTextChanged:(UITextField *)textField{
    _confirmOrderInfoModel.customSenderName = textField.text;
    
}
/**
 *  发车人手机
 */
- (void)senderPhoneNumTextChanged:(UITextField *)textField{
    NSString *tel = textField.text.length>CYTAccountLengthMax?[textField.text substringToIndex:CYTAccountLengthMax]:textField.text;
    _confirmOrderInfoModel.customSenderTel = tel;
}
/**
 *  布局控件
 */
- (void)makeConstrains{
    
    [_sendCarInfoTipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.equalTo(CYTAutoLayoutV(70.f));
    }];
    
    [_sendCarInfoTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_sendCarInfoTipView).offset(CYTMarginH);
        make.right.equalTo(_sendCarInfoTipView).offset(-CYTMarginH);
        make.centerY.equalTo(_sendCarInfoTipView);
        make.height.equalTo(_sendCarInfoTipLabel.font.pointSize+2);
        
    }];
    
    CGFloat sendCarAddTipLabelH = _sendCarAddTipLabel.font.pointSize+2;
    
    [_sendCarAddTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sendCarInfoTipView.mas_bottom).offset((CYTAutoLayoutV(90)-sendCarAddTipLabelH)*0.5);
        make.left.equalTo(self.contentView).offset(CYTMarginH);
        make.size.equalTo(CGSizeMake(sendCarAddTipLabelH*4, sendCarAddTipLabelH));
    }];
    
    [_sendCarAddLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_sendCarAddTipLabel.mas_right).offset(CYTMarginH);
        make.top.equalTo(_sendCarAddTipLabel);
        make.right.equalTo(self.contentView).offset(-CYTMarginH);
        
    }];
    
    [_sendCarAddlineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(CYTMarginH);
        make.right.equalTo(self.contentView).offset(-CYTMarginH);
        make.top.equalTo(_sendCarAddLabel.mas_bottom).offset(CYTAutoLayoutV(20.f));
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    [_sendAddressDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sendCarAddlineLabel.mas_bottom);
        make.left.equalTo(_sendCarAddLabel);
        make.right.equalTo(-CYTMarginH);
        make.height.equalTo(CYTAutoLayoutV(140.f));
    }];
    
    [_sendAddressDetaillineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_sendCarAddlineLabel);
        make.top.equalTo(_sendAddressDetail.mas_bottom);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    [_senderNameTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_sendCarAddTipLabel);
        make.top.equalTo(_sendAddressDetail.mas_bottom);
        make.width.equalTo(sendCarAddTipLabelH*6);
        make.height.equalTo(CYTAutoLayoutV(90.f));
    }];
    
    [_senderNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_senderNameTipLabel.right).offset(CYTAutoLayoutH(CYTMarginH));
        make.centerY.equalTo(_senderNameTipLabel);
        make.right.equalTo(self.contentView).offset(-CYTMarginH);
        make.height.equalTo(_senderNameTipLabel);
    }];
    
    [_senderNamelineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(CYTMarginH);
        make.right.equalTo(self.contentView).offset(-CYTMarginH);
        make.top.equalTo(_senderNameTipLabel.mas_bottom);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    [_senderPhoneNumTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_senderNameTipLabel.mas_bottom);
        make.left.equalTo(_senderNameTipLabel);
        make.width.equalTo(sendCarAddTipLabelH*7);
        make.height.equalTo(_senderNameTipLabel);
    }];
    
    [_senderPhoneNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_senderPhoneNumTipLabel.right).offset(CYTAutoLayoutH(CYTMarginH));
        make.centerY.equalTo(_senderPhoneNumTipLabel);
        make.right.equalTo(_senderNameTF);
        make.height.equalTo(_senderPhoneNumTipLabel);
        make.bottom.equalTo(self.contentView);
    }];
    
}

/**
 *  处理输入框
 */
- (void)handelTextField{
    [_senderNameTF.rac_textSignal subscribeNext:^(NSString *inputString) {
        if (inputString.length > CYTNameLengthMax) {
            _senderNameTF.text = [inputString substringToIndex:CYTNameLengthMax];
        }
    }];
    [_senderPhoneNumTF.rac_textSignal subscribeNext:^(NSString *inputString) {
        if (inputString.length > CYTAccountLengthMax) {
            _senderPhoneNumTF.text = [inputString substringToIndex:CYTAccountLengthMax];
        }
    }];
    
}
+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTLogisticSendCarInfoCell";
    CYTLogisticSendCarInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTLogisticSendCarInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setConfirmOrderInfoModel:(CYTConfirmOrderInfoModel *)confirmOrderInfoModel{
    _confirmOrderInfoModel = confirmOrderInfoModel;
    //发车地
    NSString *sendP = confirmOrderInfoModel.sProvinceName.length?confirmOrderInfoModel.sProvinceName:@"";
    NSString *sendC = confirmOrderInfoModel.sCityName.length?confirmOrderInfoModel.sCityName:@"";
    NSString *sendA = confirmOrderInfoModel.sAreaName.length?confirmOrderInfoModel.sAreaName:@"";
    NSString *sendiveAddress = [NSString stringWithFormat:@"%@ %@ %@",sendP,sendC,sendA];
    _sendCarAddLabel.text = sendiveAddress;
    //详细地址
    NSString *sendDetail = confirmOrderInfoModel.sDetailedAddress.length?confirmOrderInfoModel.sDetailedAddress:@"";
    _sendAddressDetail.text = sendDetail;
    //设置间隔
    NSAttributedString *aString = [NSAttributedString attributedWithLabel:_sendCarAddLabel lineSpacing:_sendCarAddLabel.font.pointSize*0.3];
    _sendCarAddLabel.attributedText = aString;
    //处理对齐方式
    _sendCarAddLabel.textAlignment = [self textAlignmentWithLabel:_sendCarAddLabel];
    //发车人姓名
    NSString *senderNameStr = confirmOrderInfoModel.senderName.length?confirmOrderInfoModel.senderName:@"";
    _senderNameTF.text = senderNameStr;
    //发车人手机号
    NSString *senderPhoneStr = confirmOrderInfoModel.senderTel.length?confirmOrderInfoModel.senderTel:@"";
    _senderPhoneNumTF.text = senderPhoneStr;
    
    //输入框赋值
    _sendAddressDetail.text = confirmOrderInfoModel.customSDetailedAddress;
    _senderNameTF.text = confirmOrderInfoModel.customSenderName;
    _senderPhoneNumTF.text = confirmOrderInfoModel.customSenderTel;
}
/**
 * 对齐方式
 */
- (NSTextAlignment)textAlignmentWithLabel:(UILabel *)label{
    CGFloat expCompanyMarkLabelH = [label.text sizeWithFont:label.font maxSize:CGSizeMake(kScreenWidth - 3*CYTMarginH - (_sendCarAddTipLabel.font.pointSize+2)*4, CGFLOAT_MAX)].height;
    if (expCompanyMarkLabelH>=label.font.pointSize*2) {
        return NSTextAlignmentLeft;
    }else{
        return NSTextAlignmentRight;
    }
}
/**
 * 发车人姓名
 */
- (NSString *)senderName{
    return _confirmOrderInfoModel.customSenderName;
}
/**
 * 发车人手机号
 */
- (NSString *)senderTel{
    return _confirmOrderInfoModel.customSenderTel;
}
- (NSString *)sDetailAddress{
    return _confirmOrderInfoModel.customSDetailedAddress;
}
@end
