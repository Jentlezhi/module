//
//  CYTExpenseDetailAlertView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/22.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExpenseDetailAlertView.h"
#import "CYTPriceInfoView.h"
#import "CYTLogisticDemandPriceModel.h"
#import "CYTConfirmOrderInfoModel.h"

#define kExpenseDetailViewH CYTAutoLayoutV(80.f+20.f*5+28.f*4)

@interface CYTExpenseDetailAlertView()

/** 费用合计 */
@property(weak, nonatomic) UILabel *expenseTotalLabel;

/** 费用详情 */
@property(weak, nonatomic) CYTPriceInfoView *priceInfoView;

@end

@implementation CYTExpenseDetailAlertView
{
    //费用合计
    UILabel *_expenseTotalTipLabel;
    //分割线
    UILabel *_lineLabel;
    //优惠券
    UILabel *_couponPriceLabel;
    //优惠券金额
    UILabel *_couponPriceValueLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self expenseDetailAlertViewBasicConfig];
        [self initExpenseDetailAlertViewComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)expenseDetailAlertViewBasicConfig{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
    
    //添加手势移除
    CYTWeakSelf
    [self addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
        [UIView animateWithDuration:kAnimationDurationInterval animations:^{
            weakSelf.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
        weakSelf.expenseDetailView.frame = CGRectMake(0, kScreenHeight+kExpenseDetailViewH, kScreenWidth,kExpenseDetailViewH);
        } completion:^(BOOL finished) {
            [weakSelf removeFromSuperview];
        }];
    }];
}
/**
 *  初始化子控件
 */
- (void)initExpenseDetailAlertViewComponents{
    //费用合计
    UIView *expenseDetailView = [[UIView alloc] init];
    expenseDetailView.backgroundColor = [UIColor whiteColor];
    [self addSubview:expenseDetailView];
    expenseDetailView.frame = CGRectMake(0, 0, kScreenWidth,kExpenseDetailViewH);
    _expenseDetailView = expenseDetailView;
    
    //费用合计
    UILabel *expenseTotalTipLabel = [UILabel labelWithText:@"费用合计：" textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    [expenseDetailView addSubview:expenseTotalTipLabel];
    _expenseTotalTipLabel = expenseTotalTipLabel;
    
    UILabel *expenseTotalLabel = [UILabel labelWithText:@"" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentRight fontPixel:26.f setContentPriority:NO];
    [expenseDetailView addSubview:expenseTotalLabel];
    _expenseTotalLabel = expenseTotalLabel;
    
    //分割线
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [expenseDetailView addSubview:lineLabel];
    _lineLabel = lineLabel;

    //费用详情
    CYTPriceInfoView *priceInfoView = [[CYTPriceInfoView alloc] init];
    [expenseDetailView addSubview:priceInfoView];
    _priceInfoView = priceInfoView;
    
    //优惠券
    UILabel *couponPriceLabel = [UILabel labelWithText:@"优惠金额" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:24.f setContentPriority:YES];
    [self addSubview:couponPriceLabel];
    _couponPriceLabel = couponPriceLabel;
    
    //优惠券金额
    UILabel *couponPriceValueLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentRight fontPixel:24.f setContentPriority:NO];
    [self addSubview:couponPriceValueLabel];
    _couponPriceValueLabel = couponPriceValueLabel;
    
    
    //测试数据
//    _expenseTotalLabel.text = @"134万元";
    
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    CGFloat expenseTotalLabelH = _expenseTotalLabel.font.pointSize+2;
    CGFloat expenseTotalLabelMargin = (CYTAutoLayoutV(80.f)-expenseTotalLabelH)*0.5f;
    [_expenseTotalTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_expenseDetailView).offset(expenseTotalLabelMargin);
        make.left.equalTo(_expenseDetailView).offset(CYTMarginH);
        make.size.equalTo(CGSizeMake(expenseTotalLabelH*5, expenseTotalLabelH));
    }];
    
    [_expenseTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_expenseTotalTipLabel);
        make.left.equalTo(_expenseTotalTipLabel.mas_right).offset(CYTMarginH);
        make.right.equalTo(_expenseDetailView).offset(-CYTMarginH);
    }];

    
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTMarginH);
        make.right.equalTo(self).offset(-CYTMarginH);
        make.top.equalTo(_expenseTotalLabel.mas_bottom).offset(expenseTotalLabelMargin);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    [_priceInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineLabel.mas_bottom);
        make.left.right.equalTo(_expenseDetailView);
        make.bottom.equalTo(_expenseDetailView);
    }];
}

+ (void)expenseDetailAlertViewWithModel:(CYTLogisticDemandPriceModel *)logisticDemandPriceModel{
    CYTExpenseDetailAlertView *expenseDetailAlertView = [[CYTExpenseDetailAlertView alloc] init];
    expenseDetailAlertView.frame = [UIScreen mainScreen].bounds;
    [kWindow addSubview:expenseDetailAlertView];
    [UIView animateWithDuration:kAnimationDurationInterval animations:^{
        expenseDetailAlertView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
        expenseDetailAlertView.expenseDetailView.frame = CGRectMake(0, kScreenHeight-kExpenseDetailViewH, kScreenWidth, kExpenseDetailViewH);
    }];
    
    //控件赋值
    
    //费用总价
    NSString *totalExpensesStr = [NSString stringWithFormat:@"%@ %@",logisticDemandPriceModel.totalPrice,@"元"];
    expenseDetailAlertView.expenseTotalLabel.attributedText = [NSMutableAttributedString attributedStringWithContent:totalExpensesStr keyWord:logisticDemandPriceModel.totalPrice keyFontPixel:28.f keyWordColor:CYTHexColor(@"#f43244")];
    //费用详情
    //模型转化
    NSDictionary *dict = [logisticDemandPriceModel mj_keyValues];
    expenseDetailAlertView.priceInfoView.confirmOrderInfoModel = [CYTConfirmOrderInfoModel mj_objectWithKeyValues:dict];
}

/**
 * 物流订单详情模型 传入
 */
- (void)setLogisticDemandPriceModel:(CYTLogisticDemandPriceModel *)logisticDemandPriceModel{
    _logisticDemandPriceModel = logisticDemandPriceModel;
    [self setValueWithLogisticDemandPriceModel:logisticDemandPriceModel];
    [self makeConstrainsWithLogisticDemandPriceModel:logisticDemandPriceModel];
}

- (void)setValueWithLogisticDemandPriceModel:(CYTLogisticDemandPriceModel *)logisticDemandPriceModel{
    //费用总价
    NSString *totalExpensesStr = [NSString stringWithFormat:@"%@ %@",logisticDemandPriceModel.totalPrice,@"元"];
    _expenseTotalLabel.attributedText = [NSMutableAttributedString attributedStringWithContent:totalExpensesStr keyWord:logisticDemandPriceModel.totalPrice keyFontPixel:28.f keyWordColor:CYTHexColor(@"#f43244")];
    //费用详情
    //模型转化
    NSDictionary *dict = [logisticDemandPriceModel mj_keyValues];
    _priceInfoView.confirmOrderInfoModel = [CYTConfirmOrderInfoModel mj_objectWithKeyValues:dict];
    
    //优惠券
    NSString *couponPrice = ![logisticDemandPriceModel.couponPrice isEqualToString:@"0"] ? logisticDemandPriceModel.couponPrice:@"";
    _couponPriceValueLabel.text = couponPrice;
}

- (void)makeConstrainsWithLogisticDemandPriceModel:(CYTLogisticDemandPriceModel *)logisticDemandPriceModel{
    if (logisticDemandPriceModel.couponPrice.length) {
        _couponPriceLabel.hidden = _couponPriceValueLabel.hidden = NO;
        [_couponPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_priceInfoView.mas_bottom);
            make.left.equalTo(CYTMarginH);
        }];
        
        [_couponPriceValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_couponPriceLabel.mas_right).offset(CYTItemMarginH);
            make.centerY.equalTo(_couponPriceLabel);
            make.right.equalTo(-CYTMarginH);
        }];
    }else{
        _couponPriceLabel.hidden = _couponPriceValueLabel.hidden = YES;
    }
}

@end
