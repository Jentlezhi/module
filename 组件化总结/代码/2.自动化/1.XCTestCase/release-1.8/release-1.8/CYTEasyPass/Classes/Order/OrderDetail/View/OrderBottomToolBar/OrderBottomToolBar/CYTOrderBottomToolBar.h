//
//  CYTOrderBottomToolBar.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/20.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYTOrderBottomToolBar : UIView

/** 申请订金退回是否可点击 */
@property(assign, nonatomic) BOOL sendbackSendbackEnable;

/** 付订金给卖家是否可点击 */
@property(assign, nonatomic) BOOL sendbackPayforSellerEnable;

/** 确认并退回订金给买家 */
@property(assign, nonatomic) BOOL confirmAndPayPayEnable;

/** 提交是否可点击 */
@property(assign, nonatomic) BOOL commitBtnEnable;

+ (instancetype)bottomToolBarrWithBarType:(CYTOrderToolBarType)orderToolBarType;

- (void)toolBarWithOnlyContactServer:(void(^)(UIView *server))server contact:(void(^)(UIView *contact))contact;

- (void)toolBarWithCancelOrderServer:(void(^)(UIView *server))server contact:(void(^)(UIView *contact))contact cancelOrder:(void(^)(UIView *cancelOrder))cancelOrder;

- (void)toolBarWithConfirmAndPayServer:(void(^)(UIView *server))server contact:(void(^)(UIView *pay))pay;

- (void)toolBarWithCommitServer:(void(^)(UIView *server))server contact:(void(^)(UIView *commit))commit;

- (void)toolBarWithGotoPayWithSendbackServer:(void(^)(UIView *server))server contact:(void(^)(UIView *contact))contact cancelOrder:(void(^)(UIView *gotoPay))gotoPay;

- (void)toolBarWithConfirmRecCarWithSendbackServer:(void(^)(UIView *server))server contact:(void(^)(UIView *contact))contact confirmRecCar:(void(^)(UIView *confirmRecCar))confirmRecCar;
- (void)toolBarWithConfirmSendCarWithSendbackServer:(void(^)(UIView *server))server contact:(void(^)(UIView *contact))contact cancelOrder:(void(^)(UIView *confirmSendCar))confirmSendCar;
- (void)toolBarWithSeeExpressWithConfirmRecCarWithSendbackServer:(void(^)(UIView *server))server contact:(void(^)(UIView *contact))contact cancelOrder:(void(^)(UIView *seeExpress))seeExpress;
- (void)toolBarWithCancelAndConfirmWithConfirmRecCarWithSendbackServer:(void(^)(UIView *server))server contact:(void(^)(UIView *cancel))cancel cancelOrder:(void(^)(UIView *confirm))confirm;
- (void)toolBarWithSendbackAndPayforServer:(void(^)(UIView *server))server contact:(void(^)(UIView *sendback))sendback cancelOrder:(void(^)(UIView *payfoSeller))payfoSeller;
/**
 *  自定义底部按钮（返回btn）
 */
+ (instancetype)orderDetailToolBarReturnButtonWithTitles:(NSArray <NSString *>*)titles  imageNames:(NSArray <NSString *>*)imageNames firstBtnClick:(void(^)(UIButton *firstBtn))firstBtnClick secondBtnClick:(void(^)(UIButton *secondBtn))secondBtnClick thirdBtnClick:(void(^)(UIButton *thirdBtn))thirdBtnClick fourthBtnClick:(void(^)(UIButton *fourthBtn))fourthBtnClick;
/**
 *  自定义底部按钮（新）
 */
+ (instancetype)bottomToolBarrWithBarType:(CYTOrderToolBarType)orderToolBarType server:(void(^)(UIView *service))server firstBtnTitle:(NSString *)firstTitle secondBtnTitle:(NSString *)secondTitle firstBtn:(void(^)(UIButton *firstButton))firstButton secondBtn:(void(^)(UIButton *secondBtn))secondBtn firstBtnAction:(void(^)(UIButton *))firstButtonBlock secondBtnAction:(void(^)(UIButton *))secondButtonBlock;
/**
 *  订单详情底部按钮
 */
+ (instancetype)orderDetailToolBarWithTitles:(NSArray <NSString *>*)titles  imageNames:(NSArray <NSString *>*)imageNames firstBtnClick:(void(^)())firstBtnClick secondBtnClick:(void(^)())secondBtnClick thirdBtnClick:(void(^)())thirdBtnClick fourthBtnClick:(void(^)())fourthBtnClick;

+ (instancetype)spe_orderDetailToolBarWithTitles:(NSArray <NSString *>*)titles  imageNames:(NSArray <NSString *>*)imageNames firstBtnClick:(void(^)())firstBtnClick secondBtnClick:(void(^)())secondBtnClick thirdBtnClick:(void(^)())thirdBtnClick fourthBtnClick:(void(^)())fourthBtnClick;

///新增方法
+ (instancetype)orderDetailToolBarWithTitles:(NSArray <NSString *>*)titles  imageNames:(NSArray <NSString *>*)imageNames firstBtnClick:(void(^)())firstBtnClick secondBtnClick:(void(^)())secondBtnClick thirdBtnClick:(void(^)())thirdBtnClick fourthBtnClick:(void(^)())fourthBtnClick buttonsBlock:(void(^)(NSArray *buttons))buttonsBlock;

@end
