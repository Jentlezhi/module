//
//  CYTURLManager.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/23.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

/*
 模块划分
 1、车源
 2、寻车
 3、车辆订单、物流订单、支付操作
 4、物流需求
 5、登录、注册、认证、用户操作
 6、消息
 7、h5
 8、其他
 */

#import <Foundation/Foundation.h>

#define kURL [CYTURLManager shareManager]

#define APIURLHandle(url)  [NSString stringWithFormat:@"%@/%@",self.APIURLBase,(url)]

typedef NS_ENUM(NSInteger,CYTURLType) {
    CYTURLTypeDev,
    CYTURLTypeTest,
    ///生产接口（https）
    CYTURLTypeProduction,
    ///http的生产接口
    CYTURLTypeProductionWNS,
};

@interface CYTURLManager : NSObject

@property (nonatomic, copy) NSString *APIURLBase;
@property (nonatomic, copy) NSString *H5URLBase;
@property (nonatomic, copy) NSString *URLDomain;
@property (nonatomic, assign) CYTURLType urlType;

+ (instancetype)shareManager;

- (void)changeURLType:(CYTURLType)type;

@property (nonatomic, assign) BOOL canChangeURLType;

#pragma mark- 车源
///编辑后提交
@property (nonatomic, copy) NSString *car_source_modify;
///车源搜索
@property (nonatomic, copy) NSString *indexer_carmodel_search;
///增加联系车源
@property (nonatomic, copy) NSString *car_source_addContact;
///车源列表
@property (nonatomic, copy) NSString *car_source_list;
///车源发布
@property (nonatomic, copy) NSString *car_source_add;
///车源详情
@property (nonatomic, copy) NSString *car_source_detail;
///在售车源
@property (nonatomic, copy) NSString *car_source_hisList;
///刷新车源
@property (nonatomic, copy) NSString *car_source_refresh;
///车源上下架
@property (nonatomic, copy) NSString *car_source_saleCarSourceItem;
///我的车源列表
@property (nonatomic, copy) NSString *car_source_myList;
///获取车源信息提交订单
@property (nonatomic, copy) NSString *car_source_getSourceInfoSubmitOrder;
///获取车辆品牌车系缓存数据
@property (nonatomic, copy) NSString *car_common_getCarBrandSerialData;
///车源筛选
@property (nonatomic, copy) NSString *car_source_getListByConditions;

#pragma mark-
///车类型
@property (nonatomic, copy) NSString *car_common_getCarSourceTypeList;
///获取平行进口车类型列表
@property (nonatomic, copy) NSString *car_common_GetParallelImportCarTypeList;
///根据品牌车型获取车颜色 新
@property (nonatomic, copy) NSString *car_common_getCarSeriesColor;
///到港日期
@property (nonatomic, copy) NSString *car_common_getArrivalPortDate;
///根据车系获取车款
@property (nonatomic, copy) NSString *car_common_getGroupCarInfoListByModelId;
///发车源手续文件
@property (nonatomic, copy) NSString *car_common_getCarProcedures;
///发车源寻车指导价搜索
@property (nonatomic, copy) NSString *car_common_carReferPriceQuery;
//获取随车工具
@property (nonatomic, copy) NSString *car_common_GetVehicleTools;
//获取随车手续
@property (nonatomic, copy) NSString *car_common_GetVehicleProcedureDocuments;
///城市地址数据
@property (nonatomic, copy) NSString *car_common_getNoGroupProvinceCity;
///首页banner
@property (nonatomic, copy) NSString *basic_index_getBannerInfo;
//废弃
@property (nonatomic, copy) NSString *car_common_getBannerInfo;
///首页功能按钮
@property (nonatomic, copy) NSString *basic_index_getIndexFunctionButtons;
///首页实店认证的商家
@property (nonatomic, copy) NSString *basic_index_getIndexStoreAuthList;
///首页平行进口车广告位
@property (nonatomic, copy) NSString *basic_index_getIndexRecommendList;
///首页特卖车源
@property (nonatomic, copy) NSString *car_source_getRecommendCarSourceList;
//获取主营品牌
@property (nonatomic, copy) NSString *car_common_getMasterBrandList;
///获取筛选条件
@property (nonatomic, copy) NSString *car_source_getFilterCondition;

#pragma mark- 寻车
///寻车搜索
@property (nonatomic, copy) NSString *car_seek_searchList;
///寻车列表
@property (nonatomic, copy) NSString *car_seek_list;
///发布寻车
@property (nonatomic, copy) NSString *car_seek_add;
///修改
@property (nonatomic, copy) NSString *car_seek_modify;
///寻车详情
@property (nonatomic, copy) NSString *car_seek_detail;
///刷新
@property (nonatomic, copy) NSString *car_seek_refresh;
///寻车上下架
@property (nonatomic, copy) NSString *car_seek_pushOnOffLineSeekCar;
///我的寻车列表
@property (nonatomic, copy) NSString *car_seek_myList;
///获取寻车信息提交订单
@property (nonatomic, copy) NSString *car_seek_getSeekCarInfoSubmitOrder;
///寻车筛选
@property (nonatomic, copy) NSString *car_seek_getListByConditions;
///添加联系记录
@property (nonatomic, copy) NSString *car_seek_addContact;

#pragma mark- 车辆、物流订单、支付
///创建订单-寻车
@property (nonatomic, copy) NSString *order_seekCar_createOrder;
///创建订单-车源
@property (nonatomic, copy) NSString *order_sourceCar_createOrder;
///订单列表
@property (nonatomic, copy) NSString *order_car_GetOrderList;
///发车信息
@property (nonatomic, copy) NSString *order_car_getSendCarInfo;
///订单详情
@property (nonatomic, copy) NSString *order_car_getOrderDetail;
///订单扩展（取消，发车，收车 原因）
@property (nonatomic, copy) NSString *order_car_orderExtend;
///取消订单
@property (nonatomic, copy) NSString *order_car_cancelOrder;
///卖家确认发车
@property (nonatomic, copy) NSString *order_car_sendCarConfirmed;
///卖家确认发车
@property (nonatomic, copy) NSString *order_car_sendCar;
///买家收车
@property (nonatomic, copy) NSString *order_car_receiveCar;
///卖家处理退款
@property (nonatomic, copy) NSString *order_Refund_SellerRefundProc;

#pragma mark-
//物流订单----------》
///确认订单信息
@property (nonatomic, copy) NSString *order_express_ConfirmOrderInfo;
///提交物流订单
@property (nonatomic, copy) NSString *order_express_CreateExpressOrder;
///订单列表
@property (nonatomic, copy) NSString *order_express_getOrderList;
///订单详情
@property (nonatomic, copy) NSString *order_express_getOrderDetail;
///订单提交成功，获取物流携带信息
@property (nonatomic, copy) NSString *order_express_callExpress;
///确认收车
@property (nonatomic, copy) NSString *order_express_sureorderover;

#pragma mark-
//支付操作----------》
///获取支付信息
@property (nonatomic, copy) NSString *order_pay_index;
///请求支付宝支付信息
@property (nonatomic, copy) NSString *order_pay_AppPay;
///支付结果
@property (nonatomic, copy) NSString *order_pay_payResult;
///余额支付
@property (nonatomic, copy) NSString *order_pay_BalancePay;
///支付退出提示
@property (nonatomic, copy) NSString *order_pay_payPromptMsg;

#pragma mark- 物流需求
///物流首页推荐路线
@property (nonatomic, copy) NSString *express_recommend_bestline;
///需求列表
@property (nonatomic, copy) NSString *express_purpose_list;
///物流详情
@property (nonatomic, copy) NSString *express_purpose_demandinfo;
///物流需求取消
@property (nonatomic, copy) NSString *express_purpose_cancel;
///发布物流需求
@property (nonatomic, copy) NSString *express_purpose_add;
///物流订单评论
@property (nonatomic, copy) NSString *express_evaluate_add;
//我的卡券
@property (nonatomic, copy) NSString *coupon_ExpressCoupon_CouponList;
//选择优惠券
@property (nonatomic, copy) NSString *coupon_ExpressCoupon_ChooseCouponList;
///推荐路线
@property (nonatomic, copy) NSString *express_recommend_recommendLine;

#pragma mark- 登录/注册/认证
///上传图片
@property (nonatomic, copy) NSString *user_file_uploadImage;
//用户登录
@property (nonatomic, copy) NSString *user_identity_auth;
///退出登录
@property (nonatomic, copy) NSString *user_identity_logOut;
///认证详情(不含图片信息)
@property (nonatomic, copy) NSString *user_info_getUserInfo;
///认证详情:老接口
@property (nonatomic, copy) NSString *user_info_getUserAuthenticateInfo;
///验证手机号格式和是否已注册
@property (nonatomic, copy) NSString *user_authorization_inputTelPhoneValidate;
//校验：输入的验证码
@property (nonatomic, copy) NSString *user_authorization_validateTelCode;
//校验：输入的验证码以及邀请
@property (nonatomic, copy) NSString *user_authorization_validateCodePhone;
//注册
@property (nonatomic, copy) NSString *user_identity_register;
//重置密码
@property (nonatomic, copy) NSString *user_identity_resetPassword;
//上传用户图片
@property (nonatomic, copy) NSString *user_file_userUpLoadImg;
//校验身份证号合法性
@property (nonatomic, copy) NSString *user_authorization_IDCardValidate;
//老接口：提交、修改个人/企业认证信息
@property (nonatomic, copy) NSString *user_authorization_submitAuthenticateAduit;
//获取公司类型
@property (nonatomic, copy) NSString *user_info_GetBusinessModel;
//驳回认证原因
@property (nonatomic, copy) NSString *user_info_getRefuseAuthenicateType;
//老接口：完善资料
@property (nonatomic, copy) NSString *user_authorization_fillAuthenticateInfo;
///验证码类型：1、注册；2、找回密码；3、设置交易密码
@property (nonatomic, copy) NSString *user_account_SendTelCode;
///获取用户实店认证申请状态
@property (nonatomic, copy) NSString *user_authorization_getstoreauthapplystatus;
///提交实店认证申请
@property (nonatomic, copy) NSString *user_authorization_poststoreauthapply;

///更改用户头像
@property (nonatomic, copy) NSString *user_info_updateAvatar;
///我的页面 各种订单数量
@property (nonatomic, copy) NSString *user_info_getMyCount;
///我的账户总金额，可提现金额
@property (nonatomic, copy) NSString *user_useraccount_myaccount;
///设置提款密码
@property (nonatomic, copy) NSString *user_account_SetWithdrawalPassword;
///提交提现申请
@property (nonatomic, copy) NSString *user_useraccount_withdraw;
///上传极光tokenId
@property (nonatomic, copy) NSString *user_identity_BindJPushDevice;
///意见反馈
@property (nonatomic, copy) NSString *user_feedback_add;


///车商圈发布提交
@property (nonatomic, copy) NSString *user_moments_post;
///删除
@property (nonatomic, copy) NSString *user_moments_delete;
///分享app
@property (nonatomic, copy) NSString *user_share_app;
///分享车源寻车详情
@property (nonatomic, copy) NSString *user_share_car;
///分享结果反馈
@property (nonatomic, copy) NSString *user_share_setShareResult;

#pragma mark-
//车商主页----------》
///认证图片
@property (nonatomic, copy) NSString *user_authorization_getAuthImageList;
///经销商首页
@property (nonatomic, copy) NSString *user_info_getpersonalhomepageinfo;
///评价列表
@property (nonatomic, copy) NSString *user_evaluation_getServiceEvalList;
///提交评价
@property (nonatomic, copy) NSString *user_evaluation_postServiceEval;
///车商搜索
@property (nonatomic, copy) NSString *user_info_searchDealer;
///好评榜
@property (nonatomic, copy) NSString *user_ranking_GetPraiseCountList;
///销量榜
@property (nonatomic, copy) NSString *user_ranking_GetSaleCountList;


#pragma mark-
//地址管理、收发车联系人----------》
///地址管理列表
@property (nonatomic, copy) NSString *user_address_getList;
///删除收车地址
@property (nonatomic, copy) NSString *user_address_delete;
///设置默认收车地址
@property (nonatomic, copy) NSString *user_address_setDefault;
///新增和修改
@property (nonatomic, copy) NSString *user_address_addOrUpdate;
///收发车联系人地址
@property (nonatomic, copy) NSString *user_contacts_addOrUpdate;
//获取收车或发车联系人列表
@property (nonatomic, copy) NSString *user_contacts_getList;
//设置默认收车、发车联系人
@property (nonatomic, copy) NSString *user_contacts_setDefault;
//删除收车、发车联系人
@property (nonatomic, copy) NSString *user_contacts_delete;


#pragma mark- 消息中心
///消息分类
@property (nonatomic, copy) NSString *message_center_typeList;
///消息列表my
@property (nonatomic, copy) NSString *message_center_list;
///首页未读消息
@property (nonatomic, copy) NSString *message_center_getUnread;
///修改消息状态
@property (nonatomic, copy) NSString *message_center_read;


#pragma mark- h5
//H5
///登录帮助
@property (nonatomic, copy) NSString *kLoginHelpUrl;
///用户协议
@property (nonatomic, copy) NSString *kUserProtocolUrl;
///我的账户url
@property (nonatomic, copy) NSString *kURL_myAccount;
///首页帮助页面
@property (nonatomic, copy) NSString *kURL_Home_help;
///物流页面
@property (nonatomic, copy) NSString *kURL_expressProcess;
///在线交易协议、
@property (nonatomic, copy) NSString *kURL_me_set_deal;
///车商圈首页
@property (nonatomic, copy) NSString *kURL_carFriends_home;
///分享
@property (nonatomic, copy) NSString *kURL_shareLink;
///车辆运输--居间服务协议  h5
@property (nonatomic, copy) NSString *kURL_me_set_transport;
///车辆运输--帮助h5
@property (nonatomic, copy) NSString *kURLLogistics_publishNeed_help;
///我的卡券--使用说明h5
@property (nonatomic, copy) NSString *kURLCoupon_used_help;
///易车币商城
@property (nonatomic, copy) NSString *KURL_mall_goodsList;

#pragma mark - 易车币
///获取签到状态
@property (nonatomic, copy) NSString *user_ycbhome_SignInState;
///签到
@property (nonatomic, copy) NSString *user_ycbhome_signin;
///易车币收支明细
@property (nonatomic, copy) NSString *user_ycbhome_ycbRecords;
///首页任务列表
@property (nonatomic, copy) NSString *user_ycbhome_tasks;
///领取任务奖励
@property (nonatomic, copy) NSString *user_ycbhome_ReceiveReward;
///首页兑换奖励
@property (nonatomic, copy) NSString *user_ycbhome_goods;
///易车币兑换商品
@property (nonatomic, copy) NSString *user_YCBGoods_exchange;

#pragma mark- 其他
///更新
@property (nonatomic, copy) NSString *app_checkUpdate;
///联系我的用户列表
@property (nonatomic, copy) NSString *car_contactRecord_getContactedMeList;
///我的联系的寻车列表
@property (nonatomic, copy) NSString *car_seek_GetMyContactedSeekCarList;
///我的联系的车源列表
@property (nonatomic, copy) NSString *car_source_contactList;
///商品详情
@property (nonatomic, copy) NSString *mall_goodsDetail;

#pragma mark- 开屏

@property (nonatomic, copy) NSString *basic_index_getSpreadAd;


@end
