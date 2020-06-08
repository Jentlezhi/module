//
//  CYTPriceInfoCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/18.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPriceInfoCell.h"
#import "CYTPriceInfoView.h"
#import "CYTPriceAddInfoView.h"
#import "CYTConfirmOrderInfoModel.h"
#import "CYTCouponView.h"

@implementation CYTPriceInfoCell

{
    //分割条
    UIView *_topBar;
    //分割条
    CYTCouponView *_couponView;
    //价格详情
    CYTPriceInfoView *_priceInfoView;
    //报价详情
    UILabel *_priceDetailTipLabel;
    //报价详情
    UILabel *_totalPriceLabel;
    //分割线
    UILabel *_lineLabel;
    //附加信息
    CYTPriceAddInfoView *_priceAddInfoView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self priceInfoBasicConfig];
        [self initPriceInfoComponents];
        [self makeConstrains];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)priceInfoBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor clearColor];
}
/**
 *  初始化子控件
 */
- (void)initPriceInfoComponents{
    //分割条
    UIView *topBar = [[UIView alloc] init];
    topBar.backgroundColor = kFFColor_bg_nor;
    [self.contentView addSubview:topBar];
    _topBar = topBar;
    //报价详情
    UILabel *priceDetailTipLabel = [UILabel labelWithText:@"报价详情" textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:NO];
    [self.contentView addSubview:priceDetailTipLabel];
    _priceDetailTipLabel = priceDetailTipLabel;
    
    UILabel *totalPriceLabel = [UILabel labelWithText:@"报价详情" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentRight fontPixel:26.f setContentPriority:NO];
    [self.contentView addSubview:totalPriceLabel];
    _totalPriceLabel = totalPriceLabel;

    //分割线
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self.contentView addSubview:lineLabel];
    _lineLabel = lineLabel;

    //费用相关
    CYTPriceInfoView *priceInfoView = [[CYTPriceInfoView alloc] init];
    [self.contentView addSubview:priceInfoView];
    _priceInfoView = priceInfoView;

    CYTWeakSelf
    //可用券
    CYTCouponView *couponView = [[CYTCouponView alloc] init];
    [self.contentView addSubview:couponView];
    couponView.availableCouponClick = ^{
        !weakSelf.availableCouponClick?:weakSelf.availableCouponClick();
    };
    _couponView = couponView;
    
    //附加信息
    CYTPriceAddInfoView *priceAddInfoView = [[CYTPriceAddInfoView alloc] init];
    [self.contentView addSubview:priceAddInfoView];
    _priceAddInfoView = priceAddInfoView;
}
/**
 * 左标题
 */
- (UILabel *)leftItemLabelWithText:(NSString *)text{
    return [UILabel labelWithText:text textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:24.f setContentPriority:NO];
}

/**
 * 右标题
 */
- (UILabel *)rightItemLabel{
    return [UILabel labelWithText:nil textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentRight fontPixel:24.f setContentPriority:NO];
}

/**
 *  布局控件
 */
- (void)makeConstrains{
    [_topBar makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(CYTAutoLayoutV(20));
    }];
    
    CGFloat priceDetailTipLabelH = _priceDetailTipLabel.font.pointSize+2;
    
    [_priceDetailTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(CYTMarginH);
        make.width.equalTo(priceDetailTipLabelH*4);
        make.top.equalTo(_topBar.mas_bottom).offset(CYTAutoLayoutV(20.f));
    }];
    
    [_totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_priceDetailTipLabel.mas_right).offset(CYTMarginH);
        make.right.equalTo(self.contentView).offset(-CYTMarginH);
        make.centerY.equalTo(_priceDetailTipLabel);
        make.height.equalTo(_totalPriceLabel.font.pointSize+2);
    }];
    
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(CYTMarginH);
        make.right.equalTo(self.contentView).offset(-CYTMarginH);
        make.top.equalTo(_priceDetailTipLabel.mas_bottom).offset(CYTAutoLayoutV(20.f));
        make.height.equalTo(CYTDividerLineWH);
    }];

    [_priceInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineLabel.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(CYTAutoLayoutV(220.f));
    }];

    [_couponView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceInfoView.mas_bottom);
        make.left.right.equalTo(_priceInfoView);
        make.height.equalTo(CYTAutoLayoutV(90.f)+2*CYTItemMarginV);
    }];
    
    [_priceAddInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_couponView.mas_bottom);
        make.left.right.equalTo(_priceInfoView);
        make.bottom.equalTo(self.contentView).offset(-CYTMarginH);
    }];
    
}
+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTPriceInfoCell";
    CYTPriceInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTPriceInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
/**
 * 提交物流订单页面 传入数据模型
 */
- (void)setConfirmOrderInfoModel:(CYTConfirmOrderInfoModel *)confirmOrderInfoModel{
    if (!confirmOrderInfoModel) return;
    _confirmOrderInfoModel = confirmOrderInfoModel;
    [self setValueWithConfirmOrderInfoModel:confirmOrderInfoModel];
}

- (void)setValueWithConfirmOrderInfoModel:(CYTConfirmOrderInfoModel *)confirmOrderInfoModel{
    //费用总价
    NSString *totalPriceStr = [NSString stringWithFormat:@"%@%@ %@",@"费用合计：",confirmOrderInfoModel.totalPrice,@"元"];
    _totalPriceLabel.attributedText = [NSMutableAttributedString attributedStringWithContent:totalPriceStr keyWord:confirmOrderInfoModel.totalPrice keyFontPixel:24.f keyWordColor:CYTHexColor(@"#f43244")];
    
    //价格
    _priceInfoView.confirmOrderInfoModel = confirmOrderInfoModel;
    //卡券
    _couponView.confirmOrderInfoModel = confirmOrderInfoModel;
    //附加信息
    _priceAddInfoView.confirmOrderInfoModel = confirmOrderInfoModel;
}

@end
