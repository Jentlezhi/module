//
//  CYTGetCashCtr.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTGetCashCtr.h"
#import "CYTGetCashCountView.h"
#import "CYTGetCashAccessCountView.h"
#import "CYTGetCashBottomView.h"
#import "CYTGetCashNextCtr.h"
#import "CYTGetCashVM.h"

@interface CYTGetCashCtr ()
@property (nonatomic, strong) CYTGetCashAccessCountView *accessCountView;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) CYTGetCashCountView *countView;
@property (nonatomic, strong) UILabel *descriptLabel;
@property (nonatomic, strong) CYTGetCashBottomView *bottomView;

@property (nonatomic, strong) CYTGetCashVM *viewModel;
@property (nonatomic, assign) BOOL cannotAction;

@end

@implementation CYTGetCashCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithBackButtonAndTitle:@"提现"];
    self.viewModel = [CYTGetCashVM new];
    self.view.backgroundColor = kFFColor_bg_nor;
    [self loadUI];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    @weakify(self);
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        @strongify(self);
        [self.view endEditing:YES];
    }];
    [self.view addGestureRecognizer:tap];
    [self bindViewModel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.viewModel.accessCashCommand execute:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.countView.textFiled becomeFirstResponder];
}

- (void)loadUI {
    [self.view addSubview:self.accessCountView];
    [self.view addSubview:self.line];
    [self.view addSubview:self.countView];
    [self.view addSubview:self.descriptLabel];
    [self.view addSubview:self.bottomView];
    
    [self.accessCountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(CYTViewOriginY+10);
        make.height.equalTo(CYTAutoLayoutV(100));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTAutoLayoutH(30));
        make.right.equalTo(-CYTAutoLayoutH(30));
        make.height.equalTo(CYTLineH);
        make.bottom.equalTo(self.accessCountView);
    }];
    [self.countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.accessCountView.mas_bottom);
        make.height.equalTo(CYTAutoLayoutV(220));
    }];
    [self.descriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.equalTo(SCREEN_WIDTH/2.0);
        make.top.equalTo(self.countView.mas_bottom).offset(CYTAutoLayoutV(20));
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTAutoLayoutH(30));
        make.right.equalTo(-CYTAutoLayoutH(30));
        make.top.equalTo(self.countView.mas_bottom).offset(CYTAutoLayoutV(170));
        make.height.equalTo(CYTAutoLayoutV(90));
    }];
}

- (void)backButtonClick:(UIButton *)backButton {
    [self .navigationController popViewControllerAnimated:YES];
}

- (void)bindViewModel {
    @weakify(self);
    
    [self.viewModel.hudSubject subscribeNext:^(id x) {
        if ([x integerValue] == 0) {
            [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeNotEditable];
        }else{
            [CYTLoadingView hideLoadingView];
        }
    }];
    
    [self.viewModel.accessCashCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *model) {
        @strongify(self);
        
        if (model.resultEffective) {
            NSString *cash = [[model.dataDictionary objectForKey:@"availableBalance"] description];
            self.viewModel.accessCash = cash;
            NSString *cashDes = [NSString stringWithFormat:@"%@ 元",cash];
            self.accessCountView.contentLabel.text = cashDes;
        }else {
            //不可操作，
            self.cannotAction = YES;
            //内部提示
            [CYTToast errorToastWithMessage:model.resultMessage];
        }
    }];
}

#pragma mark-

- (NSString *)getBenefitCashWithTotal:(NSString *)total {
    float totalCash = [total floatValue];
    totalCash = totalCash*0.006;
    self.viewModel.benefitCash = [NSString stringWithFormat:@"%.4f",totalCash];
    return self.viewModel.benefitCash;
}

- (NSString *)getBenefitStringWithCash:(NSString *)cash {
    NSString *str = [NSString stringWithFormat:@"支付宝提现手续费为现金额的0.6%%\n本次平台为您全额垫付%@元",cash];
    return str;
}

#pragma mark- get
- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = kFFColor_line;
    }
    return _line;
}

- (CYTGetCashAccessCountView *)accessCountView {
    if (!_accessCountView) {
        _accessCountView = [CYTGetCashAccessCountView new];
    }
    return _accessCountView;
}

- (CYTGetCashCountView *)countView {
    if (!_countView) {
        _countView = [CYTGetCashCountView new];
        @weakify(self);
        [[_countView.textFiled rac_textSignal] subscribeNext:^(NSString *x) {
            @strongify(self);
            self.viewModel.totalCash = x;
//            NSString *benefitString = [self getBenefitStringWithCash:[self getBenefitCashWithTotal:x]];
//            self.descriptLabel.text = benefitString;
            BOOL valid = NO;
            if (x.length!=0) {
                valid = YES;
            }
            self.bottomView.actionEnable = valid;
        }];
    }
    return _countView;
}

- (UILabel *)descriptLabel {
    if (!_descriptLabel) {
        _descriptLabel = [UILabel new];
        _descriptLabel.font = CYTFontWithPixel(24);
        _descriptLabel.textColor = kFFColor_title_L3;
        _descriptLabel.numberOfLines = 0;
        _descriptLabel.text = @"支付宝提现手续费已由车销通平台为您全额垫付";
        _descriptLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _descriptLabel;
}

- (CYTGetCashBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [CYTGetCashBottomView new];
        [_bottomView.actionButton setTitle:@"提现至支付宝账户" forState:UIControlStateNormal];
        _bottomView.actionEnable = NO;
        @weakify(self);
        [_bottomView setClickedBlock:^{
            @strongify(self);
            if (self.cannotAction) {
                [CYTToast messageToastWithMessage:@"无法进行该操作"];
                return ;
            }
            if (self.viewModel.totalCash.floatValue > self.viewModel.accessCash.floatValue ) {
                [CYTToast warningToastWithMessage:@"金额不足"];
                return;
            }
            
            if (self.viewModel.totalCash == 0) {
                [CYTToast warningToastWithMessage:@"提取金额不能为0"];
                return;
            }
            
            CYTGetCashNextCtr *ctr = [CYTGetCashNextCtr new];
            ctr.viewModel = self.viewModel;
            [self.navigationController pushViewController:ctr animated:YES];
        }];
    }
    return _bottomView;
}

@end
