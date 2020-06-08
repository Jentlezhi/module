//
//  CYTOrderStatusCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/30.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTOrderStatusCell.h"
#import "CYTOrderModel.h"
#import "CYTCarOrderEnum.h"

@interface CYTOrderStatusCell()

/** 图标 */
@property(strong, nonatomic) UIImageView *iconImageView;
/** 订单状态 */
@property(strong, nonatomic) UILabel *orderStatusLabel;
/** 订单状态描述 */
@property(strong, nonatomic) UILabel *orderStatusDesLabel;

@end

@implementation CYTOrderStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self orderStatusConfig];
        [self initOrderStatusComponents];
        [self makeConstrain];
    }
    return self;
}
#pragma mark - 懒加载

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [UIImageView ff_imageViewWithImageName:@"ic_order_nor"];
    }
    return _iconImageView;
}
- (UILabel *)orderStatusLabel{
    if (!_orderStatusLabel) {
        _orderStatusLabel = [UILabel labelWithTextColor:CYTHexColor(@"#FFFFFF") textAlignment:NSTextAlignmentLeft fontPixel:32.f setContentPriority:NO];
    }
    return _orderStatusLabel;
}

- (UILabel *)orderStatusDesLabel{
    if (!_orderStatusDesLabel) {
        _orderStatusDesLabel = [UILabel labelWithTextColor:CYTHexColor(@"#FFFFFF") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
        _orderStatusDesLabel.numberOfLines = 0;
    }
    return _orderStatusDesLabel;
}

/**
 *  基本配置
 */
- (void)orderStatusConfig{
    self.backgroundColor = CYTHexColor(@"#52C060");
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
/**
 *  初始化子控件
 */
- (void)initOrderStatusComponents{
    //图标
    [self.contentView addSubview:self.iconImageView];
    //订单状态
    [self.contentView addSubview:self.orderStatusLabel];
    //订单状态描述
    [self.contentView addSubview:self.orderStatusDesLabel];
}
/**
 *  布局控件
 */
- (void)makeConstrain{
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(CYTAutoLayoutV(42.f));
        make.top.equalTo(CYTMarginV);
        make.left.equalTo(CYTItemMarginH);
    }];
}
/**
 *  布局控件
 */
- (void)makeConstrainsWithOrderModel:(CYTOrderModel *)orderModel{
    NSString *orderDecStr = orderModel.orderStatusDesc;
    if (!orderDecStr.length) {
        [self.orderStatusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.iconImageView);
            make.left.equalTo(self.iconImageView.mas_right).offset(CYTAutoLayoutH(10));
            make.right.equalTo(-CYTMarginH);
            make.bottom.equalTo(-CYTItemMarginV);
        }];
    }else{
        [self.orderStatusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.iconImageView);
            make.left.equalTo(self.iconImageView.mas_right).offset(CYTAutoLayoutH(10.f));
            make.right.equalTo(-CYTMarginH);
        }];
        [self.orderStatusDesLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.orderStatusLabel.mas_bottom).offset(CYTAutoLayoutV(23.f));
            make.left.equalTo(self.iconImageView);
            make.right.equalTo(self.orderStatusLabel);
            make.bottom.equalTo(-CYTItemMarginV);
        }];
    }

}
+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTOrderStatusCell";
    CYTOrderStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTOrderStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
/**
 *  订单详情页面 模型传入
 */
- (void)setOrderModel:(CYTOrderModel *)orderModel{
    if (!orderModel) return;
    _orderModel = orderModel;
    [self setValueWithOrderModel:orderModel];
    [self makeConstrainsWithOrderModel:orderModel];
}
/**
 *  控件赋值
 */
- (void)setValueWithOrderModel:(CYTOrderModel *)orderModel{
    NSString *orderStatusStr = orderModel.orderStatusText.length?orderModel.orderStatusText:@"订单状态错误";
    CarOrderState  orderState = orderModel.orderStatus;
    self.backgroundColor = orderState <= CarOrderStateCancel?CYTHexColor(@"#BDBDBD"):CYTHexColor(@"#52C060");
    self.orderStatusLabel.text = orderStatusStr;
    self.orderStatusDesLabel.text = orderModel.orderStatusDesc;
    NSAttributedString *aString = [NSAttributedString attributedWithLabel:self.orderStatusDesLabel lineSpacing:self.orderStatusDesLabel.font.pointSize*0.1];
    self.orderStatusDesLabel.attributedText = aString;
}
@end
