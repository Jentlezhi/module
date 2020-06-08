//
//  CYTCompanyCertificateViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCompanyCertificateViewController.h"
#import "CYTCompanyCertificateView.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "CYTCompanyCertificateModel.h"
#import "CYTManageTypeViewController.h"
#import "CYTManageBrandViewController.h"
#import "CYTManageTypeModel.h"
#import "CYTUserInfoModel.h"
#import "CYTManageBrandModel.h"
#import "CYTPhotoSelectTool.h"
#import "CYTAddressDataWNCManager.h"
#import "CYTAddressChooseCommonVC.h"


@interface CYTCompanyCertificateViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

/** 企业认证视图 */
@property(weak, nonatomic) CYTCompanyCertificateView *companyCertificateView;

/** 已选经营类型模型 */
@property(strong, nonatomic) CYTManageTypeModel *manageTypeModel;

/** 已选主营品牌模型 */
@property(strong, nonatomic) NSMutableArray *manageBrands;

@end

@implementation CYTCompanyCertificateViewController

- (void)loadView{
    CYTCompanyCertificateView *companyCertificateView = [[CYTCompanyCertificateView alloc] init];
    companyCertificateView.personalCertificateModel = self.personalCertificateModel;
    _companyCertificateView = companyCertificateView;
    self.view = companyCertificateView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self companyCertificateBasicConfig];
    [self initPCompanyCertificateComponents];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
/**
 *  基本配置
 */
- (void)companyCertificateBasicConfig{
    NSInteger authStatus = [CYTAccountManager sharedAccountManager].authStatus;
    NSString *righBtnItmeTitle = authStatus == 0 ?@"跳过":@"";
    [self createNavBarWithTitle:@"企业认证" andShowBackButton:YES showRightButtonWithTitle:righBtnItmeTitle];
}

- (void)rightButtonClick:(UIButton *)rightButton{
    [CYTAlertView alertViewWithTitle:@"提示" message:@"返回后认证将中断，请确认？" confirmAction:^{
       [kAppdelegate goHomeView];
    } cancelAction:nil];
}

/**
 *  初始化子控件
 */
- (void)initPCompanyCertificateComponents{
    
    //设置驳回原因显示
    _companyCertificateView.reasonLine = self.reasonline;
    _companyCertificateView.refuseReason = self.refuseString;
    
    //经营类型
    CYTWeakSelf
    //已提交数据显示
    self.manageTypeModel = [[CYTManageTypeModel alloc] init];
    //主营品牌的选择
    self.manageBrands = [NSMutableArray array];
    if (self.userAuthenticateInfoModel) {
        _companyCertificateView.userAuthenticateInfoModel = self.userAuthenticateInfoModel;
        self.manageTypeModel.levelId = self.userAuthenticateInfoModel.companyTypeId;
        self.manageTypeModel.levelName = self.userAuthenticateInfoModel.companyType;
        NSArray *carBrandIDArray;
        if (_userAuthenticateInfoModel.carBrandIdStr.length) {
            carBrandIDArray = [_userAuthenticateInfoModel.carBrandIdStr componentsSeparatedByString:@","];
        }
        
        NSArray *carBrandNameArray;
        if (_userAuthenticateInfoModel.carBrandStr.length) {
            carBrandNameArray = [_userAuthenticateInfoModel.carBrandStr componentsSeparatedByString:@","];
        }
        //兼容服务器id和name返回不一致情况 
        NSUInteger count = MIN(carBrandIDArray.count, carBrandNameArray.count);
        for (NSUInteger index = 0; index < count; index++) {
            CYTManageBrandModel *item = [[CYTManageBrandModel alloc] init];
            item.brandId = carBrandIDArray[index];
            item.brandName = carBrandNameArray[index];
            [self.manageBrands addObject:item];
        }
        
    }
    _companyCertificateView.manageType = ^{
        CYTManageTypeViewController *manageTypeVC = [[CYTManageTypeViewController alloc] init];
        //经营类型的回调
        manageTypeVC.companyTypeBack = ^(CYTManageTypeModel *manageTypeModel){
            _companyCertificateView.manageTypeModel = manageTypeModel;
            CYTAppManager *appManager = [CYTAppManager sharedAppManager];
            appManager.LevelId = [manageTypeModel.levelId intValue];
            appManager.LevelName = manageTypeModel.levelName;
            self.manageTypeModel.levelId = manageTypeModel.levelId;
            self.manageTypeModel.levelName = manageTypeModel.levelName;
        };
        manageTypeVC.manageTypeModel = self.manageTypeModel;
        [weakSelf.navigationController pushViewController:manageTypeVC animated:YES];
    };
    
    //注册地址
    _companyCertificateView.registerAddressBack = ^{
        CYTAddressDataWNCManager *vm = [CYTAddressDataWNCManager shareManager];
        [vm cleanAllModelCache];
        vm.showArea = NO;
        vm.titleString = @"城市选择";
        vm.type = AddressChooseTypeCounty;
        
        CYTAddressChooseCommonVC *choose = [CYTAddressChooseCommonVC new];
        choose.viewModel = vm;
        [choose setChooseFinishedBlock:^(CYTAddressDataWNCManager *model) {
            NSString *pName = model.addressModel.selectProvinceModel.name?model.addressModel.selectProvinceModel.name:@"";
            NSString *cName = model.addressModel.selectCityModel.name?model.addressModel.selectCityModel.name:@"";
            NSString *dName = model.addressModel.selectCountyModel.name?model.addressModel.selectCountyModel.name:@"";
            CYTAppManager *appManger = [CYTAppManager sharedAppManager];
            appManger.countryId = model.addressModel.selectCountyModel.idCode > 0?model.addressModel.selectCountyModel.idCode:model.addressModel.selectCityModel.idCode;
            NSString *detailAddress = [NSString stringWithFormat:@"%@ %@ %@",pName,cName,dName];
            [_companyCertificateView setValue:detailAddress forKeyPath:@"areraLabel.text"];
            
        }];
        [self.navigationController pushViewController:choose animated:YES];
        

    };
    //主营品牌
    _companyCertificateView.manageBrand = ^{
        CYTManageBrandViewController *manageBrandVC = [[CYTManageBrandViewController alloc] init];
        manageBrandVC.manageBrandsBack = ^(NSMutableArray *selectBrands){
            _companyCertificateView.manageBrands = selectBrands;
            self.manageBrands = selectBrands;
        };
        manageBrandVC.hasSelectBrands = self.manageBrands;
        [weakSelf.navigationController pushViewController:manageBrandVC animated:YES];
    };
    //营业执照的添加
    _companyCertificateView.addBusinessLicenseBack = ^{
        [weakSelf actionSheetWithType:CYTCompanyCertificateTypeBusLen];
    };
    //展厅照片的添加
    _companyCertificateView.addShrowroomBack = ^{
       [weakSelf actionSheetWithType:CYTCompanyCertificateTypeShrom];
    };
    //提交审核成功
    _companyCertificateView.companyCertificateNextStep = ^(NSString *message){
        [CYTToast successToastWithMessage:message completion:^{
            [kAppdelegate goHomeView];
        }];
    };
}

- (void)actionSheetWithType:(CYTCompanyCertificateType)certificateType{
    @weakify(self);
    [CYTPhotoSelectTool photoSelectToolWithImageMode:CYTImageModePreview image:^(UIImage *selectedImage) {
        @strongify(self);
        CYTCompanyCertificateModel *companyCertificateModel = [[CYTCompanyCertificateModel alloc] init];
        companyCertificateModel.certificateType = certificateType;
        companyCertificateModel.selectedImage = selectedImage;
        self.companyCertificateView.companyCertificateModel = companyCertificateModel;
    }];
}


- (void)backButtonClick:(UIButton *)backButton {
    //是否已审核通过
    CYTWeakSelf
    NSInteger authStatus = [CYTAccountManager sharedAccountManager].authStatus;
    if (authStatus == 0){
        [CYTAlertView alertViewWithTitle:@"提示" message:@"返回后认证将中断，请确认？" confirmAction:^{
            [weakSelf backAction];
        } cancelAction:nil];
    }else{
        [weakSelf backAction];
    }
    
}
 /**
 * 返回操作
 */
- (void)backAction{
    if (self.backType == CYTBackTypePop) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
