//
//  CYTLogisticsNeedWriteTableController.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticsNeedWriteTableController.h"
#import "CYTLogisticsNeedBottomView.h"
#import "FFCell_Style_SimpleChoose.h"
#import "CYTLogisticsNeedAddressCell.h"
#import "CYTLogisticsProtocalView.h"
#import "CYTCarBrandModel.h"
#import "CYTAddressListViewController.h"
#import "CYTAddressChooseCommonVC.h"
#import "CYTBrandSelectViewController.h"
#import "CYTLogisticsNeedDetailTableController.h"
#import "CYTLogisticsNeedWriteInputCell.h"
#import "CYTLogisticsNeedWriteDesCell.h"

@interface CYTLogisticsNeedWriteTableController ()
@property (nonatomic, strong) CYTLogisticsProtocalView *protocalView;
@property (nonatomic, strong) CYTLogisticsNeedBottomView *bottomView;
@property (nonatomic, strong) UITextField *textFiled;
@property (nonatomic, assign) NSInteger sectionNumber;

@end

@implementation CYTLogisticsNeedWriteTableController
@synthesize showNavigationView = _showNavigationView;
@synthesize mainView = _mainView;
 

#pragma mark- flow control
- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self.ffContentView addSubview:self.mainView];
    [self.ffContentView addSubview:self.protocalView];
    [self.ffContentView addSubview:self.bottomView];
    [self.mainView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(0);
        make.bottom.equalTo(self.protocalView.top).offset(-CYTAutoLayoutV(20));
    }];
    [self.protocalView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.bottom.equalTo(self.bottomView.top).offset(-CYTAutoLayoutV(10));
    }];
    [self.bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo(50);
    }];
}

- (void)ff_bindViewModel {
    [super ff_bindViewModel];
    
    @weakify(self);
    [self.viewModel.hudSubject subscribeNext:^(id x) {
        if ([x integerValue]==0) {
            [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
        }else {
            [CYTLoadingView hideLoadingView];
        }
    }];
    
    //提交需求结果
    [self.viewModel.requestCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
        @strongify(self);
        if (responseModel.resultEffective) {
            //发送消息，刷新需求列表
            [[NSNotificationCenter defaultCenter] postNotificationName:kLogisticsNeedListRefreshKey object:nil];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:responseModel.resultMessage delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            @weakify(self);
            [[alert rac_buttonClickedSignal] subscribeNext:^(id x) {
                @strongify(self);
                CYTLogisticsNeedDetailTableController *detail = [CYTLogisticsNeedDetailTableController new];
                detail.viewModel.source = (self.viewModel.needGetLogisticInfo)?LogisticsDetailSourceCallTransport:LogisticsDetailSourcePublish;
                NSInteger demandId = [[responseModel.dataDictionary valueForKey:@"demandId"] integerValue];
                detail.viewModel.neeId = demandId;
                [self.navigationController pushViewController:detail animated:YES];
            }];
            [alert show];
            
        }else {
            if (responseModel.httpCode==4000001) {
                //报价问题
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:responseModel.resultMessage delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [[alert rac_buttonClickedSignal] subscribeNext:^(id x) {
                    //none
                }];
                [alert show];
            }else {
                [CYTToast errorToastWithMessage:responseModel.resultMessage];
            }
        }
    }];
    
    //叫个物流获取物流携带信息结果
    [self.viewModel.requestLogisticInfo.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        if (self.viewModel.logisticInfoResult.resultEffective) {
            //成功更新UI
            [self showTableView];
            self.bottomView.valid = self.viewModel.valid;
        }else {
            //失败显示reload
            [self showReloadView];
        }
    }];
}

- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
    self.viewModel = viewModel;
    _showNavigationView = YES;
}

#pragma mark- life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.ffContentView.backgroundColor = kFFColor_bg_nor;
    [CYTTools updateNavigationBarWithController:self showBackView:YES showLine:YES];
    self.ffTitle = @"物流需求提交";
    self.ffNavigationView.contentView.rightView.titleColor = kFFColor_title_L2;
    [self.ffNavigationView showRightItemWithTitle:@"帮助"];
    self.sectionNumber = 3;
    [self.mainView autoRefreshWithInterval:0 andPullRefresh:NO];
    
    if (!self.viewModel.needGetLogisticInfo) {
        [self showTableView];
    }
}

#pragma mark- delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CYTAutoLayoutV(20);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionNumber;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 4;
    }else if (section == 2) {
        return 1;
    }
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self indexWithIndexPath:indexPath];
    CYTLogisticsNeedWriteCellModel *model = self.viewModel.cellModelArray[index];
    
    if (indexPath.section == 0) {
        CYTLogisticsNeedAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTLogisticsNeedAddressCell identifier] forIndexPath:indexPath];
        cell.model = model;
        cell.hideBottomLine = (indexPath.row == 1);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //选择车型
            return [self chooseCellWithTableView:tableView andIndexPath:indexPath andModel:model];
        }else {
            //数量、单价、总价
            return [self inputCellWithTableView:tableView andIndexPath:indexPath andModel:model];
        }
    }else {
        FFExtendTableViewCellModel *ccModel = [FFExtendTableViewCellModel new];
        ccModel.ffIndexPath = indexPath;
        ccModel.ffIdentifier = [CYTLogisticsNeedWriteDesCell identifier];
        CYTLogisticsNeedWriteDesCell *cell = [tableView dequeueReusableCellWithIdentifier:ccModel.ffIdentifier forIndexPath:ccModel.ffIndexPath];
        cell.ffCustomizeCellModel = ccModel;
        cell.ffModel = model;
        return cell;
    }
}

- (FFCell_Style_SimpleChoose *)chooseCellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath andModel:(CYTLogisticsNeedWriteCellModel *)model {
    FFCell_Style_SimpleChoose *cell = [tableView dequeueReusableCellWithIdentifier:[FFCell_Style_SimpleChoose identifier]forIndexPath:indexPath];
    cell.cellView.flagLabel.text = model.title;
    
    UIColor *textColor = (model.select)?kFFColor_title_L2:kFFColor_title_gray;
    textColor = (self.viewModel.needGetLogisticInfo)?kFFColor_title_gray:textColor;
    cell.cellView.contentLabel.textColor = textColor;
    
    NSString *string = model.contentString;
    if (indexPath.row == 1  && string.length >0) {
        //数量
        string = [NSString stringWithFormat:@"%@辆",string];
    }
    cell.cellView.contentLabel.text = string;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CYTLogisticsNeedWriteInputCell *)inputCellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath andModel:(CYTLogisticsNeedWriteCellModel *)model {
    FFExtendTableViewCellModel *ccModel = [FFExtendTableViewCellModel new];
    ccModel.ffIndexPath = indexPath;
    ccModel.ffIdentifier = [CYTLogisticsNeedWriteInputCell identifier];
    
    CYTLogisticsNeedWriteInputCell *cell = [tableView dequeueReusableCellWithIdentifier:ccModel.ffIdentifier forIndexPath:ccModel.ffIndexPath];
    cell.ffCustomizeCellModel = ccModel;
    cell.ffModel = model;
    cell.callLogisticsService = self.viewModel.needGetLogisticInfo;
    
    @weakify(self);
    [cell setTextBlock:^(NSString *text) {
        @strongify(self);
        [self.viewModel saveAndCalculatePriceWithText:text andIndexPath:indexPath];
        [self.mainView.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
        self.bottomView.valid = self.viewModel.valid;
    }];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];    
    [self.view endEditing:YES];

    if (indexPath.section == 0) {
        self.viewModel.addressIndex = indexPath.row;
        [self gotoAddressCtrWithIndex:indexPath.row];
        
    }else if (indexPath.section == 1) {
        if (self.viewModel.needGetLogisticInfo) {
            //叫个物流
            return;
        }
        
        if (indexPath.row == 0) {
            //处理车型
            [self gotoBrandCtr];
        }
    }
}

- (void)mainViewWillRefresh:(FFMainView *)mainView {
    [self getData];
}

- (void)mainViewWillReload:(FFMainView *)mainView {
    [self getData];
}

#pragma mark- method
- (void)ff_leftClicked:(FFNavigationItemView *)backView {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)ff_rightClicked:(FFNavigationItemView *)rightView {
    [self gotoHelpView];
}

- (void)getData {
    if (self.viewModel.needGetLogisticInfo) {
        //重新获取物流信息
        [self.viewModel.requestLogisticInfo execute:nil];
    }
}

- (NSInteger)indexWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return indexPath.row;
    }
    if (indexPath.section == 1) {
        return 2+indexPath.row;
    }
    if (indexPath.section == 2) {
        return 6+indexPath.row;
    }
    return 0;
}

- (void)gotoProtocalView {
    CYTH5WithInteractiveCtr *ctr = [[CYTH5WithInteractiveCtr alloc] init];
    ctr.requestURL = kURL.kURL_me_set_transport;
    [self.navigationController pushViewController:ctr animated:YES];
}

- (void)gotoHelpView {
    CYTH5WithInteractiveCtr *ctr = [[CYTH5WithInteractiveCtr alloc] init];
    ctr.requestURL = kURL.kURLLogistics_publishNeed_help;
    [self.navigationController pushViewController:ctr animated:YES];
}

#pragma mark- 选择车型
- (void)gotoBrandCtr {
    CYTBrandSelectViewController *brandSelect = [CYTBrandSelectViewController new];
    __weak typeof(self)bself = self;
    brandSelect.ffobj = bself;
    brandSelect.viewModel.type = CYTBrandSelectTypeCar;
    brandSelect.viewModel.brandResultModel = [self.viewModel.brandSelectModel copy];
    
    @weakify(self);
    [brandSelect setBrandSelectBlock:^(CYTBrandSelectResultModel *brandModel) {
        @strongify(self);
        //处理选择的车款
        self.viewModel.brandSelectModel = brandModel;
        [self.viewModel saveCarInfoAndGuidePriceWithModel:brandModel];
        [self.mainView.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        self.bottomView.valid = self.viewModel.valid;
    }];
    
    [self.navigationController pushViewController:brandSelect animated:YES];
}

#pragma mark- 选择地址
- (void)gotoAddressCtrWithIndex:(NSInteger)index {
    
    //根据index获取对应的数据模型
    CYTAddressDataWNCManager *addressManager = (self.viewModel.addressIndex==0)?self.viewModel.sendManager:self.viewModel.receiveManager;
    if (!addressManager) {
        addressManager =[CYTAddressDataWNCManager shareManager];
        [addressManager cleanAllModelCache];
        addressManager.showArea = NO;
        addressManager.titleString = @"城市选择";
        addressManager.type = AddressChooseTypeCounty;
    }
    
    CYTAddressChooseCommonVC *choose = [CYTAddressChooseCommonVC new];
    choose.viewModel = addressManager;
    [choose setChooseFinishedBlock:^(CYTAddressDataWNCManager *model) {
        //处理回调数据
        if (self.viewModel.addressIndex == 0) {
            self.viewModel.sendManager = model;
        }else {
            self.viewModel.receiveManager = model;
        }
        
        //数据处理
        CYTAddressModel *addressModel = [CYTAddressModel new];
        addressModel.provinceId = [NSString stringWithFormat:@"%ld",(long)model.addressModel.selectProvinceModel.idCode];
        addressModel.provinceName = model.addressModel.selectProvinceModel.name;
        addressModel.cityId = [NSString stringWithFormat:@"%ld",model.addressModel.selectCityModel.idCode];
        addressModel.cityName = model.addressModel.selectCityModel.name;
        if (model.addressModel.selectCountyModel) {
            addressModel.countyId = model.addressModel.selectCountyModel.idCode;
            addressModel.countyName = model.addressModel.selectCountyModel.name;
        }else {
            addressModel.countyId = -1;
            addressModel.countyName = @"";
        }
        
        //修改数据
        CYTLogisticsNeedWriteCellModel *itemModel = self.viewModel.cellModelArray[self.viewModel.addressIndex];
        itemModel.addressModel.mainAddress = [NSString stringWithFormat:@"%@ %@ %@",addressModel.provinceName,addressModel.cityName,addressModel.countyName];
        itemModel.addressModel.provinceId = addressModel.provinceId.integerValue;
        itemModel.addressModel.cityId = addressModel.cityId.integerValue;
        itemModel.addressModel.countyId = addressModel.countyId;
        itemModel.addressModel.detailAddress = @"";
        itemModel.select = YES;
        
        ///刷新table
        [self.mainView.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        
        //设置是否可提交
        self.bottomView.valid = self.viewModel.valid;
        
    }];
    [self.navigationController pushViewController:choose animated:YES];
    
}

#pragma mark- table reload
- (void)showReloadView {
    self.protocalView.hidden = YES;
    self.bottomView.hidden = YES;
    self.sectionNumber = 0;
    
    [self.mainView remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    
    [self.mainView autoReloadWithInterval:0 andMainViewModelBlock:^FFMainViewModel *{
        FFMainViewModel *model = [FFMainViewModel new];
        model.dataHasMore = NO;
        model.dataEmpty = YES;
        model.netEffective = NO;
        return model;
    }];
}

- (void)showTableView {
    self.protocalView.hidden = NO;
    self.bottomView.hidden = NO;
    self.sectionNumber = 3;
    
    [self.mainView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(0);
        make.bottom.equalTo(self.protocalView.top).offset(-CYTAutoLayoutV(20));
    }];
    
    [self.mainView autoReloadWithInterval:0 andMainViewModelBlock:^FFMainViewModel *{
        FFMainViewModel *model = [FFMainViewModel new];
        model.dataHasMore = NO;
        model.dataEmpty = NO;
        model.netEffective = YES;
        return model;
    }];
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
        [_mainView registerCellWithIdentifier:@[[CYTLogisticsNeedAddressCell identifier],
                                                [FFCell_Style_SimpleChoose identifier],
                                                [CYTLogisticsNeedWriteInputCell identifier],
                                                [CYTLogisticsNeedWriteDesCell identifier]]];
    }
    return _mainView;
}

- (CYTLogisticsNeedBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [CYTLogisticsNeedBottomView new];
        _bottomView.valid = NO;
        @weakify(self);
        [_bottomView setClickedBlock:^{
            @strongify(self);
            [self.viewModel.requestCommand execute:nil];
        }];
    }
    return _bottomView;
}

- (CYTLogisticsProtocalView *)protocalView {
    if (!_protocalView) {
        _protocalView = [CYTLogisticsProtocalView new];
        @weakify(self);
        [_protocalView setSelectBlock:^(BOOL agree) {
            @strongify(self);
            self.viewModel.agreeProtocal = agree;
            self.bottomView.valid = self.viewModel.valid;
        }];
        [_protocalView setAgreeProtocalBlock:^{
            @strongify(self);
            [self gotoProtocalView];
        }];
    }
    return _protocalView;
}

- (CYTLogisticsNeedWriteVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [CYTLogisticsNeedWriteVM new];
    }
    return _viewModel;
}

@end
