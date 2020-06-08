//
//  CYTCarTradeCircleCtr.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/22.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarTradeCircleCtr.h"
#import "CYTCarTradeCirclePublishCtr.h"
#import "CYTLoginViewController.h"
#import "CYTPhontoPreviewViewController.h"
#import "CYTPersonalCertificateViewController.h"
#import "CYTCarTradeCircleViewModel.h"
#import "CYTDealerCommentPublishView.h"
#import "CYTNavigationController.h"

@interface CYTCarTradeCircleCtr ()
@property (nonatomic, strong) UIButton *actionButton;

@property (nonatomic, assign) CarTradeViewType in_type;
@property (nonatomic, copy) NSString *in_telNumber;
@property (nonatomic, copy) NSString *in_pubUserId;
@property (nonatomic, copy) NSString *in_momentId;

@property (nonatomic, strong) CYTCarTradeCircleViewModel *viewModel;

///电话监听
@property (nonatomic, strong) CYTCarTradeCircleCallMonitorModel *callMonitorModel;
///评论页面
@property (nonatomic, strong) CYTDealerCommentPublishView *commentPublishView;
///电话检测
@property (nonatomic, strong) FFCallCenterViewModel *callCenter;

@end

@implementation CYTCarTradeCircleCtr

- (void)dealloc {
    [_callCenter endMonitoring];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //电话检测
    [self.callCenter startMonitoringWithCondition:^id{
        return self.callMonitorModel;
    }];
    [self handleAction];
    [self createNavBarWithTitle:@"车商圈" andShowBackButton:YES showRightButtonWithTitle:self.rightBarItemTitle];
    [self bindViewModel];
    [self loadURL];
    [self.commentPublishView config];
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

- (void)bindViewModel {
    @weakify(self);
    [self.viewModel.hudSubject subscribeNext:^(id x) {
        if ([x integerValue] == 0) {
            [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeNotEditable];
        }else{
            [CYTLoadingView hideLoadingView];
        }
    }];
    
    [self.viewModel.deleteCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *model) {
        @strongify(self);
        
        if (model.resultEffective) {
            [CYTToast successToastWithMessage:model.resultMessage];
            if (self.deleteBlock) {
                self.deleteBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [CYTToast errorToastWithMessage:model.resultMessage];
        }
    }];
}

- (void)handleAction {
    self.actionButton.hidden = YES;
    NSString *userId = CYTUserId;
    
    BOOL show = YES;
    
    if (self.type == CarTradeViewTypeList) {
        //列表
        if ([userId isEqualToString:self.pubUserId]) {
            show = NO;
        }
        
        if (show) {
            //显示打电话
            self.rightBarItemTitle = @"打电话";
            self.rightItemButton.hidden = NO;
        }
        
    }else if (self.type == CarTradeViewTypeDetail) {
        show = NO;
        //detail
        if ([userId isEqualToString:self.pubUserId]) {
            show = YES;
        }
        
        if (show) {
            //显示删除
            self.rightBarItemTitle = @"删除";
            self.rightItemButton.hidden = NO;
        }
    }else if (self.type == CarTradeViewTypeHome) {
        self.rightItemButton.hidden = NO;
        self.rightBarItemTitle = @"发布";
    }
    
}

#pragma mark- common

- (BOOL)handleURL:(NSURL *)urlString {
    //父类统一处理h5登录超时,或多设备登录
    [super handleURL:urlString];
    
//    NSLog(@"Scheme: %@", [urlString scheme]);
//    NSLog(@"Host: %@", [urlString host]);
//    NSLog(@"Port: %@", [urlString port]);
//    NSLog(@"Path: %@", [urlString path]);
//    NSLog(@"Relative path: %@", [urlString relativePath]);
//    NSLog(@"Path components as array: %@", [urlString pathComponents]);
//    NSLog(@"Parameter string: %@", [urlString parameterString]);
//    NSLog(@"Query: %@", [urlString query]);

    NSString *queryString = [urlString query];
    NSString *hostStander = @"www.bitauto.com";
    NSString *host = [urlString host];
    NSString *titleString = @"";
    NSArray *componetsArray = [urlString pathComponents];
    
    if ([componetsArray containsObject:@"image_preview"]) {
        [self goImageReviewWithURL:queryString];
        return NO;
    }else {
        if (queryString) {
            if ([host isEqualToString:hostStander] ) {
                
                if ([queryString hasPrefix:@"url="]) {
                    //url格式"url=moments/personalList?userId=1038"
                    NSString *newURL = [queryString substringFromIndex:4];
                    NSArray *parametersArray = [newURL componentsSeparatedByString:@"?"];
                    if ([parametersArray containsObject:@"moments/personalList"]) {
                        //列表页，有打电话
                        titleString = @"车商圈";
                        self.in_type = CarTradeViewTypeList;
                        
                        if (parametersArray.count>1) {
                            NSString *paraArrayTmp = parametersArray[1];
                            NSArray *tmp = [paraArrayTmp componentsSeparatedByString:@"&"];
                            for (int i=0; i<tmp.count; i++) {
                                NSString *strTmp = tmp[i];
                                if ([strTmp hasPrefix:@"phone"]) {
                                    self.in_telNumber = [strTmp substringFromIndex:6];
                                }
                                if ([strTmp hasPrefix:@"userId"]) {
                                    self.in_pubUserId = [strTmp substringFromIndex:7];
                                }
                            }
                        }
                        
                    }else if ([parametersArray containsObject:@"moments/detail"]) {
                        //详情，有删除
                        titleString = @"详情";
                        self.in_type = CarTradeViewTypeDetail;
                        
                        if (parametersArray.count>1) {
                            NSString *paraArrayTmp = parametersArray[1];
                            NSArray *tmp = [paraArrayTmp componentsSeparatedByString:@"&"];
                            for (int i=0; i<tmp.count; i++) {
                                NSString *strTmp = tmp[i];
                                if ([strTmp hasPrefix:@"momentId"]) {
                                    self.in_momentId = [strTmp substringFromIndex:9];
                                }
                                if ([strTmp hasPrefix:@"userId"]) {
                                    self.in_pubUserId = [strTmp substringFromIndex:7];
                                }
                            }
                        }
                    }
                    
                    //拼接成新的URL
                    newURL = [NSString stringWithFormat:@"%@%@",kURL.H5URLBase,newURL];
                    [self goOtherView:newURL title:titleString];
                    return NO;

                }else {
                    //url格式"userId=1038&phone=1831234534"
                    
                    NSString *userId = @"";
                    NSString *phone = @"";

                    NSArray *tmp = [[queryString copy] componentsSeparatedByString:@"&"];
                    for (int i=0; i<tmp.count; i++) {
                        NSString *strTmp = tmp[i];
                        if ([strTmp hasPrefix:@"phone"]) {
                            phone = [strTmp substringFromIndex:6];
                        }
                        if ([strTmp hasPrefix:@"userId"]) {
                            userId = [strTmp substringFromIndex:7];
                        }
                    }

                    self.callMonitorModel.type = 1;
                    self.callMonitorModel.userId = userId;
                    [CYTPhoneCallHandler makePhoneWithNumber:phone alert:@"联系对方?" resultBlock:^(BOOL state) {
                        
                    }];
                    return NO;
                }
            }
        }
    }
    
    return YES;
}

- (void)goImageReviewWithURL:(NSString *)url {
    ///图片浏览
    NSArray *componetsArray = [url componentsSeparatedByString:@"&"];
    if (componetsArray.count==2) {
        NSString *indexString = componetsArray[0];
        indexString = [indexString substringFromIndex:6];
        
        NSString *imageUrlString = componetsArray[1];
        imageUrlString = [imageUrlString substringFromIndex:5];
        
        NSInteger index = [indexString integerValue];
        NSArray *imageUrlArray = [imageUrlString componentsSeparatedByString:@","];
        
        
        CYTPhontoPreviewViewController *photoPreviewVC = [[CYTPhontoPreviewViewController alloc] init];
        photoPreviewVC.netImage = YES;
        photoPreviewVC.images = [imageUrlArray mutableCopy];
        photoPreviewVC.index = index;
        [self.navigationController pushViewController:photoPreviewVC animated:YES];
    }
}

///跳转到其他页面
- (void)goOtherView:(NSString *)url title:(NSString *)title{
    CYTCarTradeCircleCtr *ctr = [[CYTCarTradeCircleCtr alloc] init];
    @weakify(self);
    [ctr setDeleteBlock:^{
        @strongify(self);
        [self.webView reload];
    }];
    ctr.requestURL = url;
    ctr.telNumber = self.in_telNumber;
    ctr.pubUserId = self.in_pubUserId;
    ctr.momentId = self.in_momentId;
    ctr.type = self.in_type;
    [self.navigationController pushViewController:ctr animated:YES];
}
/**
 *  发布按钮的点击
 */
- (void)rightButtonClick:(UIButton *)rightButton{
    
    if (self.type == CarTradeViewTypeList) {
        //打电话
        self.callMonitorModel.type = 0;
        self.callMonitorModel.userId = self.pubUserId;
        
        [CYTPhoneCallHandler makePhoneWithNumber:self.telNumber alert:@"拨打电话" resultBlock:^(BOOL status) {
            //none
        }];
    }else if (self.type == CarTradeViewTypeDetail) {
        //删除
        [CYTAlertView alertViewWithTitle:@"提示" message:@"确定删除？" confirmAction:^{
            self.viewModel.momentId = self.momentId;
            [self.viewModel.deleteCommand execute:nil];
        } cancelAction:nil];
        
    }else if (self.type == CarTradeViewTypeHome) {
        //发布
        [self goPublishView];
    }
    
}

///发布
- (void)goPublishView {
    //发布统计
    [MobClick event:@"CSQ_FB"];
    [[CYTAuthManager manager] autoHandleAccountStateWithLocalState:NO result:^(AccountState state) {
        if (state == AccountStateAuthenticationed) {
            CYTCarTradeCirclePublishCtr *ctr = [CYTCarTradeCirclePublishCtr new];
            @weakify(self);
            [ctr setRefreshBlock:^{
                @strongify(self);
                [self.webView reload];
            }];
            CYTNavigationController *nav = [[CYTNavigationController alloc] initWithRootViewController:ctr];
            [self presentViewController:nav animated:YES completion:nil];
        }
    }];
}

- (CYTCarTradeCircleViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [CYTCarTradeCircleViewModel new];
    }
    return _viewModel;
}

- (CYTDealerCommentPublishView *)commentPublishView {
    if (!_commentPublishView) {
       
        CYTDealerCommentPublishModel *model = [CYTDealerCommentPublishModel new];
        //被评论认用户Id
        model.beEvalUserId = @"";
        //评价类型1=电话、2=订单
        model.sourceType = @"1";
        //评价来源1=车源详情 2=寻车详情 3=个人主页 4=买家订单 5=卖家订单 6=车商圈
        model.sourceId = @"6";

        CYTDealerCommentPublishVM *vm = [[CYTDealerCommentPublishVM alloc] initWithModel:model];
        [vm.hudSubject subscribeNext:^(id x) {
            if ([x integerValue] == 0) {
                [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeNotEditable];
            }else {
                [CYTLoadingView hideLoadingView];
            }
        }];
        
        [vm.requestCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
            //不论成功失败都清空，因为车商圈评价的可以是不同的人
            _commentPublishView = nil;
            [CYTToast messageToastWithMessage:responseModel.resultMessage];
        }];
        _commentPublishView = [[CYTDealerCommentPublishView alloc] initWithViewModel:vm];
        _commentPublishView.title = @"发布评价";
    }
    return _commentPublishView;
}

- (CYTCarTradeCircleCallMonitorModel *)callMonitorModel {
    if (!_callMonitorModel) {
        _callMonitorModel = [CYTCarTradeCircleCallMonitorModel new];
    }
    return _callMonitorModel;
}

- (FFCallCenterViewModel *)callCenter {
    if (!_callCenter) {
        _callCenter = [FFCallCenterViewModel new];
        @weakify(self);
        [_callCenter setIsDialingBlock:^(CYTCarTradeCircleCallMonitorModel *model) {
            @strongify(self);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                if (model.type == -1) {return ;}
                if (model.type == 0) {
                    //右上角打电话
                    [MobClick event:@"CSQ_GRZY_DHHC"];
                }else {
                    //列表中打电话
                    [MobClick event:@"CSQ_LB_DHHC"];
                }

                if (![model.userId isEqualToString:CYTUserId]) {
                    //给别人通话后
                    self.commentPublishView.viewModel.model.beEvalUserId = model.userId;
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

@end
