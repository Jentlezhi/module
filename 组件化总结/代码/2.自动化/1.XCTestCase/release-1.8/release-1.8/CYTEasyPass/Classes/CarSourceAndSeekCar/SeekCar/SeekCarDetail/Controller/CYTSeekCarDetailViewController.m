//
//  CYTSeekCarDetailViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTSeekCarDetailViewController.h"
#import "SeekCarDetailCarTitleCell.h"
#import "CYTSeekCarDetailCarInfoCell.h"
#import "CYTOptionTagModel.h"
#import "CYTDealer.h"
#import "CYTSeekCarDetailModel.h"
#import "CYTDealer.h"
#import "CYTOrderBottomToolBar.h"
#import "CYTOrderCommitViewController.h"
#import "CYTShareActionView.h"
#import "CYTShareManager.h"
#import "CYTDealerHisHomeTableController.h"
#import "CYTDealerCommentPublishView.h"
#import "CYTOtherHeaderCell.h"
#import "CYTCardView.h"
#import "CYTSeekCarDetailParameters.h"
#import "CYTSeekCarDetailFlowCell.h"
#import "CarSourceDetailDescModel.h"
#import "CYTCommitGuideView.h"

@interface CYTSeekCarDetailViewController ()<UITableViewDataSource,UITableViewDelegate>


/** 需求详情表格 */
@property(strong, nonatomic) UITableView *seekCarDetailTableView;
/** 数据源 */
@property(strong, nonatomic) NSArray *seekCarDetailData;
/** 寻车模型 */
@property(strong, nonatomic) CYTSeekCarDetailModel *seekCarDetailModel;
/** 经销商模型 */
@property(strong, nonatomic) CYTDealer *carSourceFindCarDealerModel;
/** 底部按钮 */
@property(weak, nonatomic) CYTOrderBottomToolBar *orderBottomToolBar;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) CYTShareActionView *shareActionView;
///电话检测
@property (nonatomic, strong) FFExtendModel *callMonitorModel;
///评论页面
@property (nonatomic, strong) CYTDealerCommentPublishView *commentPublishView;
///电话检测
@property (nonatomic, strong) FFCallCenterViewModel *callCenter;
///流程图数组
@property (nonatomic, strong) NSMutableArray *flowArray;

@end

@implementation CYTSeekCarDetailViewController

- (UITableView *)seekCarDetailTableView{
    if (!_seekCarDetailTableView) {
        CGRect frame = CGRectMake(0, CYTViewOriginY, kScreenWidth, kScreenHeight - CYTViewOriginY);
        _seekCarDetailTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        if (@available(iOS 11.0, *)) {
            _seekCarDetailTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _seekCarDetailTableView.estimatedSectionFooterHeight = 0;
            _seekCarDetailTableView.estimatedSectionHeaderHeight = 0;
        }
    }
    return _seekCarDetailTableView;
}

- (NSArray *)seekCarDetailData{
    if (!_seekCarDetailData) {
        _seekCarDetailData = [NSArray array];
    }
    return _seekCarDetailData;
}

- (void)dealloc {
    [_callCenter endMonitoring];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //电话检测
    @weakify(self);
    [self.callCenter startMonitoringWithCondition:^id{
        @strongify(self);
        return self.callMonitorModel;
    }];
    
    [self seekCarDetailBasicConfig];
    [self configSeekCarDetailTableView];
    [self initSeekCarDetailComponents];
    [self requestData];
    [self mobClick];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideShareView) name:kHideWindowSubviewsKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:kloginSucceedKey object:nil];
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

- (void)hideShareView {
    [self.shareActionView dismissWithAnimation:YES];
}

/**
 *  基本配置
 */
- (void)seekCarDetailBasicConfig{
    self.view.backgroundColor = CYTLightGrayColor;
    [self createNavBarWithBackButtonAndTitle:@"需求详情"];
}
/**
 *  配置表格
 */
- (void)configSeekCarDetailTableView{
    self.seekCarDetailTableView.backgroundColor = CYTLightGrayColor;
    self.seekCarDetailTableView.delegate = self;
    self.seekCarDetailTableView.dataSource = self;
    self.seekCarDetailTableView.tableFooterView = [[UIView alloc] init];
    self.seekCarDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.seekCarDetailTableView.estimatedRowHeight = CYTAutoLayoutV(100);
    self.seekCarDetailTableView.rowHeight = UITableViewAutomaticDimension;
    self.seekCarDetailTableView.contentInset = UIEdgeInsetsMake(0, 0, CYTAutoLayoutV(98+20), 0);
    [self.seekCarDetailTableView registerClass:[CYTSeekCarDetailFlowCell class] forCellReuseIdentifier:[CYTSeekCarDetailFlowCell identifier]];
    [self.view addSubview:self.seekCarDetailTableView];
}
/**
 *  初始化子控件
 */
- (void)initSeekCarDetailComponents{
    [self.view addSubview:self.shareButton];
    [self.shareButton makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(44);
        make.top.equalTo(CYTStatusBarHeight);
        make.right.equalTo(-CYTAutoLayoutH(20));
    }];
}
/**
 *  请求数据
 */
- (void)requestData{
    CYTWeakSelf
    [CYTLoadingView showBackgroundLoadingWithType:CYTLoadingViewTypeEditNavBar];
    CYTSeekCarDetailParameters *par = [[CYTSeekCarDetailParameters alloc] init];
    par.seekCarId = self.seekCarId;
    [CYTNetworkManager GET:kURL.car_seek_detail parameters:par.mj_keyValues dataTask:^(NSURLSessionDataTask *dataTask) {
        self.sessionDataTask = dataTask;
    } showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
        [CYTLoadingView hideLoadingView];
        if (responseObject.resultEffective) {
            [weakSelf dismissNoNetworkView];
            CYTSeekCarDetailModel *seekCarDetailModel = [CYTSeekCarDetailModel mj_objectWithKeyValues:responseObject.dataDictionary];
            weakSelf.carSourceFindCarDealerModel = seekCarDetailModel.dealer;
            weakSelf.seekCarDetailModel = seekCarDetailModel;
            [weakSelf handelTagDataWithModel:seekCarDetailModel];
            [weakSelf handleFlowImageWithModel:seekCarDetailModel];
            [weakSelf seekCarDetailBottomBarWithModel:seekCarDetailModel];
            [weakSelf handelPersonalInfoWithModel:seekCarDetailModel];
            [weakSelf.commentPublishView config];
            [weakSelf.seekCarDetailTableView reloadData];
        }else{
            [weakSelf showNoNetworkViewInView:weakSelf.view];
        }
    }];
}

- (void)mobClick{
    if ([CYTUserId integerValue] != self.userId) {
#pragma mark - <友盟统计：寻车>
        [MobClick event:@"XC_LLL"];
    }
}
/**
 * 重新加载
 */
- (void)reloadData{
    [self requestData];
}
/**
 * 处理tag数据
 */
- (void)handelTagDataWithModel:(CYTSeekCarDetailModel *)seekCarDetailModel{
    //标签内容
    NSMutableArray *tagsModelArray = [NSMutableArray array];
    NSMutableArray *tagsModelTempArray = [NSMutableArray array];
    NSArray *tagsTitleMArray = @[@"颜\u3000\u3000色",@"指  导  价",@"上牌地区",@"接车地址",@"手\u3000\u3000续",@"配\u3000\u3000置",@"更新时间",@"备\u3000\u3000注"];
    
    NSInteger titlesTotalCount = tagsTitleMArray.count;
    for (NSInteger index = 0; index < titlesTotalCount; index++) {
        CYTOptionTagModel *tagModel = [[CYTOptionTagModel alloc] init];
        CYTSeekCarInfoModel *infoModel = seekCarDetailModel.seekCarInfo;
        
        if (index == 0) {//颜色
            tagModel.content = [NSString stringWithFormat:@"%@/%@",infoModel.exteriorColor,infoModel.interiorColor];
        }else if (index == 1){//指导价
            tagModel.content = infoModel.carReferPriceDesc;
        }else if (index == 2){//上牌地区
            tagModel.content = [NSString stringWithFormat:@"%@",infoModel.registCardAddress];
        }else if (index == 3){//接车地址
            tagModel.content = [NSString stringWithFormat:@"%@",infoModel.receiveAddressDetail];
        }else if (index == 4){//手续
            tagModel.content = [NSString stringWithFormat:@"%@",infoModel.carProcedures];
        }else if (index == 5){//配置
            tagModel.content = [NSString stringWithFormat:@"%@",infoModel.carConfigure];
        }else if (index == 6){//更新时间
            tagModel.content = [NSString stringWithFormat:@"%@",infoModel.publishTime];
        }else{//备注
            tagModel.content = [NSString stringWithFormat:@"%@",infoModel.remark];
        }
        tagModel.tagTitle = tagsTitleMArray[index];
        [tagsModelTempArray addObject:tagModel];
    }
    
    for (CYTOptionTagModel *itemModel in tagsModelTempArray) {
        if (itemModel.content.length) {
            [tagsModelArray addObject:itemModel];
        }
    }
    
    //数据源赋值
    self.seekCarDetailData = [tagsModelArray copy];

}

///处理交易流程图
- (void)handleFlowImageWithModel:(CYTSeekCarDetailModel *)seekCarDetailModel{
    self.flowArray = [CarSourceDetailDescModel mj_objectArrayWithKeyValuesArray:seekCarDetailModel.descList].mutableCopy;
}

/**
 * 处理个人信息的显示与隐藏
 */
- (void)handelPersonalInfoWithModel:(CYTSeekCarDetailModel *)seekCarDetailModel{
    CYTDealer *dealerModel = [CYTDealer mj_objectWithKeyValues:seekCarDetailModel.dealer];
    if ([seekCarDetailModel.seekCarInfo.seekCarStatus integerValue] == 0) {
        _orderBottomToolBar.hidden = YES;
    }
    if ([CYTUserId integerValue] == dealerModel.userId) {
        self.seekCarDetailType = CYTSeekCarDetailTypeSelf;
        _orderBottomToolBar.hidden = YES;
    }
    
    if (self.seekCarDetailType == CYTSeekCarDetailTypeOrderDetail) {
        _orderBottomToolBar.hidden = YES;
    }
}

#pragma mark- 发起订金交易
- (void)showDealAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"message:@"确定已联系买家了解寻车需求？"preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *connected = [UIAlertAction actionWithTitle:@"我已联系买家" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //弹出流程图,点击确认进入交易
        FFBasicSupernatantViewModel *vm = [FFBasicSupernatantViewModel new];
        //0-买家，1-卖家
        vm.ffIndex = 1;
        CYTCommitGuideView *commitView = [[CYTCommitGuideView alloc] initWithViewModel:vm];
        [commitView setClickBlock:^{
            NSString *seekCarId = _seekCarDetailModel.seekCarInfo.seekCarId;
            CYTOrderCommitViewController *orderCommitViewController = [CYTOrderCommitViewController orderCommitViewControllerWithType:CYTOrderCommitTypeSeller carID:seekCarId];
            [self.navigationController pushViewController:orderCommitViewController animated:YES];
        }];
        [commitView ff_showSupernatantView];
    }];
    UIAlertAction *connectNow = [UIAlertAction actionWithTitle:@"马上联系" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打电话,相当于点击电话议价
        NSString *phone = _seekCarDetailModel.dealer.phone;
        //提交联系记录
        [self addContactWithPhoneNum:phone];
        [CYTPhoneCallHandler makePhoneWithNumber:phone withInterval:0.5];
    }];
    
    [alertController addAction:connected];
    [alertController addAction:connectNow];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger count = 3;
    count += self.flowArray.count;
    if (self.seekCarDetailType == CYTSeekCarDetailTypeSelf || self.seekCarDetailType == CYTSeekCarDetailTypeOthersSeekCar) {
        return count--;
    }
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return self.seekCarDetailData.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SeekCarDetailCarTitleCell *cell = [SeekCarDetailCarTitleCell cellForTableView:tableView indexPath:indexPath];
        cell.seekCarDetailModel = self.seekCarDetailModel;
        return cell;
    }else if (indexPath.section == 1){
        CYTSeekCarDetailCarInfoCell *cell = [CYTSeekCarDetailCarInfoCell cellForTableView:tableView indexPath:indexPath];
        cell.optionTagModel = self.seekCarDetailData[indexPath.row];
        return cell;
    }else if (indexPath.section<2+self.flowArray.count) {
        //流程图
        CYTSeekCarDetailFlowCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTSeekCarDetailFlowCell identifier] forIndexPath:indexPath];
        CarSourceDetailDescModel *model = self.flowArray[indexPath.section-2];
        cell.model = model;
        return cell;
    }else{
        //用户信息
        CYTOtherHeaderCell *cell = [CYTOtherHeaderCell cellForTableView:tableView indexPath:indexPath];
        CYTDealer *dealerModel = [CYTDealer mj_objectWithKeyValues:self.seekCarDetailModel.dealer];
        cell.carSourceFindCarDealerModel = dealerModel;
        return cell;
    }
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //点击就算
    [MobClick event:@"CSZY_XC"];
    if (indexPath.section == 2+self.flowArray.count) {
        [[CYTAuthManager manager] autoHandleAccountStateWithLocalState:NO result:^(AccountState state) {
            if (state == AccountStateAuthenticationed) {
                CYTDealerHisHomeTableController *hisHome = [CYTDealerHisHomeTableController new];
                hisHome.viewModel.userId = [NSString stringWithFormat:@"%ld",self.carSourceFindCarDealerModel.userId];
                [self.navigationController pushViewController:hisHome animated:YES];
            }
        }];
    }
}
/**
 * 底部按钮
 */
- (void)seekCarDetailBottomBarWithModel:(CYTSeekCarDetailModel *)seekCarDetailModel{
    CYTDealer *dealerModel = seekCarDetailModel.dealer;
    
    CYTWeakSelf
    NSString *serverImage = @"ic_kefu_hl_new";
    NSString *cancelImage = @"ic_phone_hl_new";
    CYTOrderBottomToolBar *bottomToolBar = [CYTOrderBottomToolBar orderDetailToolBarWithTitles:@[@"客服",@"电话议价",@"发起订金交易"] imageNames:@[serverImage,cancelImage] firstBtnClick:^{
        [CYTPhoneCallHandler makeServicePhone];
        weakSelf.callMonitorModel.ffIndex = 0;
    } secondBtnClick:^{
        //只要点击电话议价就统计
        [MobClick event:@"XC_DHBJ"];
        weakSelf.callMonitorModel.ffIndex = 1;
        
        NSString *phone = dealerModel.phone;
        
        [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
        [[CYTAuthManager manager] autoHandleAccountStateWithLocalState:NO result:^(AccountState state) {
            [CYTLoadingView hideLoadingView];
            if (state == AccountStateAuthenticationed) {
                
                if (CYTValueForKey(CYTCardViewSeekCarNeverShowKey)) {
                    //显示正常提示
                    [CYTPhoneCallHandler makePhoneWithNumber:phone alert:@"线下交易有风险，订金交易保证车源锁定和订金安全" resultBlock:^(BOOL resultBlock){
                        //确定拨打打电话统计
                        [MobClick event:@"XC_DHBJ_HC"];
                        [weakSelf addContactWithPhoneNum:phone];
                    }];
                }else {
                    //显示美女提示
                    CYTCardView *carView = [CYTCardView showCardViewWithType:CYTCardViewTypeSeekCarEvaluate];
                    carView.operationBtnClick = ^(BOOL neverShowAgain){
                        //美女框点击ok
                        [MobClick event:@"XC_DHBJ_HCTS"];
                        if (neverShowAgain) {
                            [MobClick event:@"XC_DHBJ_HCBZTS"];
                        }
                        [weakSelf addContactWithPhoneNum:phone];
                        [CYTPhoneCallHandler makePhoneWithNumber:phone withInterval:0.5];
                    };
                    
                    carView.removeBtnClick = ^(BOOL neverShowAgain){
                        if (neverShowAgain) {
                            [MobClick event:@"XC_DHBJ_HCBZTS"];
                        }
                    };
                }
            }
        }];
        
    } thirdBtnClick:^{
        [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
        [[CYTAuthManager manager] autoHandleAccountStateWithLocalState:NO result:^(AccountState state) {
            [CYTLoadingView hideLoadingView];
            if (state == AccountStateAuthenticationed) {
                [self showDealAlert];
            }
        }];
        
    } fourthBtnClick:nil];
    
    [self.view addSubview:bottomToolBar];
    _orderBottomToolBar = bottomToolBar;
    [bottomToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(CYTAutoLayoutV(98.f));
    }];

}

#pragma mark- get
- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setImage:[UIImage imageNamed:@"shareManager_share"] forState:UIControlStateNormal];
        @weakify(self);
        [[_shareButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            CYTShareActionView *share = [CYTShareActionView new];
            share.type = ShareViewType_carInfo;
            [share setClickedBlock:^(NSInteger tag) {
                if (tag == 0) {
                    //好友
                    [MobClick event:@"FX_WXHY_XCXQ"];
                }else {
                    //朋友圈
                    [MobClick event:@"FX_WXPYQ_XCXQ"];
                }
                CYTShareRequestModel *model = [CYTShareRequestModel new];
                model.plant = tag;
                model.type = ShareTypeId_seekCar;
                model.idCode = [self.seekCarId integerValue];
                kAppdelegate.wxShareType = ShareTypeId_seekCar;
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
        model.beEvalUserId = [NSString stringWithFormat:@"%ld",self.carSourceFindCarDealerModel.userId];
        //评价类型1=电话、2=订单
        model.sourceType = @"1";
        //评价来源1=车源详情 2=寻车详情 3=个人主页 4=买家订单 5=卖家订单 6=车商圈
        model.sourceId = @"2";
        
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
                    //被评论认用户Id
                    self.commentPublishView.viewModel.model.beEvalUserId = [NSString stringWithFormat:@"%ld",self.carSourceFindCarDealerModel.userId];
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

- (void)addContactWithPhoneNum:(NSString *)phoneNum{
    NSMutableDictionary *par = NSMutableDictionary.new;
    [par setValue:phoneNum forKey:@"Phone"];
    [par setValue:self.seekCarId forKey:@"SeekCarId"];
    [CYTNetworkManager POST:kURL.car_seek_addContact parameters:par dataTask:^(NSURLSessionDataTask *dataTask) {
        self.sessionDataTask = dataTask;
    } showErrorTost:NO completion:nil];
}

@end
