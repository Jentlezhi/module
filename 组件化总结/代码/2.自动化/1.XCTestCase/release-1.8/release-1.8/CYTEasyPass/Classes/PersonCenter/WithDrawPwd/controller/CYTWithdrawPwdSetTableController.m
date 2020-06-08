//
//  CYTWithdrawPwdSetTableController.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTWithdrawPwdSetTableController.h"
#import "CYTGetCashPwdSettingFirstCell.h"
#import "CYTGetCashPwdSettingSecondCell.h"
#import "AESCrypt.h"
#import "CYTGetCashSetPwdSucceedCtr.h"

@interface CYTWithdrawPwdSetTableController ()
@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *identifyButton;
@property (nonatomic, strong) UITextField *pwdTextField;

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSString *dealerName;
@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSTimer *theTimer;
@property (nonatomic, assign) NSInteger timeIndex;

@property (nonatomic, copy) NSString *pwdString;
@property (nonatomic, copy) NSString *identifyString;

@end

@implementation CYTWithdrawPwdSetTableController
@synthesize showNavigationView = _showNavigationView;
@synthesize mainView = _mainView;
 

#pragma mark- flow control
- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self.ffContentView addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
}

- (void)ff_bindViewModel {
    [super ff_bindViewModel];
    
    @weakify(self);
    [self.viewModel.hudSubject subscribeNext:^(id x) {
        if ([x integerValue] == 0) {
            [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeNotEditable];
        }else {
            [CYTLoadingView hideLoadingView];
        }
    }];
    
    [self.viewModel.fetchVerifyCode.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
        @strongify(self);
        
        [CYTToast messageToastWithMessage:responseModel.resultMessage];
        //如果验证码获取成功则开始倒计时
        if (responseModel.resultEffective) {
            //开启定时器
            [self beginTimer];
        }
    }];
    
    [self.viewModel.confirmVerifyCode.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
        @strongify(self);
        
        [CYTToast messageToastWithMessage:responseModel.resultMessage];
        //如果验证码获取成功则开始倒计时
        if (responseModel.resultEffective) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kMeRefreshKey object:nil];
            CYTGetCashSetPwdSucceedCtr *ctr = [CYTGetCashSetPwdSucceedCtr new];
            [self.navigationController pushViewController:ctr animated:YES];
        }
    }];
}

- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
    _showNavigationView = YES;
    self.viewModel = viewModel;
}

#pragma mark- life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kFFColor_bg_nor;
    [CYTTools updateNavigationBarWithController:self showBackView:YES showLine:YES];
    
    CYTUserInfoModel *model = [CYTAccountManager sharedAccountManager].userAuthenticateInfoModel;
    //获取是否设置过提款密码
    self.ffTitle = (model.isBeenSetTradePwd)?@"重置交易密码":@"设置交易密码";
    //获取数据
    [self loadData];
    
    UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
    __weak typeof(self)bself = self;
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        [bself.view endEditing:YES];
    }];
    [self.view addGestureRecognizer:tap];
    extern NSString *CYTKeyboardSwitchNot;
    [[NSNotificationCenter defaultCenter] postNotificationName:CYTKeyboardSwitchNot object:@(YES)];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.pwdTextField) {
        [self.pwdTextField becomeFirstResponder];
    }
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CYTAutoLayoutV(20);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==0) {
        CYTGetCashPwdSettingFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTGetCashPwdSettingFirstCell identifier] forIndexPath:indexPath];
        cell.contentLabel.text = self.phone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        CYTGetCashPwdSettingSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTGetCashPwdSettingSecondCell identifier] forIndexPath:indexPath];
        
        if (indexPath.row == 1) {
            //填写密码
            cell.identifyButton.hidden = YES;
            cell.flagImageView.image = [UIImage imageNamed:@"me_pwd_set"];
            cell.textFiled.placeholder = @"填写提款密码";
            if (!self.pwdTextField ) {
                self.pwdTextField = cell.textFiled;
                __weak typeof(self)bself = self;
                [[self.pwdTextField rac_textSignal] subscribeNext:^(NSString *x) {
                    if (x.length>6) {
                        x = [x substringToIndex:6];
                        bself.pwdTextField.text = x;
                    }else{
                        [bself updateBottomView];
                        bself.pwdString = x;
                    }
                }];
            }
            
        }else {
            cell.identifyButton.hidden = NO;
            cell.flagImageView.image = [UIImage imageNamed:@"me_pwd_identify"];
            cell.textFiled.placeholder = @"填写验证码";
            cell.textFiled.text = self.identifyString;
            
            //填写验证码
            if (!self.textField) {
                self.textField = cell.textFiled;
                __weak typeof(self)bself = self;
                [[self.textField rac_textSignal] subscribeNext:^(id x) {
                    bself.identifyString = x;
                    [bself updateBottomView];
                }];
            }
            
            if (!self.identifyButton) {
                self.identifyButton = cell.identifyButton;
                @weakify(self);
                [[self.identifyButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                    @strongify(self);
                    self.viewModel.phone = self.phone;
                    [self.viewModel.fetchVerifyCode execute:nil];
                }];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)updateBottomView {
    BOOL valid = NO;
    if (self.textField.text.length!=0 &&self.pwdTextField.text.length!=0) {
        valid = YES;
    }
    self.submitButton.enabled = valid;
    [self.submitButton setBackgroundColor:(valid?kFFColor_green:kFFColor_line)];
}

#pragma mark- method
- (void)ff_leftClicked:(FFNavigationItemView *)backView {
    [super ff_leftClicked:backView];
}

- (void)loadData {
    self.titleArray = @[@"经销商名称:",@"手机号码:"];
    self.phone = [CYTAccountManager sharedAccountManager].userAuthenticateInfoModel.phone;
    __weak typeof(self)bself = self;
    [[CYTAuthManager manager] getUserDealerInfoFromLocal:YES result:^(CYTUserInfoModel *model) {
        bself.dealerName = model.companyName;
    }];
}

- (void)timer_callback {
    self.timeIndex--;
    
    if (self.timeIndex == 0) {
        [self.theTimer invalidate];
        self.theTimer = nil;
        self.identifyButton.enabled = YES;
        [self.identifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.identifyButton setTitleColor:UIColorFromRGB(0x2287ff) forState:UIControlStateNormal];
        
    }else{
        NSString *str = [NSString stringWithFormat:@"%ld",self.timeIndex];
        [self.identifyButton setTitle:str forState:UIControlStateNormal];
        [self.identifyButton setTitleColor:kFFColor_title_L3 forState:UIControlStateNormal];
    }
}

- (void)beginTimer {
    self.identifyButton.enabled = NO;
    self.timeIndex = 60;
    //创建Timer
    self.theTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timer_callback) userInfo:nil repeats:YES];
    //使用NSRunLoopCommonModes模式，把timer加入到当前Run Loop中。
    [[NSRunLoop currentRunLoop] addTimer:self.theTimer forMode:NSRunLoopCommonModes];
    //开启
    [self.theTimer setFireDate:[NSDate distantPast]];
}

#pragma mark- get
- (CYTGetCashPwdVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [CYTGetCashPwdVM new];
    }
    return _viewModel;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitButton.titleLabel.font = CYTFontWithPixel(34);
        [_submitButton setBackgroundColor:kFFColor_line];
        [_submitButton setTitle:@"确 认" forState:UIControlStateNormal];
        [_submitButton radius:2 borderWidth:1 borderColor:[UIColor clearColor]];
        
        __weak typeof(self)bself = self;
        [[_submitButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [bself requestTOModifyThePSD];
            
        }];
    }
    return _submitButton;
}

- (void)requestTOModifyThePSD{
    //简单校验
    //密码6-20位
    if (self.pwdString.length >=6 && self.pwdString.length<=20) {
        NSString *mobile = self.phone;
        NSString *secretKey = [NSString tokenValueOf16];
        NSString *msgcode = self.identifyString;
        NSString *psd = [AESCrypt encrypt:self.pwdString password:secretKey];
        NSDictionary *par = @{
                              @"mobile":mobile,
                              @"msgCode":msgcode,
                              @"password":psd,
                              @"tokenValue":Token_Value,
                              };
        
        self.viewModel.confirmParameters = [par copy];
        [self.viewModel.confirmVerifyCode execute:nil];
        
    }else{
        [CYTToast warningToastWithMessage:@"密码6-20位"];
    }
}

- (FFMainView *)mainView {
    if (!_mainView) {
        _mainView = [FFMainView new];
        _mainView.delegate = self;
        [_mainView registerCellWithIdentifier:@[[CYTGetCashPwdSettingFirstCell identifier],
                                                [CYTGetCashPwdSettingSecondCell identifier]]];
        _mainView.mjrefreshSupport = MJRefreshSupportNone;
        [CYTTools configForMainView:_mainView ];
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CYTAutoLayoutV(260))];
        [footerView addSubview:self.submitButton];
        [self.submitButton makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.bottom.equalTo(0);
            make.width.equalTo(CYTAutoLayoutH(690));
            make.height.equalTo(CYTAutoLayoutV(90));
        }];
        _mainView.tableView.tableFooterView = footerView;
    }
    return _mainView;
}

@end
