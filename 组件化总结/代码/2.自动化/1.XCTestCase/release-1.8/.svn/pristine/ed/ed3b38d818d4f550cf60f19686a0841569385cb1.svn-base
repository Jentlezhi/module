//
//  CYTCompanyCertificateViewModel.m
//  CYTEasyPass
//
//  Created by Juniort on 2017/3/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCompanyCertificateViewModel.h"
#import "CYTCommitCertificateModel.h"

@implementation CYTCompanyCertificateViewModel

/**
 *  初始化方法
 *
 *  @return self
 */
- (instancetype)init{
    if (self = [super init]) {
        [self companyCertificateBasicConfig];
    }
    return self;
}
/**
 * 基本配置
 */
- (void)companyCertificateBasicConfig{
    //下一步按钮是否可点击
    _netStepEnableSiganl = [RACSignal combineLatest:@[RACObserve(self, companyName),RACObserve(self, registerAddress)] reduce:^id(NSString *companyNameString, NSString *registerAddress){
        return @(companyNameString.length && registerAddress.length);
    }];
    
    //下一步按钮的点击事件
    _netStepCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            CYTAppManager *appManager = [CYTAppManager sharedAppManager];
            BOOL isSelectArea = appManager.countryId>0;//所在地区
            BOOL isSelectManageType = [appManager.LevelName isEqualToString:@"请输入您的经营类型"];
            BOOL isSelectManageBrand = [appManager.manageBrand isEqualToString:@"请选择您的主营品牌，最多可选择8个"];
            BOOL isFillRegisterAddress = _registerAddress.length;
            if (!isSelectArea) {
                [CYTToast warningToastWithMessage:@"请选择你的所在地区"];
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }else if (!isFillRegisterAddress) {
                [CYTToast warningToastWithMessage:CYTFillAddressTip];
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }else if (isSelectManageType || !appManager.LevelName) {
                [CYTToast warningToastWithMessage:CYTSelectManageTypeTip];
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }else if (isSelectManageBrand || !appManager.manageBrand){
                [CYTToast warningToastWithMessage:CYTSelectManageBrandTip];
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }else if ([[self.certificatePhotos firstObject] isKindOfClass:[NSString class]] && [[self.certificatePhotos firstObject] isEqualToString:@""]){
                [CYTToast warningToastWithMessage:CYTSelectBusinessLicenseTip];
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }else{
                CYTAppManager *appManager = [CYTAppManager sharedAppManager];
                appManager.CompanyName = _companyName;
                CYTCommitCertificateModel *commitCertificateModel = [[CYTCommitCertificateModel alloc] init];
                commitCertificateModel.userName = appManager.UserName;
                commitCertificateModel.idCard = appManager.IDCard;
                commitCertificateModel.frontIDCardOriginalPic = appManager.FrontIDCardOriginalPic;
                commitCertificateModel.oppositeIDCardOriginalPic = appManager.OppositeIDCardOriginalPic;
                commitCertificateModel.holdIDCardOriginalPic = appManager.HoldIDCardOriginalPic;
                commitCertificateModel.companyName = appManager.CompanyName;
                commitCertificateModel.registerAddress = appManager.detailAddress;
                commitCertificateModel.dealerMemberLevelId = appManager.LevelId;
                commitCertificateModel.carBrandIdStr = appManager.manageBrandId;
                commitCertificateModel.businessLicenseOriginalPic = appManager.BusinessLlicenseOriginalPic;
                commitCertificateModel.exhibitOriginalPic = appManager.ExhibitOriginalPic;
                commitCertificateModel.registerAddress = _registerAddress;
                commitCertificateModel.countryId = appManager.countryId;
                [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
                [CYTNetworkManager POST:kURL.user_authorization_submitAuthenticateAduit parameters:commitCertificateModel.mj_keyValues dataTask:nil showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
                    [CYTLoadingView hideLoadingView];
                    [subscriber sendNext:responseObject];
                    [subscriber sendCompleted];
                }];
            }
            return nil;
        }];
        
    }];
    
    
}


@end
