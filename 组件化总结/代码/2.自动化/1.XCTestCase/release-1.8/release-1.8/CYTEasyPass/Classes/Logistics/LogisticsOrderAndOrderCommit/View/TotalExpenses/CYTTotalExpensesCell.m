//
//  CYTTotalExpensesCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTTotalExpensesCell.h"
#import "CYTPriceAddInfoView.h"
#import "CYTLogisticDemandPriceModel.h"

@implementation CYTTotalExpensesCell
{
    //分割条
    UIView *_topBar;
    //费用合计
    UIView *_totalExpensesView;
    UILabel *_totalExpensesLabel;
    //费用明细
    UIView *_expensesDetailView;
    //箭头
    UIImageView *_rightArrow;
    //费用明细 提示文字
    UILabel *_expensesDetailTipLabel;
    //分割线
    UILabel *_lineLabel;
    //附加信息
    CYTPriceAddInfoView *_priceAddInfoView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self totalExpensesCellBasicConfig];
        [self initTotalExpensesCellComponents];
        [self makeConstrains];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)totalExpensesCellBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
/**
 *  初始化子控件
 */
- (void)initTotalExpensesCellComponents{
    //分割条
    UIView *topBar = [[UIView alloc] init];
    topBar.backgroundColor = kFFColor_bg_nor;
    [self.contentView addSubview:topBar];
    _topBar = topBar;
    
    
    //费用合计
    UIView *totalExpensesView = [[UIView alloc] init];
    [totalExpensesView addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
        !self.expensesDetailBlock?:self.expensesDetailBlock();
    }];
    [self.contentView addSubview:totalExpensesView];
    _totalExpensesView = totalExpensesView;
    
    //费用明细
    UIView *expensesDetailView = [[UIView alloc] init];
    expensesDetailView.backgroundColor = [UIColor clearColor];
    [totalExpensesView addSubview:expensesDetailView];
    _expensesDetailView = expensesDetailView;
    //箭头
    UIImageView *rightArrow = [[UIImageView alloc] init];
    rightArrow.image = [UIImage imageNamed:@"arrow_right"];
    [expensesDetailView addSubview:rightArrow];
    _rightArrow = rightArrow;
    
    //费用明细 提示文字
    UILabel *expensesDetailTipLabel = [UILabel labelWithText:@"费用明细" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentRight fontPixel:26.f setContentPriority:NO];
    [totalExpensesView addSubview:expensesDetailTipLabel];
    _expensesDetailTipLabel = expensesDetailTipLabel;
    
    //费用合计label
    UILabel *totalExpensesLabel = [UILabel labelWithText:nil textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    [totalExpensesView addSubview:totalExpensesLabel];
    _totalExpensesLabel = totalExpensesLabel;
    
    //分割线
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self.contentView addSubview:lineLabel];
    _lineLabel = lineLabel;
    
    //附加信息
    CYTPriceAddInfoView *priceAddInfoView = [[CYTPriceAddInfoView alloc] init];
    [self.contentView addSubview:priceAddInfoView];
    _priceAddInfoView = priceAddInfoView;
    
    //测试数据
//    _totalExpensesLabel.text = @"费用合计：1200元";
    
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
    [_totalExpensesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topBar.mas_bottom);
        make.left.right.equalTo(_topBar);
        make.height.equalTo(CYTAutoLayoutV(80.f));
    }];

    CGFloat totalExpensesLabelH = _expensesDetailTipLabel.font.pointSize+2;
    
    [_expensesDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_totalExpensesView);
        make.right.equalTo(_totalExpensesView).offset(-CYTAutoLayoutV(20) );
        make.width.equalTo(CYTAutoLayoutV(44.f)+totalExpensesLabelH*5);
    }];
    
    [_rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_expensesDetailView);
        make.right.equalTo(_expensesDetailView);
        make.width.height.equalTo(CYTAutoLayoutV(44.f));
    }];
    
    CGFloat expensesDetailTipLabelH = _expensesDetailTipLabel.font.pointSize+2;
    [_expensesDetailTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_rightArrow.mas_left);
        make.centerY.equalTo(_expensesDetailView);
        make.size.equalTo(CGSizeMake(expensesDetailTipLabelH*4, expensesDetailTipLabelH));
    }];
    
    [_totalExpensesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.centerY.equalTo(_totalExpensesView);
        make.right.equalTo(_expensesDetailTipLabel.mas_left);
        make.height.equalTo(_totalExpensesLabel.font.pointSize+2);
    }];
    
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.top.equalTo(_totalExpensesView.mas_bottom);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    [_priceAddInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(_lineLabel.mas_bottom);
        make.bottom.equalTo(-CYTAutoLayoutV(20.f));
        
    }];
}
+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTTotalExpensesCell";
    CYTTotalExpensesCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTTotalExpensesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
/**
 * 物流订单详情 传入数据
 */
- (void)setLogisticDemandPriceModel:(CYTLogisticDemandPriceModel *)logisticDemandPriceModel{
    if (!logisticDemandPriceModel) return;
    _logisticDemandPriceModel = logisticDemandPriceModel;
    //费用合计 费用合计：1200元
    NSString *totalExpensesStr = [NSString stringWithFormat:@"%@%@ %@",@"费用合计：",logisticDemandPriceModel.totalPrice,@"元"];
    _totalExpensesLabel.attributedText = [NSMutableAttributedString attributedStringWithContent:totalExpensesStr keyWord:logisticDemandPriceModel.totalPrice keyFontPixel:28.f keyWordColor:CYTHexColor(@"#f43244")];
    _priceAddInfoView.logisticDemandPriceModel = logisticDemandPriceModel;
}

@end
