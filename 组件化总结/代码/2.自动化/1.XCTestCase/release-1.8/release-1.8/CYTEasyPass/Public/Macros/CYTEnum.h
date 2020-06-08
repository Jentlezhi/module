//
//  CYTEnum.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//
typedef enum : NSInteger {
    CYTBackTypePop = 0,           //pop返回
    CYTBackTypeDismiss,           //dismisss返回
    CYTBackTypeNone,                //没有任何操作
    CYTBackTypeGoHome,              //去首页
} CYTBackType;
typedef enum : NSInteger {
    CYTIdTypeFront = 0,           //身份证正面
    CYTIdTypeBack,                //身份证反面
    CYTIdTypeFrontWithHand,       //手持身份证正面
    CYTIdTypeBusLen,             //营业执照
    CYTIdTypeShrom               //展厅照片
} CYTIdType;
typedef enum : NSInteger {
    CYTCompanyCertificateTypeBusLen = 0,   //营业执照
    CYTCompanyCertificateTypeShrom,        //展厅照片
} CYTCompanyCertificateType;

typedef enum : NSInteger {
    CYTUserStatusUnRegister = 0,     //用户未注册
    CYTUserStatusRegister,          //用户已注册
} CYTUserStatus;

typedef enum : NSInteger {
    CYTSetPwdTypeReset = 0,     //用户重置密码
    CYTSetPwdTypeSet,           //用户设置密码
} CYTSetPwdType;

typedef enum : NSInteger {
    CYTGetCodeTypeRegister = 0,      //注册时发送验证码
    CYTGetCodeTypeFindPwd,           //已有用户找回密码
} CYTGetCodeType;

//流程状态
typedef enum : int {
    CYTBuyerOrderProgressStatusBeginBusiness = 0,      //发起交易
    CYTBuyerOrderProgressStatusSellerConfirm = 1,      //卖家确认
    CYTBuyerOrderProgressStatusPay = 2,                //支付订金
    CYTBuyerOrderProgressStatusSellerSendCar = 12,     //卖家发车
    CYTBuyerOrderProgressStatusConfirmRev = 21,         //确认收车
    CYTBuyerOrderProgressStatusFinish = 99,             //交易完成
    CYTBuyerOrderProgressStatusWithDraw = 9999,        //待提款
    CYTBuyerOrderProgressStatusUnPaidExpired = -11,  /// 未支付过期
    CYTBuyerOrderProgressStatusSalerRefuseSend = -3,  /// 卖家拒绝发车订单被取消
    CYTBuyerOrderProgressStatusConfirmedCanceled = -2, /// 已确认订单被取消
    CYTBuyerOrderProgressStatusUnConfirmCanceled = -1, /// 未确认订单被取消
    CYTBuyerOrderProgressStatusPaidCancel=-4           /// 已支付被取消
    
} CYTBuyerOrderProgressStatus;

typedef enum : NSInteger {
    CYTSellerOrderProgressStatusBeginBusiness = 0,     //发起交易
    CYTSellerOrderProgressStatusPay = 2,                    //买家支付
    CYTSellerOrderProgressStatusConfirmSendCar = 12,         //确认发车
    CYTSellerOrderProgressStatusRevCar = 21,                 //买家收车
    CYTSellerOrderProgressStatusFinish = 99,                 //交易完成
} CYTSellerOrderProgressStatus;

//订单状态进度条类型
typedef enum : NSInteger {
    CYTOrderStatusBarTypeTitleUp = 0,      //标题在上
    CYTOrderStatusBarTypeTitleDown,        //标题在下
} CYTOrderStatusBarType;

//订单工具条类型
typedef enum : NSInteger {
    CYTOrderToolBarTypeOnlyContact = 0,   //联系对方
    CYTOrderToolBarTypeCancelOrder,       //可取消订单
    CYTOrderToolBarTypeSendbackAndPay,     //退回订金和付订金给卖家
    CYTOrderToolBarTypeConfirmAndSendback,  //确认并退回订金给买家
    CYTOrderToolBarTypeCommit,              //提交
    CYTOrderToolBarTypeGotoPay,             //去支付
    CYTOrderToolBarTypeConfirmSendCar,       //确认发车
    CYTOrderToolBarTypeConfirmRevCar,       //确认发车
    CYTOrderToolBarTypeSeeExpress,           //查看物流
    CYTOrderToolBarTypeConfirmAndCancel,          //确认订单和取消订单
    CYTOrderToolBarTypeContactServerAndOneCustomButton, //联系客服和一个自定义按钮
    CYTOrderToolBarTypeContactServerWithCallAndCustomButton //联系客服/联系对方和一个自定义按钮
} CYTOrderToolBarType;

typedef enum : NSInteger {
    CYTOrderStatusUnConfirmed = 0,      //未确认
    CYTOrderStatusUnPaid = 1,           //未支付
    //    CYTOrderStatusPaying = 2,           //支付中
    //    CYTOrderStatusDownPaid = 11,        //首付已支付已支付
    CYTOrderStatusPaid = 12,            //已支付
    CYTOrderStatusUnReceived = 21,      //待收货
    CYTOrderStatusFinished = 99,        //已收货（已完成）
    CYTOrderStatusUnConfirmCanceled = -1,    //未确认订单被取消
    CYTOrderStatusConfirmedCanceled = -2,    //已确认订单被取消
    //    CYTOrderStatusSalerRefuseSend = -3,      //卖家拒绝发车订单被取消
    CYTOrderStatusPaidCanceled = -4,         //全部已支付
    CYTOrderStatusUnPaidExpired = -11,       //已支付订单被取消
    
} CYTOrderStatus;

//订单状态进度条类型
typedef enum : NSInteger {
    CYTOrderFeedbackTypeBuyerCancelOrder = 0,      //买家取消订单
    CYTOrderFeedbackTypeSellerCancelOrder,         //卖家取消订单
    CYTOrderFeedbackTypeBuyerConfirmRecCar,        //买家确认收车
    CYTOrderFeedbackTypeSellerConfirmSendCar,        //卖家确认发车
} CYTOrderFeedbackType;

//卖家确认发车框
typedef enum : NSInteger {
    CYTConfirmSendCarInputTypeContact = 0,   //物流联系人
    CYTConfirmSendCarInputTypePhone,         //联系电话
    CYTConfirmSendCarInputTypeExpressCompany,//物流公司
    CYTConfirmSendCarInputTypeRemark,        //备注
} CYTConfirmSendCarInputType;

//刷新类型
typedef enum : NSInteger {
    CYTRequestTypeRefresh = 0,   //刷新
    CYTRequestTypeLoadMore,      //加载更多
} CYTRequestType;

///运单状态( 待支付:1 待配板:11 待司机上门:21 运输中:31 已完成:300 待支付已取消:-1 待配板已取消-11 待司机上门已取消:-21,取消列表：-33)
typedef enum : NSInteger {
    CYTLogisticsOrderStatusAll = 0,                         //全部
    CYTLogisticsOrderStatusWaitPay = 1,                      //待支付
    CYTLogisticsOrderStatusWaitMatchingBoard = 11,            //待配板
    CYTLogisticsOrderStatusWaitDriver = 21,                   //待司机上门
    CYTLogisticsOrderStatusInTransit = 31,                    //运输中
    CYTLogisticsOrderStatusFinish = 300,                       //已完成
    CYTLogisticsOrderStatusFinishUnComment = 200,               //完成，未评价
    CYTLogisticsOrderStatusFinishCommented = 202,               //完成，已评价
    CYTLogisticsOrderStatusCancel = -33,                       //订单列表取消
    CYTLogisticsOrderStatusWaitPayCanceled = -1,             //待支付已取消
    CYTLogisticsOrderStatusWaitMatchingBoardCanceled = -11,   //待配板已取消
    CYTLogisticsOrderStatusWaitDriverCanceled = -21,          //待司机上门已取消
} CYTLogisticsOrderStatus;

///物流需求状态
typedef NS_ENUM(NSInteger,CYTLogisticsNeedStatus) {
    CYTLogisticsNeedStatusAll = -1,         //全部
    CYTLogisticsNeedStatusUnOrder = 1,      //待下单
    CYTLogisticsNeedStatusFinished = 2,     //已完成
    CYTLogisticsNeedStatusExpired = 3,      //已过期
    CYTLogisticsNeedStatusCancel = 4,       //已取消
};


typedef enum : NSInteger {
    CYTMyCouponCardTypeDefault = 0,//默认卡券
    CYTMyCouponCardTypeSelect,//选择我的卡券
} CYTMyCouponCardType;

typedef enum : NSInteger {
    CYTCouponStatusTypeUnused = 1,//未使用
    CYTCouponStatusTypeUsed,//已使用
    CYTCouponStatusTypeExpired,//已过期
    CYTCouponStatusTypeAvailable,//可用
    CYTCouponStatusTypeNotAvailable,//不可用
} CYTCouponStatusType;

typedef enum : NSInteger {
    CYTCouponTypeVoucher = 1, //抵用（满减）
    CYTCouponTypeFreeShipping,//包邮
    CYTCouponTypeDiscount     //折扣
} CYTCouponType;


///车源寻车入口类型
typedef NS_ENUM(NSInteger,CarViewSource) {
    ///车源
    CarViewSourceCarSource,
    ///寻车
    CarViewSourceSeekCar,
};




