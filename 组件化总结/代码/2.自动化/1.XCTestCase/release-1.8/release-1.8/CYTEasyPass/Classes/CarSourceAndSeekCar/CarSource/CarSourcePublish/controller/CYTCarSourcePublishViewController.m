//
//  CYTCarSourcePublishViewController.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/25.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSourcePublishViewController.h"
#import "CYTSimpleBottomView.h"
#import "CYTUnenableSearchViewWithBorder.h"
#import "CYTCarSearchWithGuidePriceTableController.h"
#import "FFCell_Style_SimpleChoose.h"
#import "FFCell_Style_Input.h"
#import "CYTCarSourceTypeViewController.h"
#import "CYTGetColorViewController.h"
#import "CYTAddressChooseCommonVC.h"
#import "CYTPublishProcedureVC.h"
#import "CYTPublishProcedureVC.h"
#import "CYTArrivalDateVC.h"
#import "CYTCarSourcePublishCarBrandCell.h"
#import "CYTPublishRemarkVC.h"
#import "CYTCarSourcePriceInputView.h"
#import "CYTCarPublishSucceedController.h"
#import "CYTImageFileModel.h"
#import "CYTCarSourceAddImageViewController.h"
#import "CYTSelectImageModel.h"
#import "CYTUploadImageResult.h"
#import "CYTIndicatorView.h"
#import "CYTBrandSelectViewController.h"
#import "CYTImageHandelTool.h"
#import "CYTBrandSelectCarModel.h"
#import "CYTMultiImgeUploadTool.h"
#import "CYTCarSourceStatusCell.h"
#import "CYTMyYicheCoinViewController.h"

///车源类型
#define kSelectCarTypeAlert     (@"请选择车源类型")
///品牌车型
#define kSelectCarBrandAlert    (@"请选择品牌车型")


@interface CYTCarSourcePublishViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) CYTUnenableSearchViewWithBorder *searchView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CYTSimpleBottomView *bottomView;
@property (nonatomic, strong) CYTCarSourceTypeViewController *carTypeCtr;
@property (nonatomic, strong) CYTArrivalDateVC *arrivalDateCtr;
@property (nonatomic, strong) CYTCarSourcePriceInputView *priceInputView;
@property (nonatomic, strong) UITextField *priceTF;
@property (nonatomic, assign) BOOL dataSending;
/** 已添加图片数据 */
@property(strong, nonatomic) NSMutableArray<CYTSelectImageModel *> *selImageModels;

@end

@implementation CYTCarSourcePublishViewController

- (void)ff_bindViewModel {
    [super ff_bindViewModel];

    self.dataSending = NO;
    self.sideView.topOffset = 0;
    //清空上牌地区数据
    [[CYTAddressDataWNCManager shareManager] cleanAllModelCache];
    
    //loading
    [self.viewModel.hudSubject subscribeNext:^(id x) {
        if ([x integerValue] == 0) {
            [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
        }else {
            [CYTLoadingView hideLoadingView];
        }
    }];

    @weakify(self);
    //发布编辑后的需求
    [self.viewModel.editSaveCommond.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        if (self.viewModel.editSaveCommandResult.resultEffective) {
            [CYTToast successToastWithMessage:self.viewModel.editSaveCommandResult.resultMessage];
            //发布成功
            [[NSNotificationCenter defaultCenter] postNotificationName:kRefresh_CarSourceList object:nil];
            //发送通知,我的车源刷新
            [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshMyCarSourceKey object:nil];
            [self ff_leftClicked:nil];
            
        }else {
            //失败时候可以再次发送
            self.dataSending = NO;
            [CYTToast errorToastWithMessage:self.viewModel.editSaveCommandResult.resultMessage];
        }
    }];
    
    //发布需求
    [self.viewModel.requestCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
        @strongify(self);
        if (responseModel.resultEffective) {
            //发布成功
            [[NSNotificationCenter defaultCenter] postNotificationName:kRefresh_CarSourceList object:nil];
            
            CYTCarPublishSucceedController *succeed = [CYTCarPublishSucceedController new];
            succeed.ffobj = self.ffobj;
            succeed.idCode = self.viewModel.carSourceId;
            succeed.publishType = CYTPublishTypeCarsourcePublish;
            [self.navigationController pushViewController:succeed animated:YES];
            [self removeFromParentViewController];
            
        }else {
            //失败时候可以再次发送
            self.dataSending = NO;
            [CYTToast errorToastWithMessage:responseModel.resultMessage];
        }
    }];
    
    [self.viewModel.reloadSubject subscribeNext:^(id x) {
        @strongify(self);
        //刷新table
        self.priceInputView.guidePrice = self.viewModel.guidePrice;
        [self.tableView reloadData];
        [self updateBottomView];
    }];
    
    //编辑请求数据失败，返回编辑列表
    [self.viewModel.backSubject subscribeNext:^(id x) {
        @strongify(self);
        if ([x integerValue] == 1) {
            [self ff_leftClicked:nil];
        }
    }];
}

- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self.ffContentView addSubview:self.tableView];
    [self.ffContentView addSubview:self.bottomView];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(0);
        make.bottom.equalTo(self.bottomView.top);
    }];
    [self.bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo([CYTSimpleBottomView height]);
    }];
    
    [self.priceInputView showOnView:self.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *title = self.viewModel.editingState?@"编辑车源信息":@"发布车源";
    self.ffTitle = title;
    [CYTTools updateNavigationBarWithController:self showBackView:YES showLine:NO];
}

//有价格输入控件，禁用iqkeyboard------------>>>>
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
//<<<<----------------------------------------

- (void)ff_leftClicked:(FFNavigationItemView *)backView {
    [self.view endEditing:YES];
    if (self.viewModel.editingState) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if ([self.ffobj integerValue] == 1) {
        [FFCommonCode navigation:self.navigationController popControllerWithClassName:NSStringFromClass([CYTMyYicheCoinViewController class])];
    }else {
        //处理返回位置，不论何时返回到根部
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark- delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.listArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    FFSectionHeadView_style0 *header = [FFSectionHeadView_style0 new];
    header.ffMoreImageView.hidden = YES;
    header.moreLabelLeftAlig = YES;
    header.topOffset = CYTItemMarginV;
    if (section ==0) {
        header.ffServeNameLabel.text = @"必填项";
        header.ffMoreLabel.text = @"";
    }else {
        header.ffServeNameLabel.text = @"选填项";
        header.ffMoreLabel.text = @"（信息越完整，越有机会达成交易）";
    }
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CYTAutoLayoutV(100);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel.listArray[section] count];
}

#pragma mark - 自定义cell

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CYTCarSourcePublishItemModel *model = [self.viewModel.listArray[indexPath.section] objectAtIndex:indexPath.row];
    if (indexPath.section == 0) {
        if ([model.title isEqualToString:@"指导价"] ||[model.title isEqualToString:@"报价"] ) {
            return [self inputCell:model indexPath:indexPath];
        }else if([model.title isEqualToString:@"品牌车型"]) {
            return [self brandCell:model indexPath:indexPath];
        }else if ([model.title isEqualToString:@"车源状态"]){
            return [self carSourceWithTableView:tableView idexPath:indexPath];
        }else{
            return [self chooseCell:model indexPath:indexPath];
        }
    }else{
        return [self chooseCell:model indexPath:indexPath];
    }
}

- (FFCell_Style_Input *)inputCell:(CYTCarSourcePublishItemModel *)model indexPath:(NSIndexPath *)indexPath{
    FFCell_Style_Input *cell = [self.tableView dequeueReusableCellWithIdentifier:[FFCell_Style_Input identifier] forIndexPath:indexPath];
    cell.cellView.line.hidden = NO;
    cell.cellView.flagLabel.text = model.title;
    cell.cellView.textFiled.text = model.content;
    cell.cellView.textFiled.textColor = (model.select)?kFFColor_title_L2:kFFColor_title_L3;
    cell.cellView.assistantLabel.text = model.assistanceString;
    
    if ([model.title isEqualToString:@"报价"]) {
        //报价
        self.priceTF = cell.cellView.textFiled;
        self.priceTF.delegate = self;
        cell.cellView.textFiled.textColor = (model.select)?CYTRedColor:kFFColor_title_L3;
        cell.cellView.textFiled.userInteractionEnabled = YES;
    }else {
        //指导价
        cell.cellView.textFiled.textColor = (model.select)?kFFColor_title_L2:kFFColor_title_L3;
        cell.cellView.textFiled.userInteractionEnabled = NO;
    }
    
    cell.cellView.textFiled.keyboardType = UIKeyboardTypeDecimalPad;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CYTCarSourcePublishCarBrandCell *)brandCell:(CYTCarSourcePublishItemModel *)model indexPath:(NSIndexPath *)indexPath {
    CYTCarSourcePublishCarBrandCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[CYTCarSourcePublishCarBrandCell identifier] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.flagLab.text = model.title;
    cell.contentLab.textColor = (model.select)?kFFColor_title_L2:kFFColor_title_L3;
    [cell title:model.content subtitle:model.assistanceString placeholder:@"请选择"];
    cell.hideArrow = (self.viewModel.editingState);
    if (self.viewModel.editingState) {
        cell.contentLab.textColor = kFFColor_title_L3;
        cell.subTitleLab.textColor = kFFColor_title_L3;
    }
    return cell;
}

- (FFCell_Style_SimpleChoose *)chooseCell:(CYTCarSourcePublishItemModel *)model indexPath:(NSIndexPath *)indexPath{
    FFCell_Style_SimpleChoose *cell = [self.tableView dequeueReusableCellWithIdentifier:[FFCell_Style_SimpleChoose identifier] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellView.flagLabel.text = model.title;
    cell.cellView.contentLabel.text = (model.select)?model.content:model.placeholder;
    BOOL showArrow = YES;
    if (self.viewModel.editingState && indexPath.section == 0 && indexPath.row == 0) {
        showArrow = NO;
        cell.cellView.contentLabel.textColor = kFFColor_title_L3;
    }
    cell.cellView.leftMinWidth = CYTAutoLayoutH(170);
    //单独处理车源类型
    if (indexPath.section == 0 && indexPath.row == 1) {
        cell.cellView.showArrow = !model.hideArrow;
        if (self.viewModel.editingState) {
            cell.cellView.contentLabel.textColor = kFFColor_title_L3;
        }else{
            cell.cellView.contentLabel.textColor = (model.select)?kFFColor_title_L2:kFFColor_title_L3;
        }
    }else{
        cell.cellView.showArrow = showArrow;
        cell.cellView.contentLabel.textColor = (model.select)?kFFColor_title_L2:kFFColor_title_L3;
    }
    
    return cell;
}

/**
 *  车源状态
 */
- (CYTCarSourceStatusCell *)carSourceWithTableView:(UITableView *)tableView idexPath:(NSIndexPath *)indexPath{
    CYTCarSourceStatusCell *cell = [CYTCarSourceStatusCell celllForTableView:tableView indexPath:indexPath];
    cell.carSourcePublishItemModel = self.viewModel.necessaryArray[indexPath.row];
    @weakify(self);
    NSString *carSourceStatusTitle = @"到港日期";
    cell.carSourceStatusBlock = ^(CYTCarSourceStatus carSourceStatus) {
        @strongify(self);
        if (carSourceStatus == CYTCarSourceStatusSpot) {
            [self.viewModel removeNecessaryItemWithTitle:carSourceStatusTitle];
        }else{
            if (![self.viewModel containNecessaryItemWithTitle:carSourceStatusTitle]) {
                CYTCarSourcePublishItemModel *arriveDataModel = CYTCarSourcePublishItemModel.new;
                arriveDataModel.title = carSourceStatusTitle;
                [self.viewModel addNecessaryItemWithModel:arriveDataModel beforeTitle:@"报价"];
            }else{
                CYTCarSourcePublishItemModel *arriveDataModel = [self.viewModel necessaryItemModelWithTitle:carSourceStatusTitle];
                arriveDataModel.content = @"";
            }
        }
        [self.tableView reloadDataAtSection:0 animation:YES];
        [self updateBottomView];
        
    };
    return cell;
}

#pragma mark - cell的点击

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
    
    CYTCarSourcePublishItemModel *model = [self.viewModel.listArray[indexPath.section] objectAtIndex:indexPath.row];
    if (indexPath.section == 0) {
        [self necessoryWithTitle:model.title];
    }else if (indexPath.section == 1) {
        [self unnecessoryWithIndex:indexPath.row];
    }
}

#pragma mark- 必选
- (void)necessoryWithTitle:(NSString *)title{
    if ([title isEqualToString:@"品牌车型"]) {
        if (self.viewModel.editingState) {
            return;
        }
        //选择车型
        [self selectCarMethod];
    }else if ([title isEqualToString:@"车源类型"]) {
        if (self.viewModel.editingState) {
            return;
        }
        [self selectCarTypWithTitle:title];
    }else if ([title isEqualToString:@"颜色"]) {
        //选择颜色
        if (self.viewModel.selectCarBrand) {
            [self selectColorMethod];
        }else {
            [CYTToast messageToastWithMessage:kSelectCarBrandAlert];
        }
    }else if ([title isEqualToString:@"到港日期"]) {
        //到港日期
        [self arrivalDateMethod];
    }else if ([title isEqualToString:@"车源地"]) {
        //车原地
        [self carSourceLocation];
    }
}

///选择车源类型
- (void)selectCarTypWithTitle:(NSString *)title{
    CYTCarSourcePublishItemModel *model = [self.viewModel necessaryItemModelWithTitle:title];
    if (model.hideArrow)return;
    [MobClick event:@"CYFB_LXXZ"];
    self.sideView.contentController = self.carTypeCtr;
    self.carTypeCtr.indexPath = self.viewModel.carSourceTypeIndexPath;
    [self showSideView];
}
///选择品牌车型
- (void)selectCarMethod {
    CYTBrandSelectViewController *brandSelect = [CYTBrandSelectViewController new];
    __weak typeof(self)bself = self;
    brandSelect.ffobj = bself;
    brandSelect.viewModel.type = CYTBrandSelectTypeCar;
    brandSelect.viewModel.brandResultModel = [self.viewModel.brandSelectModel copy];
    @weakify(self);
    [brandSelect setBrandSelectBlock:^(CYTBrandSelectResultModel *brandModel) {
        @strongify(self);
        [self.viewModel handleCarBrandData:brandModel];
        //获取指导价
        self.priceInputView.guidePrice = self.viewModel.guidePrice;
        //刷新
        [self.tableView reloadData];
        [self updateBottomView];
        
    }];
    
    [self.navigationController pushViewController:brandSelect animated:YES];
}

//内饰颜色
- (void)carColorINNotification:(NSNotification *)notification {
    if ([notification.object isKindOfClass:[NSMutableArray class]]) {
        NSArray *tmp = [CYTGetColorBasicVM colorArray:[notification.object copy] withType:CarColorTypeColorAll];
        self.viewModel.inColorArray = tmp;
    }
}

//外观颜色
- (void)carColorEXNotification:(NSNotification *)notification {
    if ([notification.object isKindOfClass:[NSMutableArray class]]) {
        NSArray *tmp = [CYTGetColorBasicVM colorArray:[notification.object copy] withType:CarColorTypeColorAll];
        self.viewModel.exColorArray = tmp;
    }
}

///选择内饰外观颜色
- (void)selectColorMethod {
    CYTGetColorViewController *getColorCtr = [CYTGetColorViewController new];
    getColorCtr.viewModel.inColorArray = self.viewModel.inColorArray;
    getColorCtr.viewModel.exColorArray = self.viewModel.exColorArray;
    CYTCarSourcePublishItemModel *colorItem = [self.viewModel necessaryItemModelWithTitle:@"颜色"];
    getColorCtr.viewModel.inColorSel = colorItem.inColorSel;
    getColorCtr.viewModel.exColorSel = colorItem.exColorSel;
    
    getColorCtr.parentCtr = self;
    @weakify(self);
    [getColorCtr setGetColorFinishedBlock:^(CYTGetColorBasicVM *colorVM) {
        @strongify(self);
        CYTCarSourcePublishItemModel *itemModel = [self.viewModel necessaryItemModelWithTitle:@"颜色"];
        itemModel.inColorSel = colorVM.inColorSel;
        itemModel.exColorSel = colorVM.exColorSel;
        itemModel.select = YES;
        itemModel.content = self.viewModel.colorString;
        self.viewModel.haveEdit = YES;
        [self.tableView reloadData];
        [self updateBottomView];
    }];
    [self.navigationController pushViewController:getColorCtr animated:YES];
}

- (void)arrivalDateMethod {
    self.sideView.contentController = self.arrivalDateCtr;
    [self.sideView showHalfView];
    [self.arrivalDateCtr showView];
}

- (void)carSourceLocation {
    CYTCarSourcePublishItemModel *itemModel = [self.viewModel necessaryItemModelWithTitle:@"车源地"];
    CYTAddressDataWNCManager *vm = itemModel.carSourceLocationModel;
    if (!vm) {
        vm = [CYTAddressDataWNCManager shareManager];
        [vm cleanAllModelCache];
        vm.showArea = YES;
        vm.type = AddressChooseTypeProvince;
        vm.titleString = @"车源所在地";
    }
    
    CYTAddressChooseCommonVC *chooseCtr = [CYTAddressChooseCommonVC new];
    chooseCtr.viewModel = vm;
    
    @weakify(self);
    [chooseCtr setChooseFinishedBlock:^(CYTAddressDataWNCManager *model) {
        @strongify(self);
        itemModel.carSourceLocationModel = model;
        itemModel.select = YES;
        itemModel.content = self.viewModel.carSourceLocationString;
        self.viewModel.haveEdit = YES;
        [self.tableView reloadData];
        [self updateBottomView];
    }];
    [self.navigationController pushViewController:chooseCtr animated:YES];
}

#pragma mark- 非必选
- (void)unnecessoryWithIndex:(NSInteger)index{
    
    CYTCarSourcePublishItemModel *itemModel = self.viewModel.inecessaryArray[index];
    if (index == 0) {
        //配置
        [self configCtrWithModel:itemModel];
    }else if (index == 1) {
        //手续
        [self procedureCtrWithModel:itemModel];
    }else if (index == 2) {
        //可售区域
        [self soldAreaCtrWithModel:itemModel];
    }else if (index == 3) {
        //图片
        [self imageCtrWithModel:itemModel];
    }else {
        //备注
        [self remarkWithModel:itemModel];
    }
}

- (void)configCtrWithModel:(CYTCarSourcePublishItemModel *)model {
    CYTPublishRemarkVC *config = [CYTPublishRemarkVC new];
    config.titleString = @"配置";
    config.placeholder = config.configPlaceholder;
    config.content = model.content;
    @weakify(self);
    [config setConfigBlock:^(NSString *string) {
        @strongify(self);
        model.content = string;
        model.select = (string.length !=0);
        self.viewModel.haveEdit = YES;
        [self.tableView reloadData];
        [self updateBottomView];
    }];
    
    [self.navigationController pushViewController:config animated:YES];
}

///手续
- (void)procedureCtrWithModel:(CYTCarSourcePublishItemModel *)model {
    CYTPublishProcedureVC *procedure = [CYTPublishProcedureVC new];
    procedure.viewModel.content = model.content;
    @weakify(self);
    [procedure setProcedureBlock:^(NSString *string) {
        @strongify(self);
        model.content = string;
        model.select = (string.length !=0);
        self.viewModel.haveEdit = YES;
        [self.tableView reloadData];
        [self updateBottomView];
    }];
    [self.navigationController pushViewController:procedure animated:YES];
}

- (void)soldAreaCtrWithModel:(CYTCarSourcePublishItemModel *)model {
    CYTPublishRemarkVC *avaliable = [CYTPublishRemarkVC new];
    avaliable.titleString = @"可售区域";
    avaliable.placeholder = avaliable.avaliableAreaPlaceholder;
    avaliable.content = model.content;
    @weakify(self);
    [avaliable setConfigBlock:^(NSString *string) {
        @strongify(self);
        model.content = string;
        model.select = (string.length !=0);
        self.viewModel.haveEdit = YES;
        [self.tableView reloadData];
        [self updateBottomView];
    }];
    [self.navigationController pushViewController:avaliable animated:YES];
}

- (void)imageCtrWithModel:(CYTCarSourcePublishItemModel *)model {
    @weakify(self);
    CYTCarSourceAddImageViewController *addImageVC = [[CYTCarSourceAddImageViewController alloc] init];
    addImageVC.albumModels = [model.imageArray mutableCopy];
    
    addImageVC.completion = ^(NSMutableArray<UIImage *> *images, NSMutableArray<NSData *> *imageDatas, NSMutableArray<CYTSelectImageModel *> *imageModels) {
        @strongify(self);
        //上传方法
        self.selImageModels = imageModels;
        //更改数据
        model.imageArray = [imageModels mutableCopy];
        model.select = (imageModels.count==0)?NO:YES;
        model.content = [NSString stringWithFormat:@"%ld张",imageModels.count];
        [self.viewModel.inecessaryArray replaceObjectAtIndex:3 withObject:model];
        self.viewModel.haveEdit = YES;
        [self.tableView reloadData];
        [self updateBottomView];
     };
    [self.navigationController pushViewController:addImageVC animated:YES];
}

- (void)remarkWithModel:(CYTCarSourcePublishItemModel *)model {
    CYTPublishRemarkVC *remark = [CYTPublishRemarkVC new];
    remark.titleString = @"备注";
    remark.placeholder = remark.remarkPlaceholder;
    remark.content = model.content;
    @weakify(self);
    [remark setConfigBlock:^(NSString *string) {
        @strongify(self);
        model.content = string;
        model.select = (string.length !=0);
        self.viewModel.haveEdit = YES;
        [self.tableView reloadData];
        [self updateBottomView];
    }];
    [self.navigationController pushViewController:remark animated:YES];
}

#pragma mark- 刷新table

- (void)updateBottomView {
    self.bottomView.enable = [self.viewModel canSubmit];
}

#pragma mark- delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    //如果选择了车型则有效
    if (self.viewModel.selectCarBrand) {
        self.priceInputView.guidePrice = self.viewModel.guidePrice;
        self.priceInputView.effective = YES;
        return YES;
    }else {
        [CYTToast messageToastWithMessage:kSelectCarBrandAlert];
        return NO;
    }
}
#pragma mark- get
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        
        self.searchView.frame = CGRectMake(0, 0, kScreenWidth, CYTAutoLayoutV(86));
        if (!self.viewModel.editingState) {
            _tableView.tableHeaderView = self.searchView;
        }
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 50;
        [_tableView registerClass:[FFCell_Style_SimpleChoose class] forCellReuseIdentifier:[FFCell_Style_SimpleChoose identifier]];
        [_tableView registerClass:[FFCell_Style_Input class] forCellReuseIdentifier:[FFCell_Style_Input identifier]];
        [_tableView registerClass:[CYTCarSourcePublishCarBrandCell class] forCellReuseIdentifier:[CYTCarSourcePublishCarBrandCell identifier]];
        
        _tableView.ffBgColor = kFFColor_bg_nor;
    }
    return _tableView;
}

- (CYTUnenableSearchViewWithBorder *)searchView {
    if (!_searchView) {
        _searchView = [CYTUnenableSearchViewWithBorder new];
        _searchView.searchView.textField.placeholder = @"输入指导价格直接导入选择车型";
        _searchView.searchView.canFillText = NO;
        @weakify(self);
        [_searchView setSearchBlock:^{
            @strongify(self);
            
            CYTCarSearchWithGuidePriceTableController *search = [CYTCarSearchWithGuidePriceTableController new];
            search.viewModel.searchString = [self.searchView.searchView.textField.text copy];
            @weakify(self);
            [search setSelectBlock:^(CYTStockCarModel *model) {
                @strongify(self);
                [MobClick event:@"CYFB_ZDJDR"];
                [self.viewModel handleSearchModel:model];
                [self.searchView.searchView moveLeft];
                self.searchView.searchView.textField.text = model.searchString;
                [self.tableView reloadDataAtSection:0 animation:YES];
            }];
            [self.navigationController pushViewController:search animated:YES];
        }];
    }
    return _searchView;
}

- (CYTSimpleBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [CYTSimpleBottomView new];
        _bottomView.title = (self.viewModel.editingState)?@"保存发布":@"发布车源";
        @weakify(self);
        [_bottomView setClickBlock:^{
            @strongify(self);
//            //先判断是否正在上传，如果正在上传则无操作
//            if (self.dataSending) {
//                return ;
//            }
//            self.dataSending = YES;
            //否则开始上传图片 //图片上传成功后提交网络请求
            [self commitCarSourceWithImageDatas:self.selImageModels];
            
        }];
        _bottomView.enable = NO;
    }
    return _bottomView;
}

- (CYTCarSourcePublishVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [CYTCarSourcePublishVM new];
    }
    return _viewModel;
}

- (CYTCarSourceTypeViewController *)carTypeCtr {
    if (!_carTypeCtr) {
        _carTypeCtr = [CYTCarSourceTypeViewController new];
        _carTypeCtr.parallelImportCar = YES;
        _carTypeCtr.indexPath = self.viewModel.carSourceTypeIndexPath;
        
        @weakify(self);
        [_carTypeCtr setSelectBlock:^(CYTCarSourceTypeModel *model) {
            @strongify(self);
            [self.sideView hideHalfView];
            [self.viewModel handleCarSourceData:model];
            //刷新
            [self.tableView reloadDataAtSection:0 animation:YES];
            [self updateBottomView];
            
        }];
    }
    return _carTypeCtr;
}

- (CYTArrivalDateVC *)arrivalDateCtr {
    if (!_arrivalDateCtr) {
        _arrivalDateCtr = [CYTArrivalDateVC new];
        @weakify(self);
        [_arrivalDateCtr setSelectModelBlock:^(CYTArrivalDateItemModel *model) {
            @strongify(self);
            [self.sideView hideHalfView];
            CYTCarSourcePublishItemModel *itemModel = [self.viewModel necessaryItemModelWithTitle:@"到港日期"];
            itemModel.arrivalModel = model;
            itemModel.select = YES;
            itemModel.content = self.viewModel.arrivalDateString;
            //刷新
            [self.tableView reloadData];
            [self updateBottomView];
        }];
    }
    return _arrivalDateCtr;
}

- (CYTCarSourcePriceInputView *)priceInputView {
    if (!_priceInputView) {
        _priceInputView = [CYTCarSourcePriceInputView new];
        @weakify(self);
        [_priceInputView setCancelBlock:^{
            @strongify(self);
            [self.view endEditing:YES];
            
        }];
        [_priceInputView setAffirmBlock:^(NSInteger index, NSString *value, NSString *resultString) {
            @strongify(self);
            [self.view endEditing:YES];
            [self.viewModel handlePriceWithMode:index andValue:value andResultString:resultString];
            self.viewModel.haveEdit = YES;
            [self.tableView reloadData];
            [self updateBottomView];
        }];
    }
    return _priceInputView;
}

#pragma mark - 上传图片并提交车源数据

- (void)commitCarSourceWithImageDatas:(NSMutableArray<CYTSelectImageModel *> *)imageModels{
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
    [CYTImageHandelTool handelImageWithImageModels:imageModels complation:^(NSArray *imageDatas) {
        [[CYTMultiImgeUploadTool new] uploadImagesWithImageDatas:imageDatas completion:^(NSArray<NSString *> *imageFileIds) {
            CYTCarSourcePublishItemModel *imageItemModel = [self.viewModel.inecessaryArray objectAtIndex:3];
            if (imageFileIds.count) {
                imageItemModel.fileIdImageArray = imageFileIds.mutableCopy;
            }
            dispatch_group_leave(group);
        }];
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //提交车源数据
        if (self.viewModel.editingState) {
            [self.viewModel.editSaveCommond execute:nil];
        }else {
            [self.viewModel.requestCommand execute:nil];
        }
    });
}

@end
