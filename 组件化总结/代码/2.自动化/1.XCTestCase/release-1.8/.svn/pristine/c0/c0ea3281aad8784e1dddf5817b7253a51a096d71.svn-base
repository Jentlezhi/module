//
//  CYTCertificationPreviewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCertificationPreviewController.h"
#import "CYTCertificationPreviewSectionHeader.h"
#import "CYTCertificationPersonalInfoCell.h"
#import "CYTCertificationCompanyInfoCell.h"
#import "CYTUserInfoModel.h"
#import "CYTPhontoPreviewViewController.h"
#import "CYTInfoTipView.h"
#import "CYTUserCertificationParameters.h"

@interface CYTCertificationPreviewController ()<UITableViewDataSource,UITableViewDelegate>

/** 滚动视图 */
@property(strong, nonatomic) UITableView *mainView;
/** 组 */
@property(strong, nonatomic,readonly) NSArray *sectionTitles;
/** 信息模型 */
@property(strong, nonatomic) CYTUserInfoModel *userAuthenticateInfoModel;
/** 图片url */
@property(strong, nonatomic) NSMutableArray *imageUrls;

@end

@implementation CYTCertificationPreviewController
{
    NSArray *_sectionTitles;
    
    //信息条
    CYTInfoTipView *_infoTipView;
}

- (NSMutableArray *)imageUrls{
    if (!_imageUrls) {
        _imageUrls = [NSMutableArray array];
    }
    return _imageUrls;
}

- (NSArray *)sectionTitles{
    if (!_sectionTitles) {
        _sectionTitles = @[@"个人信息",@"企业信息"];
    }
    return _sectionTitles;
}

- (UITableView *)mainView{
    if (!_mainView) {
        _mainView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        if (@available(iOS 11.0, *)) {
            _mainView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _mainView.estimatedSectionFooterHeight = 0;
            _mainView.estimatedSectionHeaderHeight = 0;
        }
    }
    return _mainView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self certificationPreviewBasicConfig];
    [self configorderMainView];
    [self initCertificationPreviewComponents];
    [self makeConstraints];
    [self requestUserCertificationInfo];
}

/**
 *  基本配置
 */
- (void)certificationPreviewBasicConfig{
    [self createNavBarWithBackButtonAndTitle:@"个人和企业认证"];
    self.interactivePopGestureEnable = YES;
}
/**
 *  配置表格
 */
- (void)configorderMainView{
    self.mainView.backgroundColor = [UIColor whiteColor];
    self.mainView.delegate = self;
    self.mainView.dataSource = self;
    self.mainView.tableFooterView = [[UIView alloc] init];
    self.mainView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainView.estimatedRowHeight = CYTAutoLayoutV(700);
    self.mainView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.mainView];
}
/**
 *  初始化子控件
 */
- (void)initCertificationPreviewComponents{
    //信息条
    CYTInfoTipView *infoTipView = [[CYTInfoTipView alloc] init];
    infoTipView.message = @"你的认证申请正在审核中，请您耐心等待。";
    [self.view addSubview:infoTipView];
    _infoTipView = infoTipView;
    
    //移除的回调
    CYTWeakSelf
    typeof(self.mainView) weakMainView = self.mainView;
    _infoTipView.removeActionBlock = ^{
        [weakMainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(CYTViewOriginY);
        }];
        
        [UIView animateWithDuration:0.2f animations:^{
            [weakSelf.view layoutIfNeeded];
        }];
    };
}

- (void)makeConstraints{
    CYTWeakSelf
    if (self.accountState == AccountStateAuthenticating) {
        [_infoTipView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(CYTViewOriginY);
            make.left.right.equalTo(weakSelf.view);
            make.height.equalTo(CYTAutoLayoutV(80.f));
        }];
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_infoTipView.mas_bottom);
            make.left.right.bottom.equalTo(weakSelf.view);
        }];
    }else{
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.view).offset(CYTViewOriginY);
            make.left.right.bottom.equalTo(weakSelf.view);
        }];
    }
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {//个人信息
        CYTCertificationPersonalInfoCell *cell = [CYTCertificationPersonalInfoCell certificationPersonalInfoCelllForTableView:tableView indexPath:indexPath];
        cell.userAuthenticateInfoModel = self.userAuthenticateInfoModel;
        cell.picClickBack = ^(NSUInteger index){
            CYTPhontoPreviewViewController *photoPreviewVC = [[CYTPhontoPreviewViewController alloc] init];
            photoPreviewVC.netImage = YES;
            photoPreviewVC.images = [self.imageUrls mutableCopy];
            photoPreviewVC.index = index;
            [self.navigationController pushViewController:photoPreviewVC animated:YES];
        };
        return cell;
    }else if(indexPath.section == 1){//企业信息
        CYTCertificationCompanyInfoCell *cell = [CYTCertificationCompanyInfoCell certificationCompanyInfoCellForTableView:tableView indexPath:indexPath];
        cell.userAuthenticateInfoModel = self.userAuthenticateInfoModel;
        cell.picClickBack = ^(NSUInteger index){
            CYTPhontoPreviewViewController *photoPreviewVC = [[CYTPhontoPreviewViewController alloc] init];
            photoPreviewVC.netImage = YES;
            photoPreviewVC.images = [self.imageUrls mutableCopy];
            photoPreviewVC.index = index;
            [self.navigationController pushViewController:photoPreviewVC animated:YES];
        };
        return cell;
    }
    return nil;
    
}

#pragma mark - <UITableViewDelegate>

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CYTCertificationPreviewSectionHeader *sectionHeader = [[CYTCertificationPreviewSectionHeader alloc] init];
    sectionHeader.title = self.sectionTitles[section];
    return sectionHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CYTAutoLayoutV(70.f);
}
/**
 * 获取认证信息
 */
- (void)requestUserCertificationInfo{
    CYTUserCertificationParameters *userCertificationParameters = [[CYTUserCertificationParameters alloc] init];
    userCertificationParameters.userID = CYTUserId;
    [CYTLoadingView showBackgroundLoadingWithType:CYTLoadingViewTypeEditNavBar];
    [CYTNetworkManager POST:kURL.user_info_getUserAuthenticateInfo parameters:userCertificationParameters.mj_keyValues dataTask:nil showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
        [CYTLoadingView hideLoadingView];
        if (responseObject.resultEffective) {
            [self dismissNoNetworkView];
            self.userAuthenticateInfoModel = [CYTUserInfoModel mj_objectWithKeyValues:responseObject.dataDictionary];
            if (self.userAuthenticateInfoModel.frontIdCardOriginalPic.length) {
                [self.imageUrls addObject:self.userAuthenticateInfoModel.frontIdCardOriginalPic];
            }else{
                [self.imageUrls addObject:@""];
            }
            if (self.userAuthenticateInfoModel.oppositeIdCardOriginalPic.length) {
                [self.imageUrls addObject:self.userAuthenticateInfoModel.oppositeIdCardOriginalPic];
            }else{
                [self.imageUrls addObject:@""];
            }
            if (self.userAuthenticateInfoModel.holdIdCardOriginalPic.length) {
                [self.imageUrls addObject:self.userAuthenticateInfoModel.holdIdCardOriginalPic];
            }else{
                [self.imageUrls addObject:@""];
            }
            if (self.userAuthenticateInfoModel.businessLicenseOriginalPic.length) {
                [self.imageUrls addObject:self.userAuthenticateInfoModel.businessLicenseOriginalPic];
            }else{
                [self.imageUrls addObject:@""];
            }
            if (self.userAuthenticateInfoModel.exhibitOriginalPic.length) {
                [self.imageUrls addObject:self.userAuthenticateInfoModel.exhibitOriginalPic];
            }
            [self.mainView reloadData];
        }else{
            [self showNoNetworkViewInView:self.view];
        }
    }];
}
/**
 * 重新加载
 */
- (void)reloadData{
    [self requestUserCertificationInfo];
}

- (void)backButtonClick:(UIButton *)backButton{
    if (self.backType == CYTBackTypeDismiss) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [super backButtonClick:backButton];
    }
}

@end
