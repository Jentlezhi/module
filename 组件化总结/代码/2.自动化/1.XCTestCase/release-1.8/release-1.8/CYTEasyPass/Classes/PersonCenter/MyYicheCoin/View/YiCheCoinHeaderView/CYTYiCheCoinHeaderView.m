//
//  CYTYiCheCoinHeaderView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTYiCheCoinHeaderView.h"
#import "CYTYiCheCoinInfoView.h"
#import "CYTYiCheCoinSignView.h"
#import "MyYicheCoinConfig.h"
#import "CYTCoinSignResultModel.h"

@interface CYTYiCheCoinHeaderView()

/** 易车币信息 */
@property(strong, nonatomic) CYTYiCheCoinInfoView *infoView;
/** 签到信息 */
@property(strong, nonatomic) CYTYiCheCoinSignView *signView;
/** 底部分割条 */
@property(strong, nonatomic) UIView *bottomBar;

@end

@implementation CYTYiCheCoinHeaderView

#pragma mark - 懒加载

- (CYTYiCheCoinInfoView *)infoView{
    if (!_infoView) {
        _infoView = CYTYiCheCoinInfoView.new;
        CYTWeakSelf
        _infoView.signBtnClick = ^{
            !weakSelf.signBtnClick?:weakSelf.signBtnClick();
        };
        _infoView.amountClick = ^{
            !weakSelf.profitLossDetails?:weakSelf.profitLossDetails();
        };
    }
    return _infoView;
}

- (CYTYiCheCoinSignView *)signView{
    if (!_signView) {
        _signView = CYTYiCheCoinSignView.new;
    }
    return _signView;
}

- (UIView *)bottomBar{
    if (!_bottomBar) {
        _bottomBar = UIView.new;
        _bottomBar.backgroundColor = CYTHexColor(@"#F6F6F6");
    }
    return _bottomBar;
}

- (void)initSubComponents{
    [self addSubview:self.infoView];
    [self addSubview:self.signView];
    [self addSubview:self.bottomBar];
}
- (void)makeSubConstrains{
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(CYTAutoLayoutV(kMyYicheCoinInfoHeight));
    }];
    
    [self.signView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(CYTAutoLayoutV(kMyYicheCoinSignHeight));
    }];
    
    [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.signView.mas_bottom);
        make.bottom.left.right.equalTo(self);
    }];
}

- (void)setSignResultModel:(CYTCoinSignResultModel *)signResultModel{
    _signResultModel = signResultModel;
    self.infoView.signResultModel = signResultModel;
    self.signView.signResultModel = signResultModel;
}
@end
