//
//  CYTBalancePayTableController.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBalancePayTableController.h"
#import "CYTPayZeroCell.h"
#import "CYTPayFirstCell.h"
#import "CYTPaySecondCell.h"
#import "CYTPayCellModel.h"
#import "CYTGetCashPwdInputView.h"
#import "CYTAlipayTableController.h"
#import "CYTPayFinishedViewController.h"

@interface CYTBalancePayTableController ()
@property (nonatomic, strong) CYTGetCashPwdInputView *inputView;
@property (nonatomic, strong) UIButton *bottomButton;

@end

@implementation CYTBalancePayTableController
@synthesize showNavigationView = _showNavigationView;
@synthesize mainView = _mainView;
 

#pragma mark- flow control
- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self.ffContentView addSubview:self.mainView];
    [self.ffContentView addSubview:self.bottomButton];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    [self.bottomButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTAutoLayoutH(30));
        make.right.equalTo(CYTAutoLayoutH(-30));
        make.bottom.equalTo(-CYTMarginV);
        make.height.equalTo(CYTAutoLayoutV(80));
    }];
}

- (void)ff_bindViewModel {
    [super ff_bindViewModel];
    
    @weakify(self);
    [self.manager.hudSubject subscribeNext:^(id x) {
        if ([x integerValue] == 0) {
            [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeNotEditable];
        }else{
            [CYTLoadingView hideLoadingView];
        }
    }];
    
    [self.manager.requestBalanceInfoCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *model) {
        @strongify(self);
        //如果成功,判断是不是需要继续支付，如果不需要则支付完成，否则继续支付
        //如果失败则停留在当前页面
        if (!model.resultEffective) {
            //支付出错
            self.inputView.error = model.resultMessage;
            return ;
        }
        
        //支付完成
        CYTBalancePaymentModel *balanceModel = [CYTBalancePaymentModel mj_objectWithKeyValues:model.dataDictionary];
        if (!balanceModel) {
            [CYTToast messageToastWithMessage:CYTNetworkError];
            return;
        }
        
        BOOL finished = YES;
        if (balanceModel.needPayAmount > 0) {finished = NO;}
        if (finished) {
            //还需支付0，支付已完成
            if (self.manager.requestModel.sourceType == PaySourceTypeLogistics) {
                //物流支付成功，要提示
                [CYTToast successToastWithMessage:model.resultMessage];
            }
            //支付成功处理
            [self payFinished:YES];
        }else {
            //继续支付
            [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshOrderDetailKey object:nil];
            [self payContinueWithBalance:balanceModel];
        }
    }];
    
    [self.manager.payExistAlertCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *model) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString *alert = kPayExistAlertDefault;
            if (model.resultEffective) {
                alert = model.dataDictionary[@"msg"];
            }
            [self backAlertWithString:alert];
        });
    }];
}

- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
    _showNavigationView = YES;
}

#pragma mark- life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [CYTTools updateNavigationBarWithController:self showBackView:YES showLine:YES];
    self.ffTitle = @"支付";
}

///关闭手势返回功能,设置键盘---------------------->>>
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.interactivePopGestureEnable = NO;
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.interactivePopGestureEnable = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    extern NSString *CYTKeyboardSwitchNot;
    [[NSNotificationCenter defaultCenter] postNotificationName:CYTKeyboardSwitchNot object:@(NO)];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [[IQKeyboardManager sharedManager] setEnable:YES];
}
///<<<------------------------------------

#pragma mark- delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        CYTPayZeroCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTPayZeroCell identifier] forIndexPath:indexPath];
        cell.title = self.manager.unpayCashString;
        cell.subTitle = self.manager.accountBalanceCashString;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1) {
        CYTPayFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTPayFirstCell identifier] forIndexPath:indexPath];
        cell.flagLabel.text = @"选择支付方式";
        cell.contentLabel.text = @"";
        cell.flagLabel.textColor = kFFColor_title_L2;
        cell.backgroundColor = kFFColor_bg_nor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        CYTPaySecondCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTPaySecondCell identifier] forIndexPath:indexPath];
        cell.backgroundColor  = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        CYTPayCellModel *model = self.manager.listArray[1];//没有错
        model.subTitle = self.manager.useBalanceString;
        cell.model = model;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 2) {
        CYTPayCellModel *model = self.manager.listArray[1];//没有错
        model.selectState = !model.selectState;
        [self.mainView.tableView reloadData];
        self.bottomButton.enabled = model.selectState;
        self.bottomButton.backgroundColor = (model.selectState)?kFFColor_green:CYTBtnDisableColor;
    }
}


#pragma mark- method
- (void)ff_leftClicked:(FFNavigationItemView *)backView {
    //请求提示信息，
    [self.manager.payExistAlertCommand execute:nil];
}

///显示alert
- (void)handleAlertView {
    CYTGetCashPwdInputView *alertView = [CYTGetCashPwdInputView new];
    alertView.cashWillGet = [NSString stringWithFormat:@"%g",self.manager.balanceModel.balancePayAmount];
    alertView.alertView.titleLabel.text = @"请输入交易密码";
    alertView.alertView.desLabel.text = @"交易手续费平台已全额垫付";
    
    @weakify(self);
    [alertView setFinishedBlock:^(NSString *pwd) {
        @strongify(self);
        self.manager.pwdString = pwd;
        [self.manager.requestBalanceInfoCommand execute:nil];
    }];
    [alertView showInView:self.view];
    self.inputView = alertView;
}

- (void)backAlertWithString:(NSString *)message {
    NSString *title = @"确认返回吗？";
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"确定返回" otherButtonTitles:@"继续支付", nil];
    @weakify(self);
    [[alert rac_buttonClickedSignal] subscribeNext:^(id x) {
        @strongify(self);
        if ([x integerValue] == 0) {
            [self payFinished:NO];
        }
    }];
    [alert show];
}

#pragma mark- 支付流程控制
- (void)payFinished:(BOOL)succeed {
    //支付成功，进入成功页面，携带orderId
    if (!succeed) {
        //取消支付，返回对应页面
        self.manager.requestModel.payResultType = PayResultTypeBalanceCancel;
        [CYTPaymentManager handlePayResultWithController:self andPayManager:self.manager];
    }else {
        //支付成功
        if (self.manager.requestModel.sourceType == PaySourceTypeLogistics) {
            //物流不进入成功页面
            self.manager.requestModel.payResultType = PayResultTypeBalanceFinished;
            [CYTPaymentManager handlePayResultWithController:self andPayManager:self.manager];
        }else {
            CYTPayFinishedViewController *finished = [CYTPayFinishedViewController new];
            finished.manager = self.manager;
            [self.navigationController pushViewController:finished animated:YES];
        }
    }
}

- (void)payContinueWithBalance:(CYTBalancePaymentModel *) balanceModel{
    CYTAlipayTableController *payCtr = [CYTAlipayTableController new];
    CYTPaymentModel *requestModel = self.manager.requestModel;
    requestModel.unPayTotalCash = balanceModel.toPayAmount;
    requestModel.balancePaidCash = balanceModel.balancePaidAmount;
    requestModel.unPaidCash = balanceModel.needPayAmount;
    
    payCtr.manager.requestModel = requestModel;
    [self.navigationController pushViewController:payCtr animated:YES];
}

#pragma mark- get
- (FFMainView *)mainView {
    if (!_mainView) {
        _mainView = [FFMainView new];
        _mainView.delegate = self;
        [_mainView registerCellWithIdentifier:@[[CYTPayZeroCell identifier],
                                                [CYTPayFirstCell identifier],
                                                [CYTPaySecondCell identifier]]];
        _mainView.mjrefreshSupport = MJRefreshSupportNone;
        [CYTTools configForMainView:_mainView ];
    }
    return _mainView;
}

- (CYTPaymentManager *)manager {
    if (!_manager) {
        _manager = [CYTPaymentManager new];
    }
    return _manager;
}

- (UIButton *)bottomButton {
    if (!_bottomButton) {
        _bottomButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _bottomButton.titleLabel.font = CYTFontWithPixel(32);
        _bottomButton.backgroundColor = kFFColor_green;
        [_bottomButton setTitle:@"余额支付" forState:UIControlStateNormal];
        [_bottomButton radius:4 borderWidth:1 borderColor:[UIColor clearColor]];
        @weakify(self);
        [[_bottomButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            //进行余额支付
            [self handleAlertView];
        }];
    }
    return _bottomButton;
}

@end
