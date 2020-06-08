//
//  CYTPersonalCertificateViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPersonalCertificateViewController.h"
#import "CYTPersonalCertificateView.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "CYTIdPhotoModel.h"
#import "CYTCompanyCertificateViewController.h"
#import "CYTPersonalCertificateModel.h"
#import "CYTPhotoSelectTool.h"
#import "CYTCourseView.h"

@interface CYTPersonalCertificateViewController ()

/** 个人认证视图 */
@property(weak, nonatomic) CYTPersonalCertificateView *personalCertificateView;


@end

@implementation CYTPersonalCertificateViewController

- (void)loadView{
    CYTPersonalCertificateView *personalCertificateView = [[CYTPersonalCertificateView alloc] init];
    _personalCertificateView = personalCertificateView;
    self.view = personalCertificateView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self personalCertificateBasicConfig];
    [self initPersonalCertificateComponents];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
/**
 *  基本配置
 */
- (void)personalCertificateBasicConfig{
    NSInteger authStatus = [CYTAccountManager sharedAccountManager].authStatus;
    NSString *righBtnItmeTitle = authStatus == 0 ?@"跳过":@"";
    [self createNavBarWithTitle:@"个人认证" andShowBackButton:!self.hiddeBackButton showRightButtonWithTitle:righBtnItmeTitle];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)rightButtonClick:(UIButton *)rightButton{
    [CYTAlertView alertViewWithTitle:@"提示" message:@"返回后认证将中断，请确认？" confirmAction:^{
        [kAppdelegate goHomeView];
    } cancelAction:nil];
}

/**
 *  初始化子控件
 */
- (void)initPersonalCertificateComponents{
    //身份证正面添加
    CYTWeakSelf
    self.personalCertificateView.identityCardFront = ^{
        [CYTCourseView showCourseViewWithType:CYTIdTypeFront finish:^{
            [weakSelf actionSheetWithType:CYTIdTypeFront];
        }];
    };
    //身份反面添加
    self.personalCertificateView.identityCardBack = ^{
        [CYTCourseView showCourseViewWithType:CYTIdTypeBack finish:^{
            [weakSelf actionSheetWithType:CYTIdTypeBack];
        }];
        
    };
    //手持身份正面添加
    self.personalCertificateView.identityCardWithHand = ^{
        [CYTCourseView showCourseViewWithType:CYTIdTypeFrontWithHand finish:^{
            [weakSelf actionSheetWithType:CYTIdTypeFrontWithHand];
        }];
    };
    
    //下一步按钮
    self.personalCertificateView.personalCertificateNextStep = ^(CYTPersonalCertificateModel *personalCertificateModel,NSUInteger line,NSMutableAttributedString *refuseString){
        //校验身份证号
        NSMutableDictionary *par = [NSMutableDictionary dictionary];
        [par setValue:personalCertificateModel.IDCard forKey:@"idCard"];
        [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
        [CYTNetworkManager POST:kURL.user_authorization_IDCardValidate parameters:par.mj_keyValues dataTask:nil showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
            [CYTLoadingView hideLoadingView];
            if (responseObject.resultEffective) {
                CYTCompanyCertificateViewController *companyCertificateVC = [[CYTCompanyCertificateViewController alloc] init];
                companyCertificateVC.userAuthenticateInfoModel = [weakSelf.personalCertificateView valueForKeyPath:@"userAuthenticateInfoModel"];
                companyCertificateVC.backType = weakSelf.backType;
                //有驳回原因，传入驳回原因
                if (line) {
                    companyCertificateVC.refuseString = refuseString;
                    companyCertificateVC.reasonline = line;
                }
                companyCertificateVC.personalCertificateModel = personalCertificateModel;
                [weakSelf.navigationController pushViewController:companyCertificateVC animated:YES];
            }
        }];
        
    };
}

- (void)actionSheetWithType:(CYTIdType)idType{
    @weakify(self);
    [CYTPhotoSelectTool photoSelectToolWithImageMode:CYTImageModePreview image:^(UIImage *selectedImage) {
        @strongify(self);
        CYTIdPhotoModel *photoModel = [[CYTIdPhotoModel alloc] init];
        photoModel.idType = idType;
        photoModel.selectedImage = selectedImage;
        self.personalCertificateView.photoModel = photoModel;
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
    }else if (self.backType == CYTBackTypeGoHome){
        [kAppdelegate goHomeView];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}



@end
