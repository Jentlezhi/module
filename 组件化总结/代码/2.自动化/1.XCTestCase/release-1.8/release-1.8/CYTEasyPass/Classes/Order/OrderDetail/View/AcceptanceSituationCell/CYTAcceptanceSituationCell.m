//
//  CYTAcceptanceSituationCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAcceptanceSituationCell.h"
#import "CYTAcceptanceSituationView.h"
#import "CYTVoucherPictureView.h"
#import "CYTOrderModel.h"

@interface CYTAcceptanceSituationCell()

/** 验收 */
@property(strong, nonatomic) CYTAcceptanceSituationView *acceptanceSituationView;
/** 凭证图片 */
@property(strong, nonatomic) CYTVoucherPictureView *voucherPictureView;

@end

@implementation CYTAcceptanceSituationCell

- (void)initSubComponents{
    [self.contentView addSubview:self.acceptanceSituationView];
    [self.contentView addSubview:self.voucherPictureView];
}

- (void)makeSubConstrains{
    [self.acceptanceSituationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
    }];
    
    [self.voucherPictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.acceptanceSituationView.mas_bottom);
        make.bottom.equalTo(self.contentView);
    }];
}

- (CYTAcceptanceSituationView *)acceptanceSituationView{
    if (!_acceptanceSituationView) {
        _acceptanceSituationView = [[CYTAcceptanceSituationView alloc] init];
    }
    return _acceptanceSituationView;
}
- (CYTVoucherPictureView *)voucherPictureView{
    CYTWeakSelf
    if (!_voucherPictureView) {
        _voucherPictureView = [[CYTVoucherPictureView alloc] init];
        _voucherPictureView.voucherPictureViewClick = ^(NSInteger index) {
            !weakSelf.voucherPictureViewClick?:weakSelf.voucherPictureViewClick(index);
        };
    }
    return _voucherPictureView;
}
- (void)setOrderModel:(CYTOrderModel *)orderModel{
    _orderModel = orderModel;
    self.acceptanceSituationView.orderModel = orderModel;
    self.voucherPictureView.orderModel = orderModel;
    BOOL showPic = orderModel.customImageVouchers.count;
    self.voucherPictureView.hidden = !showPic;
    if (!showPic) {
        [self.acceptanceSituationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.contentView);
        }];
    }
}

@end
