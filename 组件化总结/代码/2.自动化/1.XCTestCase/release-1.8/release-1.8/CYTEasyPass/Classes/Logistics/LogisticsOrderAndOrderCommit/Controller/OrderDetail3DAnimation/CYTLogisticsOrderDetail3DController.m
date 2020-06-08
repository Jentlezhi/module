//
//  CYTLogisticsOrderDetail3DController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticsOrderDetail3DController.h"
#import "CYTLogisticsOrderDetailController.h"
#import "CYTExpenseDetailAlertView.h"
#import "CYTLogisticDemandPriceModel.h"

NSTimeInterval const kAnimationDuration = 0.3f;
#define kExpenseDetailViewH CYTAutoLayoutV(80.f+20.f*5+28.f*4)

@interface CYTLogisticsOrderDetail3DController ()

/** 物流订单详情控制器 */
@property(weak, nonatomic) CYTLogisticsOrderDetailController *logisticsOrderDetailController;
/** 动画遮盖 */
@property(strong, nonatomic) UIView *maskView;
/** 费用明细 */
@property(strong, nonatomic) CYTExpenseDetailAlertView *expenseDetailAlertView;

@end

@implementation CYTLogisticsOrderDetail3DController

- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:self.logisticsOrderDetailController.view.bounds];
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
        CYTWeakSelf
        [_maskView addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
            [weakSelf dismissTransform3D];
        }];
        
    }
    return _maskView;
}

- (UIView *)expenseDetailAlertView{
    if (!_expenseDetailAlertView) {
        CYTWeakSelf
        _expenseDetailAlertView = [[CYTExpenseDetailAlertView alloc] init];
        _expenseDetailAlertView.backgroundColor = [UIColor whiteColor];
        _expenseDetailAlertView.layer.shadowColor = [UIColor blackColor].CGColor;
        _expenseDetailAlertView.layer.shadowOffset = CGSizeMake(3, 3);
        _expenseDetailAlertView.layer.shadowOpacity = 0.8;
        _expenseDetailAlertView.layer.shadowRadius = 5.0f;
        _expenseDetailAlertView.frame =  CGRectMake(0, kScreenHeight, kScreenWidth, kExpenseDetailViewH);
        [_expenseDetailAlertView addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
            [weakSelf dismissTransform3D];
        }];
    }
    return _expenseDetailAlertView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self logisticsOrderDetail3DBasicConfig];
    [self initLogisticsOrderDetail3DComponents];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideView) name:kHideWindowSubviewsKey object:nil];
}

- (void)hideView {
    [self dismissTransform3D];
}

/**
 *  基本配置
 */
- (void)logisticsOrderDetail3DBasicConfig{
    self.navigationZone.alpha = 0;
    self.view.backgroundColor = [UIColor blackColor];
}
/**
 *  初始化子控件
 */
- (void)initLogisticsOrderDetail3DComponents{
    //添加物流订单详情
    CYTLogisticsOrderDetailController *logisticsOrderDetailController = [[CYTLogisticsOrderDetailController alloc] init];
    logisticsOrderDetailController.orderId = self.orderId;
    logisticsOrderDetailController.logisticsOrderPushed = self.logisticsOrderPushed;
    logisticsOrderDetailController.showCommentView = self.showCommentView;
    [self addChildViewController:logisticsOrderDetailController];
    [self.view addSubview:logisticsOrderDetailController.view];
    _logisticsOrderDetailController = logisticsOrderDetailController;
    
    //显示折叠效果
    logisticsOrderDetailController.expensesDetailBlock = ^(CYTLogisticDemandPriceModel *logisticDemandPriceModel){
        [kWindow addSubview:self.maskView];
//        logisticDemandPriceModel.couponPrice = @"1000";
        self.expenseDetailAlertView.logisticDemandPriceModel = logisticDemandPriceModel;
        //设置费用明细frame
        CGRect alertViewFrame = CGRectZero;
        CGFloat couponHeight = 28.f;
        if (!logisticDemandPriceModel.couponPrice.length) {
            alertViewFrame = CGRectMake(0, kScreenHeight-kExpenseDetailViewH, kScreenWidth, kExpenseDetailViewH);
        }else{
            alertViewFrame = CGRectMake(0, kScreenHeight-kExpenseDetailViewH-couponHeight, kScreenWidth, kExpenseDetailViewH+couponHeight);
        }
        [kWindow addSubview:self.expenseDetailAlertView];
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.15f];
            self.logisticsOrderDetailController.view.layer.transform = [self firstTransform];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:kAnimationDuration animations:^{
                self.logisticsOrderDetailController.view.layer.transform = [self secondTransform];
                self.expenseDetailAlertView.frame = alertViewFrame;
            } completion:nil];
        }];
        
    };
    
}
/**
 *  移除动画
 */
- (void)dismissTransform3D{
    CYTWeakSelf
    CGRect rec = weakSelf.expenseDetailAlertView.frame;
    rec.origin.y = weakSelf.view.bounds.size.height;
    [UIView animateWithDuration:kAnimationDuration animations:^{
        weakSelf.expenseDetailAlertView.frame = rec;
        weakSelf.logisticsOrderDetailController.view.layer.transform = [weakSelf firstTransform];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:kAnimationDuration animations:^{
            weakSelf.logisticsOrderDetailController.view.layer.transform = CATransform3DIdentity;
            weakSelf.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
        } completion:^(BOOL finished) {
            [weakSelf.expenseDetailAlertView removeFromSuperview];
            [weakSelf.maskView removeFromSuperview];
        }];
        
    }];

}
/**
 *  折叠动画
 */
- (CATransform3D)firstTransform{
    CATransform3D firstForm = CATransform3DIdentity;
    firstForm.m34 = 1.0/-900;
    firstForm = CATransform3DScale(firstForm, 0.95, 0.95, 1);
    firstForm = CATransform3DRotate(firstForm, 15.0 * M_PI/180.0, 1, 0, 0);
    return firstForm;
}
/**
 *  折叠动画
 */
- (CATransform3D)secondTransform{
    CATransform3D secondForm = CATransform3DIdentity;
    secondForm.m34 = [self firstTransform].m34;
    CGFloat secondFormScal = 0.85f;
    secondForm = CATransform3DTranslate(secondForm, 0, -(1-secondFormScal)*kScreenWidth*0.5, 0);
    secondForm = CATransform3DScale(secondForm, secondFormScal, secondFormScal, 1);
    return secondForm;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
