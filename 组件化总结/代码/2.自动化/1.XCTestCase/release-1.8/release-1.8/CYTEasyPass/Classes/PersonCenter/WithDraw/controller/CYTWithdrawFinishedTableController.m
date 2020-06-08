//
//  CYTWithdrawFinishedTableController.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTWithdrawFinishedTableController.h"
#import "CYTGetCashFinishedItemCell.h"

@interface CYTWithdrawFinishedTableController ()
@property (nonatomic, strong) UIButton *finishButton;
@property (nonatomic, strong) NSArray *flagArray;

@end

@implementation CYTWithdrawFinishedTableController
@synthesize showNavigationView = _showNavigationView;
@synthesize mainView = _mainView;
 

#pragma mark- flow control
- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self.ffContentView addSubview:self.mainView];
    [self.ffContentView addSubview:self.finishButton];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    [self.finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTAutoLayoutV(800));
        make.height.equalTo(CYTAutoLayoutV(90));
        make.left.equalTo(CYTAutoLayoutH(30));
        make.right.equalTo(-CYTAutoLayoutH(30));
    }];
}

- (void)ff_bindViewModel {
    [super ff_bindViewModel];
}

- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
    _showNavigationView = YES;
}

#pragma mark- life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [CYTTools updateNavigationBarWithController:self showBackView:NO showLine:YES];
    self.ffTitle = @"提现完成";
    self.flagArray = @[@"支付宝账号",@"提现金额",@"手续费"];
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
    CYTGetCashFinishedItemCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTGetCashFinishedItemCell identifier] forIndexPath:indexPath];
    NSString *title = self.flagArray[indexPath.row];
    NSString *content;
    if (indexPath.row==0) {
        content = self.accountString;
    }else if (indexPath.row == 1) {
        content = [NSString stringWithFormat:@"%@元",self.cashMount];
    }else{
        content = [NSString stringWithFormat:@"%@元",self.poundage];
    }
    
    cell.flagLabel.text = title;
    cell.contentLabel.text = content;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark- method
- (void)ff_leftClicked:(FFNavigationItemView *)backView {
    [super ff_leftClicked:backView];
}

#pragma mark- get
- (UIView *)headView {
    UIView *head = [UIView new];
    head.frame = CGRectMake(0, 0, SCREEN_WIDTH, CYTAutoLayoutV(450-128));
    
    UIImageView *imageView = [UIImageView new];
    imageView.frame = CGRectMake(0, 30, SCREEN_WIDTH, 65);
    imageView.image = [UIImage imageNamed:@"me_pwd_finished"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [head addSubview:imageView];
    
    
    UILabel *flagLabel = [UILabel new];
    flagLabel.frame = CGRectMake(0, 105, SCREEN_WIDTH, 20);
    flagLabel.textAlignment = NSTextAlignmentCenter;
    flagLabel.font = CYTFontWithPixel(34);
    flagLabel.textColor = kFFColor_title_L1;
    flagLabel.text = @"提现已提交";
    [head addSubview:flagLabel];
    
    UIView *line = [UIView new];
    line.backgroundColor = kFFColor_bg_nor;
    line.frame  = CGRectMake(0, CYTAutoLayoutV(450-128-20), SCREEN_WIDTH, CYTAutoLayoutV(20));
    [head addSubview:line];
    
    return head;
}

- (FFMainView *)mainView {
    if (!_mainView) {
        _mainView = [FFMainView new];
        _mainView.tableView.bounces = NO;
        _mainView.delegate = self;
        [_mainView registerCellWithIdentifier:@[[CYTGetCashFinishedItemCell identifier]]];
        _mainView.mjrefreshSupport = MJRefreshSupportNone;
        [CYTTools configForMainView:_mainView ];
        _mainView.tableView.tableHeaderView = [self headView];
    }
    return _mainView;
}

- (UIButton *)finishButton {
    if (!_finishButton) {
        _finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_finishButton setTitle:@"完成" forState:UIControlStateNormal];
        [_finishButton radius:4 borderWidth:1 borderColor:kFFColor_green];
        _finishButton.titleLabel.font = CYTFontWithPixel(34);
        [_finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _finishButton.backgroundColor = kFFColor_green;
        
        @weakify(self);
        [[_finishButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    }
    return _finishButton;
}

@end
