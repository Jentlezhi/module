//
//  CYTPriceAddInfoView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/18.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPriceAddInfoView.h"
#import "CYTConfirmOrderInfoModel.h"
#import "CYTLogisticDemandPriceModel.h"

@implementation CYTPriceAddInfoView
{
    //预计提车时间
    UILabel *_estimatePickupTimeTipLabel;
    //预计提车时间
    UILabel *_estimatePickupTimeLabel;
    //预计运输时间
    UILabel *_estimateTransportTimeTipLabel;
    //预计运输时间
    UILabel *_estimateTransportTimeLabel;
    //物流公司备注
    UILabel *_expCompanyMarkTipLabel;
    //物流公司备注
    UILabel *_expCompanyMarkLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self priceAddInfoBasicConfig];
        [self initPriceAddInfoComponents];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)priceAddInfoBasicConfig{
    self.backgroundColor = [UIColor clearColor];
}
/**
 *  初始化子控件
 */
- (void)initPriceAddInfoComponents{
    //预计提车时间
    UILabel *estimatePickupTimeTipLabel = [self leftItemLabelWithText:@"预计提车时间"];
    [self addSubview:estimatePickupTimeTipLabel];
    _estimatePickupTimeTipLabel = estimatePickupTimeTipLabel;
    
    UILabel *estimatePickupTimeLabel = [self rightItemLabel];
    [self addSubview:estimatePickupTimeLabel];
    _estimatePickupTimeLabel = estimatePickupTimeLabel;
    
    //预计运输时间
    UILabel *estimateTransportTimeTipLabel = [self leftItemLabelWithText:@"预计运输时间"];
    [self addSubview:estimateTransportTimeTipLabel];
    _estimateTransportTimeTipLabel = estimateTransportTimeTipLabel;
    
    UILabel *estimateTransportTimeLabel = [self rightItemLabel];
    [self addSubview:estimateTransportTimeLabel];
    _estimateTransportTimeLabel = estimateTransportTimeLabel;
    
    //物流公司备注
    UILabel *expCompanyMarkTipLabel = [self leftItemLabelWithText:@"物流公司备注"];
    [self addSubview:expCompanyMarkTipLabel];
    _expCompanyMarkTipLabel = expCompanyMarkTipLabel;
    
    UILabel *expCompanyMarkLabel = [self rightItemLabel];
    expCompanyMarkLabel.numberOfLines = 0;
    [self addSubview:expCompanyMarkLabel];
    _expCompanyMarkLabel = expCompanyMarkLabel;
    
//    //测试数据
//    _estimatePickupTimeLabel.text = @"付款后12小时内";
//    _estimateTransportTimeLabel.text = @"7天";
//    _expCompanyMarkLabel.text = @"腾讯娱乐讯近日,人气女演员张天爱一组最新夏日写真大片曝光。与以往的英气率性大相径庭,大片中张天爱首次挑战嫁衣,身着简洁清爽白蕾丝长裙,露出“";
//
//    NSAttributedString *aString = [NSAttributedString attributedWithLabel:_expCompanyMarkLabel lineSpacing:_expCompanyMarkLabel.font.pointSize*0.1];
//    _expCompanyMarkLabel.attributedText = aString;
//    //处理对齐方式
//    _expCompanyMarkLabel.textAlignment = [self textAlignmentWithLabel:_expCompanyMarkLabel];
}
/**
 *  布局子控件
 */
- (void)makeConstrainsWithModel:(CYTConfirmOrderInfoModel *)confirmOrderInfoModel{
    CGFloat estimatePickupTimeTipLabelH = _estimatePickupTimeTipLabel.font.pointSize+2;
    
    [_estimatePickupTimeTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(CYTAutoLayoutV(20.f));
        make.left.equalTo(self).offset(CYTMarginH);
        make.width.equalTo(estimatePickupTimeTipLabelH*6);
    }];
    
    [_estimatePickupTimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_estimatePickupTimeTipLabel.mas_right).offset(CYTMarginH);
        make.centerY.equalTo(_estimatePickupTimeTipLabel);
        make.right.equalTo(self).offset(-CYTMarginH);
    }];
    
    [_estimateTransportTimeTipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_estimatePickupTimeTipLabel.mas_bottom).offset(CYTAutoLayoutV(20.f));
        make.left.equalTo(_estimatePickupTimeTipLabel);
        make.width.equalTo(_estimatePickupTimeTipLabel);
    }];
    
    [_estimateTransportTimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_estimateTransportTimeTipLabel.mas_right).offset(CYTMarginH);
        make.centerY.height.equalTo(_estimateTransportTimeTipLabel);
        make.right.equalTo(self).offset(-CYTMarginH);
    }];
    
    [_expCompanyMarkTipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_estimateTransportTimeTipLabel.mas_bottom).offset(CYTAutoLayoutV(20.f));
        make.left.equalTo(_estimatePickupTimeTipLabel);
        make.size.equalTo(_estimatePickupTimeTipLabel);
    }];
    [_expCompanyMarkLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_expCompanyMarkTipLabel.mas_right).offset(CYTMarginH);
        make.top.equalTo(_expCompanyMarkTipLabel).offset(CYTAutoLayoutV(3.5f));
        make.right.equalTo(self).offset(-CYTMarginH);
        make.bottom.equalTo(self.mas_bottom).priorityHigh();
    }];
}
/**
 * 左标题
 */
- (UILabel *)leftItemLabelWithText:(NSString *)text{
    return [UILabel labelWithText:text textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:24.f setContentPriority:NO];
}

/**
 * 右标题
 */
- (UILabel *)rightItemLabel{
    return [UILabel labelWithText:nil textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentRight fontPixel:24.f setContentPriority:NO];
}

/**
 * 填写物流订单 传入模型数据
 */
- (void)setConfirmOrderInfoModel:(CYTConfirmOrderInfoModel *)confirmOrderInfoModel{
    if(!confirmOrderInfoModel) return;
    _confirmOrderInfoModel = confirmOrderInfoModel;
    //预计提车时间
    _estimatePickupTimeLabel.text = confirmOrderInfoModel.estimateStartTime;
    //预计运输时间
    _estimateTransportTimeLabel.text = confirmOrderInfoModel.estimateTransportPeriod;
//   confirmOrderInfoModel.remarks = @"无";
    //物流公司备注
    NSString *expCompanyMarkStr = [NSString string];
    if (!confirmOrderInfoModel.remarks.length) {
        expCompanyMarkStr = @"无";
    }else{
        expCompanyMarkStr = confirmOrderInfoModel.remarks;
    }
    _expCompanyMarkLabel.text = expCompanyMarkStr;
    //调整行间距
    NSAttributedString *aString = [NSAttributedString attributedWithLabel:_expCompanyMarkLabel lineSpacing:_expCompanyMarkLabel.font.pointSize*0.1];
    _expCompanyMarkLabel.attributedText = aString;
    //处理对齐方式
    _expCompanyMarkLabel.textAlignment = [self textAlignmentWithLabel:_expCompanyMarkLabel];
    //布局控件
    [self makeConstrainsWithModel:confirmOrderInfoModel];
}

/**
 * 对齐方式
 */
- (NSTextAlignment)textAlignmentWithLabel:(UILabel *)label{
    CGFloat expCompanyMarkLabelH = [label.text sizeWithFont:label.font maxSize:CGSizeMake(kScreenWidth - 3*CYTMarginH - (_expCompanyMarkTipLabel.font.pointSize+2)*6, CGFLOAT_MAX)].height;
    CYTLog(@"%f",label.font.pointSize)
    if (expCompanyMarkLabelH>=label.font.pointSize*2) {
        return NSTextAlignmentLeft;
    }else{
        return NSTextAlignmentRight;
    }
}

/**
 * 物流订单详情 传入数据
 */
- (void)setLogisticDemandPriceModel:(CYTLogisticDemandPriceModel *)logisticDemandPriceModel{
    if (!logisticDemandPriceModel) return;
    _logisticDemandPriceModel = logisticDemandPriceModel;
    //模型转换
    NSDictionary *dict = logisticDemandPriceModel.mj_keyValues;
    CYTConfirmOrderInfoModel *confirmOrderInfoModel = [CYTConfirmOrderInfoModel mj_objectWithKeyValues:dict];
    //调用setConfirmOrderInfoModel方法
    self.confirmOrderInfoModel = confirmOrderInfoModel;
}

@end
