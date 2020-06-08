//
//  CYTLogisticsNeedDetailTableController.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticsNeedDetailTableController.h"
#import "CYTLogisticsNeedAddressCell.h"
#import "CYTLogisticsNeedDetailCarCell.h"
#import "CYTLogisticsNeedDetailOfferCell.h"
#import "CYTLogisticsNeedDetailOfferHeaderCell.h"
#import "CYTLogisticsNeedDetailOfferEmptyCell.h"
#import "CYTLogisticsNeedDetailBottomView.h"
#import "CYTPaymentManager.h"
#import "CYTLogisticsOrderCommitController.h"
#import "CYTLogisticsOrderDetail3DController.h"

#define kCancelLogisticsNeedAlert   @"多家物流公司正在为您报价！\n稍等一下，可能有更合适的价格"

@interface CYTLogisticsNeedDetailTableController ()
@property (nonatomic, strong) CYTLogisticsNeedDetailBottomView *bottomView;
@property (nonatomic, strong) UIImageView *statusImageView;

@end

@implementation CYTLogisticsNeedDetailTableController
@synthesize showNavigationView = _showNavigationView;
@synthesize mainView = _mainView;
 

#pragma mark- flow control
- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self loadUI];
}

- (void)loadUI {
    [self.bottomView removeFromSuperview];
    self.bottomView = nil;
    
    [self.ffContentView addSubview:self.mainView];
    [self.ffContentView addSubview:self.bottomView];
    
    [self.mainView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(0);
    }];
    [self.bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainView.bottom);
        make.left.right.bottom.equalTo(0);
        //已过期的话不显示
        float height = (self.viewModel.status == CYTLogisticsNeedStatusExpired || self.viewModel.status == CYTLogisticsNeedStatusCancel)?0:CYTAutoLayoutV(98);
        make.height.equalTo(height);
    }];
}

- (void)ff_bindViewModel {
    [super ff_bindViewModel];
    
    @weakify(self);
    
    [self.viewModel.hudSubject subscribeNext:^(id x) {
        if ([x integerValue] == 0) {
            [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
        }else {
            [CYTLoadingView hideLoadingView];
        }
    }];
    
    [self.viewModel.requestCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
        @strongify(self);
        
        //需要重新加载视图，刷新bottomview
        [self loadUI];
        
        [self.mainView autoReloadWithInterval:0 andMainViewModelBlock:^FFMainViewModel *{
            self.mainView.hidden = NO;
            FFMainViewModel *model = [FFMainViewModel new];
            model.dataEmpty = (self.viewModel.detailModel == nil);
            model.dataHasMore = NO;
            model.netEffective = NO;
            return model;
        }];
        
        if (self.viewModel.detailModel) {
            self.bottomView.hidden = NO;
        }
        
        if (responseModel.resultEffective) {
            //处理状态图片
            NSString *imageStirng = @"";
            if (self.viewModel.status == CYTLogisticsNeedStatusFinished) {
                imageStirng = @"logistics_need_finished";
            }else if (self.viewModel.status == CYTLogisticsNeedStatusExpired) {
                imageStirng = @"logistics_need_expired";
            }else if (self.viewModel.status == CYTLogisticsNeedStatusCancel) {
                imageStirng = @"logistics_need_cancel";
            }
            self.statusImageView.hidden = (self.viewModel.status == CYTLogisticsNeedStatusUnOrder);
            self.statusImageView.image = [UIImage imageNamed:imageStirng];
        }
    }];
    
    [self.viewModel.cancelCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        
        if (self.viewModel.cancelCommandResult.resultEffective) {
            [CYTToast successToastWithMessage:self.viewModel.cancelCommandResult.resultMessage];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLogisticsNeedList_cancel_refresh object:nil];
            //刷新当前页面
            [self.mainView autoRefreshWithInterval:0 andPullRefresh:YES];
        }else {
            [CYTToast errorToastWithMessage:self.viewModel.cancelCommandResult.resultMessage];
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
    [CYTTools updateNavigationBarWithController:self showBackView:YES showLine:YES];
    self.ffTitle = @"物流需求详情";
    self.ffNavigationView.contentView.rightView.titleColor = kFFColor_title_L2;
    [self.ffNavigationView showRightItemWithTitle:@"帮助"];
    [self.mainView autoRefreshWithInterval:0 andPullRefresh:YES];
    [self refreshListData];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.sectionNumber;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CYTAutoLayoutV(20);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else {
        return 2+self.viewModel.listArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CYTLogisticsNeedAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTLogisticsNeedAddressCell identifier] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.arrowImageView.hidden = YES;
        
        if (indexPath.row == 0) {
            self.viewModel.sendModel.ffIndex = 99;
            cell.model = self.viewModel.sendModel;
        }else {
            cell.model = self.viewModel.receiveModel;
        }
        
        return cell;
    }else {
        if (indexPath.row == 0) {
            CYTLogisticsNeedDetailCarCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTLogisticsNeedDetailCarCell identifier] forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.viewModel.carModel;
            return cell;
        }else if (indexPath.row == 1) {
            if (self.viewModel.listArray.count == 0) {
                CYTLogisticsNeedDetailOfferEmptyCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTLogisticsNeedDetailOfferEmptyCell identifier] forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return cell;
            }else {
                CYTLogisticsNeedDetailOfferHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTLogisticsNeedDetailOfferHeaderCell identifier] forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.number = self.viewModel.listArray.count;
                cell.expireLabel.text = self.viewModel.detailModel.quoteExpiredTime;
                return cell;
            }
        }else {
            CYTLogisticsNeedDetailOfferCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTLogisticsNeedDetailOfferCell identifier] forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.viewModel.listArray[indexPath.row-2];
            cell.state = self.viewModel.status;
            
            @weakify(self);
            [cell setClickedBlock:^(CYTLogisticsNeedDetailOfferModel *model) {
                @strongify(self);
                [self placeOrder:model];
            }];
            return cell;
        }
    }
}

- (void)mainViewWillRefresh:(FFMainView *)mainView {
    [self.viewModel.requestCommand execute:nil];
}

#pragma mark- method
- (void)ff_leftClicked:(FFNavigationItemView *)backView {
    if (self.viewModel.source == LogisticsDetailSourceCallTransport) {
        //如果是叫个物流，则返回到订单列表/详情
        [CYTPaymentManager popToOrderListWithNoti:YES andController:self];
    } else if(self.viewModel.source == LogisticsDetailSourcePublish) {
        //如果是普通物流需求发布，则直接返回发布之前的页面
        NSInteger index = self.navigationController.viewControllers.count-1;
        index = (index-2)>0?(index-2):0;
        UIViewController *theController = self.navigationController.viewControllers[index];
        [self.navigationController popToViewController:theController animated:YES];
    } else {
        [super ff_leftClicked:backView];
    }
}

- (void)ff_rightClicked:(FFNavigationItemView *)rightView {
    [self gotoHelpView];
}

- (void)gotoHelpView {
    CYTH5WithInteractiveCtr *ctr = [[CYTH5WithInteractiveCtr alloc] init];
    ctr.requestURL = kURL.kURLLogistics_publishNeed_help;
    [self.navigationController pushViewController:ctr animated:YES];
}

- (void)cancelNeed {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:kCancelLogisticsNeedAlert delegate:nil cancelButtonTitle:@"去意已决" otherButtonTitles:@"再等等吧", nil];
    
    @weakify(self);
    [[alert rac_buttonClickedSignal] subscribeNext:^(id x) {
        @strongify(self);
        if ([x integerValue] == 0) {
            [self.viewModel.cancelCommand execute:nil];
        }
    }];
    [alert show];
}

///下单操作
- (void)placeOrder:(CYTLogisticsNeedDetailOfferModel *)model {
    //    self.viewModel.neeId;
    CYTLogisticsOrderCommitController *logisticsOrderCommitController = [[CYTLogisticsOrderCommitController alloc] init];
    logisticsOrderCommitController.confirmOrderInfoParameters.demandPriceId = model.demandPriceId;
    [self.navigationController pushViewController:logisticsOrderCommitController animated:YES];
    
}

///查看订单详情
- (void)reaviewOrder {
    CYTLogisticsOrderDetail3DController *logisticsOrderDetailController = [[CYTLogisticsOrderDetail3DController alloc] init];
    logisticsOrderDetailController.orderId = [NSString stringWithFormat:@"%ld",self.viewModel.detailModel.transportOrderId];
    [self.navigationController pushViewController:logisticsOrderDetailController animated:YES];
    
}

- (void)refreshListData{
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kLogisticsOrderCommitSuccessNotkey object:nil] subscribeNext:^(id x) {
        [self.mainView autoRefreshWithInterval:0 andPullRefresh:YES];
    }];
}

#pragma mark- get
- (FFMainView *)mainView {
    if (!_mainView) {
        _mainView = [FFMainView new];
        _mainView.delegate = self;
        _mainView.hidden = YES;
        _mainView.mjrefreshSupport = MJRefreshSupportRefresh;
        [CYTTools configForMainView:_mainView ];
        [_mainView registerCellWithIdentifier:@[[CYTLogisticsNeedAddressCell identifier],
                                                [CYTLogisticsNeedDetailCarCell identifier],
                                                [CYTLogisticsNeedDetailOfferCell identifier],
                                                [CYTLogisticsNeedDetailOfferHeaderCell identifier],
                                                [CYTLogisticsNeedDetailOfferEmptyCell identifier]]];
        
        UIView *headerView = [UIView new];
        headerView.size = CGSizeMake(kScreenWidth, 0.1);
        headerView.backgroundColor = [UIColor clearColor];
        
        UIImageView *tmp = [UIImageView ff_imageViewWithImageName:@"logistics_need_expired"];
        [headerView addSubview:tmp];
        [tmp makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerView.bottom).offset(CYTAutoLayoutV(30));
            make.right.equalTo(CYTAutoLayoutH(-30));
        }];
        self.statusImageView = tmp;
        self.statusImageView.hidden = YES;
        
        _mainView.tableView.tableHeaderView = headerView;
    }
    return _mainView;
}

- (CYTLogisticsNeedDetailBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[CYTLogisticsNeedDetailBottomView alloc] initWithViewModel:@(self.viewModel.status)];
        _bottomView.hidden = YES;
        @weakify(self);
        [_bottomView setServiceBlock:^{
            [CYTPhoneCallHandler makeLogisticsServicePhone];
        }];
        
        [_bottomView setRightActionBlock:^{
            @strongify(self);
            if (self.viewModel.status == CYTLogisticsNeedStatusUnOrder) {
                //待下单
                [self cancelNeed];
            }else if (self.viewModel.status == CYTLogisticsNeedStatusFinished) {
                //完成
                [self reaviewOrder];
            }
        }];
    }
    return _bottomView;
}

- (CYTLogisticsNeedDetailVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [CYTLogisticsNeedDetailVM new];
    }
    return _viewModel;
}

@end
