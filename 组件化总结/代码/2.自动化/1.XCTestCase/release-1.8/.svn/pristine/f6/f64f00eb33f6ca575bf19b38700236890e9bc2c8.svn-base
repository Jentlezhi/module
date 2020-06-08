//
//  CYTSettingViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 17/5/21.
//  Copyright (c) 2017年 EasyPass. All rights reserved.
//

#import "CYTSettingViewController.h"
#import "CYTSettingModel.h"
#import "CYTSettingItemModel.h"
#import "CYTUserBaseInfoParameters.h"
#import "CYTFeedBackViewController.h"
#import "CYTAboutUsViewController.h"
#import "CYTPersonalCertificateViewController.h"
#import "CYTShareActionView.h"
#import "CYTShareManager.h"
#import "CYTPhotoSelectTool.h"
#import "CYTCertificationPreviewController.h"
#import "CYTCarContactsViewController.h"
#import "CYTAddressListViewController.h"
#import "CYTSettingTableViewCell.h"
#import "CYTDealerAuthImageViewController.h"
#import "CYTCardView.h"
#import "CYTUserInfoModel.h"
#import "CYTUserCertificationParameters.h"
#import "CYTSignalImageUploadTool.h"

@interface CYTSettingViewController () <UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,copy) NSString *dealerId;
/** 滚动视图 */
@property (nonatomic,strong) UITableView *settingTableView;
/** 选项卡数据 */
@property(strong, nonatomic) NSArray *settingData;
/** 用户认证信息模型 */
@property(strong, nonatomic) CYTUserInfoModel *userAuthenticateInfoModel;

@property (nonatomic, strong) CYTShareActionView *shareActionView;

@end

@implementation CYTSettingViewController

- (UITableView *)settingTableView{
    if (!_settingTableView) {
        CGRect frame = CGRectMake(0, CYTViewOriginY, kScreenWidth, kScreenHeight - CYTViewOriginY);
        _settingTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        if (@available(iOS 11.0, *)) {
            _settingTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _settingTableView.estimatedSectionFooterHeight = 0;
            _settingTableView.estimatedSectionHeaderHeight = 0;
        }
        _settingTableView.contentInset = UIEdgeInsetsMake(CYTAutoLayoutV(40.f), 0, CYTAutoLayoutV(20.f), 0);
    }
    return _settingTableView;
}

- (NSArray *)settingData{
    NSString *authenStatus = [self certificationDescription];
    NSString *restigerPhoneNum = self.userAuthenticateInfoModel.phone;
    NSString *realStoreDes = [self realStoreCertificationDescription];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"settingData.plist" ofType:nil];
    NSArray *plistData = [NSArray arrayWithContentsOfFile:plistPath];
    NSMutableArray *tempMarray = [NSMutableArray array];
    NSInteger totalCount = plistData.count;
    
    for (NSInteger index = 0; index<totalCount; index++) {
        NSDictionary *dict = plistData[index];
        CYTSettingModel *settingModel = [[CYTSettingModel alloc] init];
        NSString *key =  [[dict allKeys] firstObject];
        settingModel.section = key;
        settingModel.data = [CYTSettingItemModel mj_objectArrayWithKeyValuesArray:[dict valueForKey:key]];
        //手机号和认证描述赋值
        if ([key integerValue] == 0) {
            CYTSettingItemModel *restigerPhoneModel = settingModel.data[1];
            restigerPhoneModel.content = restigerPhoneNum;
            
            CYTSettingItemModel *authentDesModel = settingModel.data[2];
            authentDesModel.content = authenStatus;
            
            CYTSettingItemModel *realStoreDesModel = settingModel.data[3];
            realStoreDesModel.content = realStoreDes;
        }
        [tempMarray addObject:settingModel];
    }
    
    _settingData = [tempMarray mutableCopy];
    
    return _settingData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingBasicConfig];
    [self configSettingTableView];
    [self initSettingComponents];
    [self requestUserInfoData];
}

- (void)hideShareView {
    [self.shareActionView dismissWithAnimation:YES];
}

/**
 *  基本配置
 */
- (void)settingBasicConfig{
    self.view.backgroundColor = kFFColor_bg_nor;
    [self createNavBarWithBackButtonAndTitle:@"设置"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideShareView) name:kHideWindowSubviewsKey object:nil];
}

/**
 *  配置表格
 */
- (void)configSettingTableView{
    self.settingTableView.backgroundColor = CYTLightGrayColor;
    self.settingTableView.delegate = self;
    self.settingTableView.dataSource = self;
    self.settingTableView.tableFooterView = [[UIView alloc] init];
    self.settingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.settingTableView.estimatedRowHeight = CYTAutoLayoutV(100);
    self.settingTableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.settingTableView];
}

/**
 *  初始化子控件
 */
- (void)initSettingComponents{
    
}

/**
 * 请求用户数据
 */
- (void)requestUserInfoData{
    CYTUserCertificationParameters *userCertificationParameters = [[CYTUserCertificationParameters alloc] init];
    userCertificationParameters.userID = CYTUserId;
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
    [[CYTAccountManager sharedAccountManager] updateUserInfoCompletion:^(CYTUserInfoModel *userAuthenticateInfoModel) {
        [CYTLoadingView hideLoadingView];
        self.userAuthenticateInfoModel = userAuthenticateInfoModel;
        [self.settingTableView reloadData];
    }];
}

- (NSString *)certificationDescription{
    NSInteger authenticateState = self.userAuthenticateInfoModel.authStatus;
    switch (authenticateState) {
        case 0:
            return @"去认证";
            break;
        case 1:
            return @"审核中";
            break;
        case 2:
            return @"已认证";
            break;
        case -2:
            return @"请修改";
            break;
        default:
            return @"未认证";
            break;
    }
}

- (NSString *)realStoreCertificationDescription{
    return self.userAuthenticateInfoModel.isStoreAuth?@"已认证":@"未认证";
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.settingData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CYTSettingModel *settingModel = self.settingData[section];
    return settingModel.data.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTSettingTableViewCell *cell = [[CYTSettingTableViewCell alloc] init];
    CYTSettingModel *settingModel = self.settingData[indexPath.section];
    CYTSettingItemModel *itemModel = settingModel.data[indexPath.row];
    itemModel.hiddeDividerLine = indexPath.row == (settingModel.data.count-1);
    itemModel.picUrl = self.userAuthenticateInfoModel.avatar;
    itemModel.onlyTitle = (indexPath.section != 0)?YES:NO;
    cell.settingItemModel = itemModel;
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.0001f;
    }
    return CYTAutoLayoutV(40.f);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return CYTAutoLayoutV(150.f);
    }
    return CYTAutoLayoutV(90);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0://头像、注册电话、个人和企业认证
        {
            switch (indexPath.row) {
                case 0://设置头像
                    [self setUserPicture];
                    break;
                case 2://个人和企业认证
                    [self personalAndCompanyCertifications];
                    break;
                case 3://实体店认证
                    [self physicalStoreCertifications];
                    break;
                default:
                    break;
            }
        }
            break;
        case 1://地址管理、收车联系人、发车联系人
        {
            switch (indexPath.row) {
                case 0://地址管理
                    [self addressManage];
                    break;
                case 1://收车联系人
                    [self contactsWithType:CYTCarContactsTypeReceiverDefault];
                    break;
                case 2://发车联系人
                    [self contactsWithType:CYTCarContactsTypeSenderDefault];
                    break;
                default:
                    break;
            }
        }
            break;
        case 2://分享
        {
            switch (indexPath.row) {
                case 0://分享
                    [self share];
                    break;
                default:
                    break;
            }
        }
            break;
        case 3://服务协议
        {
            switch (indexPath.row) {
                case 0://用户注册协议
                    [self protocolWithTitle:@"用户注册协议" requestUrlString:kURL.kUserProtocolUrl];
                    break;
                case 1://在线交易协议
                    [self protocolWithTitle:@"在线交易协议" requestUrlString:kURL.kURL_me_set_deal];
                    break;
                case 2://车辆运输区间服务协议
                    [self protocolWithTitle:@"车辆运输居间服务协议" requestUrlString:kURL.kURL_me_set_transport];
                    break;
                default:
                    break;
            }
        }
            break;
        case 4://意见反馈、关于
        {
            switch (indexPath.row) {
                case 0://意见反馈
                    [self feedBack];
                    break;
                case 1://关于
                    [self aboutUs];
                    break;
                default:
                    break;
            }
        }
            break;
        case 5://退出
        {
            switch (indexPath.row) {
                case 0://退出
                    [self logOut];
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
}
/**
 * 设置用户头像
 */
- (void)setUserPicture{
    @weakify(self);
    [CYTPhotoSelectTool photoSelectToolWithImageMode:CYTImageModeAllowsEditing image:^(UIImage *selectedImage) {
        @strongify(self);
        [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeNotEditable];
        [CYTSignalImageUploadTool uploadWithImage:selectedImage parameters:nil url:kURL.user_info_updateAvatar success:^(CYTUploadImageResult *result) {
            if (result.result) {
                [self requestUserInfoData];
                !self.changeHeaderSuccess?:self.changeHeaderSuccess();
            }
        } fail:nil];
    }];
}

/**
 * 个人和企业认证
 */
- (void)personalAndCompanyCertifications{
    AccountState accountState = [[CYTAuthManager manager] getLocalAccountState];
    if (accountState== AccountStateAuthenticationed || accountState== AccountStateAuthenticating) {
        CYTCertificationPreviewController *certificationPreviewController = [[CYTCertificationPreviewController alloc] init];
        certificationPreviewController.accountState = accountState;
        [self.navigationController pushViewController:certificationPreviewController animated:YES];
    }else{
        CYTPersonalCertificateViewController *personalCertificateVC = [[CYTPersonalCertificateViewController alloc] init];
        personalCertificateVC.backType = CYTBackTypePop;
        [self.navigationController pushViewController:personalCertificateVC animated:YES];
    }
}

/**
 * 实体店认证
 */
- (void)physicalStoreCertifications{
    if (!CYTIsStoreAuth) {
        CYTCardView *carView = [CYTCardView showCardViewWithType:CYTCardViewTypeUnauthorized];
        carView.operationBtnClick = ^(BOOL neverShowAgain){
            //联系客服
            [CYTPhoneCallHandler makeServicePhone];
        };
        return;
    }
    CYTDealerAuthImageViewController *authImage = [CYTDealerAuthImageViewController new];
    authImage.viewModel.userId = CYTUserId;
    authImage.viewModel.onlyEntityShow = YES;
    [self.navigationController pushViewController:authImage animated:YES];
}

/**
 * 地址管理
 */
- (void)addressManage{
    CYTWeakSelf
    [self authenticateAlertWithBlock:^{
        CYTAddressListViewController *addressList = [CYTAddressListViewController new];
        [weakSelf.navigationController pushViewController:addressList animated:YES];
    }];
}

/**
 * 收车/发车联系人
 */
- (void)contactsWithType:(CYTCarContactsType)carContactsType{
    CYTWeakSelf
    [self authenticateAlertWithBlock:^{
        CYTCarContactsViewController *carContactsViewController = [CYTCarContactsViewController carContactsWithType:carContactsType];
        [weakSelf.navigationController pushViewController:carContactsViewController animated:YES];
    }];

    
}
/**
 * 分享
 */
- (void)share{
    CYTShareActionView *share = [CYTShareActionView new];
    [share setClickedBlock:^(NSInteger tag) {
        CYTShareRequestModel *model = [CYTShareRequestModel new];
        model.plant = tag;
        model.type = ShareTypeId_applink;
        [CYTShareManager shareWithRequestModel:model];
    }];
    [share showWithSuperView:self.view];
    self.shareActionView = share;
}
/**
 * 协议
 */
- (void)protocolWithTitle:(NSString *)title requestUrlString:(NSString *)urlString{
    CYTH5WithInteractiveCtr *h5 = [[CYTH5WithInteractiveCtr alloc] init];
    h5.requestURL = urlString;
    [self.navigationController pushViewController:h5 animated:YES];
}
/**
 * 意见反馈
 */
- (void)feedBack{
    CYTFeedBackViewController *feedBack = [CYTFeedBackViewController new];
    [self.navigationController pushViewController:feedBack animated:YES];
}
/**
 * 关于
 */
- (void)aboutUs{
    [self.navigationController pushViewController:[CYTAboutUsViewController new] animated:YES];
}
/**
 * 退出
 */
- (void)logOut{
    CYTWeakSelf
    [CYTAlertView alertViewWithTitle:@"提示" message:@"确定要退出登录吗？" confirmAction:^{
       dispatch_async(dispatch_get_main_queue(), ^{
           [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeNotEditable];
           [CYTNetworkManager POST:kURL.user_identity_logOut parameters:nil dataTask:nil showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
               [CYTLoadingView hideLoadingView];
               if (responseObject.resultEffective) {
                   [weakSelf exitAction];
               }else {
                   [CYTToast errorToastWithMessage:responseObject.resultMessage];
               }
           }];
       });
    } cancelAction:nil];
}

- (void)exitAction {
    [[CYTAccountManager sharedAccountManager] cleanUserData];
    [kAppdelegate goHomeView];
}

#pragma mark- 所有跳转方法进行权限验证

- (void)authenticateAlertWithBlock:(void(^)(void))block {
    [[CYTAuthManager manager] autoHandleAccountStateWithLocalState:YES result:^(AccountState state) {
        if (state == AccountStateAuthenticationed) {
            !block?:block();
        }
    }];
}

@end
