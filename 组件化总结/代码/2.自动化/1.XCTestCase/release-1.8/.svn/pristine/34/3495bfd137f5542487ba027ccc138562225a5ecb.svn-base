//
//  CYTCompleteUserInfoViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCompleteUserInfoViewController.h"
#import "CYTCompleteInfoModel.h"
#import "CYTCompleteInfoItemModel.h"
#import "CYTCompleteUserInfoCell.h"
#import "CYTPhotoSelectTool.h"
#import "CYTFillAuthenticateInfoParameters.h"
#import "CYTManageTypeViewController.h"
#import "CYTManageTypeModel.h"
#import "CYTManageBrandViewController.h"
#import "CYTManageBrandModel.h"
#import "CYTCommonButton.h"
#import "CYTImageFileModel.h"
#import "CYTAddressAddOrModifyViewController.h"
#import "CYTPersonalCertificateViewController.h"
#import "CYTWaitCommitUserInfoModel.h"
#import "CYTAddressChooseCommonVC.h"
#import "CYTSignalImageUploadTool.h"

@interface CYTCompleteUserInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

/** 数据源 */
@property(strong, nonatomic) NSArray *userInfoData;
/** 完善资料参数 */
@property(strong, nonatomic) CYTFillAuthenticateInfoParameters *fillAuthenticateInfoParameters;
/** 已选经营类型模型 */
@property(strong, nonatomic) CYTManageTypeModel *manageTypeModel;
/** 已选主营品牌模型 */
@property(strong, nonatomic) NSMutableArray *manageBrands;

/** footer */
@property(strong, nonatomic) UIView *footerView;

@end

@implementation CYTCompleteUserInfoViewController
- (CYTFillAuthenticateInfoParameters *)fillAuthenticateInfoParameters{
    if (!_fillAuthenticateInfoParameters) {
        _fillAuthenticateInfoParameters = [[CYTFillAuthenticateInfoParameters alloc] init];
    }
    return _fillAuthenticateInfoParameters;
}

- (CYTManageTypeModel *)manageTypeModel{
    if (!_manageTypeModel) {
        _manageTypeModel = [[CYTManageTypeModel alloc] init];
    }
    return _manageTypeModel;
}

- (UIView *)footerView{
    if (!_footerView) {
        _footerView = [[UIView alloc] init];
        CYTWeakSelf
        UIButton *confirmBtn = [UIButton buttonWithTitle:@"下一步" enabled:YES];
        [[confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            confirmBtn.enabled = NO;
            CYTCompleteInfoModel *userNameCompleteInfoModel = self.userInfoData[1];
            CYTCompleteInfoItemModel *userNameCompleteInfoItemModel = userNameCompleteInfoModel.data[1];
            weakSelf.fillAuthenticateInfoParameters.userName = userNameCompleteInfoItemModel.customInput;
            //测试
            CYTLog(@"%@",self.fillAuthenticateInfoParameters.carBrandIdStr);
            //校验姓名合法
            if ([CYTCommonTool isEmpty:weakSelf.fillAuthenticateInfoParameters.userName]) {
                [CYTToast errorToastWithMessage:CYTNameNil];
                confirmBtn.enabled = YES;
                return;
            }
            if (![CYTCommonTool isChinese:weakSelf.fillAuthenticateInfoParameters.userName]) {
                [CYTToast errorToastWithMessage:CYTNameOnlyChinese];
                confirmBtn.enabled = YES;
                return;
            }
            [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
            [CYTNetworkManager POST:kURL.user_authorization_fillAuthenticateInfo parameters:weakSelf.fillAuthenticateInfoParameters.mj_keyValues dataTask:nil showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
                [CYTLoadingView hideLoadingView];
                confirmBtn.enabled = YES;
                if (responseObject.resultEffective) {
                    [CYTToast successToastWithMessage:responseObject.resultMessage completion:^{
                        CYTPersonalCertificateViewController *personalCertificateVC = [[CYTPersonalCertificateViewController alloc] init];
                        personalCertificateVC.backType = CYTBackTypeGoHome;
                        [weakSelf.navigationController pushViewController:personalCertificateVC animated:YES];
                    }];
                }
            }];
        }];
        [_footerView addSubview:confirmBtn];
        [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(CYTMarginH);
            make.right.equalTo(-CYTMarginH);
            make.bottom.equalTo(_footerView);
            make.height.equalTo(CYTAutoLayoutV(80.f));
        }];
    }
    return _footerView;
}

- (NSArray *)userInfoData{
    if (!_userInfoData) {
        NSString *phone = [CYTAccountManager sharedAccountManager].userPhoneNum;
        NSString *restigerPhoneNum = phone?phone:@"";
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"CYTCompleteUserInfoData.plist" ofType:nil];
        NSArray *plistData = [NSArray arrayWithContentsOfFile:plistPath];
        NSMutableArray *tempMarray = [NSMutableArray array];
        NSInteger totalCount = plistData.count;
        
        for (NSInteger index = 0; index<totalCount; index++) {
            NSDictionary *dict = plistData[index];
            CYTCompleteInfoModel *completeInfoModel = [[CYTCompleteInfoModel alloc] init];
            NSString *key =  [[dict allKeys] firstObject];
            completeInfoModel.section = key;
            completeInfoModel.data = [CYTCompleteInfoItemModel mj_objectArrayWithKeyValuesArray:[dict valueForKey:key]];
            //手机号赋值
            if ([key isEqualToString:@"0"]) {
                CYTCompleteInfoItemModel *completeInfoItemModel = [completeInfoModel.data firstObject];
                completeInfoItemModel.content = restigerPhoneNum;
            }
            [tempMarray addObject:completeInfoModel];
        }
        _userInfoData = [tempMarray mutableCopy];
    }
    return _userInfoData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self completeUserInfoBasicConfig];
    [self configCompleteUserInfoTableView];
    [self initCompleteUserInfoComponents];
    [self makeConstrains];
}
/**
 *  基本配置
 */
- (void)completeUserInfoBasicConfig{
    self.view.backgroundColor = CYTLightGrayColor;
    [self createNavBarWithBackButtonAndTitle:@"完善资料"];
    //主营品牌的选择
    self.manageBrands = [NSMutableArray array];
}

/**
 *  配置表格
 */
- (void)configCompleteUserInfoTableView{
    
}
/**
 *  初始化子控件
 */
 - (void)initCompleteUserInfoComponents{
     self.mainTableView.tableFooterView = self.footerView;
     self.mainTableView.tableFooterView.height = CYTAutoLayoutV(140.f);
}
/**
 *  约束控件
 */
- (void)makeConstrains{
    
}
#pragma mark - <UITableViewCustomMethod>
/**
 * 获取当前已点击的表格模型
 */
- (CYTCompleteInfoItemModel *)currentSelectItemModel{
    
    return [self itemModelWithIndexPath:self.itemSelectedIndexPath];
}
/**
 * 获取指定cell表格模型
 */
- (CYTCompleteInfoItemModel *)itemModelWithIndexPath:(NSIndexPath *)indexPath{
    CYTCompleteInfoModel *completeInfoModel = self.userInfoData[indexPath.section];
    CYTCompleteInfoItemModel *completeInfoItemModel = completeInfoModel.data[indexPath.row];
    return completeInfoItemModel;
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
    if (!indexPath) return;
    [self.mainTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)backButtonClick:(UIButton *)backButton{
    CYTAppDelegate *delegate= (CYTAppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate goHomeView];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.userInfoData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CYTCompleteInfoModel *completeInfoModel = self.userInfoData[section];
    return completeInfoModel.data.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTCompleteInfoModel *completeInfoModel = self.userInfoData[indexPath.section];
    CYTCompleteInfoItemModel *completeInfoItemModel = completeInfoModel.data[indexPath.row];
    CYTCompleteUserInfoCell *cell = [CYTCompleteUserInfoCell cellForTableView:tableView indexPath:indexPath];
    cell.completeInfoItemModel = completeInfoItemModel;
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2 && (indexPath.row == 1 || indexPath.row == 2)) {
        return tableView.rowHeight;
    }
    return CYTAutoLayoutV(90);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CYTAutoLayoutV(40.f);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001f;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = UIColor.clearColor;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.itemSelectedIndexPath = indexPath;
    if (indexPath.section == 1 && indexPath.row == 0) {//头像
        [self setUserPicture];
    }else if (indexPath.section == 2 && indexPath.row == 0){//公司类型
        [self manageTypeSelect];
    }else if (indexPath.section == 2 && indexPath.row == 1){//主营品牌
        [self manageBrandsSelect];
    }else if (indexPath.section == 2 && indexPath.row == 2){//所在地区
        [self areraSelect];
    }else{}

}
/**
 * 设置用户头像
 */
- (void)setUserPicture{
    @weakify(self);
    [CYTPhotoSelectTool photoSelectToolWithImageMode:CYTImageModeAllowsEditing image:^(UIImage *selectedImage) {
        @strongify(self);
        CYTCompleteInfoItemModel *model = [self currentSelectItemModel];
        model.headerImage = selectedImage;
        [self reloadCurrentCell];
        [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
        
        [CYTSignalImageUploadTool uploadWithImage:selectedImage parameters:nil url:kURL.user_info_updateAvatar success:^(CYTUploadImageResult *result) {
            if (result.result) {
                CYTImageFileModel *fileModel = [CYTImageFileModel mj_objectWithKeyValues:result.data];
                self.fillAuthenticateInfoParameters.faceOriginalPic = fileModel.fileName;
                CYTCompleteInfoItemModel *model = [self currentSelectItemModel];
                model.headerImage = selectedImage;
                [self reloadCurrentCell];
                [CYTToast toastWithType:CYTToastTypeSuccess message:result.message];
            }else{
                [CYTToast toastWithType:CYTToastTypeError message:result.message];
            }
        } fail:nil];
    }];
}
/**
 * 经营类型
 */
- (void)manageTypeSelect{
    CYTWeakSelf
    CYTManageTypeViewController *manageTypeVC = [[CYTManageTypeViewController alloc] init];
    //经营类型的回调
    manageTypeVC.companyTypeBack = ^(CYTManageTypeModel *manageTypeModel){
        weakSelf.manageTypeModel = manageTypeModel;
        CYTAppManager *appManager = [CYTAppManager sharedAppManager];
        appManager.LevelId = [manageTypeModel.levelId intValue];
        appManager.LevelName = manageTypeModel.levelName;
        weakSelf.fillAuthenticateInfoParameters.dealerMemberLevelId = manageTypeModel.levelId;
        CYTCompleteInfoItemModel *model = [weakSelf currentSelectItemModel];
        model.content = manageTypeModel.levelName;
        [weakSelf reloadCurrentCell];
    };
    manageTypeVC.manageTypeModel = self.manageTypeModel;
    [weakSelf.navigationController pushViewController:manageTypeVC animated:YES];
}
/**
 * 主营品牌
 */
- (void)manageBrandsSelect{
    CYTWeakSelf
    CYTManageBrandViewController *manageBrandVC = [[CYTManageBrandViewController alloc] init];
    manageBrandVC.manageBrandsBack = ^(NSMutableArray *selectBrands){
        CYTCompleteInfoItemModel *model = [weakSelf currentSelectItemModel];
        model.content = [self manageBrandNameWithManageBrandModelArray:selectBrands];
        weakSelf.fillAuthenticateInfoParameters.carBrandIdStr = [self manageBrandIDWithManageBrandModelArray:selectBrands];
        [weakSelf reloadCurrentCell];
        self.manageBrands = selectBrands;
    };
    manageBrandVC.hasSelectBrands = self.manageBrands;
    [weakSelf.navigationController pushViewController:manageBrandVC animated:YES];
}
/**
 * 主营品牌名称（、分隔开）
 */
- (NSString *)manageBrandNameWithManageBrandModelArray:(NSArray *)selectBrands{
    NSMutableArray *tempBrandNameArray = [NSMutableArray array];
    for (CYTManageBrandModel *item in selectBrands) {
        [tempBrandNameArray addObject:item.brandName];
    }
    NSString *manageBrandString = [tempBrandNameArray componentsJoinedByString:@","];
    return [manageBrandString stringByReplacingOccurrencesOfString:@"," withString:@"、"];
    
}
/**
 * 主营品牌ID（,分隔开）
 */
- (NSString *)manageBrandIDWithManageBrandModelArray:(NSArray *)selectBrands{
    NSMutableArray *tempBrandNameArray = [NSMutableArray array];
    for (CYTManageBrandModel *item in selectBrands) {
        [tempBrandNameArray addObject:item.brandId];
    }
    return [tempBrandNameArray componentsJoinedByString:@","];
    
}
/**
 * 所在地区
 */
- (void)areraSelect{
    CYTWeakSelf
    CYTAddressDataWNCManager *vm = [CYTAddressDataWNCManager shareManager];
    [vm cleanAllModelCache];
    vm.showArea = NO;
    vm.titleString = @"城市选择";
    vm.type = AddressChooseTypeCounty;
    
    CYTAddressChooseCommonVC *choose = [CYTAddressChooseCommonVC new];
    choose.viewModel = vm;
    [choose setChooseFinishedBlock:^(CYTAddressDataWNCManager *model) {
        CYTCompleteInfoItemModel *completeInfoItemModel = [weakSelf currentSelectItemModel];
        NSString *pName = model.addressModel.selectProvinceModel.name?model.addressModel.selectProvinceModel.name:@"";
        NSString *cName = model.addressModel.selectCityModel.name?model.addressModel.selectCityModel.name:@"";
        NSString *dName = model.addressModel.selectCountyModel.name?model.addressModel.selectCountyModel.name:@"";
        NSString *countryIdStr = [NSString stringWithFormat:@"%ld",model.addressModel.selectCountyModel.idCode];
        NSString *cityIdStr = [NSString stringWithFormat:@"%ld",model.addressModel.selectCityModel.idCode];
        completeInfoItemModel.content = [NSString stringWithFormat:@"%@ %@ %@",pName,cName,dName];
        weakSelf.fillAuthenticateInfoParameters.countryId = model.addressModel.selectCountyModel.idCode?countryIdStr:cityIdStr;
        [weakSelf reloadCurrentCell];
    }];
    [self.navigationController pushViewController:choose animated:YES];
    
}

@end
