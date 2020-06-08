//
//  CYTOrderNumberInfoCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTOrderNumberInfoCell.h"
#import "CYTOrderModel.h"

@implementation CYTOrderNumberInfoCell
{
    //分割条
    UIView *_topBar;
    //复制按钮
    UIButton *_copyBtn;
    //订单号
    UILabel *_orderNumTipLabel;
    UILabel *_orderNumLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self orderNumberInfoBasicConfig];
        [self initOrderNumberInfoComponents];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)orderNumberInfoBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
/**
 *  初始化子控件
 */
- (void)initOrderNumberInfoComponents{
    //分割条
    UIView *topBar = [[UIView alloc] init];
    topBar.backgroundColor = kFFColor_bg_nor;
    [self.contentView addSubview:topBar];
    _topBar = topBar;
    //复制按钮
    UIButton *copyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    copyBtn.titleLabel.font = CYTFontWithPixel(22.f);
    [copyBtn setTitle:@"复制" forState:UIControlStateNormal];
    [copyBtn setTitleColor:CYTHexColor(@"#999999") forState:UIControlStateNormal];
    copyBtn.layer.cornerRadius = 2.f;
    copyBtn.layer.borderColor = CYTHexColor(@"#dbdbdb").CGColor;
    copyBtn.layer.borderWidth = 1.f;
    [self.contentView addSubview:copyBtn];
    [[copyBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = _orderNumLabel.text;
        [CYTToast successToastWithMessage:@"已复制订单号"];
    }];
    _copyBtn = copyBtn;
    
    //订单号
    UILabel *orderNumTipLabel = [UILabel labelWithText:@"订单号：" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:24.f setContentPriority:YES];
    [self.contentView addSubview:orderNumTipLabel];
    _orderNumTipLabel = orderNumTipLabel;
    
    UILabel *orderNumLabel = [UILabel labelWithTextColor:CYTHexColor(@"#999999") textAlignment:NSTextAlignmentLeft fontPixel:24.f setContentPriority:NO];
    [self.contentView addSubview:orderNumLabel];
    _orderNumLabel = orderNumLabel;
    
    
    //测试数据
    _orderNumLabel.text = @"R234ff4566666666666662";

    
}

/**
 *  布局控件
 */
- (void)makeConstrainsWithOrderModel:(CYTOrderModel *)orderModel{
    [_topBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(CYTAutoLayoutV(20));
        
    }];
    [_orderNumTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(_topBar.mas_bottom).offset(CYTItemMarginV);
        make.bottom.equalTo(-CYTItemMarginV);
    }];
    
    CGFloat copyBtnH = _copyBtn.titleLabel.font.pointSize + 6;
    
    [_copyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-CYTMarginH);
        make.centerY.equalTo(_orderNumTipLabel);
        make.size.equalTo(CGSizeMake(copyBtnH*2, copyBtnH));
        
    }];
    
    [_orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_orderNumTipLabel);
        make.left.equalTo(_orderNumTipLabel.mas_right);
        make.right.equalTo(_copyBtn.mas_left).offset(-CYTItemMarginH);
    }];

}
+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTOrderNumberInfoCell";
    CYTOrderNumberInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTOrderNumberInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

/**
 *  订单详情界面 传入模型
 */
- (void)setOrderModel:(CYTOrderModel *)orderModel{
    if (!orderModel) return;
    [self setValueWithOrderModel:orderModel];
    [self makeConstrainsWithOrderModel:orderModel];
    
}

- (void)setValueWithOrderModel:(CYTOrderModel *)orderModel{
    NSString *orderCode = orderModel.orderCode.length?orderModel.orderCode:@"";
    _orderNumLabel.text = orderCode;
}


@end
