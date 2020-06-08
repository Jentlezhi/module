//
//  CYTOrderStatusCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticsOrderStatusCell.h"
#import "CYTLogisticOrderModel.h"

@implementation CYTLogisticsOrderStatusCell
{
    //订单状态
    UILabel *_orderStatusLabel;
    //订单状态描述
    UILabel *_orderStatusDesLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self orderStatusConfig];
        [self initOrderStatusComponents];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)orderStatusConfig{
    self.backgroundColor = CYTLightGrayColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
/**
 *  初始化子控件
 */
- (void)initOrderStatusComponents{
    //订单状态
    UILabel *orderStatusLabel = [UILabel labelWithText:@"" textColor:CYTHexColor(@"#F43244") textAlignment:NSTextAlignmentLeft fontPixel:30.f setContentPriority:NO];
    [self.contentView addSubview:orderStatusLabel];
    _orderStatusLabel = orderStatusLabel;
    
    //订单状态描述
    UILabel *orderStatusDesLabel = [UILabel labelWithText:@"" textColor:CYTHexColor(@"#999999") textAlignment:NSTextAlignmentLeft fontPixel:24.f setContentPriority:NO];
    orderStatusDesLabel.numberOfLines = 0;
    [self.contentView addSubview:orderStatusDesLabel];
    _orderStatusDesLabel = orderStatusDesLabel;
    
//    //测试数据
//    _orderStatusLabel.text = @"待支付";
//    _orderStatusDesLabel.text = @"长沙城区80多平方米的房子，被八旬老人以29万的低价出售，急得儿子打官司讨回。因为老人被诊断患了老年性痴呆，他儿子认为签订的合同无效，应予以撤销。近日，长沙市芙蓉区人民法院公布了该起案件，因购房合同显失公平，法院依法撤销了该合同。";
//    NSAttributedString *aString = [NSAttributedString attributedWithLabel:_orderStatusDesLabel lineSpacing:_orderStatusDesLabel.font.pointSize*0.1];
//    _orderStatusDesLabel.attributedText = aString;
    
}
/**
 *  布局控件
 */
- (void)makeConstrainsLogisticOrderModel:(CYTLogisticOrderModel *)logisticOrderModel{
    NSString *orderStatusText = logisticOrderModel.orderStatusText;
    if (!orderStatusText.length) {
        [_orderStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(CYTItemMarginV);
            make.left.offset(CYTMarginH);
            make.right.equalTo(-CYTMarginH);
            make.bottom.equalTo(-CYTItemMarginV);
        }];
    }else{
        [_orderStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(CYTItemMarginV);
            make.left.offset(CYTMarginH);
            make.right.equalTo(-CYTMarginH);
        }];
        [_orderStatusDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_orderStatusLabel.mas_bottom).offset(CYTAutoLayoutV(15.f));
            make.left.right.equalTo(_orderStatusLabel);
            make.bottom.equalTo(-CYTItemMarginV);
        }];
    }
}
+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTLogisticsOrderStatusCell";
    CYTLogisticsOrderStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTLogisticsOrderStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
/**
 *  物流订单详情 模型传入
 */
- (void)setLogisticOrderModel:(CYTLogisticOrderModel *)logisticOrderModel{
    if (!logisticOrderModel) return;
    _logisticOrderModel = logisticOrderModel;
    [self setValueWithLogisticOrderModel:logisticOrderModel];
    [self makeConstrainsLogisticOrderModel:logisticOrderModel];
}
/**
 *  控件赋值
 */
- (void)setValueWithLogisticOrderModel:(CYTLogisticOrderModel *)logisticOrderModel{
    NSString *orderStatusStr = logisticOrderModel.orderStatusDesc.length?logisticOrderModel.orderStatusDesc:@"物流订单状态错误";
    _orderStatusLabel.text = orderStatusStr;
    _orderStatusLabel.textColor = [self orderStatusTextColorWithLogisticOrderModel:logisticOrderModel];
    _orderStatusDesLabel.text = logisticOrderModel.orderStatusText;
    //设置行间距
    NSAttributedString *aString = [NSAttributedString attributedWithLabel:_orderStatusDesLabel lineSpacing:_orderStatusDesLabel.font.pointSize*0.1];
    _orderStatusDesLabel.attributedText = aString;
}
/**
 * 设置支付状态文字颜色
 */
- (UIColor *)orderStatusTextColorWithLogisticOrderModel:(CYTLogisticOrderModel *)logisticOrderModel{
    CYTLogisticsOrderStatus logisticsOrderStatus = logisticOrderModel.orderStatus;
    switch (logisticsOrderStatus) {
        case CYTLogisticsOrderStatusWaitPay:
            return CYTHexColor(@"#F43244");
            break;
        case CYTLogisticsOrderStatusWaitMatchingBoard:
        case CYTLogisticsOrderStatusWaitDriver:
        case CYTLogisticsOrderStatusInTransit:
             return CYTHexColor(@"#2CB63E");
            break;
        case CYTLogisticsOrderStatusFinish:
        case CYTLogisticsOrderStatusFinishUnComment:
        case CYTLogisticsOrderStatusFinishCommented:
            return CYTHexColor(@"#333333");
            break;
        default:
            return CYTHexColor(@"#9F9F9F");
            break;
    }
}

@end
