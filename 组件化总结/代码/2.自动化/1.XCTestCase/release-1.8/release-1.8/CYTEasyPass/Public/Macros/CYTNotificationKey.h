
//
//  CYTNotificationKey.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

//点击tabBar
#define CYTTabBarDidSelectNotification  @"CYTTabBarDidSelectNotification"
//刷新订单详情界面
#define kRefreshOrderDetailKey      @"kRefreshOrderDetailKey"
///刷新订单列表
#define kRefreshOrderListKey        @"kRefreshOrderListKey"
///支付回调
#define kPayResultNotiKey           @"kPayResultNotiKey"
///登录成功的通知
#define kloginSucceedKey            @"kloginSucceedKey"
///重置密码的通知
#define kResetPwdSucceedKey         @"kResetPwdSucceedKey"
//订单拓展输入
#define kOrderExtendInputKey     @"kOrderExtendCarInputKey"
//token刷新
#define kTokenRefreshedKey          @"kTokenRefreshedKey"

//注册成功的通知
#define kResiterSuccessKey         @"kResiterSuccessKey"

//完善资料的姓名输入
#define kCompleteInfoUserNameInputKey  @"kCompleteInfoUserNameInputKey"

//提交认证成功的通知
#define kCommitCertificationSuccessKey    @"kCommitCertificationSuccessKey"

///退款等待我操作的数量
#define kRefundNumberKey            @"kRefundNumberKey"

///操作了退款，我的页面刷新
#define kMeRefreshKey               @"kMeRefreshKey"

///车源列表刷新
#define kRefresh_CarSourceList      @"kRefresh_CarSourceList"
///寻车列表刷新
#define kRefresh_FindCarList        @"kRefresh_FindCarList"
//刷新我的寻车列表
#define kRefreshMySeekCarKey        @"kRefreshMySeekCarKey"
//刷新我的车源列表
#define kRefreshMyCarSourceKey      @"kRefreshMyCarSourceKey"
//网络连接正常
#define kNetworkReachable           @"kNetworkReachableKey"
//网络连接异常
#define kNetworkUnReachable         @"kNetworkUnReachableKey"


///物流需求列表刷新
#define kLogisticsNeedList_cancel_refresh       @"kLogisticsNeedList_cancel_refresh"
///需求刷新
#define kLogisticsNeedListRefreshKey            @"kLogisticsNeedListRefreshKey"

///提交物流订单成功
#define kLogisticsOrderCommitSuccessNotkey      @"kLogisticsOrderCommitSuccessNotkey"
///物流订单支付成功
#define kLogisticsOrderPaySuccessNotkey         @"kLogisticsOrderPaySuccessNotkey"
///物流订单列表刷新
#define kLogisticsOrderListRefreshKey           @"kLogisticsOrderListRefreshKey"

#pragma mark- 消息中心
///消息阅读状态发送成功
#define kMessageReadStateSendSuccceed           @"kMessageReadStateSendSuccceed"
///收到了push
#define kReceivePushKey                         @"kReceivePushKey"

///发消息隐藏所有window上的自定义view
#define kHideWindowSubviewsKey                  @"kHideWindowSubviewsKey"

#pragma mark- 车商页面
///车商评论数量变化
#define kDealerCommentCountChangedKey           @"kDealerCommentCountChangedKey"

///品牌选择，常用品牌相关
#define kUpdateFrequentlyBrandKey               @"kUpdateFrequentlyBrandKey"

///车源筛选页面刷新
#define kCarFilterRefreshKey                    @"kCarFilterRefreshKey"

///回根视图
#define kGoMainHomeViewKey                     @"kGoMainHomeViewKey"

