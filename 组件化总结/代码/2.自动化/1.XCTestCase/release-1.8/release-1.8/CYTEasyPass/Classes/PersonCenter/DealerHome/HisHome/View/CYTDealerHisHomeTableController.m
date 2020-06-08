//
//  CYTDealerHisHomeTableController.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTDealerHisHomeTableController.h"
#import "CYTDealerHomeAuthInfoCell.h"
#import "CYTDealerHomeCommentCell.h"
#import "CYTDealerHomeCarFriendsCell.h"
#import "CYTCarTradeCircleCtr.h"
#import "CYTDealerAuthImageViewController.h"
#import "CYTDealerCarFriendsViewController.h"
#import "CYTDealerCommentViewController.h"
#import "CYTOnSaleCarSourceViewController.h"
#import "CYTCarSourceListModel.h"
#import "CYTCarSourceDetailTableController.h"
#import "CYTCarListInfoCell.h"
#import "CYTHisHeadCell.h"
#import "CYTDealerCommentPublishView.h"
#import "CYTOrderBottomToolBar.h"
#import "CYTDealerHeadView.h"
#import "CYTDealerNavView.h"

@interface CYTDealerHisHomeTableController ()
@property (nonatomic, strong) CYTDealerNavView *navView;
@property (nonatomic, strong) CYTDealerHeadView *headView;
@property (nonatomic, strong) CYTOrderBottomToolBar *bottomView;
///电话检测
@property (nonatomic, strong) FFExtendModel *callMonitorModel;
///评论页面
@property (nonatomic, strong) CYTDealerCommentPublishView *commentPublishView;
///电话检测
@property (nonatomic, strong) FFCallCenterViewModel *callCenter;
///自动弹出评价一次有效
@property (nonatomic, assign) BOOL firstShow;

@end

@implementation CYTDealerHisHomeTableController
@synthesize showNavigationView = _showNavigationView;
@synthesize mainView = _mainView;
 

#pragma mark- flow control
- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self loadUI];
}

- (void)loadUI {
    [self.ffContentView addSubview:self.mainView];
    [self.ffContentView addSubview:self.navView];
    [self.ffContentView addSubview:self.bottomView];
    
    [self.mainView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(0);
        make.bottom.equalTo(self.bottomView.top);
    }];
    [self.bottomView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        float height = (self.viewModel.sectionNumber>0)?CYTAutoLayoutV(98):0;
        make.height.equalTo(height);
    }];
    [self.navView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(0);
        make.height.equalTo(CYTViewOriginY);
    }];
    
    //设置是否显示
    self.bottomView.hidden = (self.viewModel.sectionNumber==0);
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
        
        [self loadUI];
        
        if (self.viewModel.homeModel.basic) {
            self.headView.model = self.viewModel.homeModel.basic;
            self.mainView.tableView.tableHeaderView = self.headView;
            [self.commentPublishView config];
        }else {
            self.mainView.tableView.tableHeaderView = nil;
            [self.navView updateViewWithDefault];
        }
        
        [self.mainView autoReloadWithInterval:0 andMainViewModelBlock:^FFMainViewModel *{
            FFMainViewModel *model = [FFMainViewModel new];
            model.dataEmpty = (self.viewModel.homeModel)?NO:YES;
            model.dataHasMore = NO;
            model.netEffective = responseModel.resultEffective;
            return model;
        }];
        
        if (responseModel.resultEffective && self.firstShow) {
            self.firstShow = NO;
            if (self.viewModel.commentShow) {
                //评价来源1=车源详情 2=寻车详情 3=个人主页 4=买家订单 5=卖家订单 6=车商圈
                //消息跳转来的，可能是：1或2
                self.commentPublishView.viewModel.model.sourceId = [NSString stringWithFormat:@"%ld",self.viewModel.commentType];
                [self.commentPublishView showNow];
            }
        }
    }];
}

- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
    _showNavigationView = NO;
    self.viewModel = viewModel;
}

#pragma mark- life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstShow = YES;
    //电话检测
    [self.callCenter startMonitoringWithCondition:^id{
        return self.callMonitorModel;
    }];
    [self.mainView autoRefreshWithInterval:0 andPullRefresh:NO];
}

//有评价功能 1）禁止自动滚动 2）不使用toolbar------>>>>
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [[IQKeyboardManager sharedManager] setEnable:YES];
}
//<<<<---------------------------------------------

#pragma mark- delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return (section == 0)?0.01:CYTAutoLayoutV(80);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    FFSectionHeadView_style0 *headView = [FFSectionHeadView_style0 new];
    //从section1开始显示
    headView.ffServeNameLabel.text = [self.viewModel titleForSection:section-1];
    headView.hidden = (section==0);
    [headView setFfClickedBlock:^(id view) {
        if (section == 1) {
            [self authMethod];
        }else if (section == 2) {
            [self commentMethod];
        }else if (section == 3) {
            [self carFriendsWithIndex:-1];
        }else if (section == 4) {
            [self onSaleCarWithIndex:-1];
        }
    }];
    
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CYTItemMarginV;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.sectionNumber;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel rowNumberWithSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CYTHisHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTHisHeadCell identifier] forIndexPath:indexPath];
        cell.model = self.viewModel.homeModel.basic;
        return cell;
    }else if (indexPath.section == 1) {
        //认证信息
        CYTDealerHomeAuthInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTDealerHomeAuthInfoCell identifier] forIndexPath:indexPath];
        cell.model = self.viewModel.homeModel.auth;
        return cell;
    }else if (indexPath.section == 2) {
        //评论
        CYTDealerHomeCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTDealerHomeCommentCell identifier] forIndexPath:indexPath];
        CYTDealerCommentListModel *model = self.viewModel.commentArray[indexPath.row];
        cell.needSep = NO;
        cell.model = model;
        return cell;
    }else if (indexPath.section == 3) {
        //车商圈
        CYTDealerHomeCarFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTDealerHomeCarFriendsCell identifier] forIndexPath:indexPath];
        CYTDealerHomeCarFriendsModel *model = self.viewModel.carFriendsArray[indexPath.row];
        cell.model = model;
        return cell;
    }else if (indexPath.section == 4) {
        //在售车源
        CYTCarListInfoCell *cell = [CYTCarListInfoCell cellWithType:CYTCarListInfoTypeCarSource forTableView:self.mainView.tableView indexPath:indexPath hideTopBar:YES];
        CYTCarSourceListModel *model = self.viewModel.onSaleCarArray[indexPath.row];
        cell.carSourceListModel = model;
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        [self authMethod];
    }else if (indexPath.section == 2) {
        [self commentMethod];
    }else if (indexPath.section == 3) {
        [self carFriendsWithIndex:indexPath.row];
    }else if (indexPath.section == 4) {
        [self onSaleCarWithIndex:indexPath.row];
    }
}

#pragma mark- delegate

- (void)mainViewWillRefresh:(FFMainView *)mainView {
    [self.viewModel.requestCommand execute:nil];
}

- (void)mainViewWillReload:(FFMainView *)mainView {
    [self.viewModel.requestCommand execute:nil];
}

#pragma mark- scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.viewModel.homeModel.basic) {
        return;
    }
    
    float offset = scrollView.contentOffset.y;
    if (offset<=0) {
        //修改headView高度
        float height = CYTAutoLayoutV(280)+(-offset);
        self.headView.bgImageView.frame = CGRectMake(0, offset, kScreenWidth, height);
    }
    
    [self.navView updateViewWithOffset:offset];
}

#pragma mark- method
- (void)ff_leftClicked:(FFNavigationItemView *)backView {
    [super ff_leftClicked:backView];
}

#pragma mark- select method
- (void)authMethod {
    CYTDealerAuthImageViewController *authImage = [CYTDealerAuthImageViewController new];
    authImage.viewModel.userId = self.viewModel.homeModel.basic.userId;
    [self.navigationController pushViewController:authImage animated:YES];
}

- (void)commentMethod {
    CYTDealerCommentViewController *comment = [CYTDealerCommentViewController new];
    comment.userId = self.viewModel.userId;
    [comment setRefreshBlock:^{
        [self.mainView autoRefreshWithInterval:0 andPullRefresh:NO];
    }];
    [self.navigationController pushViewController:comment animated:YES];
}

- (void)carFriendsWithIndex:(NSInteger)index {
    NSString *linkURL;
    NSString *momentId;
    NSString *userId = self.viewModel.homeModel.basic.userId;
    CarTradeViewType type;
    
    if (index<0) {
        type = CarTradeViewTypeList;
        linkURL = self.viewModel.homeModel.moment.linkUrl;
    }else {
        //获取车商圈id
        CYTDealerHomeCarFriendsModel *model = self.viewModel.carFriendsArray[index];
        if (!model) {
            return;
        }
        momentId = model.momentId;
        type = CarTradeViewTypeDetail;
        linkURL = model.linkUrl;
    }
    
    CYTCarTradeCircleCtr *ctr = [[CYTCarTradeCircleCtr alloc] init];
    [ctr setDeleteBlock:^{
        [self.mainView autoRefreshWithInterval:0 andPullRefresh:NO];
    }];
    ctr.requestURL = linkURL;
    ctr.telNumber = self.viewModel.homeModel.basic.phone;
    ctr.pubUserId = userId;
    ctr.momentId = momentId;
    ctr.type = type;
    [self.navigationController pushViewController:ctr animated:YES];
    
}

- (void)onSaleCarWithIndex:(NSInteger)index {
    if (index<0) {
        //list
        CYTOnSaleCarSourceViewController *onSaleCar = [[CYTOnSaleCarSourceViewController alloc] init];
        onSaleCar.userId = self.viewModel.userId.integerValue;
        [self.navigationController pushViewController:onSaleCar animated:YES];
    }else {
        //详情
        CYTCarSourceListModel *model = self.viewModel.onSaleCarArray[index];
        CYTCarSourceDetailTableController *detail = [CYTCarSourceDetailTableController new];
        detail.viewModel.fromHisCarSource = (self.viewModel.userId.integerValue != [CYTUserId integerValue]);
        detail.viewModel.carSourceId = model.carSourceInfo.carSourceId;
        [self.navigationController pushViewController:detail animated:YES];
    }
}

#pragma mark- get
- (FFMainView *)mainView {
    if (!_mainView) {
        FFMainViewConfigViewModel *configVM = [FFMainViewConfigViewModel new];
        configVM.style = UITableViewStyleGrouped;
        _mainView = [[FFMainView alloc] initWithViewModel:configVM];
        _mainView.delegate = self;
        [CYTTools configForMainView:_mainView ];
        _mainView.mjrefreshSupport = MJRefreshSupportNone;
        _mainView.tableView.showsVerticalScrollIndicator = NO;
        _mainView.tableView.tableHeaderView = self.headView;
        [_mainView registerCellWithIdentifier:@[[CYTDealerHomeAuthInfoCell identifier],
                                                [CYTDealerHomeCommentCell identifier],
                                                [CYTDealerHomeCarFriendsCell identifier],
                                                [CYTHisHeadCell identifier]]];
    }
    return _mainView;
}

- (CYTDealerHeadView *)headView {
    if (!_headView) {
        _headView = [CYTDealerHeadView new];
        _headView.frame = CGRectMake(0, 0, kScreenWidth, CYTAutoLayoutV(280));
    }
    return _headView;
}

- (CYTDealerNavView *)navView {
    if (!_navView) {
        _navView = [CYTDealerNavView new];
        _navView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        _navView.titleLabel.text = @"Ta的主页";
        @weakify(self);
        [_navView setBackBlock:^{
            @strongify(self);
            [self ff_leftClicked:nil];
        }];
    }
    return _navView;
}

- (CYTOrderBottomToolBar *)bottomView {
    if (!_bottomView) {
        NSString *serverImage = @"ic_kefu_hl_new";
        @weakify(self);
        _bottomView = [CYTOrderBottomToolBar orderDetailToolBarWithTitles:@[@"客服",@"联系对方"] imageNames:@[serverImage] firstBtnClick:^{
            @strongify(self);
            self.callMonitorModel.ffIndex = 0;
            [CYTPhoneCallHandler makeServicePhone];
        } secondBtnClick:^{
            @strongify(self);
            if (!self.viewModel.homeModel.basic.phone || self.viewModel.homeModel.basic.phone.length<5) {
                [CYTToast errorToastWithMessage:@"电话号码异常"];
                return ;
            }
            self.callMonitorModel.ffIndex = 1;
            [CYTPhoneCallHandler makePhoneWithNumber:self.viewModel.homeModel.basic.phone alert:@"联系对方?" resultBlock:nil];
        } thirdBtnClick:nil fourthBtnClick:nil];
    }
    return _bottomView;
}

- (CYTDealerCommentPublishView *)commentPublishView {
    if (!_commentPublishView) {
        
        CYTDealerCommentPublishModel *model = [CYTDealerCommentPublishModel new];
        //他的车商主页，被评价id就是userid
        model.beEvalUserId = self.viewModel.userId;
        //评价类型1=电话、2=订单
        model.sourceType = @"1";
        //评价来源1=车源详情 2=寻车详情 3=个人主页 4=买家订单 5=卖家订单 6=车商圈
        model.sourceId = @"3";
        
        CYTDealerCommentPublishVM *vm = [[CYTDealerCommentPublishVM alloc] initWithModel:model];
        [vm.hudSubject subscribeNext:^(id x) {
            if ([x integerValue] == 0) {
                [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeNotEditable];
            }else {
                [CYTLoadingView hideLoadingView];
            }
        }];
        
        [vm.requestCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
            //如果成功则设置nil
            if (responseModel.resultEffective) {
                _commentPublishView = nil;
                //刷新页面
                [self.mainView autoRefreshWithInterval:0 andPullRefresh:NO];
            }
            [CYTToast messageToastWithMessage:responseModel.resultMessage];
        }];
        _commentPublishView = [[CYTDealerCommentPublishView alloc] initWithViewModel:vm];
        _commentPublishView.title = @"发布评价";
    }
    return _commentPublishView;
}

- (CYTDealerHisHomeVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [CYTDealerHisHomeVM new];
    }
    return _viewModel;
}

- (FFExtendModel *)callMonitorModel {
    if (!_callMonitorModel) {
        _callMonitorModel = [FFExtendModel new];
    }
    return _callMonitorModel;
}

- (FFCallCenterViewModel *)callCenter {
    if (!_callCenter) {
        _callCenter = [FFCallCenterViewModel new];
        @weakify(self);
        [_callCenter setIsDialingBlock:^(FFExtendModel *model) {
            @strongify(self);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (model.ffIndex == 1) {
                    //有效
                    self.commentPublishView.viewModel.model.beEvalUserId = self.viewModel.userId;
                    if (self.isShowing) {
                        [self.commentPublishView showNow];
                    }
                }
                self.callMonitorModel = nil;
            });
        }];
    }
    return _callCenter;
}

@end
