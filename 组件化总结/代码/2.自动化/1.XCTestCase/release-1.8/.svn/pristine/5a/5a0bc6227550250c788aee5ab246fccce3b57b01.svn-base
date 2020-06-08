//
//  CYTScrollMessageView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/11.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTScrollMessageView.h"
#import "SDCycleScrollView.h"
#import "CYTScrollMessageCell.h"
#import "CYTStoreAuthModel.h"
#import "CYTDealerHisHomeTableController.h"
#import "CYTDealerMeHomeTableController.h"


@interface CYTScrollMessageView()<SDCycleScrollViewDelegate>
/** 轮播消息 */
@property(strong, nonatomic) SDCycleScrollView *messageBgView;
@end

@implementation CYTScrollMessageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self scrollMessageBasicConfig];
        [self initScrollMessageComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)scrollMessageBasicConfig{
}
/**
 *  初始化子控件
 */
- (void)initScrollMessageComponents{
    [self addSubview:self.messageBgView];
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    [self.messageBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
}
#pragma mark - 懒加载

- (SDCycleScrollView *)messageBgView{
    if (!_messageBgView) {
        _messageBgView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
        _messageBgView.showPageControl = NO;
        _messageBgView.onlyDisplayText = YES;
        _messageBgView.userInteractionEnabled = YES;
        _messageBgView.autoScrollTimeInterval = 5.f;
//        _messageBgView.placeholderImage = [UIImage imageNamed:@"home_messageBgView_placeholder"];
        _messageBgView.scrollDirection = UICollectionViewScrollDirectionVertical;
        _messageBgView.backgroundColor = CYTLightGrayColor;
        _messageBgView.autoScroll = YES;
        [_messageBgView disableScrollGesture];
    }
    return _messageBgView;
}
#pragma mark - 自定义轮播
- (Class)customCollectionViewCellClassForCycleScrollView:(SDCycleScrollView *)view{
    return [CYTScrollMessageCell class];
}
- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view{
    CYTScrollMessageCell *messageCell = (CYTScrollMessageCell*)cell;
    messageCell.storeAuthModel = self.storeAuthModels[index];
}

#pragma mark - <SDCycleScrollViewDelegate>

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    CYTStoreAuthModel *storeAuthModel = self.storeAuthModels[index];
    if (storeAuthModel.userId == [CYTAccountManager sharedAccountManager].userId) {
       CYTDealerMeHomeTableController *dealerMeHomeVC = CYTDealerMeHomeTableController.new;
        dealerMeHomeVC.viewModel.userId = storeAuthModel.userId;
        [[CYTCommonTool currentViewController].navigationController pushViewController:dealerMeHomeVC animated:YES];
    }else{
        //需要登录
        BOOL islogin = [CYTAccountManager sharedAccountManager].isLogin;
        //未登录
        if (!islogin) {
            [[CYTAuthManager manager] goLoginView];
            return;
        }
        //需要认证
        [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditTabBar];
        [[CYTAccountManager sharedAccountManager] updateUserInfoCompletion:^(CYTUserInfoModel *userAuthenticateInfoModel) {
            [CYTLoadingView hideLoadingView];
            if (userAuthenticateInfoModel) {
                BOOL authed = userAuthenticateInfoModel.authStatus == 2;
                if (authed) {
                    CYTDealerHisHomeTableController *dealerHisHomeVC = CYTDealerHisHomeTableController.new;
                    dealerHisHomeVC.viewModel.userId = storeAuthModel.userId;
                    [[CYTCommonTool currentViewController].navigationController pushViewController:dealerHisHomeVC animated:YES];
                }else{
                    [[CYTAuthManager manager] alert_authenticate];
                }
            }else{
                [CYTToast errorToastWithMessage:CYTNetworkError];
            }
        }];
    
    }
}
- (void)setStoreAuthModels:(NSArray *)storeAuthModels{
    _storeAuthModels = storeAuthModels;
    self.messageBgView.autoScroll = YES;
    self.messageBgView.titlesGroup = storeAuthModels;
}

@end
