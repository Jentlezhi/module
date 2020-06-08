//
//  CYTLogisticsNeedCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/10.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticsNeedCell.h"

@implementation CYTLogisticsNeedCell

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.timeLabel,
                       self.stateLabel,
                       self.line,
                       self.titleLab,
                       self.priceLab,
                       self.subTitle,
                       self.sendLabel,
                       self.receiveLabel,
                       self.topPointView,
                       self.vView,
                       self.botPointView,
                       self.actionView];
    block(views,^{
        self.bottomHeight = 0;
        self.topHeight = CYTItemMarginV;
        self.ffTopLineColor = kFFColor_bg_nor;
        [self.titleLab setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    });
}

- (void)updateConstraints {

    [self.timeLabel updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTItemMarginH);
        make.top.equalTo(CYTAutoLayoutV(20));
        make.right.lessThanOrEqualTo(self.stateLabel.left).offset(-10);
    }];
    [self.stateLabel updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-CYTItemMarginH);
        make.centerY.equalTo(self.timeLabel);
    }];
    [self.line updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.bottom).offset(CYTAutoLayoutV(20));
        make.left.equalTo(CYTItemMarginH);
        make.right.equalTo(-CYTItemMarginH);
        make.height.equalTo(CYTLineH);
    }];
    [self.titleLab updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTItemMarginH);
        make.top.equalTo(self.line.bottom).offset(CYTAutoLayoutV(30));
        make.right.lessThanOrEqualTo(self.priceLab.left).offset(-5);
    }];
    [self.priceLab updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLab);
        make.right.equalTo(-CYTAutoLayoutH(20));
    }];
    [self.subTitle updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTItemMarginH);
        make.right.equalTo(-CYTItemMarginH);
        make.top.equalTo(self.titleLab.bottom).offset(CYTAutoLayoutV(30)).priorityHigh();
    }];

    //address
    [self.sendLabel updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTitle.bottom).offset(CYTAutoLayoutV(30));
        make.left.equalTo(CYTAutoLayoutH(60));
        make.right.equalTo((-CYTMarginH));
    }];
    [self.receiveLabel updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sendLabel);
        make.top.equalTo(self.sendLabel.bottom).offset(CYTAutoLayoutV(40));
        make.right.equalTo((-CYTMarginH));
    }];
    [self.topPointView updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(self.subTitle.bottom).offset(CYTAutoLayoutV(42));
    }];
    [self.vView updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topPointView);
        make.top.equalTo(self.topPointView.bottom).offset(3);
        make.width.equalTo(CYTAutoLayoutH(1));
        make.bottom.equalTo(self.botPointView.top).offset(-3);
    }];
    [self.botPointView updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topPointView);
        make.top.equalTo(self.receiveLabel).offset(CYTAutoLayoutV(12));
    }];
    
    //actionView
    [self.actionView updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.ffContentView);
        make.top.equalTo(self.receiveLabel.bottom).offset(CYTItemMarginV);
    }];

    [super updateConstraints];
}

///物流需求状态获取
- (NSString *)stateString {
    switch (self.needModel.status) {
        case CYTLogisticsNeedStatusUnOrder:
        {
            NSString *str = [NSString stringWithFormat:@"：已收到%ld个报价",self.needModel.quoteCount];
            return [NSString stringWithFormat:@"待下单%@",str];
        }
        case CYTLogisticsNeedStatusFinished:
            return @"已完成";
        case CYTLogisticsNeedStatusExpired:
            return @"已过期";
        case CYTLogisticsNeedStatusCancel:
            return @"已取消";
        default:
            return @"";
    }
}

- (NSString *)sendAddress:(BOOL)needList {
    
    NSString *result = @"起运地：";
    NSString *string = @"";
    
    if (needList) {
        string = [NSString stringWithFormat:@"%@ %@ %@ %@",self.needModel.startProvinceName,self.needModel.startCityName,self.needModel.startCountyName,self.needModel.startAddress];
    }else {
        string = [NSString stringWithFormat:@"%@ %@ %@ %@",self.orderModel.startProvinceName,self.orderModel.startCityName,self.orderModel.startCountyName,self.orderModel.startAddress];
    }
    result = [NSString stringWithFormat:@"%@ %@",result,string];
    return result;
}

- (NSString *)receiveAddress:(BOOL)needList {
    NSString *result = @"目的地：";
    NSString *string = @"";
    
    if (needList) {
        string = [NSString stringWithFormat:@"%@ %@ %@ %@",self.needModel.destinationProvinceName,self.needModel.destinationCityName,self.needModel.destinationCountyName,self.needModel.destinationAddress];
    }else {
        string = [NSString stringWithFormat:@"%@ %@ %@ %@",self.orderModel.destinationProvinceName,self.orderModel.destinationCityName,self.orderModel.destinationCountyName,self.orderModel.destinationAddress];
    }
    result = [NSString stringWithFormat:@"%@ %@",result,string];
    return result;
}

- (void)setNeedModel:(CYTLogisticsNeedListModel *)needModel {
    _needModel = needModel;
    
    self.timeLabel.text = needModel.createTime;
    self.stateLabel.text = [self stateString];
    self.stateLabel.textColor = (self.needModel.status == CYTLogisticsNeedStatusUnOrder)?kFFColor_green:kFFColor_title_L2;
    
    NSString *title = [NSString stringWithFormat:@"%@ %@",needModel.bsName,needModel.csName];
    self.titleLab.text = title;
    
    NSString *total = [NSString stringWithFormat:@"车辆总价：%g万",needModel.totalValues];
    self.priceLab.text = total;
    
    NSString *yearString = needModel.carYearType;
    if (yearString && yearString.length != 0 && ![yearString isEqualToString:@"0"]) {
        yearString = [NSString stringWithFormat:@"%@款 ",yearString];
    }else {
        yearString = @"";
    }
    NSString *subTitle = [NSString stringWithFormat:@"%@%@",yearString,needModel.carName];
    self.subTitle.text = subTitle;
    
    self.sendLabel.text = [self sendAddress:YES];
    self.receiveLabel.text = [self receiveAddress:YES];
    
    ////需要重绘，否则第一次显示不正确
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

//获取物流订单状态颜色
- (UIColor *)getStateColor {
    switch (self.orderModel.orderStatus) {
        case CYTLogisticsOrderStatusWaitPay:
            return CYTRedColor;
        case CYTLogisticsOrderStatusFinish:
        case CYTLogisticsOrderStatusFinishUnComment:
        case CYTLogisticsOrderStatusFinishCommented:
            return kFFColor_title_L2;
        case CYTLogisticsOrderStatusCancel:
        case CYTLogisticsOrderStatusWaitPayCanceled:
        case CYTLogisticsOrderStatusWaitMatchingBoardCanceled:
        case CYTLogisticsOrderStatusWaitDriverCanceled:
            return UIColorFromRGB(0x9f9f9f);
        default:
            return kFFColor_green;
    }
}

- (void)setOrderModel:(CYTLogisticsOrderListModel *)orderModel {
    _orderModel = orderModel;
    
    self.timeLabel.text = orderModel.orderSubmitTime;
    self.stateLabel.text = orderModel.orderStatusDesc;
    self.stateLabel.textColor = [self getStateColor];
    
    NSString *title = [NSString stringWithFormat:@"%@ %@",orderModel.bsName,orderModel.csName];
    self.titleLab.text = title;
    
    NSString *total = [NSString stringWithFormat:@"车辆总价：%g万",orderModel.totalValues];
    self.priceLab.text = total;
    
    NSString *yearString = orderModel.carYearType;
    if (yearString && yearString.length != 0 && ![yearString isEqualToString:@"0"]) {
        yearString = [NSString stringWithFormat:@"%@款 ",yearString];
    }else {
        yearString = @"";
    }
    NSString *subTitle = [NSString stringWithFormat:@"%@%@",yearString,orderModel.carName];
    self.subTitle.text = subTitle;
    
    self.sendLabel.text = [self sendAddress:NO];
    self.receiveLabel.text = [self receiveAddress:NO];
    
    self.actionView.status = orderModel.orderStatus;
    
    ////需要重绘，否则第一次显示不正确
    [self setNeedsUpdateConstraints];
    [self layoutIfNeeded];
}

#pragma mark- get
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithFontPxSize:24 textColor:UIColorFromRGB(0x9f9f9f)];
    }
    return _timeLabel;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [UILabel labelWithFontPxSize:26 textColor:kFFColor_green];
    }
    return _stateLabel;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = kFFColor_line;
    }
    return _line;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel labelWithFontPxSize:30 textColor:kFFColor_title_L1];
    }
    return _titleLab;
}

- (UILabel *)priceLab {
    if (!_priceLab) {
        _priceLab = [UILabel labelWithFontPxSize:24 textColor:kFFColor_title_L2];
    }
    return _priceLab;
}

- (UILabel *)subTitle {
    if (!_subTitle) {
        _subTitle = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L2];
        _subTitle.numberOfLines = 0;
    }
    return _subTitle;
}

#pragma mark- address
- (UILabel *)sendLabel {
    if (!_sendLabel) {
        _sendLabel = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L2];
        _sendLabel.numberOfLines = 0;
    }
    return _sendLabel;
}

- (UILabel *)receiveLabel {
    if (!_receiveLabel) {
        _receiveLabel = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L2];
        _receiveLabel.numberOfLines = 0;
    }
    return _receiveLabel;
}

- (UIImageView *)topPointView {
    if (!_topPointView) {
        _topPointView = [UIImageView new];
        _topPointView.contentMode = UIViewContentModeScaleAspectFit;
        _topPointView.image = [UIImage imageNamed:@"logistics_need_topPoint"];
    }
    return _topPointView;
}

- (UIImageView *)vView {
    if (!_vView) {
        _vView = [UIImageView new];
        _vView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.7];
    }
    return _vView;
}

- (UIImageView *)botPointView {
    if (!_botPointView) {
        _botPointView = [UIImageView new];
        _botPointView.contentMode = UIViewContentModeScaleAspectFit;
        _botPointView.image = [UIImage imageNamed:@"logistics_need_botPoint"];
    }
    return _botPointView;
}

#pragma mark- actionView
- (CYTLogisticsNeedCell_ActionView *)actionView {
    if (!_actionView) {
        _actionView = [CYTLogisticsNeedCell_ActionView new];
        @weakify(self);
        [_actionView setClickedBlock:^(NSInteger index) {
            @strongify(self);
            if (self.clickedBlock) {
                self.clickedBlock(index);
            }
        }];
    }
    return _actionView;
}

@end
