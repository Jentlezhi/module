//
//  CYTPriceInfoView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/18.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPriceInfoView.h"
#import "CYTConfirmOrderInfoModel.h"

@implementation CYTPriceInfoView

{
    //运费
    UILabel *_tranExpensesLabel;
    //运费金额
    UILabel *_tranExpensesValueLabel;
    //上门取车费
    UILabel *_doorToDoorGetExpLabel;
    //上门取车费金额
    UILabel *_doorToDoorGetExpValueLabel;
    //送车上门费
    UILabel *_doorToDoorSendExpLabel;
    //送车上门费金额
    UILabel *_doorToDoorSendExpValueLabel;
    //保险费
    UILabel *_insuranceLabel;
    //保险费金额
    UILabel *_insuranceValueLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self priceInfoViewBasicConfig];
        [self initPriceInfoViewComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)priceInfoViewBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}
/**
 *  初始化子控件
 */
- (void)initPriceInfoViewComponents{
    //运费
    UILabel *tranExpensesLabel = [UILabel labelWithText:@"运费" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:24.f setContentPriority:NO];
    [self addSubview:tranExpensesLabel];
    _tranExpensesLabel = tranExpensesLabel;
    
    //运费金额
    UILabel *tranExpensesValueLabel = [UILabel labelWithText:nil textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentRight fontPixel:24.f setContentPriority:NO];
    [self addSubview:tranExpensesValueLabel];
    _tranExpensesValueLabel = tranExpensesValueLabel;
    
    
    //上门取车费
    UILabel *doorToDoorGetExpLabel = [UILabel labelWithText:@"上门取车费" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:24.f setContentPriority:NO];
    [self addSubview:doorToDoorGetExpLabel];
    _doorToDoorGetExpLabel = doorToDoorGetExpLabel;
    
    //上门取车费金额
    UILabel *doorToDoorGetExpValueLabel = [UILabel labelWithText:nil textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentRight fontPixel:24.f setContentPriority:NO];
    [self addSubview:doorToDoorGetExpValueLabel];
    _doorToDoorGetExpValueLabel = doorToDoorGetExpValueLabel;
    
    //送车上门费
    UILabel *doorToDoorSendExpLabel = [UILabel labelWithText:@"送车上门费" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:24.f setContentPriority:NO];
    [self addSubview:doorToDoorSendExpLabel];
    _doorToDoorSendExpLabel = doorToDoorSendExpLabel;
    
    //送车上门费金额
    UILabel *doorToDoorSendExpValueLabel = [UILabel labelWithText:nil textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentRight fontPixel:24.f setContentPriority:NO];
    [self addSubview:doorToDoorSendExpValueLabel];
    _doorToDoorSendExpValueLabel = doorToDoorSendExpValueLabel;
    
    //保险费
    UILabel *insuranceLabel = [UILabel labelWithText:@"保险费" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:24.f setContentPriority:NO];
    [self addSubview:insuranceLabel];
    _insuranceLabel = insuranceLabel;
    
    //保险费金额
    UILabel *insuranceValueLabel = [UILabel labelWithText:nil textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentRight fontPixel:24.f setContentPriority:NO];
    [self addSubview:insuranceValueLabel];
    _insuranceValueLabel= insuranceValueLabel;
    
    //测试
//    tranExpensesValueLabel.text = @"700元";
//    doorToDoorGetExpValueLabel.text = @"700元";
//    doorToDoorSendExpValueLabel.text = @"700元";
//    insuranceValueLabel.text = @"700元";
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    CGFloat tranExpensesLabelH = _tranExpensesLabel.font.pointSize+2;
    [_tranExpensesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(CYTAutoLayoutV(20.f));
        make.left.equalTo(self).offset(CYTAutoLayoutH(30.f));
        make.size.equalTo(CGSizeMake(tranExpensesLabelH*5, tranExpensesLabelH));
    }];
    
    [_doorToDoorGetExpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tranExpensesLabel);
        make.top.equalTo(_tranExpensesLabel.mas_bottom).offset(CYTAutoLayoutV(20.f));
        make.size.equalTo(_tranExpensesLabel);
    }];
    
    [_doorToDoorSendExpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tranExpensesLabel);
        make.top.equalTo(_doorToDoorGetExpLabel.mas_bottom).offset(CYTAutoLayoutV(20.f));
        make.size.equalTo(_tranExpensesLabel);
    }];
    
    [_insuranceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tranExpensesLabel);
        make.top.equalTo(_doorToDoorSendExpLabel.mas_bottom).offset(CYTAutoLayoutV(20.f));
        make.size.equalTo(_tranExpensesLabel);
    }];
    
    [_tranExpensesValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tranExpensesLabel.mas_right).offset(CYTAutoLayoutH(30.f));
        make.top.equalTo(_tranExpensesLabel);
        make.right.equalTo(self).offset(-CYTAutoLayoutH(30.f));
        make.height.equalTo(_tranExpensesLabel);
    }];
    
    [_doorToDoorGetExpValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.with.height.equalTo(_tranExpensesValueLabel);
        make.top.equalTo(_doorToDoorGetExpLabel);
    }];
    
    [_doorToDoorSendExpValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.with.height.equalTo(_tranExpensesValueLabel);
        make.top.equalTo(_doorToDoorSendExpLabel);
    }];
    
    [_insuranceValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.with.height.equalTo(_tranExpensesValueLabel);
        make.top.equalTo(_insuranceLabel);
    }];

}

- (void)setConfirmOrderInfoModel:(CYTConfirmOrderInfoModel *)confirmOrderInfoModel{
    _confirmOrderInfoModel = confirmOrderInfoModel;
    //运费金额
    _tranExpensesValueLabel.text = confirmOrderInfoModel.transportPrice;
    //上门取车费
    _doorToDoorGetExpValueLabel.text = confirmOrderInfoModel.takeCarPrice;
    //送车上门费金额
    _doorToDoorSendExpValueLabel.text = confirmOrderInfoModel.deliveryPrice;
    //保险费
    _insuranceValueLabel.text = confirmOrderInfoModel.insurancePrice;
}

@end
