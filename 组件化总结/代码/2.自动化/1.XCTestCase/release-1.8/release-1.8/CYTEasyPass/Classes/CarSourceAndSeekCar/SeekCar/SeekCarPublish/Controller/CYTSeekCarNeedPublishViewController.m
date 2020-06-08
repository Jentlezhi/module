//
//  CYTSeekCarNeedPublishViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTSeekCarNeedPublishViewController.h"
#import "CYTUnenableSearchViewWithBorder.h"
#import "CYTCarSearchWithGuidePriceTableController.h"
#import "CYTSeekCarPublishModel.h"
#import "CYTSeekCarPublishItemModel.h"
#import "CYTCarSourceTypeViewController.h"
#import "CYTCarSourceTypeModel.h"
#import "CYTseekCarPublishParameters.h"
#import "CYTGetColorViewController.h"
#import "CYTGetColorBasicVM.h"
#import "CYTAddressChooseCommonVC.h"
#import "CYTPublishRemarkVC.h"
#import "CYTPublishProcedureVC.h"
#import "CYTAddressListViewController.h"
#import "CYTAddressModel.h"
#import "CYTCarPublishSucceedController.h"
#import "CYTSeekCarDetailModel.h"
#import "CYTCarSourceTypeModel.h"
#import "CYTBrandSelectViewController.h"
#import "CYTSeekCarDetailParameters.h"
#import "CYTSeekCarNeedPublishCell.h"
#import "CYTMyYicheCoinViewController.h"

typedef enum : NSUInteger {
    CYTSeekCarNeedPublisItemTypeNessary = 0,
    CYTSeekCarNeedPublisItemTypeUnnessary,
    CYTSeekCarNeedPublisItemTypeBrand = 0,
    CYTSeekCarNeedPublisItemTypeCarSource,
    CYTSeekCarNeedPublisItemTypeGuidePrice,
    CYTSeekCarNeedPublisItemTypeColor,
    CYTSeekCarNeedPublisItemTypeBoardArera,
    CYTSeekCarNeedPublisItemTypeReceiveCarAddress,
    CYTSeekCarNeedPublisItemTypeConfiguration = 0,
    CYTSeekCarNeedPublisItemTypeProcedure,
    CYTSeekCarNeedPublisItemTypeMark,
} CYTSeekCarNeedPublisItemType;

@interface CYTSeekCarNeedPublishViewController ()<UITableViewDataSource,UITableViewDelegate>

/** 发布需求表格 */
@property(strong, nonatomic) UITableView *publishNeedTableView;
/** 搜索框 */
@property(strong, nonatomic) CYTUnenableSearchViewWithBorder *searchView;
/** 数据源 */
@property(strong, nonatomic) NSArray *publishNeedItems;
/** 车源类型控制器 */
@property(strong, nonatomic) CYTCarSourceTypeViewController *carTypeCtr;
/** 当前页面已选择item */
@property(strong, nonatomic) NSIndexPath *itemSelectedIndexPath;
/** 车源已选择item */
@property(strong, nonatomic) NSIndexPath *carSourceSelectedIndexPath;
/** 发布寻车请求参数 */
@property(strong, nonatomic) CYTSeekCarPublishParameters *seekCarPublishParameters;
/** 发布寻车请求参数 */
@property(strong, nonatomic) CYTSeekCarPublishParameters *seekCarPublishTempParameters;
/** 车款外观颜色 */
@property(strong, nonatomic) NSArray *inColorArray;
/** 车款内饰颜色 */
@property(strong, nonatomic) NSArray *exColorArray;
/** 已选择颜色等模型 */
@property(strong, nonatomic) CYTGetColorBasicVM *colorVM;
/** 已选择接车地址模型 */
@property(strong, nonatomic) CYTAddressModel *hasSelectedAddressModel;
/** 发布按钮 */
@property(weak, nonatomic) UIButton *seekCarPublishBtn;
///车源类型
@property(strong, nonatomic) CYTCarSourceTypeModel *carSourceModel;
///保存品牌车型选择的数据模型用于回显
@property (nonatomic, strong) CYTBrandSelectResultModel *brandSelectModel;

@end

@implementation CYTSeekCarNeedPublishViewController

- (UITableView *)publishNeedTableView{
    if (!_publishNeedTableView) {
        CGRect frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - CYTViewOriginY);
        _publishNeedTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        if (@available(iOS 11.0, *)) {
            _publishNeedTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _publishNeedTableView.estimatedSectionFooterHeight = 0;
            _publishNeedTableView.estimatedSectionHeaderHeight = 0;
        }
    }
    return _publishNeedTableView;
}

- (CYTUnenableSearchViewWithBorder *)searchView {
    if (!_searchView) {
        CYTWeakSelf
        _searchView = [CYTUnenableSearchViewWithBorder new];
        _searchView.searchView.textField.placeholder = @"输入指导价格直接导入选择车型";
        _searchView.searchView.canFillText = NO;
        [_searchView setSearchBlock:^{
            CYTCarSearchWithGuidePriceTableController *search = [CYTCarSearchWithGuidePriceTableController new];
            search.selectBlock = ^(CYTStockCarModel *model){
                [MobClick event:@"XCFB_ZDJSR"];
                [weakSelf.searchView.searchView moveLeft];
                weakSelf.searchView.searchView.textField.text = model.searchString;
                //车源类型和品牌车型 数据回调
                //更新数据
                [weakSelf updateSearchDataWithModel:model];
                
            };
            [weakSelf.navigationController pushViewController:search animated:YES];
        }];
    }
    return _searchView;
}
/**
 *  更新车源类型、品牌类型、指导价
 */
- (void)updateSearchDataWithModel:(CYTStockCarModel *)model{
    
    CYTWeakSelf
    NSIndexPath *brandTypeModelIdx = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *carSourceTypeModelIdx = [NSIndexPath indexPathForRow:1 inSection:0];
    NSIndexPath *guidePriceModelIdx = [NSIndexPath indexPathForRow:2 inSection:0];
    CYTSeekCarPublishItemModel *carSourceTypeModel = [weakSelf itemModelWithIndexPath:carSourceTypeModelIdx];
    CYTSeekCarPublishItemModel *brandTypeModel = [weakSelf itemModelWithIndexPath:brandTypeModelIdx];
    CYTSeekCarPublishItemModel *guidePriceModel = [weakSelf itemModelWithIndexPath:guidePriceModelIdx];
    
    carSourceTypeModel.content = model.carSourceTypeName;
    brandTypeModel.content = model.serialName;
    brandTypeModel.assistanceString = [NSString stringWithFormat:@"%ld %@",model.carYearType,model.carName];
    guidePriceModel.content = [NSString stringWithFormat:@"%@万元",model.carReferPrice];
    
    //请求参数的赋值
    self.seekCarPublishTempParameters.goodsType = [NSString stringWithFormat:@"%ld",model.carSourceTypeId];
    self.seekCarPublishTempParameters.brandId = [NSString stringWithFormat:@"%ld",model.brandId];
    self.seekCarPublishTempParameters.carId = [NSString stringWithFormat:@"%ld",model.carId];
    self.seekCarPublishTempParameters.serialId = [NSString stringWithFormat:@"%ld",model.serialId];
    
    self.seekCarPublishParameters = self.seekCarPublishTempParameters;
    
    //获取品牌和颜色数据
    CYTCarSourceTypeModel *typeModel = [[CYTCarSourceTypeModel alloc] init];
    typeModel.carSourceTypeId = model.carSourceTypeId;
    typeModel.carSourceTypeName = model.carSourceTypeName;
    [weakSelf requestColorWithSerialId:model.serialId];
    
    //清空数据
    NSIndexPath *colorModelIdx = [NSIndexPath indexPathForRow:3 inSection:0];
    NSIndexPath *boardAreraModelIdx = [NSIndexPath indexPathForRow:4 inSection:0];
    NSIndexPath *receiveCarAddressModelIdx = [NSIndexPath indexPathForRow:5 inSection:0];
    CYTSeekCarPublishItemModel *colorModel = [self itemModelWithIndexPath:colorModelIdx];
    CYTSeekCarPublishItemModel *boardAreraModel = [self itemModelWithIndexPath:boardAreraModelIdx];
    CYTSeekCarPublishItemModel *receiveCarAddressModel = [self itemModelWithIndexPath:receiveCarAddressModelIdx];
    
    colorModel.content = @"";
    colorModel.select = NO;
    weakSelf.seekCarPublishTempParameters.exteriorColor = @"";
    weakSelf.seekCarPublishTempParameters.interiorColor = @"";;
    
    boardAreraModel.content = @"";
    boardAreraModel.select = NO;
    weakSelf.seekCarPublishTempParameters.registCardCity = @"";
    
    
    receiveCarAddressModel.content = @"";
    receiveCarAddressModel.select = NO;
    weakSelf.seekCarPublishTempParameters.receivingId = @"";
    
    //清空回显
    #warning TODO:message
    self.colorVM.inColorSel = self.colorVM.exColorSel = nil;
    self.hasSelectedAddressModel = nil;
    
    //参数赋值
    weakSelf.seekCarPublishParameters = weakSelf.seekCarPublishTempParameters;
    
    
    [self.publishNeedTableView reloadDataAtSection:0 animation:YES];
}

- (NSArray *)publishNeedItems{
    if (!_publishNeedItems) {
        _publishNeedItems = [NSArray array];
        NSMutableArray *temp = [NSMutableArray array];
        for (NSUInteger index = 0; index<2; index++) {
            CYTSeekCarPublishModel *carPublishModel = [[CYTSeekCarPublishModel alloc] init];
            if (index == 0) {
                carPublishModel.sectionTitle = @"必填项";
                carPublishModel.subSectionTitle = @"";
                NSArray *nessaryTitles = @[@"品牌车型",@"车源类型",@"指导价",@"颜色",@"上牌地区",@"收车地址"];
                NSMutableArray *itemModels = [NSMutableArray array];
                NSInteger titleTotalCount = nessaryTitles.count;
                for (NSInteger index = 0; index<titleTotalCount; index++) {
                    CYTSeekCarPublishItemModel *itemModel = [[CYTSeekCarPublishItemModel alloc] init];
                    itemModel.title = nessaryTitles[index];
                    itemModel.placeholder = @"请选择";
                    //默认车源类型和指导价：隐藏箭头和holder
                    if (index == 1 || index == 2) {
                        itemModel.hideArrow = YES;
                        itemModel.placeholder = @"";
                    }
//                    else{
//                        itemModel.hideArrow = self.seekCarNeedPublishType == CYTSeekCarNeedPublishTypeEdit?NO:NO;
//                    }
                    [itemModels addObject:itemModel];
                }
                [carPublishModel.seekCarPublishItems addObjectsFromArray:itemModels];
            }else{
                carPublishModel.sectionTitle = @"选填项";
                carPublishModel.subSectionTitle = @"（信息越完整，越有机会达成交易）";
                NSArray *unnessaryTitles = @[@"配置",@"手续",@"备注"];
                NSMutableArray *itemModels = [NSMutableArray array];
                for (NSUInteger index = 0; index<unnessaryTitles.count; index++) {
                    NSString *unnessaryTitle = unnessaryTitles[index];
                    CYTSeekCarPublishItemModel *itemModel = [[CYTSeekCarPublishItemModel alloc] init];
                    itemModel.title = unnessaryTitle;
                    itemModel.placeholder = index==1?@"请选择":@"请填写";
                    [itemModels addObject:itemModel];
                }
                [carPublishModel.seekCarPublishItems addObjectsFromArray:itemModels];
                
            }
            [temp addObject:carPublishModel];
        }
        _publishNeedItems = [temp copy];
    }
    
    return _publishNeedItems;
}

- (CYTCarSourceTypeViewController *)carTypeCtr {
    if (!_carTypeCtr) {
        _carTypeCtr = [CYTCarSourceTypeViewController new];
        _carTypeCtr.parallelImportCar = YES;
        CYTWeakSelf
        [_carTypeCtr setSelectBlock:^(CYTCarSourceTypeModel *model) {
            //清空数据
            weakSelf.carSourceModel = model;
            weakSelf.seekCarPublishTempParameters.goodsType = [NSString stringWithFormat:@"%ld",model.carSourceTypeId];
            weakSelf.seekCarPublishParameters =  weakSelf.seekCarPublishTempParameters;
            [weakSelf updateCardataSourceWithModel:model];
            [weakSelf.sideView hideHalfView];
        }];
    }
    return _carTypeCtr;
}

- (NSArray *)exColorArray{
    if (!_exColorArray) {
        _exColorArray = [NSArray array];
    }
    return _exColorArray;
}

- (NSArray *)inColorArray{
    if (!_inColorArray) {
        _inColorArray = [NSArray array];
    }
    return _inColorArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self seekCarNeedPublishBasicConfig];
    [self configSeekCarNeedPublishTableView];
    [self initSeekCarNeedPublishComponents];
}
/**
 *  基本配置
 */
- (void)seekCarNeedPublishBasicConfig{
    self.view.backgroundColor = CYTLightGrayColor;
    NSString *title = [NSString string];
    if (self.seekCarNeedPublishType == CYTSeekCarNeedPublishTypeDefault) {
        title = @"发布寻车需求";
    }else{
        title = @"编辑寻车信息";
    }
    self.ffTitle = title;
    [CYTTools updateNavigationBarWithController:self showBackView:YES showLine:NO];
    
    //请求参数的初始化
    self.seekCarPublishTempParameters = [[CYTSeekCarPublishParameters alloc] init];
    self.seekCarPublishParameters = self.seekCarPublishTempParameters;
    //侧边顶部距离设置
    self.sideView.topOffset = 0;
    
    //清空上牌地区数据
    [[CYTAddressDataWNCManager shareManager] cleanAllModelCache];
}
/**
 *  配置表格
 */
- (void)configSeekCarNeedPublishTableView{
    self.publishNeedTableView.backgroundColor = CYTLightGrayColor;
    self.publishNeedTableView.delegate = self;
    self.publishNeedTableView.dataSource = self;
    self.publishNeedTableView.tableFooterView = [[UIView alloc] init];
    self.publishNeedTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.publishNeedTableView.estimatedRowHeight = CYTAutoLayoutV(100);
    self.publishNeedTableView.rowHeight = UITableViewAutomaticDimension;
    self.publishNeedTableView.contentInset = UIEdgeInsetsMake(0, 0, CYTAutoLayoutV(80+30+20), 0);
    [self.ffContentView addSubview:self.publishNeedTableView];
}
/**
 *  初始化子控件
 */
- (void)initSeekCarNeedPublishComponents{
    
    NSString *bottomBtnTitle = [NSString string];
    
    //搜索
    self.searchView.frame = CGRectMake(0, 0, kScreenWidth, CYTAutoLayoutV(86));
    if (self.seekCarNeedPublishType == CYTSeekCarNeedPublishTypeDefault) {
        self.publishNeedTableView.tableHeaderView = self.searchView;
        bottomBtnTitle = @"发布寻车";
    }else{
        bottomBtnTitle = @"保存发布";
    }
    //发布寻车
    UIButton *seekCarPublishBtn = [UIButton buttonWithTitle:bottomBtnTitle enabled:NO];
    [self.ffContentView addSubview:seekCarPublishBtn];
    _seekCarPublishBtn = seekCarPublishBtn;
    //布局
    [seekCarPublishBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(CYTMarginH);
        make.right.equalTo(self.view).offset(-CYTMarginH);
        make.bottom.equalTo(self.view).offset(-CYTMarginV);
        make.height.equalTo(CYTAutoLayoutV(80.f));
    }];
    CYTWeakSelf
    //点击的实现
    [[seekCarPublishBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        _seekCarPublishBtn.enabled = NO;
        NSString *requestUrl = [NSString string];
        if (weakSelf.seekCarNeedPublishType == CYTSeekCarNeedPublishTypeDefault) {
            requestUrl = kURL.car_seek_add;
        }else{
            requestUrl = kURL.car_seek_modify;
        }
        
        [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
        [CYTNetworkManager POST:requestUrl parameters:weakSelf.seekCarPublishParameters.mj_keyValues dataTask:nil showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
            [CYTLoadingView hideLoadingView];
            if (responseObject.resultEffective) {
                if (weakSelf.seekCarNeedPublishType == CYTSeekCarNeedPublishTypeDefault) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kRefresh_FindCarList object:nil];
                    CYTCarPublishSucceedController *publishSuccessVC = [[CYTCarPublishSucceedController alloc] init];
                    publishSuccessVC.ffobj = self.ffobj;
                    publishSuccessVC.publishType = CYTPublishTypeSeekCarPublish;
                    publishSuccessVC.idCode = [responseObject.dataDictionary[@"seekCarId"] integerValue];
                    [weakSelf.navigationController pushViewController:publishSuccessVC animated:YES];
                    [weakSelf removeFromParentViewController];
                }else{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshMySeekCarKey object:nil];
                }
            }else {
                _seekCarPublishBtn.enabled = YES;
            }
        }];
    }];
}

- (void)ff_leftClicked:(FFNavigationItemView *)backView {
    if ([self.ffobj integerValue] == 1) {
        [FFCommonCode navigation:self.navigationController popControllerWithClassName:NSStringFromClass([CYTMyYicheCoinViewController class])];
        return;
    }
    
    if (self.seekCarNeedPublishType == CYTSeekCarNeedPublishTypeEdit) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.publishNeedItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CYTSeekCarPublishModel *seekCarPublishModel = self.publishNeedItems[section];
    return seekCarPublishModel.seekCarPublishItems.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTSeekCarPublishModel *seekCarPublishModel = self.publishNeedItems[indexPath.section];
    CYTSeekCarPublishItemModel *itemModel = seekCarPublishModel.seekCarPublishItems[indexPath.row];
    CYTSeekCarNeedPublishCell *cell = [CYTSeekCarNeedPublishCell celllForTableView:tableView indexPath:indexPath];
    cell.seekCarPublishItemModel  = itemModel;
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    FFSectionHeadView_style0 *header = [FFSectionHeadView_style0 new];
    header.ffMoreImageView.hidden = YES;
    header.moreLabelLeftAlig = YES;
    header.topOffset = CYTItemMarginV;
    CYTSeekCarPublishModel *publishModel = self.publishNeedItems[section];
    header.ffServeNameLabel.text = publishModel.sectionTitle;
    header.ffMoreLabel.text = publishModel.subSectionTitle;
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CYTAutoLayoutV(100);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self didSelectRowWithIndexPath:indexPath];

}
/**
 * item的点击
 */
- (void)didSelectRowWithIndexPath:(NSIndexPath *)indexPath{
    CYTSeekCarPublishItemModel *seekCarPublishItemModel = [self itemModelWithIndexPath:indexPath];
    self.itemSelectedIndexPath = indexPath;
    switch (indexPath.section) {
        case CYTSeekCarNeedPublisItemTypeNessary :
        {
            switch (indexPath.row) {
                case CYTSeekCarNeedPublisItemTypeBrand:
                    seekCarPublishItemModel.hideArrow?:[self brandTypeSelect];
                    break;
                case CYTSeekCarNeedPublisItemTypeCarSource:
                    seekCarPublishItemModel.hideArrow?:[self carSourceTypeSelect];
                    break;
                case CYTSeekCarNeedPublisItemTypeColor:
                    [self colorSelect];
                    break;
                case CYTSeekCarNeedPublisItemTypeBoardArera:
                    [self boardAreraSelect];
                    break;
                case CYTSeekCarNeedPublisItemTypeReceiveCarAddress:
                    [self receiveCarAddressSelect];
                    break;
                    
            }
        }
            break;
        case CYTSeekCarNeedPublisItemTypeUnnessary :
        {
            switch (indexPath.row) {
                case CYTSeekCarNeedPublisItemTypeConfiguration:
                    [self configurationFillWithIndexPath:indexPath];
                    break;
                case CYTSeekCarNeedPublisItemTypeProcedure:
                    [self procedureSelectWithIndexPath:indexPath];
                    break;
                case CYTSeekCarNeedPublisItemTypeMark:
                    [self markFillWithIndexPath:indexPath];
                    break;
            }
        }
            break;
    }
}

/**
 * 获取当前已点击的表格模型
 */
- (CYTSeekCarPublishItemModel *)currentSelectItemModel{
    
    return [self itemModelWithIndexPath:self.itemSelectedIndexPath];
}
/**
 * 获取指定cell表格模型
 */
- (CYTSeekCarPublishItemModel *)itemModelWithIndexPath:(NSIndexPath *)indexPath{
    CYTSeekCarPublishModel *seekCarPublishModel = self.publishNeedItems[indexPath.section];
    CYTSeekCarPublishItemModel *seekCarPublishItemModel = seekCarPublishModel.seekCarPublishItems[indexPath.row];
    return seekCarPublishItemModel;
}
/**
 * 刷新当前表格
 */
- (void)reloadCurrentCell{
    [self reloadCellWithIndexPath:self.itemSelectedIndexPath];
}
/**
 * 刷新指定表格
 */
- (void)reloadCellWithIndexPath:(NSIndexPath *)indexPath{
    CYTSeekCarPublishItemModel *seekCarPublishItemModel = [self itemModelWithIndexPath:indexPath];
    seekCarPublishItemModel.select = YES;
    if (!indexPath) return;
    [self.publishNeedTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
/**
 * 清空表格数据
 */
- (void )cleanCellDataWithArray:(NSArray *)indexPathsArray{
    for (NSIndexPath *indexPath in indexPathsArray) {
        CYTSeekCarPublishItemModel *seekCarPublishItemModel = [self itemModelWithIndexPath:indexPath];
        seekCarPublishItemModel.select = NO;
        seekCarPublishItemModel.assistanceString = nil;
        seekCarPublishItemModel.content = nil;
    }
    [self.publishNeedTableView reloadRowsAtIndexPaths:indexPathsArray withRowAnimation:UITableViewRowAnimationFade];
}
/**
 * 清空表格数据
 */
- (void )cleanCellDataWithIndexPath:(NSIndexPath *)indexPath{
    CYTSeekCarPublishItemModel *seekCarPublishItemModel = [self itemModelWithIndexPath:indexPath];
    seekCarPublishItemModel.title = nil;
    seekCarPublishItemModel.select = NO;
    seekCarPublishItemModel.assistanceString = nil;
    seekCarPublishItemModel.content = nil;
    [self.publishNeedTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}



#pragma mark - 必填项

#pragma mark - 品牌车型的选择
- (void)brandTypeSelect{
    CYTBrandSelectViewController *brandSelect = [CYTBrandSelectViewController new];
    __weak typeof(self)bself = self;
    brandSelect.ffobj = bself;
    brandSelect.viewModel.type = CYTBrandSelectTypeCar;
    brandSelect.viewModel.brandResultModel = [self.brandSelectModel copy];
    
    @weakify(self);
    [brandSelect setBrandSelectBlock:^(CYTBrandSelectResultModel *brandModel) {
        @strongify(self);
        [self cleanDataForCarBrandSelected];
        self.brandSelectModel = brandModel;
        [self cleanDataForBrandTypeSelect];
        [self updateBrandWithModel:brandModel];
         //请求车款对应的外观内饰颜色数据
        [self requestColorWithSerialId:brandModel.seriesModel.serialId];
    }];
    [self.navigationController pushViewController:brandSelect animated:YES];
}


/**
 * 车源类型的选择
 */
#pragma mark - 品牌车型的选择
- (void)carSourceTypeSelect{
    [MobClick event:@"XCFB_LXXZ"];
    self.sideView.contentController = self.carTypeCtr;
    self.carTypeCtr.indexPath = self.carSourceSelectedIndexPath;
    [self showSideView];
}
/**
 * 品牌车型的选择 清空数据
 */
- (void)cleanDataForCarBrandSelected{
    NSIndexPath *carsourcePath = [NSIndexPath indexPathForRow:1 inSection:0];
    NSIndexPath *colorPath = [NSIndexPath indexPathForRow:2 inSection:0];
    NSIndexPath *guidePricePath = [NSIndexPath indexPathForRow:3 inSection:0];
    [self cleanCellDataWithArray:@[carsourcePath,colorPath,guidePricePath]];
    //清空品牌、颜色参数
    self.seekCarPublishTempParameters.brandId = nil;
    self.seekCarPublishTempParameters.exteriorColor = nil;
    self.seekCarPublishTempParameters.interiorColor = nil;
    self.seekCarPublishParameters = self.seekCarPublishTempParameters;
    
    //清空保存的颜色
    self.colorVM.inColorSel = nil;
    self.colorVM.exColorSel = nil;
}
#pragma mark - 更新车源类型数据
- (void)updateCardataSourceWithModel:(CYTCarSourceTypeModel *)model{
    CYTWeakSelf
    weakSelf.carSourceSelectedIndexPath = model.indexPath;
    CYTSeekCarPublishItemModel *seekCarPublishItemModel = [weakSelf currentSelectItemModel];
    seekCarPublishItemModel.content = model.carSourceTypeName;
    [weakSelf reloadCurrentCell];
}
#pragma mark - 品牌车型选择 清空数据
- (void)cleanDataForBrandTypeSelect{
    NSIndexPath *colorPath = [NSIndexPath indexPathForRow:3 inSection:0];
    [self cleanCellDataWithArray:@[colorPath]];
    //清空保存的颜色
    self.colorVM.inColorSel = nil;
    self.colorVM.exColorSel = nil;
}
#pragma mark - 更新品牌车型的数据
- (void)updateBrandWithModel:(CYTBrandSelectResultModel *)brandModel{
    CYTWeakSelf
    NSString *brandId = [NSString stringWithFormat:@"%ld",brandModel.subBrandId];
    NSString *carId = [NSString stringWithFormat:@"%ld",brandModel.carModel.carId];
    NSString *serialId = [NSString stringWithFormat:@"%ld",brandModel.seriesModel.serialId];
    
    self.seekCarPublishTempParameters.exteriorColor = nil;
    self.seekCarPublishTempParameters.interiorColor = nil;
    
    //请求参数
    self.seekCarPublishTempParameters.brandId = brandId;
    self.seekCarPublishTempParameters.serialId = serialId;
    self.seekCarPublishTempParameters.carId = carId;
    self.seekCarPublishTempParameters.customCarName = brandModel.carModel.carName;
    self.seekCarPublishParameters = self.seekCarPublishTempParameters;

    CYTSeekCarPublishItemModel *seekCarPublishItemModel = [weakSelf currentSelectItemModel];
    if (brandModel.carModel.carId == -1) {//自定义车款
        seekCarPublishItemModel.content = brandModel.seriesModel.serialName;
        seekCarPublishItemModel.assistanceString = brandModel.carModel.carName;
    }else {
        seekCarPublishItemModel.content = brandModel.seriesModel.serialName;
        seekCarPublishItemModel.assistanceString = brandModel.carModel.carName;
    }
    [weakSelf reloadCurrentCell];
    
    //车源类型
    CYTCarSourceTypeModel *carSourceTypeModel = CYTCarSourceTypeModel.new;
    if (brandModel.carModel.carId == -1 && brandModel.seriesModel.isParallelImportCar) {//自定义车款
        carSourceTypeModel.carSourceTypeName = @"";
        carSourceTypeModel.carSourceTypeId = -1;
    }else {
        carSourceTypeModel.carSourceTypeName = brandModel.carModel.typeName;
        carSourceTypeModel.carSourceTypeId = [brandModel.carModel.type integerValue];
    }

    carSourceTypeModel.editEnable = brandModel.seriesModel.isParallelImportCar && brandModel.carModel.carId == -1;
    [self updateCarSourceTypeDataWithCarSourceTypeModel:carSourceTypeModel];
    //指导价
    [self updateCarReferPriceWithBrandWithModel:brandModel];
}
/**
 *  更新车源类型数据
 */
- (void)updateCarSourceTypeDataWithCarSourceTypeModel:(CYTCarSourceTypeModel *)carSourceTypeModel{
    NSIndexPath *carSourceTypeIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    CYTSeekCarPublishItemModel *aSeekCarPublishItemModel = [self itemModelWithIndexPath:carSourceTypeIndexPath];
    aSeekCarPublishItemModel.content = carSourceTypeModel.carSourceTypeName;
    aSeekCarPublishItemModel.hideArrow = !carSourceTypeModel.editEnable;
    aSeekCarPublishItemModel.placeholder = !carSourceTypeModel.editEnable?@"":@"请选择";
    self.seekCarPublishTempParameters.goodsType = [NSString stringWithFormat:@"%ld",carSourceTypeModel.carSourceTypeId];
    self.seekCarPublishParameters = self.seekCarPublishTempParameters;
    [self reloadCellWithIndexPath:carSourceTypeIndexPath];
}

/**
 *  更新指导价数据
 */
- (void)updateCarReferPriceWithBrandWithModel:(CYTBrandSelectResultModel *)brandModel{
    NSIndexPath *carGuidePriceIndexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    CYTSeekCarPublishItemModel *aSeekCarPublishItemModel = [self itemModelWithIndexPath:carGuidePriceIndexPath];
    NSString *price = brandModel.carModel.carReferPrice;
    if ([price integerValue] == 0) {
        price = @"暂无";
    }else {
        price = [NSString stringWithFormat:@"%@万元",price];
    }
    aSeekCarPublishItemModel.content = price;
    [self reloadCellWithIndexPath:carGuidePriceIndexPath];
}

/**
 * 请求外观颜色和内饰颜色数据
 */
- (void)requestColorWithSerialId:(NSInteger)serialId{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableDictionary *par = [NSMutableDictionary dictionary];
        [par setValue:[NSNumber numberWithInteger:serialId] forKey:@"CarSerialId"];
        [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
        
        [CYTNetworkManager GET:kURL.car_common_getCarSeriesColor parameters:par.mj_keyValues dataTask:nil showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
            [CYTLoadingView hideLoadingView];
            if (responseObject.resultEffective) {
                NSDictionary *colorDict = responseObject.dataDictionary;
                NSArray *exColorArray = [CYTGetColorBasicVM colorArray:colorDict[@"exteriorColors"] withType:CarColorTypeNoLimit];
                self.exColorArray = exColorArray;
                NSArray *inColorArray = [CYTGetColorBasicVM colorArray:colorDict[@"interiorColors"] withType:CarColorTypeNoLimit];
                self.inColorArray = inColorArray;
            }
        }];
        
    });
}

/**
 * 颜色的选择
 */
- (void)colorSelect{
    if (self.seekCarNeedPublishType == CYTSeekCarNeedPublishTypeDefault) {
        if (!self.seekCarPublishParameters.brandId){
            [CYTToast messageToastWithMessage:@"请选择品牌车型"];
            return;
        }
    }
    CYTWeakSelf
    CYTGetColorViewController *getColorCtr = [[CYTGetColorViewController alloc] init];
    getColorCtr.viewModel.inColorArray = self.inColorArray;
    getColorCtr.viewModel.exColorArray = self.exColorArray;
    getColorCtr.viewModel.inColorSel = self.colorVM.inColorSel;
    getColorCtr.viewModel.exColorSel = self.colorVM.exColorSel;
    getColorCtr.parentCtr = self;
    //数据回调
    [getColorCtr setGetColorFinishedBlock:^(CYTGetColorBasicVM *colorVM){
        CYTSeekCarPublishItemModel *seekCarPublishItemModel = [weakSelf currentSelectItemModel];
        weakSelf.colorVM = colorVM;
        weakSelf.seekCarPublishTempParameters.exteriorColor = colorVM.exColorSel;
        weakSelf.seekCarPublishTempParameters.interiorColor = colorVM.inColorSel;
        weakSelf.seekCarPublishParameters = weakSelf.seekCarPublishTempParameters;
        seekCarPublishItemModel.content = [NSString stringWithFormat:@"%@/%@",colorVM.exColorSel,colorVM.inColorSel];
        [weakSelf reloadCurrentCell];
    }];
    [self.navigationController pushViewController:getColorCtr animated:YES];
}
/**
 * 上牌地区的选择
 */
- (void)boardAreraSelect{
    CYTWeakSelf
    CYTAddressDataWNCManager *viewModel = [CYTAddressDataWNCManager shareManager];
    [viewModel cleanChooseModel];
    viewModel.titleString = @"车源所在地";
    CYTAddressChooseCommonVC *addressChooseCommonVC = [[CYTAddressChooseCommonVC alloc] init];
    viewModel.showArea = NO;
    viewModel.type = AddressChooseTypeCity;
    addressChooseCommonVC.viewModel = viewModel;
    //车源所在地回调
    [addressChooseCommonVC setChooseFinishedBlock:^(CYTAddressDataWNCManager *model) {
        weakSelf.seekCarPublishTempParameters.registCardCity = [NSString stringWithFormat:@"%ld",model.addressModel.selectCityModel.idCode];
        weakSelf.seekCarPublishParameters = weakSelf.seekCarPublishTempParameters;
        CYTSeekCarPublishItemModel *seekCarPublishItemModel = [weakSelf currentSelectItemModel];
        NSString *provinceName = !model.addressModel.selectProvinceModel.name.length?@"":model.addressModel.selectProvinceModel.name;
        NSString *cityName = !model.addressModel.selectCityModel.name.length?@"":model.addressModel.selectCityModel.name;
        seekCarPublishItemModel.content = [NSString stringWithFormat:@"%@ %@",provinceName,cityName];
        [weakSelf reloadCurrentCell];
    }];
    [self.navigationController pushViewController:addressChooseCommonVC animated:YES];
}
/**
 * 接车地址的选择
 */
- (void)receiveCarAddressSelect{
    CYTWeakSelf
    CYTAddressListViewController *addressListViewController = [CYTAddressListViewController addressListWithType:CYTAddressListTypeSelect];
    addressListViewController.addressModel = self.hasSelectedAddressModel;
    addressListViewController.addressSelectBlock = ^(CYTAddressModel *addressModel) {
        weakSelf.seekCarPublishTempParameters.receivingId = addressModel.receivingId;
        weakSelf.seekCarPublishParameters = weakSelf.seekCarPublishTempParameters;
        weakSelf.hasSelectedAddressModel = addressModel;
        CYTSeekCarPublishItemModel *seekCarPublishItemModel = [weakSelf currentSelectItemModel];
        
        NSString *recAddressStr = [NSString stringWithFormat:@"%@ %@ %@ %@",addressModel.provinceName,addressModel.cityName,addressModel.countyName,addressModel.addressDetail];
        seekCarPublishItemModel.content = recAddressStr;
        
        [weakSelf reloadCurrentCell];
    };
    [self.navigationController pushViewController:addressListViewController animated:YES];

}



#pragma mark - 非必填项

/**
 * 配置的填写
 */
- (void)configurationFillWithIndexPath:(NSIndexPath *)indexPath{
    CYTWeakSelf
    CYTPublishRemarkVC *configVC = [CYTPublishRemarkVC new];
    configVC.titleString = @"配置";
    CYTSeekCarPublishItemModel *seekCarPublishItemModel = [self itemModelWithIndexPath:indexPath];
    configVC.content = seekCarPublishItemModel.content;
    configVC.placeholder = configVC.configPlaceholder;
    [configVC setConfigBlock:^(NSString *content) {
        weakSelf.seekCarPublishTempParameters.carConfigure = content;
        weakSelf.seekCarPublishParameters = weakSelf.seekCarPublishTempParameters;
        seekCarPublishItemModel.content = content;
        seekCarPublishItemModel.select = content.length !=0;
        [weakSelf reloadCurrentCell];
    }];
    [self.navigationController pushViewController:configVC animated:YES];
}
/**
 * 手续文件的选择
 */
- (void)procedureSelectWithIndexPath:(NSIndexPath *)indexPath{
    CYTWeakSelf
    CYTPublishProcedureVC *procedureVC = [CYTPublishProcedureVC new];
    CYTSeekCarPublishItemModel *seekCarPublishItemModel = [self itemModelWithIndexPath:indexPath];
    [procedureVC setProcedureBlock:^(NSString *content) {
        weakSelf.seekCarPublishTempParameters.carProcedures = content;
        weakSelf.seekCarPublishParameters = weakSelf.seekCarPublishTempParameters;
        seekCarPublishItemModel.content = content;
        seekCarPublishItemModel.select = (content.length !=0);
        [weakSelf reloadCurrentCell];
    }];
    [self.navigationController pushViewController:procedureVC animated:YES];
}
/**
 * 备注的填写
 */
- (void)markFillWithIndexPath:(NSIndexPath *)indexPath{
    CYTWeakSelf
    CYTPublishRemarkVC *remarkVC = [CYTPublishRemarkVC new];
    CYTSeekCarPublishItemModel *seekCarPublishItemModel = [self itemModelWithIndexPath:indexPath];
    remarkVC.titleString = @"备注";
    remarkVC.placeholder = remarkVC.remarkPlaceholder;
    remarkVC.content = seekCarPublishItemModel.content;
    [remarkVC setConfigBlock:^(NSString *content) {
        weakSelf.seekCarPublishTempParameters.remark = content;
        weakSelf.seekCarPublishParameters = weakSelf.seekCarPublishTempParameters;
        seekCarPublishItemModel.content = content;
        seekCarPublishItemModel.select = (content.length !=0);
        [weakSelf reloadCurrentCell];
    }];
    [self.navigationController pushViewController:remarkVC animated:YES];
}
/**
 * 发布寻车参数
 */
- (void)setSeekCarPublishParameters:(CYTSeekCarPublishParameters *)seekCarPublishParameters{
    _seekCarPublishParameters = seekCarPublishParameters;
    if (self.seekCarNeedPublishType == CYTSeekCarNeedPublishTypeDefault) {
        if (seekCarPublishParameters.goodsType.length && seekCarPublishParameters.brandId.length && self.seekCarPublishParameters.exteriorColor.length && self.seekCarPublishParameters.interiorColor.length && self.seekCarPublishParameters.receivingId.length) {
            _seekCarPublishBtn.enabled = YES;
        }else{
            _seekCarPublishBtn.enabled = NO;
        }
    }else{
        if (!seekCarPublishParameters.seekCarId.length)return;
        if (seekCarPublishParameters.seekCarId.length && self.seekCarPublishParameters.exteriorColor.length && self.seekCarPublishParameters.interiorColor.length && (self.seekCarPublishTempParameters.receivingId.length || self.seekCarPublishTempParameters.countryID.length) && self.seekCarPublishParameters.registCardCity.length) {
            _seekCarPublishBtn.enabled = YES;
        }else{
            _seekCarPublishBtn.enabled = NO;
        }
    }
}
/**
 * 寻车模型 我的寻车 模型传入
 */
- (void)setSeekCarModel:(CYTSeekCarListModel *)seekCarModel{
    _seekCarModel = seekCarModel;
    NSIndexPath *brandTypeModelIdx = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *carSourceTypeModelIdx = [NSIndexPath indexPathForRow:1 inSection:0];
    NSIndexPath *guidePriceModelIdx = [NSIndexPath indexPathForRow:2 inSection:0];
    NSIndexPath *colorModelIdx = [NSIndexPath indexPathForRow:3 inSection:0];
    NSIndexPath *boardAreraModelIdx = [NSIndexPath indexPathForRow:4 inSection:0];
    NSIndexPath *receiveCarAddressModelIdx = [NSIndexPath indexPathForRow:5 inSection:0];
    NSIndexPath *configurationModelIdx = [NSIndexPath indexPathForRow:0 inSection:1];
    NSIndexPath *procedureModelIdx = [NSIndexPath indexPathForRow:1 inSection:1];
    NSIndexPath *markModelIdx = [NSIndexPath indexPathForRow:2 inSection:1];
    
    CYTSeekCarPublishItemModel *brandTypeModel = [self itemModelWithIndexPath:brandTypeModelIdx];
    brandTypeModel.contentColor = CYTHexColor(@"#B6B6B6");
    brandTypeModel.subContentColor = CYTHexColor(@"#B6B6B6");
    CYTSeekCarPublishItemModel *carSourceTypeModel = [self itemModelWithIndexPath:carSourceTypeModelIdx];
    carSourceTypeModel.contentColor = CYTHexColor(@"#B6B6B6");
    CYTSeekCarPublishItemModel *guidePriceModel = [self itemModelWithIndexPath:guidePriceModelIdx];
    CYTSeekCarPublishItemModel *colorModel = [self itemModelWithIndexPath:colorModelIdx];
    CYTSeekCarPublishItemModel *boardAreraModel = [self itemModelWithIndexPath:boardAreraModelIdx];
    CYTSeekCarPublishItemModel *receiveCarAddressModel = [self itemModelWithIndexPath:receiveCarAddressModelIdx];
    CYTSeekCarPublishItemModel *configurationModel = [self itemModelWithIndexPath:configurationModelIdx];
    CYTSeekCarPublishItemModel *procedureModel = [self itemModelWithIndexPath:procedureModelIdx];
    CYTSeekCarPublishItemModel *markModel = [self itemModelWithIndexPath:markModelIdx];
    
    CYTWeakSelf
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
    CYTSeekCarDetailParameters *par = [[CYTSeekCarDetailParameters alloc] init];
    par.seekCarId = seekCarModel.seekCarInfo.seekCarId;
    
    
    [CYTNetworkManager GET:kURL.car_seek_detail parameters:par.mj_keyValues dataTask:nil showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
        [CYTLoadingView hideLoadingView];
        
        CYTSeekCarDetailModel *seekCarDetailModel = [CYTSeekCarDetailModel mj_objectWithKeyValues:responseObject.dataDictionary];
        [CYTLoadingView hideLoadingView];
        
        CYTSeekCarInfoModel *seekCarInfo = seekCarDetailModel.seekCarInfo;
        
        //车源类型
        carSourceTypeModel.content = seekCarInfo.carSourceTypeName;
        
        //品牌车型
        brandTypeModel.content = [NSString stringWithFormat:@"%@ %@",seekCarInfo.brandName,seekCarInfo.serialName];
        NSString *yearString = seekCarInfo.carYearType.length?[NSString stringWithFormat:@"%@款",seekCarInfo.carYearType]:@"";
        brandTypeModel.assistanceString = [NSString stringWithFormat:@"%@ %@",yearString,seekCarInfo.carName];
        
        //请求该车款颜色数据
        [weakSelf requestColorWithSerialId:[seekCarInfo.serialId integerValue]];
        
        
        //颜色
        NSString *exColor = !seekCarModel.seekCarInfo.exteriorColor.length?@"":seekCarInfo.exteriorColor;
        NSString *inColor = !seekCarModel.seekCarInfo.interiorColor.length?@"":seekCarInfo.interiorColor;
        colorModel.content = [NSString stringWithFormat:@"%@/%@",exColor,inColor];
        colorModel.select = YES;
        weakSelf.colorVM.exColorSel = exColor;
        weakSelf.colorVM.inColorSel = inColor;
        
        //指导价
        guidePriceModel.content = seekCarInfo.carReferPriceDesc;
        guidePriceModel.select = YES;
        
        //上牌地区
        boardAreraModel.content = seekCarInfo.registCardAddress;
        boardAreraModel.select = YES;
        
        //接车地址
        receiveCarAddressModel.content = seekCarInfo.receiveAddressDetail;
        receiveCarAddressModel.select = YES;
        weakSelf.hasSelectedAddressModel.receivingId = seekCarInfo.receivingId;
        
        //配置
        configurationModel.content = seekCarInfo.carConfigure;
        configurationModel.select = YES;
        
        //手续
        procedureModel.content = seekCarInfo.carProcedures;
        procedureModel.select = YES;
        
        //备注
        markModel.content = seekCarInfo.remark;
        markModel.select = YES;
        
        NSIndexSet *indexSet0 = [NSIndexSet indexSetWithIndex:0];
        [weakSelf.publishNeedTableView reloadSections:indexSet0 withRowAnimation:UITableViewRowAnimationFade];
        NSIndexSet *indexSet1 = [NSIndexSet indexSetWithIndex:1];
        [weakSelf.publishNeedTableView reloadSections:indexSet1 withRowAnimation:UITableViewRowAnimationFade];
        
        //请求参数
        weakSelf.seekCarPublishTempParameters.seekCarId = seekCarInfo.seekCarId;
        weakSelf.seekCarPublishTempParameters.exteriorColor = seekCarInfo.exteriorColor;
        weakSelf.seekCarPublishTempParameters.interiorColor = seekCarInfo.interiorColor;
        weakSelf.seekCarPublishTempParameters.receivingId = @"-1";
        weakSelf.seekCarPublishTempParameters.registCardCity = seekCarInfo.registCardCityId;
        weakSelf.seekCarPublishTempParameters.carConfigure = seekCarInfo.carConfigure;
        weakSelf.seekCarPublishTempParameters.carProcedures = seekCarInfo.carProcedures;
        weakSelf.seekCarPublishTempParameters.remark = seekCarInfo.remark;
        
        //参数赋值
        weakSelf.seekCarPublishParameters = weakSelf.seekCarPublishTempParameters;
    }];

}
@end
