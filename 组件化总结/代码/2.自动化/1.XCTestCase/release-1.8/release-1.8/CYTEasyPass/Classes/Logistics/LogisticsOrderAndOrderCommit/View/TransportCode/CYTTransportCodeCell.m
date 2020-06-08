//
//  CYTTransportCodeCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/18.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTTransportCodeCell.h"
#import "CYTLogisticTranOrderModel.h"

@implementation CYTTransportCodeCell
{
    //运单号
    UILabel *_transportCodeTipLabel;
    UILabel *_transportCodeLabel;
    //复制按钮
    UIButton *_copyBtn;
    //分割线
    UILabel *_transportCodelineLabel;
    //分割条
    UIView *_topBar;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self transportCodeBasicConfig];
        [self initTransportCodeComponents];
        [self makeConstrains];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)transportCodeBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor clearColor];
}
/**
 *  初始化子控件
 */
- (void)initTransportCodeComponents{
    //分割条
    UIView *topBar = [[UIView alloc] init];
    topBar.backgroundColor = kFFColor_bg_nor;
    [self.contentView addSubview:topBar];
    _topBar = topBar;
    
    //运单号
    UILabel *transportCodeTipLabel  = [UILabel labelWithText:@"运单号:" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:NO];
    [self.contentView addSubview:transportCodeTipLabel];
    _transportCodeTipLabel = transportCodeTipLabel;
    
    UILabel *transportCodeLabel = [UILabel labelWithText:nil textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:NO];
    transportCodeLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:transportCodeLabel];
    _transportCodeLabel = transportCodeLabel;
    
    //复制按钮
    UIButton *copyBtn = [UIButton buttonWithTitle:@"复制" textFontPixel:22.f textColor:CYTHexColor(@"#999999") cornerRadius:3.f borderWidth:1.f borderColor:CYTHexColor(@"#dbdbdb")];
    [[copyBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        if (_transportCodeLabel.text.length) {
            pasteboard.string = _transportCodeLabel.text;
            [CYTToast successToastWithMessage:@"已复制运单号"];
        }else{
            [CYTToast warningToastWithMessage:@"运单号为空"];
        }
       
    }];
    [self.contentView addSubview:copyBtn];
    _copyBtn = copyBtn;
    
    //分割线
    UILabel *transportCodelineLabel = [[UILabel alloc] init];
    transportCodelineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self.contentView addSubview:transportCodelineLabel];
    _transportCodelineLabel = transportCodelineLabel;
    
    //测试数据
//    _transportCodeLabel.text = @"R2015121213480038";

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
    
    CGFloat transportCodeTipLabelH = _transportCodeTipLabel.font.pointSize+2;
    [_transportCodeTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(_topBar.mas_bottom);
        make.width.equalTo(transportCodeTipLabelH*4);
        make.height.equalTo(CYTAutoLayoutV(70.f));
    }];

    [_copyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_transportCodeTipLabel);
        make.right.offset(-CYTMarginH);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutH(70.f), CYTAutoLayoutV(34.f)));
    }];

    CGFloat transportCodeLabelH = _transportCodeLabel.font.pointSize+2;
    [_transportCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_transportCodeTipLabel.mas_right).offset(CYTMarginH);
        make.right.equalTo(_copyBtn.mas_left).offset(-CYTMarginH);
        make.centerY.equalTo(_transportCodeTipLabel);
        make.height.equalTo(transportCodeLabelH);
    }];
    
    [_transportCodelineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CYTMarginH);
        make.right.offset(-CYTMarginH);
        make.height.equalTo(CYTDividerLineWH);
        make.bottom.equalTo(self.contentView);
    }];
    
}
+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTTransportCodeCell";
    CYTTransportCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTTransportCodeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
/**
 * 物流订单详情 传入数据
 */
- (void)setLogisticTranOrderModel:(CYTLogisticTranOrderModel *)logisticTranOrderModel{
    if (!logisticTranOrderModel) return;
    _logisticTranOrderModel = logisticTranOrderModel;
    _transportCodeLabel.text = logisticTranOrderModel.expressCode;
}

@end
