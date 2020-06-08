//
//  CYTAlipayTableController.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAlipayTableController.h"
#import "CYTPayZeroCell.h"
#import "CYTPayFirstCell.h"
#import "CYTPaySecondCell.h"
#import "CYTPayCellModel.h"
#import "CYTLogisticsOrderDetail3DController.h"
#import "CYTPayFinishedViewController.h"

@interface CYTAlipayTableController ()
@property (nonatomic, strong) UIButton *bottomButton;

@end

@implementation CYTAlipayTableController
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
        if ([x integerValue]==0) {
            [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
        }else{
            [CYTLoadingView hideLoadingView];
        }
    }];
    
    [self.manager.affirmCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *model) {
        [self backHandleWitMessage:model.resultMessage andState:(model.resultEffective)?1:0];
    }];
    
    [self.manager.requestAlipayInfoCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *model) {
        @strongify(self);
        self.manager.requestModel.signedString = [model.responseObject valueForKey:@"data"];
        if (model.resultEffective) {
            //成功获取订单信息，调用支付宝接口，跳转
            NSString *orderString = self.manager.requestModel.signedString;
            
            if (orderString != nil && orderString.length>0) {
                // NOTE: 调用支付结果开始支付
                //使用 kAppScheme ，不要修改
                [[AlipaySDK defaultService] payOrder:orderString fromScheme:kAppScheme callback:^(NSDictionary *resultDic) {
                    ////////post noti
                    ///h5支付回调，支付宝app回调在APPdelegate中，不会同时执行
                    [[NSNotificationCenter defaultCenter] postNotificationName:kPayResultNotiKey object:resultDic];
                }];
            }
        }else{
            [CYTToast errorToastWithMessage:model.resultMessage];
        }
    }];
    
    [self.manager.payExistAlertCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *model) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString *alert = kPayExistAlertDefault;
            if (model.resultEffective) {
                alert = [model.dataDictionary valueForKey:@"msg"];
            }
            alert = (alert)?alert:kPayExistAlertDefault;
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payResult:) name:kPayResultNotiKey object:nil];
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

#pragma mark- delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        CYTPayZeroCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTPayZeroCell identifier] forIndexPath:indexPath];
        cell.title = [NSString stringWithFormat:@"待支付金额：%g元",self.manager.requestModel.unPayTotalCash];
        if (self.manager.requestModel.balancePaidCash == 0) {
            cell.subTitle = @"";
        }else {
            NSString *balancePaid = [NSString stringWithFormat:@"已用余额支付：%g元",self.manager.requestModel.balancePaidCash];
            NSString *unpay = [NSString stringWithFormat:@"还需支付：%g元",self.manager.requestModel.unPaidCash];
            cell.subTitle = [NSString stringWithFormat:@"%@  %@",balancePaid,unpay];
        }
        
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
        CYTPayCellModel *model = self.manager.listArray[0];//没有错
        cell.model = model;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 2) {
        CYTPayCellModel *model = self.manager.listArray[0];//没有错
        model.selectState = !model.selectState;
        [self.mainView.tableView reloadData];
        self.bottomButton.enabled = model.selectState;
        self.bottomButton.backgroundColor = (model.selectState)?kFFColor_green:kFFColor_line;
    }
}

#pragma mark- method
- (void)ff_leftClicked:(FFNavigationItemView *)backView {
    //请求提示信息，
    [self.manager.payExistAlertCommand execute:nil];
}

- (void)backAlertWithString:(NSString *)message {
    NSString *title = @"确认返回吗？";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"确定返回" otherButtonTitles:@"继续支付", nil];
    @weakify(self);
    [[alert rac_buttonClickedSignal] subscribeNext:^(id x) {
        @strongify(self);
        if ([x integerValue] == 0) {
            
            if (self.manager.requestModel.haveBalanceView) {
                //从余额支付进入
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.manager.requestModel.payResultType = PayResultTypePayCancelWithBView;
                    [CYTPaymentManager handlePayResultWithController:self andPayManager:self.manager];
                });
            }else {
                //直接支付,取消
                self.manager.requestModel.payResultType = PayResultTypePayCancelWithNotBView;
                [CYTPaymentManager handlePayResultWithController:self andPayManager:self.manager];
            }
        }
    }];
    [alert show];
}

#pragma mark- 支付完的处理
- (void)backHandleWitMessage:(NSString *)message andState:(NSInteger)state{
    if (state == 0 || state == 1) {
        //0支付结果确认中//1支付成功
        if (state == 0) {
            [CYTToast successToastWithMessage:message];
        }
        
        BOOL success = (state == 1)?YES:NO;
        //稍作延时
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self payFinished:success];
        });
        
    }else if (state == -1){
        //支付失败
        [CYTToast errorToastWithMessage:message];
    }
}

- (void)payResult:(NSNotification *)noti {
    NSDictionary * infoDic = [noti object];
    
    NSString *message;
    BOOL valid;
    if([infoDic[@"resultStatus"] intValue] == 9000 ) {
        message = @"支付成功";
        valid  = YES;
    }else{
        message = @"支付失败";
        valid  = NO;
    }
    
    //如果支付失败则直接结束
    //否则停留3s，然后请求一次接口，
    
    if (!valid) {
        [self backHandleWitMessage:message andState:-1];
    }else{
        [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeNotEditable];
        @weakify(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self);
            [CYTLoadingView hideLoadingView];
            [self.manager.affirmCommand execute:nil];
        });
    }
}

- (void)payFinished:(BOOL)success {
    if (!success) {
        //支付结果确认中
        self.manager.requestModel.payResultType = PayResultTypePaying;
        [CYTPaymentManager handlePayResultWithController:self andPayManager:self.manager];
    }else {
        //支付成功
        if (self.manager.requestModel.sourceType == PaySourceTypeLogistics) {
            //物流不进入成功页面
            self.manager.requestModel.payResultType = PayResultTypePayFinished;
            [CYTPaymentManager handlePayResultWithController:self andPayManager:self.manager];
        }else {
            CYTPayFinishedViewController *finished = [CYTPayFinishedViewController new];
            finished.manager = self.manager;
            [self.navigationController pushViewController:finished animated:YES];
        }
    }
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
        [_bottomButton setTitle:@"去支付" forState:UIControlStateNormal];
        [_bottomButton radius:4 borderWidth:1 borderColor:[UIColor clearColor]];
        @weakify(self);
        [[_bottomButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self.manager.requestAlipayInfoCommand execute:nil];
        }];
    }
    return _bottomButton;
}
@end
