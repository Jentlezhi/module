//
//  CYTLogisticInfoCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticInfoCell.h"
#import "CYTLogisticInfoView.h"
#import "CYTConfirmOrderInfoModel.h"
#import "CYTLogisticDemandModel.h"
#import "CYTLogisticDemandPriceModel.h"
#import "CYTLogisticOrderModel.h"

@interface CYTLogisticInfoCell()
/** mark */
@property(weak, nonatomic) UILabel *custom;
@end

@implementation CYTLogisticInfoCell
{
    //分割条
    UIView *_topBar;
    //物流公司
    UILabel *_logicComNameLabel;
    //物流
    CYTLogisticInfoView *_logisticInfoView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier logisticOrderModel:(CYTLogisticOrderModel *)logisticOrderModel{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self logisticInfoBasicConfig];
        [self initLogisticInfoComponentsWithLogisticOrderModel:logisticOrderModel];
        [self makeConstrainsWithLogisticOrderModel:logisticOrderModel];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)logisticInfoBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor clearColor];
}
/**
 *  初始化子控件
 */
- (void)initLogisticInfoComponentsWithLogisticOrderModel:(CYTLogisticOrderModel *)logisticOrderModel{
    //是否显示提车司机
    BOOL showDriverPhone = NO;
    CYTLogisticsOrderStatus logisticsOrderStatus = labs(logisticOrderModel.orderStatus);
    if (logisticsOrderStatus >= CYTLogisticsOrderStatusWaitDriver) {
        showDriverPhone = YES;
    }else{
        showDriverPhone = NO;
    }
    //分割条
    UIView *topBar = [[UIView alloc] init];
    topBar.backgroundColor = kFFColor_bg_nor;
    [self.contentView addSubview:topBar];
    _topBar = topBar;
    
    //物流公司
    UILabel *logicComNameLabel = [UILabel labelWithText:@"" textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:34.f setContentPriority:NO];
    [self.contentView addSubview:logicComNameLabel];
    _logicComNameLabel = logicComNameLabel;
    
    //物流信息
    CYTLogisticInfoView *logisticInfoView = [[CYTLogisticInfoView alloc] initWithShowDriverPhone:showDriverPhone];
    [self.contentView addSubview:logisticInfoView];
    _logisticInfoView = logisticInfoView;
    
}
/**
 *  布局控件
 */
- (void)makeConstrainsWithLogisticOrderModel:(CYTLogisticOrderModel *)logisticOrderModel{
    [_topBar makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(CYTAutoLayoutV(20));
    }];
    
    [_logicComNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(CYTAutoLayoutV(30.f));
        make.right.equalTo(self.contentView).offset(-CYTAutoLayoutV(30.f));
        make.top.equalTo(_topBar.mas_bottom);
        make.height.equalTo(CYTAutoLayoutV(70.f));
    }];
    
    [_logisticInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_logicComNameLabel.mas_bottom);
        make.left.right.bottom.equalTo(self.contentView);
    }];

}

+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath logisticOrderModel:(CYTLogisticOrderModel *)logisticOrderModel{
    CYTLogisticInfoCell *cell = [[CYTLogisticInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil logisticOrderModel:logisticOrderModel];;
    return cell;
}
- (void)setConfirmOrderInfoModel:(CYTConfirmOrderInfoModel *)confirmOrderInfoModel{
    _confirmOrderInfoModel = confirmOrderInfoModel;
    _logicComNameLabel.text = confirmOrderInfoModel.exressCompany;
    _logisticInfoView.confirmOrderInfoModel = confirmOrderInfoModel;
    
}
/**
 * 物流订单详情 传入模型
 */
- (void)setLogisticDemandModel:(CYTLogisticDemandModel *)logisticDemandModel{
    if (!logisticDemandModel) return;
    _logisticDemandModel = logisticDemandModel;
    _logisticInfoView.logisticDemandModel = logisticDemandModel;
}
/**
 * 物流订单详情 传入模型
 */
- (void)setLogisticDemandPriceModel:(CYTLogisticDemandPriceModel *)logisticDemandPriceModel{
    if (!logisticDemandPriceModel) return;
    _logisticDemandPriceModel = logisticDemandPriceModel;
    _logicComNameLabel.text = logisticDemandPriceModel.exressCompany;
}

@end
