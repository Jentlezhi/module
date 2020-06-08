//
//  CYTPayFinishedViewController.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPayFinishedViewController.h"
#import "CYTLogisticsNeedWriteTableController.h"

@interface CYTPayFinishedViewController ()
@property (nonatomic, strong) UIImageView *succeedImageView;
@property (nonatomic, strong) UILabel *successLabel;
@property (nonatomic, strong) UILabel *assistanceLabel;
@property (nonatomic, strong) UIButton *actionButton;

@end

@implementation CYTPayFinishedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
    self.hiddenNavigationBarLine = YES;
}

///关闭手势返回功能---------------------->>>
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.interactivePopGestureEnable = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.interactivePopGestureEnable = YES;
}
///<<<------------------------------------

- (void)loadUI {
    [self createNavBarWithBackButtonAndTitle:@"订单支付成功"];
    [self.view addSubview:self.succeedImageView];
    [self.view addSubview:self.successLabel];
    [self.view addSubview:self.assistanceLabel];
    [self.view addSubview:self.actionButton];
    
    [self.succeedImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(CYTAutoLayoutV(120)+CYTViewOriginY);
    }];
    [self.successLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.succeedImageView.bottom).offset(CYTAutoLayoutV(86));
    }];
    [self.assistanceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.successLabel.bottom).offset(CYTAutoLayoutV(30));
    }];
    [self.actionButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.equalTo(CYTAutoLayoutH(630));
        make.top.equalTo(CYTAutoLayoutV(900));
        make.height.equalTo(CYTAutoLayoutV(80));
    }];
}

- (void)backButtonClick:(UIButton *)backButton {
    //处理返回事件，区分是余额支付成功，还是非余额支付
    [CYTPaymentManager handlePayResultWithController:self andPayManager:self.manager];
}

#pragma mark- get
- (UIImageView *)succeedImageView {
    if (!_succeedImageView) {
        _succeedImageView = [UIImageView new];
        _succeedImageView.contentMode = UIViewContentModeScaleAspectFit;
        _succeedImageView.image = [UIImage imageNamed:@"carSource_publish_success"];
    }
    return _succeedImageView;
}

- (UILabel *)successLabel {
    if (!_successLabel) {
        _successLabel = [UILabel labelWithFontPxSize:32 textColor:kFFColor_green];
        _successLabel.textAlignment = NSTextAlignmentCenter;
        _successLabel.text = @"- 卖家已为您留车 -";
    }
    return _successLabel;
}

- (UILabel *)assistanceLabel {
    if (!_assistanceLabel) {
        _assistanceLabel = [UILabel labelWithFontPxSize:30 textColor:UIColorFromRGB(0x656565)];
        _assistanceLabel.textAlignment = NSTextAlignmentCenter;
        _assistanceLabel.numberOfLines = 0;
        _assistanceLabel.text = @"您可到店验车并自提，或\n安排物流公司为您到店验车、提车。";
    }
    return _assistanceLabel;
}

- (UIButton *)actionButton {
    if (!_actionButton) {
        _actionButton = [UIButton buttonWithFontPxSize:32 textColor:[UIColor whiteColor] text:@"叫个物流"];
        [_actionButton radius:4 borderWidth:1 borderColor:[UIColor clearColor]];
        _actionButton.backgroundColor = kFFColor_green;
        @weakify(self);
        [[_actionButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            CYTLogisticsNeedWriteVM *vm = [CYTLogisticsNeedWriteVM new];
            vm.needGetLogisticInfo = YES;
            vm.orderId = self.manager.requestModel.orderId.integerValue;
            CYTLogisticsNeedWriteTableController *need = [[CYTLogisticsNeedWriteTableController alloc] initWithViewModel:vm];
            [self.navigationController pushViewController:need animated:YES];
        }];
    }
    return _actionButton;
}

@end
