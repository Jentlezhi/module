//
//  CYTLogisticInfoView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/18.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticInfoView.h"
#import "CYTConfirmOrderInfoModel.h"
#import "CYTLogisticDemandModel.h"

@implementation CYTLogisticInfoView
{
    //大标题view
    UIView *_titleView;
    //标题
    UILabel *_titleLabel;
    //车辆总价
    UILabel *_totalPriceLabel;
    //车辆个数
    UILabel *_carNumLabel;
    //子标题
    UILabel *_subTitleLabel;
    //信息提示条 需要送车上门
    UIView *_infoView;
    UIImageView *_iconInfo;
    //信息文字
    UILabel *_infoLabel;
    //提车司机信息条
    UIView *_driverphoneNumInfoView;
    //电话图标
    UIImageView *_iconPhone;
    UILabel *_phoneTipLabel;
    //提车司机手机号
    UILabel *_driverphoneNumLabel;
}

- (instancetype)initWithShowDriverPhone:(BOOL)showDriverPhone{
    if (self = [super init]) {
        [self logisticInfoBasicConfig];
        [self initLogisticInfoComponentsWithShowDriverPhone:showDriverPhone];
        [self makeConstrainsWithShowDriverPhone:showDriverPhone];
    }
    return self;
}
/**
 *  基本配置
 */
- (void) logisticInfoBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}
/**
 *  初始化子控件
 */
- (void)initLogisticInfoComponentsWithShowDriverPhone:(BOOL)showDriverPhone{
    //大标题view
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor clearColor];
    [self addSubview:titleView];
    _titleView = titleView;
    //标题
    UILabel *titleLabel = [UILabel labelWithText:@"" textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:30.f setContentPriority:NO];
    [titleView addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    //车辆总价
    UILabel *totalPriceLabel = [UILabel labelWithText:@"" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentRight fontPixel:24.f setContentPriority:NO];
    [titleView addSubview:totalPriceLabel];
    _totalPriceLabel = totalPriceLabel;
    
    //车辆个数
    UILabel *carNumLabel = [UILabel labelWithText:@"" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentRight fontPixel:24.f setContentPriority:NO];
    [self addSubview:carNumLabel];
    _carNumLabel = carNumLabel;
    
    //子标题
    UILabel *subTitleLabel = [UILabel labelWithText:@"" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    [self addSubview:subTitleLabel];
    _subTitleLabel = subTitleLabel;
    
    //信息提示条 需要送车上门
    UIView *infoView = [[UIView alloc] init];
    infoView.backgroundColor = [UIColor clearColor];
    [self addSubview:infoView];
    _infoView = infoView;
    
    //提示图标
    UIImageView *iconInfo = [[UIImageView alloc] init];
    iconInfo.image = [UIImage imageNamed:@"logistic_need_service_image"];
    [infoView addSubview:iconInfo];
    _iconInfo = iconInfo;
    //信息文字 信息
    UILabel *infoLabel = [UILabel labelWithText:@"" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:22.f setContentPriority:NO];
    [infoView addSubview:infoLabel];
    _infoLabel = infoLabel;
    
    //提车司机信息条
    UIView *driverphoneNumInfoView = [[UIView alloc] init];
    driverphoneNumInfoView.backgroundColor = [UIColor clearColor];
    [infoView addSubview:driverphoneNumInfoView];
    _driverphoneNumInfoView = driverphoneNumInfoView;
    
    //电话图标
    UIImageView *iconPhone = [[UIImageView alloc] init];
    iconPhone.image = [UIImage imageNamed:@"pic_phone_hl"];
    [driverphoneNumInfoView addSubview:iconPhone];
    _iconPhone = iconPhone;
    //信息文字 电话
    UILabel *phoneTipLabel = [UILabel labelWithText:@"提车司机：" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:22.f setContentPriority:NO];
    [driverphoneNumInfoView addSubview:phoneTipLabel];
    _phoneTipLabel = phoneTipLabel;
    
    //提车司机手机号
    UILabel *driverphoneNumLabel = [UILabel labelWithText:@"" textColor:CYTHexColor(@"#1985e9") textAlignment:NSTextAlignmentLeft fontPixel:22.f setContentPriority:NO];
    [driverphoneNumInfoView addSubview:driverphoneNumLabel];
    _driverphoneNumLabel = driverphoneNumLabel;
    
    _driverphoneNumInfoView.hidden = !showDriverPhone;
//    
//    //测试数据
//    titleLabel.text = @"宝骏 宝骏 560 ";
//    totalPriceLabel.text = @"总价：46万";
//    subTitleLabel.text = @"17款 1.2L";
//    carNumLabel.text = @"2辆";
//    infoLabel.text = @"需要送车上门";
    
}
/**
 *  布局子控件
 */
- (void)makeConstrainsWithShowDriverPhone:(BOOL)showDriverPhone{
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(CYTAutoLayoutV(90.f));
    }];
    
    CGFloat totalPriceLabelH = _totalPriceLabel.font.pointSize+2;
    [_totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_titleView).offset(-CYTAutoLayoutV(30.f));
        make.centerY.equalTo(_titleView);
        make.height.equalTo(totalPriceLabelH);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_totalPriceLabel.mas_left).offset(-CYTAutoLayoutV(30.f));
        make.top.bottom.equalTo(_titleView);
        make.left.equalTo(_titleView).offset(CYTAutoLayoutV(30.f));
    }];
    
    CGFloat carNumLabelH = _carNumLabel.font.pointSize+2;
    [_carNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleView.mas_bottom);
        make.right.equalTo(_totalPriceLabel);
        make.size.equalTo(CGSizeMake(carNumLabelH*5, carNumLabelH));
    }];

    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_carNumLabel);
        make.left.equalTo(_titleLabel);
        make.right.equalTo(_carNumLabel.mas_left).offset(-CYTAutoLayoutH(20.f));
    }];

    [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(_carNumLabel.mas_bottom).offset(CYTAutoLayoutV(30.f));
        if (showDriverPhone) {
            make.height.equalTo(CYTAutoLayoutV(85.f));
        }else{
            make.height.equalTo(CYTAutoLayoutV(85.f)*0.5);
        }
        make.bottom.equalTo(self).priorityHigh();
    }];
    
    CGFloat infoLabelH = _infoLabel.font.pointSize+2;
    CGFloat iconInfoMargin = CYTAutoLayoutV(85.f)-2*infoLabelH-CYTAutoLayoutV(10);
    [_iconInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_infoView);
        make.width.height.equalTo(CYTAutoLayoutV(24.f));
    }];

    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconInfo.mas_right).offset(CYTAutoLayoutH(10.f));
        make.centerY.equalTo(_iconInfo);
        make.right.equalTo(_infoView);
    }];
    
    [_driverphoneNumInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(_infoView);
        make.height.equalTo(_infoView).dividedBy(2);
    }];
    
    [_iconPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_iconInfo.mas_bottom).offset(iconInfoMargin);
        make.width.height.equalTo(CYTAutoLayoutV(24.f));
    }];
    
    [_phoneTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconPhone.mas_right).offset(CYTAutoLayoutH(10.f));
        make.centerY.equalTo(_iconPhone);
        make.width.equalTo(infoLabelH*5);
    }];
    
    [_driverphoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_phoneTipLabel.mas_right);
        make.centerY.equalTo(_iconPhone);
        make.right.equalTo(_infoView);
    }];

}
/**
 * 提交订单 模型传入
 */
- (void)setConfirmOrderInfoModel:(CYTConfirmOrderInfoModel *)confirmOrderInfoModel{
    if (!confirmOrderInfoModel) return;
    _confirmOrderInfoModel = confirmOrderInfoModel;
    //标题
    _titleLabel.text = [NSString stringWithFormat:@"%@ %@",confirmOrderInfoModel.carBrandName,confirmOrderInfoModel.carSerialName];
   //总价
    _totalPriceLabel.text = confirmOrderInfoModel.carPrice;
    //子标题
    BOOL hasCarYearType = confirmOrderInfoModel.carYearType.length;
    _subTitleLabel.text = hasCarYearType ? [NSString stringWithFormat:@"%@ %@",confirmOrderInfoModel.carYearType,confirmOrderInfoModel.carName]:confirmOrderInfoModel.carName;
    //车辆
    _carNumLabel.text = confirmOrderInfoModel.carAmount;
    //信息文字
    _infoLabel.text = confirmOrderInfoModel.isSendCarByDropIn;
    
}
/**
 * 物流订单详情 模型传入
 */
- (void)setLogisticDemandModel:(CYTLogisticDemandModel *)logisticDemandModel{
    _logisticDemandModel = logisticDemandModel;
    
    //标题
    _titleLabel.text = [NSString stringWithFormat:@"%@ %@",logisticDemandModel.carBrandName,logisticDemandModel.carSerialName];
    
    //总价
    _totalPriceLabel.text = logisticDemandModel.carPrice;
    
    //子标题
    BOOL hasCarYearType = logisticDemandModel.carYearType.length;
    _subTitleLabel.text = hasCarYearType ? [NSString stringWithFormat:@"%@款 %@",logisticDemandModel.carYearType,logisticDemandModel.carName]:logisticDemandModel.carName;
    //车辆
    _carNumLabel.text = logisticDemandModel.carAmount;
    
    //信息文字
    _infoLabel.text = [NSString stringWithFormat:@"%@；%@。",logisticDemandModel.takeCarByDropIn,logisticDemandModel.sendCarByDropIn];
    
    //提车司机
    NSString *driverphoneNum = logisticDemandModel.driverPhoneNum;
    _driverphoneNumLabel.text = driverphoneNum;
    
    //拨打手机号
    [_driverphoneNumLabel addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
        [CYTPhoneCallHandler makePhoneWithNumber:driverphoneNum alert:@"确定要联系提车司机吗？" resultBlock:nil];
    }];
    
    

}


@end
