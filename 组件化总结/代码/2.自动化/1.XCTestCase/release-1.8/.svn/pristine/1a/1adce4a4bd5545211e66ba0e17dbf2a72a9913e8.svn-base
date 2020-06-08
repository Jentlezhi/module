//
//  CYTMyCouponViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/27.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTMyCouponViewController.h"
#import "CYTMyCouponCardTagView.h"
#import "CYTCouponMainViewCell.h"
#import "CYTMyCouponSubViewController.h"

// 复用标识
static NSString *const identifier = @"CYTCouponMainViewCell";
CGFloat const couponCardTagViewH = 90.f;

@interface CYTMyCouponViewController ()<UIScrollViewDelegate>
/** 卡券类型 */
@property(assign, nonatomic) CYTMyCouponCardType myCouponVCCardType;
/** 标签视图 */
@property(strong, nonatomic) CYTMyCouponCardTagView *couponCardTagView;
/** 内容视图 */
@property(strong, nonatomic) UIScrollView *contentScrollview;
/** 内容视图子视图 */
@property(strong, nonatomic) NSMutableArray *contentSubViews;
/** 子视图集合 */
@property(strong, nonatomic) NSMutableArray *couponSubViews;
/** 导航栏父视图 */
@property(weak, nonatomic) UIView *navBarSuperview;

@end

@implementation CYTMyCouponViewController

+ (instancetype)myCouponWithCouponCardType:(CYTMyCouponCardType)couponCardType{
    CYTMyCouponViewController *myCouponViewController = [[CYTMyCouponViewController alloc] init];
    myCouponViewController.myCouponVCCardType = couponCardType;
    return myCouponViewController;
}

- (CYTMyCouponCardTagView *)couponCardTagView{
    if (!_couponCardTagView) {
        _couponCardTagView = [[CYTMyCouponCardTagView alloc] initWithCouponCardType:self.myCouponVCCardType];
        _couponCardTagView.frame = CGRectMake(0, CYTViewOriginY, kScreenWidth, CYTAutoLayoutV(couponCardTagViewH));
    }
    return _couponCardTagView;
}

- (UIScrollView *)contentScrollview{
    if (!_contentScrollview) {
        _contentScrollview = [[UIScrollView alloc] init];
        CGFloat contentScrollviewY = CYTAutoLayoutV(couponCardTagViewH) + CYTViewOriginY;
        _contentScrollview.frame = CGRectMake(0, contentScrollviewY, kScreenWidth, kScreenHeight - contentScrollviewY);
        _contentScrollview.pagingEnabled = YES;
        _contentScrollview.delegate = self;
        _contentScrollview.backgroundColor = [UIColor clearColor];
        _contentScrollview.showsHorizontalScrollIndicator = NO;
        
    }
    return _contentScrollview;
}
- (NSMutableArray *)contentSubViews{
    if (!_contentSubViews) {
        _contentSubViews = [NSMutableArray array];
    }
    return _contentSubViews;
}
- (NSMutableArray *)couponSubViews{
    if (!_couponSubViews) {
        _couponSubViews = [NSMutableArray array];
    }
    return _couponSubViews;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self myCouponBasicConfig];
    [self initMyCouponComponents];
    [self tagClicked];
}
/**
 *  基本配置
 */
- (void)myCouponBasicConfig{
    NSString *title = self.myCouponVCCardType == CYTMyCouponCardTypeDefault ? @"我的卡券":@"选择卡券";
    [self createNavBarWithTitle:title andShowBackButton:YES showRightButtonWithTitle:@"使用说明"];
    self.interactivePopGestureEnable = NO;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBarSuperview = self.navigationController.navigationBar.superview;
    [self.navigationController.navigationBar removeFromSuperview];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navBarSuperview addSubview:self.navigationController.navigationBar];
}
/**
 *  右item点击事件
 */
- (void)rightButtonClick:(UIButton *)rightButton{
    CYTH5WithInteractiveCtr *ctr = [[CYTH5WithInteractiveCtr alloc] init];
    ctr.requestURL = kURL.kURLCoupon_used_help;
    [self.navigationController pushViewController:ctr animated:YES];
}
/**
 *  初始化子控件
 */
- (void)initMyCouponComponents{
    //标签视图
    [self.view addSubview:self.couponCardTagView];
    //主视图
    [self.view addSubview:self.contentScrollview];
    CYTWeakSelf
    if (self.myCouponVCCardType == CYTMyCouponCardTypeDefault) {
        //未使用
        CYTMyCouponSubViewController *unUsedVC = [CYTMyCouponSubViewController myCouponWithCouponCardType:CYTCouponStatusTypeUnused];
        unUsedVC.couponTagBlock = ^(CYTCouponTagModel *couponTagModel) {
            weakSelf.couponCardTagView.couponTagModel = couponTagModel;
        };
        [self addChildViewController:unUsedVC];
        [self.couponSubViews addObject:unUsedVC.view];
        [self scrollViewDidEndDecelerating:self.contentScrollview];
        
        //已使用
        CYTMyCouponSubViewController *usedVC = [CYTMyCouponSubViewController myCouponWithCouponCardType:CYTCouponStatusTypeUsed];
        usedVC.couponTagBlock = ^(CYTCouponTagModel *couponTagModel) {
            weakSelf.couponCardTagView.couponTagModel = couponTagModel;
        };
        [self addChildViewController:usedVC];
        [self.couponSubViews addObject:usedVC.view];

        //已过期
        CYTMyCouponSubViewController *expirdVC = [CYTMyCouponSubViewController myCouponWithCouponCardType:CYTCouponStatusTypeExpired];
        expirdVC.couponTagBlock = ^(CYTCouponTagModel *couponTagModel) {
            weakSelf.couponCardTagView.couponTagModel = couponTagModel;
        };
        [self addChildViewController:expirdVC];
        [self.couponSubViews addObject:expirdVC.view];
    }else{
        //可用
        CYTMyCouponSubViewController *availableVC = [CYTMyCouponSubViewController myCouponWithCouponCardType:CYTCouponStatusTypeAvailable];
        availableVC.demandPriceId = self.demandPriceId;
        availableVC.couponListItemModel = self.couponListItemModel;
        availableVC.view.backgroundColor = [UIColor orangeColor];
        availableVC.couponTagBlock = ^(CYTCouponTagModel *couponTagModel) {
            weakSelf.couponCardTagView.couponTagModel = couponTagModel;
        };
        availableVC.couponSelectBlock = ^(CYTCouponListItemModel *couponListItemModel){
            !weakSelf.couponSelectBlock?:weakSelf.couponSelectBlock(couponListItemModel);
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        [self addChildViewController:availableVC];
        [self.couponSubViews addObject:availableVC.view];
        [self scrollViewDidEndDecelerating:self.contentScrollview];
        //不可用
        CYTMyCouponSubViewController *notAvailableVC = [CYTMyCouponSubViewController myCouponWithCouponCardType:CYTCouponStatusTypeNotAvailable];
        notAvailableVC.demandPriceId = self.demandPriceId;
        notAvailableVC.view.backgroundColor = [UIColor redColor];
        notAvailableVC.couponTagBlock = ^(CYTCouponTagModel *couponTagModel) {
            weakSelf.couponCardTagView.couponTagModel = couponTagModel;
        };
        [self addChildViewController:notAvailableVC];
        [self.couponSubViews addObject:notAvailableVC.view];
    }
    
    //设置内容视图容量
    self.contentScrollview.contentSize = CGSizeMake(kScreenWidth*self.couponSubViews.count, 0);
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/scrollView.frame.size.width;
    self.couponCardTagView.currentIndex = index;
    [self addSubviewWithIndex:index];
}
- (void)addSubviewWithIndex:(NSInteger)index{
    UIView *subView = self.couponSubViews[index];
    if ([self.contentSubViews containsObject:subView])return;
    CGFloat subViewX = index*kScreenWidth;
    CGFloat subViewY = 0;
    CGFloat subViewW = kScreenWidth;
    CGFloat subViewH = self.contentScrollview.frame.size.height;
    subView.frame = CGRectMake(subViewX, subViewY, subViewW, subViewH);
    [self.contentScrollview addSubview:subView];
    [self.contentSubViews addObject:subView];
}

/**
 *  标签的点击
 */
- (void)tagClicked{
    CYTWeakSelf
   self.couponCardTagView.indicatorClicked = ^(NSInteger index) {
       [weakSelf addSubviewWithIndex:index];
       weakSelf.contentScrollview.contentOffset = CGPointMake(index * kScreenWidth, 0);
   };
}
@end
