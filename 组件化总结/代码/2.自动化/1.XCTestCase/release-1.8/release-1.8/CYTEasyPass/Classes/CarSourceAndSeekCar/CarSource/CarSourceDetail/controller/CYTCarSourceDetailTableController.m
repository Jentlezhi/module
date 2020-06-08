//
//  CYTCarSourceDetailTableController.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSourceDetailTableController.h"
#import "FFCell_Style_SimpleShow.h"
#import "CYTOrderCommitViewController.h"
#import "CYTCarSourceDetailCell_carInfo.h"
#import "CYTCarSourceDetailCell_price.h"
#import "CYTCarSourceDetailCell_image.h"
#import "CarSourceDetailItemModel.h"
#import "CYTPhontoPreviewViewController.h"
#import "CYTShareActionView.h"
#import "CYTShareManager.h"
#import "CYTCarSourceImageShowViewController.h"
#import "CYTDealerHisHomeTableController.h"
#import "CYTDealerCommentPublishView.h"
#import "CYTOtherHeaderCell.h"
#import "CYTCardView.h"
#import "CYTOrderBottomToolBar.h"
#import "CYTCommitGuideView.h"
#import "CYTCarSourceDetailCell_route.h"
#import "CYTCarSourceDetailCell_flow.h"
#import "CYTCarSourceDetailCell_code.h"

@interface CYTCarSourceDetailTableController ()
@property (nonatomic, strong) UIButton *shareButton;
/** 底部按钮 */
@property (nonatomic, strong) CYTOrderBottomToolBar *orderBottomToolBar;

@property (nonatomic, strong) CYTShareActionView *shareActionView;
///电话检测
@property (nonatomic, strong) FFExtendModel *callMonitorModel;
///评论页面
@property (nonatomic, strong) CYTDealerCommentPublishView *commentPublishView;
///电话检测
@property (nonatomic, strong) FFCallCenterViewModel *callCenter;
///是否下架
@property (nonatomic, strong) UIImageView *statusImageView;

@end

@implementation CYTCarSourceDetailTableController
@synthesize showNavigationView = _showNavigationView;
@synthesize mainView = _mainView;
 

#pragma mark- flow control
- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self.ffNavigationView addSubview:self.shareButton];
    [self.ffContentView addSubview:self.mainView];
    [self.ffContentView addSubview:self.orderBottomToolBar];
    
    [self.shareButton makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(44);
        make.top.equalTo(CYTStatusBarHeight);
        make.right.equalTo(-CYTAutoLayoutH(20));
    }];
    [self.mainView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(0);
    }];
    [self.orderBottomToolBar makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.top.equalTo(self.mainView.bottom);
        make.height.equalTo(0);
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
    
    //刷新
    [self.viewModel.requestCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
        @strongify(self);
        
        if (self.viewModel.listArray.count == 0) {
            //没有数据
            self.orderBottomToolBar.hidden = YES;
            [self.orderBottomToolBar updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(0);
            }];
        }else {
            self.orderBottomToolBar.hidden = NO;
            [self.orderBottomToolBar updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(50);
            }];
            
            //请求数据成功则创建评论实例
            [self.commentPublishView config];
            
            //获取状态是否下架
            self.statusImageView.hidden = !(self.viewModel.isUnStore);
        }
        
        [self.mainView autoReloadWithInterval:0 andMainViewModelBlock:^FFMainViewModel *{
            FFMainViewModel *model = [FFMainViewModel new];
            model.dataEmpty = (self.viewModel.listArray.count==0);
            model.dataHasMore = NO;
            model.netEffective = responseModel.resultEffective;
            return model;
        }];
        
        //友盟统计
        [self umengCalculate];
        //update
        [self updateBottomView];
    }];
    
    [self.viewModel.routeCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        [self.mainView autoReloadWithInterval:0 andMainViewModelBlock:^FFMainViewModel *{
            FFMainViewModel *model = [FFMainViewModel new];
            model.dataEmpty = (self.viewModel.listArray.count==0);
            model.dataHasMore = NO;
            model.netEffective = YES;
            return model;
        }];
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
    self.ffTitle = @"车源详情";
    //电话检测
    @weakify(self);
    [self.callCenter startMonitoringWithCondition:^id{
        @strongify(self);
        return self.callMonitorModel;
    }];
    
    [self.mainView autoRefreshWithInterval:0 andPullRefresh:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideShareView) name:kHideWindowSubviewsKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMethod) name:kloginSucceedKey object:nil];
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
    return [self.viewModel heightForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return (section == self.viewModel.listArray.count-1)?20:0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self.viewModel viewForHeaderInSection:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.listArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel.listArray[section] count];
}

#pragma mark- cell for row
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CarSourceDetailItemModel *itemModel = self.viewModel.listArray[indexPath.section][indexPath.row];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return [self carInfoCellWithIndexPath:indexPath andModel:itemModel];
        }else if (indexPath.row == 2) {
            return [self priceCellWithIndexPath:indexPath andModel:itemModel];
        }else {
            return [self simpleCellWithIndexPath:indexPath andModel:itemModel];
        }
    }else if (indexPath.section == 1) {
        if (itemModel.index == 5) {
            //图片
            return [self imageCellWithIndexPath:indexPath andModel:itemModel];
        }else if (itemModel.index==7) {
            return [self codeCellWithIndexPath:indexPath andModel:itemModel];
        }else {
            return [self simpleCellWithIndexPath:indexPath andModel:itemModel];
        }
    }else{
        
        NSString *identifier = [self.viewModel identifierWithSection:indexPath.section];
        
        if ([identifier isEqualToString:[CYTOtherHeaderCell identifier]]) {
            //用户信息
            CYTOtherHeaderCell *cell = [CYTOtherHeaderCell cellForTableView:tableView indexPath:indexPath];
            cell.carSourceFindCarDealerModel = itemModel.dealerInfoModel;
            return cell;
        }else if ([identifier isEqualToString:[CYTCarSourceDetailCell_route identifier]]) {
            //优势线路
            FFExtendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
            cell.ffModel = itemModel;
            return cell;
        }else if ([identifier isEqualToString:[CYTCarSourceDetailCell_flow identifier]]) {
            //交易流程
            FFExtendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
            cell.ffModel = itemModel;
            return cell;
        }
        
        return nil;
    }
}

- (CYTCarSourceDetailCell_carInfo *)carInfoCellWithIndexPath:(NSIndexPath *)indexPath andModel:(CarSourceDetailItemModel *)model{
    CYTCarSourceDetailCell_carInfo *cell = [self.mainView.tableView dequeueReusableCellWithIdentifier:[CYTCarSourceDetailCell_carInfo identifier] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLab.text = model.carInfoString;
    cell.subTitleLab.text = model.carTypeString;
    
    return cell;
}

- (FFCell_Style_SimpleShow *)simpleCellWithIndexPath:(NSIndexPath *)indexPath andModel:(CarSourceDetailItemModel *)model{
    FFCell_Style_SimpleShow *cell = [self.mainView.tableView dequeueReusableCellWithIdentifier:[FFCell_Style_SimpleShow identifier] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellView.showArrow = NO;
    cell.cellView.singleLine = NO;
    cell.cellView.flagLabel.text = model.flagString;
    cell.cellView.contentLabel.text = model.contentString;
    cell.cellView.flagLabel.textColor = kFFColor_title_L2;
    cell.cellView.contentLabel.textColor = kFFColor_title_L2;
    return cell;
}

- (CYTCarSourceDetailCell_price *)priceCellWithIndexPath:(NSIndexPath *)indexPath andModel:(CarSourceDetailItemModel *)model{
    CYTCarSourceDetailCell_price *cell = [self.mainView.tableView dequeueReusableCellWithIdentifier:[CYTCarSourceDetailCell_price identifier] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLab.text = model.flagString;
    NSString *priceString = ([model.contentString isEqualToString:@"0"])?@"电议":model.contentString;
    cell.subTitleLab.text = priceString;
    cell.assistantLab.text = ([model.contentString isEqualToString:@"0"])?@"":@"万元";
    
    return cell;
}

- (CYTCarSourceDetailCell_image *)imageCellWithIndexPath:(NSIndexPath *)indexPath andModel:(CarSourceDetailItemModel *)model{
    CYTCarSourceDetailCell_image *cell = [self.mainView.tableView dequeueReusableCellWithIdentifier:[CYTCarSourceDetailCell_image identifier] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.urlArray = model.imageArray;
    cell.titleLab.text = model.flagString;
    @weakify(self);
    [cell.imgView setSelectBlock:^(NSInteger index) {
        @strongify(self);
        [self browseImageWithIndex:index];
    }];
    
    return cell;
}

- (CYTCarSourceDetailCell_code *)codeCellWithIndexPath:(NSIndexPath *)indexPath andModel:(CarSourceDetailItemModel *)model{
    CYTCarSourceDetailCell_code *cell = [self.mainView.tableView dequeueReusableCellWithIdentifier:[CYTCarSourceDetailCell_code identifier] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellView.showArrow = NO;
    cell.cellView.singleLine = YES;
    cell.cellView.flagLabel.text = model.flagString;
    cell.cellView.contentLabel.text = model.contentString;
    cell.cellView.flagLabel.textColor = kFFColor_title_L2;
    cell.cellView.contentLabel.textColor = kFFColor_title_L2;
    [cell setCopyBlock:^{
        if (model.contentString) {
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = model.contentString;
            [CYTToast successToastWithMessage:@"车源编号已复制"];
        }
    }];
    return cell;
}

#pragma mark- didSelect
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section<2) {
        //0-1
        CarSourceDetailItemModel *itemModel = self.viewModel.listArray[indexPath.section][indexPath.row];
        if (itemModel.index == 5) {
            [self browseImageWithIndex:0];
        }
    }else {
        NSString *identifier = [self.viewModel identifierWithSection:indexPath.section];
        if ([identifier isEqualToString:[CYTOtherHeaderCell identifier]]) {
            //用户信息
            [self goToSellerPublishList];
        }
    }
}

- (void)mainViewWillRefresh:(FFMainView *)mainView {
    [self.viewModel.requestCommand execute:nil];
}

- (void)mainViewWillReload:(FFMainView *)mainView {
    [self.viewModel.requestCommand execute:nil];
}

#pragma mark- method
- (void)ff_leftClicked:(FFNavigationItemView *)backView {
    [super ff_leftClicked:backView];
}

- (void)dealloc {
    [_callCenter endMonitoring];
}

- (void)hideShareView {
    [self.shareActionView dismissWithAnimation:YES];
}

- (void)refreshMethod {
    [self.mainView autoRefreshWithInterval:0 andPullRefresh:NO];
}

///如果不是自己的车源则进行统计
- (void)umengCalculate {
    if (!self.viewModel.isMyCarSource) {
        [MobClick event:@"CY_LLL"];
    }
}

- (void)updateBottomView {
    if (self.viewModel.listArray.count == 0) {
        return;
    }
    
    if (self.viewModel.isMyCarSource || self.viewModel.isUnStore || self.viewModel.fromOrderView) {
        self.orderBottomToolBar.hidden = YES;
        [self.orderBottomToolBar updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(0);
        }];
    }else {
        self.orderBottomToolBar.hidden = NO;
        [self.orderBottomToolBar updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(50);
        }];
    }
}

- (void)goToSellerPublishList {
    //点击就算
    [MobClick event:@"CSZY_CY"];
    
    [[CYTAuthManager manager] autoHandleAccountStateWithLocalState:NO result:^(AccountState state) {
        if (state == AccountStateAuthenticationed) {
            CarSourceDetailItemModel *model = self.viewModel.userInfoArray[0];
            CYTDealerHisHomeTableController *hisHome = [CYTDealerHisHomeTableController new];
            hisHome.viewModel.userId = [NSString stringWithFormat:@"%ld",model.dealerInfoModel.userId];
            [self.navigationController pushViewController:hisHome animated:YES];
        }
    }];
}

- (void)browseImageWithIndex:(NSInteger)index {
    //图片浏览
    CYTCarSourceImageShowViewController *showVC = [CYTCarSourceImageShowViewController new];
    showVC.imageArray = self.viewModel.imageURLArray;
    [self.navigationController pushViewController:showVC animated:YES];
}

#pragma mark- 底部按钮操作
///打服务电话提示
- (void)alert_service {
    [CYTPhoneCallHandler makeServicePhone];
}

//点击电话议价
- (void)clickDiscussPrice {
    [MobClick event:@"CY_DHYJ"];
    self.callMonitorModel.ffIndex = 1;
    
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
    [[CYTAuthManager manager] autoHandleAccountStateWithLocalState:NO result:^(AccountState state) {
        [CYTLoadingView hideLoadingView];
        if (state == AccountStateAuthenticationed) {
            [self alert_connectSeller];
        }
    }];
}

///提示线下交易风险
- (void)alert_connectSeller {
    NSString *phone = self.viewModel.detailModel.dealer.phone;
    
    if (CYTValueForKey(CYTCardViewCarSourceNeverShowKey)) {
        //显示正常提示
        [CYTPhoneCallHandler makePhoneWithNumber:phone alert:@"线下交易有风险，订金交易保证车源锁定和订金安全" resultBlock:^(BOOL resultBlock){
            //确定拨打电话统计
            [MobClick event:@"CY_DHYJ_HC"];
            //提交联系记录
            [self.viewModel.phoneCallCommand execute:nil];
        }];
        
    }else {
        //显示美女提示
        CYTCardView *carView = [CYTCardView showCardViewWithType:CYTCardViewTypeCarSourceEvaluate];
        carView.operationBtnClick = ^(BOOL neverShowAgain){
            //美女框点击ok
            [MobClick event:@"CY_DHYJ_TPTS"];
            if (neverShowAgain) {
                [MobClick event:@"CY_DHYJ_TPBZTS"];
            }
            //提交联系记录
            [self.viewModel.phoneCallCommand execute:nil];
            [CYTPhoneCallHandler makePhoneWithNumber:phone withInterval:0.5];
        };
        carView.removeBtnClick = ^(BOOL neverShowAgain){
            if (neverShowAgain) {
                [MobClick event:@"CY_DHYJ_TPBZTS"];
            }
        };
    }
}

- (void)showDealAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"message:@"确定已联系卖家了解车源情况？"preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *connected = [UIAlertAction actionWithTitle:@"我已联系卖家" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //弹出流程图,点击确认进入交易
        FFBasicSupernatantViewModel *vm = [FFBasicSupernatantViewModel new];
        //0-买家，1-卖家
        vm.ffIndex = 0;
        CYTCommitGuideView *commitView = [[CYTCommitGuideView alloc] initWithViewModel:vm];
        [commitView setClickBlock:^{
            CYTOrderCommitViewController *orderCommitViewController = [CYTOrderCommitViewController orderCommitViewControllerWithType:CYTOrderCommitTypeBuyer carID:self.viewModel.carSourceId];
            [self.navigationController pushViewController:orderCommitViewController animated:YES];
        }];
        [commitView ff_showSupernatantView];
    }];
    UIAlertAction *connectNow = [UIAlertAction actionWithTitle:@"马上联系" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打电话,相当于点击电话议价
        NSString *phone = self.viewModel.detailModel.dealer.phone;
        [MobClick event:@"CY_DHYJ_DJJYHC"];
        //提交联系记录
        [self.viewModel.phoneCallCommand execute:nil];
        //打电话
        [CYTPhoneCallHandler makePhoneWithNumber:phone withInterval:0.5];
    }];
    
    [alertController addAction:connected];
    [alertController addAction:connectNow];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark- get
- (FFMainView *)mainView {
    if (!_mainView) {
        FFMainViewConfigViewModel *configVM = [FFMainViewConfigViewModel new];
        configVM.style = UITableViewStyleGrouped;
        _mainView = [[FFMainView alloc] initWithViewModel:configVM];
        _mainView.delegate = self;
        [CYTTools configForMainView:_mainView ];
        _mainView.dznCustomViewModel.shouldDisplay = NO;
        _mainView.mjrefreshSupport = MJRefreshSupportNone;
        [_mainView registerCellWithIdentifier:@[[FFCell_Style_SimpleShow identifier],
                                                [CYTCarSourceDetailCell_carInfo identifier],
                                                [CYTCarSourceDetailCell_price identifier],
                                                [CYTCarSourceDetailCell_image identifier],
                                                [CYTCarSourceDetailCell_flow identifier],
                                                [CYTCarSourceDetailCell_route identifier],
                                                [CYTCarSourceDetailCell_code identifier]]
         ];
        
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

- (CYTOrderBottomToolBar *)orderBottomToolBar {
    if (!_orderBottomToolBar) {
        NSString *serverImage = @"ic_kefu_hl_new";
        NSString *cancelImage = @"ic_phone_hl_new";
        @weakify(self);
        _orderBottomToolBar = [CYTOrderBottomToolBar orderDetailToolBarWithTitles:@[@"客服",@"电话议价",@"发起订金交易"] imageNames:@[serverImage,cancelImage] firstBtnClick:^{
            @strongify(self);
            [self alert_service];
            self.callMonitorModel.ffIndex = 0;
        } secondBtnClick:^{
            @strongify(self);
            [self clickDiscussPrice];
        } thirdBtnClick:^{
            @strongify(self);
            [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
            [[CYTAuthManager manager] autoHandleAccountStateWithLocalState:NO result:^(AccountState state) {
                [CYTLoadingView hideLoadingView];
                if (state == AccountStateAuthenticationed) {
                    //弹出弹框提示
                    [self showDealAlert];
                }
            }];
        } fourthBtnClick:nil];
        
        _orderBottomToolBar.hidden = YES;
    }
    return _orderBottomToolBar;
}

- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setImage:[UIImage imageNamed:@"shareManager_share"] forState:UIControlStateNormal];
        @weakify(self);
        [[_shareButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            CYTShareActionView *share = [CYTShareActionView new];
            share.type = ShareViewType_carInfo;
            @weakify(self);
            [share setClickedBlock:^(NSInteger tag) {
                @strongify(self);
                if (tag == 0) {
                    //好友
                    [MobClick event:@"FX_WXHY_CYXQ"];
                }else {
                    //朋友圈
                    [MobClick event:@"FX_WXPYQ_CYXQ"];
                }
                
                CYTShareRequestModel *model = [CYTShareRequestModel new];
                model.plant = tag;
                model.type = ShareTypeId_carSource;
                model.idCode = self.viewModel.detailModel.carSourceInfo.carSourceId;
                kAppdelegate.wxShareType = ShareTypeId_carSource;
                kAppdelegate.wxShareBusinessId = model.idCode;
                [CYTShareManager shareWithRequestModel:model];
            }];
            [share showWithSuperView:self.view];
            
            self.shareActionView = share;
        }];
    }
    return _shareButton;
}

- (CYTDealerCommentPublishView *)commentPublishView {
    if (!_commentPublishView) {
        CYTDealerCommentPublishModel *model = [CYTDealerCommentPublishModel new];
        //被评论认用户Id
        CarSourceDetailItemModel *modelTmp;
        if (!self.viewModel.userInfoArray || self.viewModel.userInfoArray.count==0) {
            model.beEvalUserId = @"";
        }else {
            modelTmp = self.viewModel.userInfoArray[0];
            model.beEvalUserId = [NSString stringWithFormat:@"%ld",modelTmp.dealerInfoModel.userId];
        }
        
        //评价类型1=电话、2=订单
        model.sourceType = @"1";
        //评价来源1=车源详情 2=寻车详情 3=个人主页 4=买家订单 5=卖家订单 6=车商圈
        model.sourceId = @"1";
        
        CYTDealerCommentPublishVM *vm = [[CYTDealerCommentPublishVM alloc] initWithModel:model];
        [vm.hudSubject subscribeNext:^(id x) {
            if ([x integerValue] == 0) {
                [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeNotEditable];
            }else {
                [CYTLoadingView hideLoadingView];
            }
        }];
        
        @weakify(self);
        [vm.requestCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
            @strongify(self);
            //如果成功则设置nil
            if (responseModel.resultEffective) {
                self.commentPublishView = nil;
            }
            [CYTToast messageToastWithMessage:responseModel.resultMessage];
        }];
        _commentPublishView = [[CYTDealerCommentPublishView alloc] initWithViewModel:vm];
        _commentPublishView.title = @"发布评价";
    }
    return _commentPublishView;
}

- (CarSourceDetailVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [CarSourceDetailVM new];
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
                    //被评论认用户Id
                    if (self.viewModel.userInfoArray&& self.viewModel.userInfoArray.count>0) {
                        CarSourceDetailItemModel *modelTmp = self.viewModel.userInfoArray[0];
                        self.commentPublishView.viewModel.model.beEvalUserId = [NSString stringWithFormat:@"%ld",modelTmp.dealerInfoModel.userId];
                        if (self.isShowing) {
                            [self.commentPublishView showNow];
                        }
                    }
                }
                
                self.callMonitorModel = nil;
            });
        }];
    }
    return _callCenter;
}
@end
