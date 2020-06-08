//
//  CYTOrderStatusCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticOrderProgressCell.h"
#import "CYTCommonOrderProgress.h"
#import "CYTLogisticOrderModel.h"

@implementation CYTLogisticOrderProgressCell
{
    //占位图
    UIView *_bgView;
    //订单进度
    CYTCommonOrderProgress *_orderProgress;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self orderProgressConfig];
        [self initOrderProgressComponents];
        [self makeConstrains];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)orderProgressConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
/**
 *  初始化子控件
 */
- (void)initOrderProgressComponents{
    //占位图
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:bgView];
    _bgView = bgView;
}
/**
 *  布局控件
 */
- (void)makeConstrains{
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(CYTMarginH);
        make.bottom.equalTo(-CYTMarginH);
        make.height.equalTo(CYTAutoLayoutV((28+10)*2 + 32.f));
    }];
}
/**
 *  初始化子控件
 */
- (void)initOrderProgressComponentsWithModel:(CYTLogisticOrderModel *)logisticOrderModel{
    NSInteger orginOrderStatus = logisticOrderModel.orderStatus;
    CYTOrderStatusStyle orderStatusStyle = orginOrderStatus>0 ? CYTOrderStatusStyleNormal:CYTOrderStatusStyleCancel;
    NSInteger progressStatus = 0;
    switch (orginOrderStatus) {
        case CYTLogisticsOrderStatusWaitPay:
        case CYTLogisticsOrderStatusWaitPayCanceled:
            progressStatus = 1;
            break;
        case CYTLogisticsOrderStatusWaitMatchingBoard:
        case CYTLogisticsOrderStatusWaitMatchingBoardCanceled:
            progressStatus = 2;
            break;
        case CYTLogisticsOrderStatusWaitDriver:
        case CYTLogisticsOrderStatusWaitDriverCanceled:
            progressStatus = 3;
            break;
        case CYTLogisticsOrderStatusInTransit:
            progressStatus = 4;
            break;
        case CYTLogisticsOrderStatusFinish:
        case CYTLogisticsOrderStatusFinishUnComment:
        case CYTLogisticsOrderStatusFinishCommented:
            progressStatus = 5;
            break;
        default:
            break;
    }
    //订单进度
    CYTCommonOrderProgress *orderProgress = [CYTCommonOrderProgress logisticOrderProgressWithStatus:progressStatus orderStatusStyle:orderStatusStyle];
    [_bgView addSubview:orderProgress];
    _orderProgress = orderProgress;
    
    [_orderProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    
}

+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTOrderProgressCell";
    CYTLogisticOrderProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTLogisticOrderProgressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setLogisticOrderModel:(CYTLogisticOrderModel *)logisticOrderModel{
    if (!logisticOrderModel) return;
    [self initOrderProgressComponentsWithModel:logisticOrderModel];
}

@end
