//
//  CYTRecCarInfoCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticRecCarInfoCell.h"
#import "CYTConfirmOrderInfoModel.h"
#import "CYTIDCardTextField.h"
#import "CYTTextView.h"

@implementation CYTLogisticRecCarInfoCell
{
    //收车信息
    UIView *_recCarTipView;
    UILabel *_recCarTipLabel;
    //收车地
    UILabel *_recCarAddTipLabel;
    UILabel *_recCarAddLabel;
    UILabel *_recCarAddlineLabel;
    
    //收车地址
    CYTTextView *_recAddressDetail;
    //收车详细地址分割线
    UILabel *_recAddressDetaillineLabel;
    
    //收车人姓名
    UILabel *_recNameTipLabel;
    //收车人姓名输入
    UITextField *_recNameTF;
    UILabel *_recNamelineLabel;
    
    //收车人手机号
    UILabel *_recPhoneNumTipLabel;
    //收车人姓名输入
    UITextField *_recPhoneNumTF;
    UILabel *_recPhoneNumlineLabel;
    
    //收车人身份证号
    UILabel *_recIDCardNumTipLabel;
    //收车人身份证号输入
    CYTIDCardTextField *_recIDCardNumTF;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self recCarInfoBasicConfig];
        [self initRecCarInfoComponents];
        [self handelTextField];
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
    //收车信息
    UIView *recCarTipView = [[UIView alloc] init];
    recCarTipView.backgroundColor = CYTLightGrayColor;
    [self.contentView addSubview:recCarTipView];
    _recCarTipView = recCarTipView;
    
    UILabel *recCarTipLabel = [UILabel labelWithText:@"收车信息" textColor:CYTHexColor(@"#5A5A5A") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:NO];
    [recCarTipView addSubview:recCarTipLabel];
    _recCarTipLabel = recCarTipLabel;
    
    //收车地
    UILabel *recCarAddTipLabel = [UILabel labelWithText:@"收车地：" textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:NO];
    [self.contentView addSubview:recCarAddTipLabel];
    _recCarAddTipLabel = recCarAddTipLabel;
    
    UILabel *recCarAddLabel = [UILabel labelWithText:nil textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    recCarAddLabel.numberOfLines = 0;
    [self.contentView addSubview:recCarAddLabel];
    _recCarAddLabel = recCarAddLabel;
    
    UILabel *recCarAddlineLabel = [[UILabel alloc] init];
    recCarAddlineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self.contentView addSubview:recCarAddlineLabel];
    _recCarAddlineLabel = recCarAddlineLabel;
    
    //收车地址
    CYTTextView *recAddressDetail = [[CYTTextView alloc] init];
    recAddressDetail.placeholder = @"请输入详细地址";
    recAddressDetail.placeholderColor = CYTHexColor(@"#999999");
    recAddressDetail.font = CYTFontWithPixel(26.f);
    recAddressDetail.backgroundColor = [UIColor clearColor];
    recAddressDetail.delegate = self;
    [self.contentView addSubview:recAddressDetail];
    _recAddressDetail = recAddressDetail;
    
    //发车详细地址分割线
    UILabel *recAddressDetaillineLabel = [[UILabel alloc] init];
    recAddressDetaillineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self.contentView addSubview:recAddressDetaillineLabel];
    _recAddressDetaillineLabel = recAddressDetaillineLabel;
    
    //收车人姓名
    UILabel *recNameTipLabel = [UILabel labelWithText:@"收车人姓名：" textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:NO];
    [self.contentView addSubview:recNameTipLabel];
    _recNameTipLabel = recNameTipLabel;
    
    //收车人姓名输入
    UITextField *recNameTF = [UITextField textFieldWithTextColor:CYTHexColor(@"#333333") fontPixel:26.f textAlignment:NSTextAlignmentRight keyboardType:UIKeyboardTypeDefault clearButtonMode:UITextFieldViewModeWhileEditing placeholder:@"请输入姓名"];
    [recNameTF addTarget:self action:@selector(recNameTextChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:recNameTF];
    _recNameTF = recNameTF;
    
    UILabel *recNamelineLabel = [[UILabel alloc] init];
    recNamelineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self.contentView addSubview:recNamelineLabel];
    _recNamelineLabel = recNamelineLabel;
    
    //收车人手机号
    UILabel *recPhoneNumTipLabel = [UILabel labelWithText:@"收车人手机号：" textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:NO];
    [self.contentView addSubview:recPhoneNumTipLabel];
    _recPhoneNumTipLabel = recPhoneNumTipLabel;
    
    //收车人姓名输入
    UITextField *recPhoneNumTF = [UITextField textFieldWithTextColor:CYTHexColor(@"#333333") fontPixel:26.f textAlignment:NSTextAlignmentRight keyboardType:UIKeyboardTypeNumberPad clearButtonMode:UITextFieldViewModeWhileEditing placeholder:@"请输入手机号"];
    [recPhoneNumTF addTarget:self action:@selector(recPhoneNumChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:recPhoneNumTF];
    _recPhoneNumTF = recPhoneNumTF;
    
    UILabel *recPhoneNumlineLabel = [[UILabel alloc] init];
    recPhoneNumlineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self.contentView addSubview:recPhoneNumlineLabel];
    _recPhoneNumlineLabel = recPhoneNumlineLabel;
    
    //收车人身份证号
    UILabel *recIDCardNumTipLabel = [UILabel labelWithText:@"收车人身份证号：" textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:NO];
    [self.contentView addSubview:recIDCardNumTipLabel];
    _recIDCardNumTipLabel = recIDCardNumTipLabel;
    
    //收车人身份证号输入
    CYTIDCardTextField *recIDCardNumTF = [[CYTIDCardTextField alloc] init];
    recIDCardNumTF.textAlignment = NSTextAlignmentRight;
    recIDCardNumTF.placeholder = @"请输入身份证号";
    recIDCardNumTF.textColor = [UIColor colorWithHexColor:@"#333333"];
    recIDCardNumTF.font = CYTFontWithPixel(26.f);
    [recIDCardNumTF addTarget:self action:@selector(recIDCardNumChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:recIDCardNumTF];
    _recIDCardNumTF = recIDCardNumTF;

//    //测试数据
//    _recCarAddLabel.text = @"中国国家主席习近平在2013年提出共建丝绸之路经济带和21世纪海上丝绸之路的重要合作倡议。3年多来";
//    NSAttributedString *aString = [NSAttributedString attributedWithLabel:_recCarAddLabel lineSpacing:_recCarAddLabel.font.pointSize*0.3];
//    _recCarAddLabel.attributedText = aString;
//    //处理对齐方式
//    _recCarAddLabel.textAlignment = [self textAlignmentWithLabel:_recCarAddLabel];
}
/**
 *  处理输入框
 */
- (void)handelTextField{
    [_recNameTF.rac_textSignal subscribeNext:^(NSString *inputString) {
        if (inputString.length > CYTNameLengthMax) {
            _recNameTF.text = [inputString substringToIndex:CYTNameLengthMax];
        }
    }];
    [_recPhoneNumTF.rac_textSignal subscribeNext:^(NSString *inputString) {
        if (inputString.length > CYTAccountLengthMax) {
            _recPhoneNumTF.text = [inputString substringToIndex:CYTAccountLengthMax];
        }
    }];
    
    [_recIDCardNumTF.rac_textSignal subscribeNext:^(NSString *inputString) {
        if (inputString.length > CYTIdCardLengthMax) {
            _recIDCardNumTF.text = [inputString substringToIndex:CYTIdCardLengthMax];
        }
    }];
    
}

/**
 *  收车详细地址
 */
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.markedTextRange == nil) {
        _confirmOrderInfoModel.customRDetailedAddress = textView.text;
    }
}
/**
 *  收车人姓名
 */
- (void)recNameTextChanged:(UITextField *)textField{
    _confirmOrderInfoModel.customReceiverName = textField.text;
    
}
/**
 *  收车人手机
 */
- (void)recPhoneNumChanged:(UITextField *)textField{
        NSString *tel = textField.text.length>CYTAccountLengthMax?[textField.text substringToIndex:CYTAccountLengthMax]:textField.text;
    _confirmOrderInfoModel.customReceiverTel = tel;
}
/**
 *  收车人身份证号
 */
- (void)recIDCardNumChanged:(UITextField *)textField{
    _confirmOrderInfoModel.customReceiverIdentityNo = textField.text;
}

/**
 *  布局控件
 */
- (void)makeConstrains{
    [_recCarTipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.equalTo(CYTAutoLayoutV(90.f));
    }];
    
    [_recCarTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_recCarTipView).offset(CYTMarginH);
        make.right.equalTo(_recCarTipView).offset(-CYTMarginH);
        make.centerY.equalTo(_recCarTipView);
        make.height.equalTo(_recCarTipLabel.font.pointSize+2);
        
    }];
    
    CGFloat recCarAddTipLabelH = _recCarAddTipLabel.font.pointSize+2;
    
    [_recCarAddTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_recCarTipView.mas_bottom).offset(CYTAutoLayoutV(20.f));
        make.left.equalTo(self.contentView).offset(CYTMarginH);
        make.size.equalTo(CGSizeMake(recCarAddTipLabelH*4, recCarAddTipLabelH));
    }];
    
    [_recCarAddLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_recCarAddTipLabel.mas_right).offset(CYTMarginH);
        make.top.equalTo(_recCarAddTipLabel);
        make.right.equalTo(self.contentView).offset(-CYTMarginH);
        
    }];
    
    [_recCarAddlineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(CYTMarginH);
        make.right.equalTo(self.contentView).offset(-CYTMarginH);
        make.top.equalTo(_recCarAddLabel.mas_bottom).offset(CYTAutoLayoutV(20.f));
        make.height.equalTo(CYTDividerLineWH);
        
    }];
    
    [_recAddressDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_recCarAddlineLabel.mas_bottom);
        make.left.equalTo(_recCarAddLabel);
        make.right.equalTo(-CYTMarginH);
        make.height.equalTo(CYTAutoLayoutV(140.f));
    }];
    
    [_recAddressDetaillineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_recCarAddlineLabel);
        make.top.equalTo(_recAddressDetail.mas_bottom);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    [_recNameTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_recCarAddTipLabel);
        make.top.equalTo(_recAddressDetaillineLabel.mas_bottom);
        make.width.equalTo(recCarAddTipLabelH*6);
        make.height.equalTo(CYTAutoLayoutV(90.f));
    }];
    
    [_recNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_recNameTipLabel.right).offset(CYTAutoLayoutH(CYTMarginH));
        make.centerY.equalTo(_recNameTipLabel);
        make.right.equalTo(self.contentView).offset(-CYTMarginH);
        make.height.equalTo(_recNameTipLabel);
    }];
    
    [_recNamelineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(CYTMarginH);
        make.right.equalTo(self.contentView).offset(-CYTMarginH);
        make.top.equalTo(_recNameTipLabel.mas_bottom);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    [_recPhoneNumTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_recNameTipLabel.mas_bottom);
        make.left.equalTo(_recNameTipLabel);
        make.width.equalTo(recCarAddTipLabelH*7);
        make.height.equalTo(_recNameTipLabel);
    }];
    
    [_recPhoneNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_recPhoneNumTipLabel.right).offset(CYTAutoLayoutH(CYTMarginH));
        make.centerY.equalTo(_recPhoneNumTipLabel);
        make.right.equalTo(_recNameTF);
        make.height.equalTo(_recPhoneNumTipLabel);
        
    }];
    
    [_recPhoneNumlineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(CYTMarginH);
        make.right.equalTo(self.contentView).offset(-CYTMarginH);
        make.top.equalTo(_recPhoneNumTipLabel.mas_bottom);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    [_recIDCardNumTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_recPhoneNumlineLabel.mas_bottom);
        make.left.equalTo(_recPhoneNumTipLabel);
        make.width.equalTo(recCarAddTipLabelH*8);
        make.height.equalTo(_recNameTipLabel);
    }];
    
    [_recIDCardNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_recIDCardNumTipLabel.right).offset(CYTAutoLayoutH(CYTMarginH));
        make.centerY.equalTo(_recIDCardNumTipLabel);
        make.right.equalTo(_recNameTF);
        make.height.equalTo(_recIDCardNumTipLabel);
        make.bottom.equalTo(self.contentView).offset(-CYTAutoLayoutV(5.f));
    }];

    
}
+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTLogisticRecCarInfoCell";
    CYTLogisticRecCarInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTLogisticRecCarInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setConfirmOrderInfoModel:(CYTConfirmOrderInfoModel *)confirmOrderInfoModel{
    _confirmOrderInfoModel = confirmOrderInfoModel;
    //收车地
    NSString *receP = confirmOrderInfoModel.rProvinceName.length?confirmOrderInfoModel.rProvinceName:@"";
    NSString *receC = confirmOrderInfoModel.rCityName.length?confirmOrderInfoModel.rCityName:@"";
    NSString *receA = confirmOrderInfoModel.rAreaName.length?confirmOrderInfoModel.rAreaName:@"";
    NSString *receiveAddress = [NSString stringWithFormat:@"%@ %@ %@",receP,receC,receA];
    _recCarAddLabel.text = receiveAddress;
    //详细地址
    NSString *recDetail = confirmOrderInfoModel.rDetailedAddress.length?confirmOrderInfoModel.rDetailedAddress:@"";
    _recAddressDetail.text = recDetail;
    //设置行间距
    NSAttributedString *aString = [NSAttributedString attributedWithLabel:_recCarAddLabel lineSpacing:_recCarAddLabel.font.pointSize*0.3];
    _recCarAddLabel.attributedText = aString;
    //处理对齐方式
    _recCarAddLabel.textAlignment = [self textAlignmentWithLabel:_recCarAddLabel];
    //收车人姓名
    NSString *recNameStr = confirmOrderInfoModel.receiverName.length?confirmOrderInfoModel.receiverName:@"";
    _recNameTF.text = recNameStr;
    //收车人手机号
    NSString *recPhoneStr = confirmOrderInfoModel.receiverTel.length?confirmOrderInfoModel.receiverTel:@"";
    _recPhoneNumTF.text = recPhoneStr;
    //收车人身份证号
    NSString *recIDCardNumStr = confirmOrderInfoModel.receiverIdentityNo.length?confirmOrderInfoModel.receiverIdentityNo:@"";
    _recIDCardNumTF.text = recIDCardNumStr;
    
    //输入框赋值
    _recAddressDetail.text = confirmOrderInfoModel.customRDetailedAddress;
    _recNameTF.text = confirmOrderInfoModel.customReceiverName;
    _recPhoneNumTF.text = confirmOrderInfoModel.customReceiverTel;
    _recIDCardNumTF.text = confirmOrderInfoModel.customReceiverIdentityNo;
    
}
/**
 * 对齐方式
 */
- (NSTextAlignment)textAlignmentWithLabel:(UILabel *)label{
    CGFloat expCompanyMarkLabelH = [label.text sizeWithFont:label.font maxSize:CGSizeMake(kScreenWidth - 3*CYTMarginH - (_recCarAddTipLabel.font.pointSize+2)*4, CGFLOAT_MAX)].height;
    if (expCompanyMarkLabelH>=label.font.pointSize*2) {
        return NSTextAlignmentLeft;
    }else{
        return NSTextAlignmentRight;
    }
}
/**
 * 收车人姓名
 */
- (NSString *)receiverName{
    return _confirmOrderInfoModel.customReceiverName;
}
/**
 * 收车人手机号
 */
- (NSString *)receiverTel{
    return _confirmOrderInfoModel.customReceiverTel;
}
/**
 * 收车人身份证号
 */
- (NSString *)receiverIdentityNo{
    return _confirmOrderInfoModel.customReceiverIdentityNo;
}
- (NSString *)rDetailAddress{
    return _confirmOrderInfoModel.customRDetailedAddress;
}
@end
