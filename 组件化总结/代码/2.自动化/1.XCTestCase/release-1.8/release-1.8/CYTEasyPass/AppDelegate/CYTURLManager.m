//
//  CYTURLManager.m
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

#import "CYTURLManager.h"

#define kURLTypeKey @"domainType"

@implementation CYTURLManager

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static CYTURLManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [CYTURLManager new];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        
        NSString *domainType = ([[[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"]] valueForKey:kURLTypeKey]);
        [self changeURLType:[domainType integerValue]];
        
    }
    return self;
}

- (void)changeURLType:(CYTURLType)type {
    switch (type) {
        case 0://开发
        {
            self.APIURLBase =       @"http://dev.cxtapi.easypass.cn/api";
            self.H5URLBase =        @"http://dev.yxt.easypass.cn/h5/v2/#/";
            self.URLDomain =        @"dev.yxt.easypass.cn";
            self.urlType =          CYTURLTypeDev;
        }
            break;
        case 1://测试
        {
            self.APIURLBase =       @"http://test.cxtapi.easypass.cn/api";
            self.H5URLBase =        @"http://test.yxt.easypass.cn/h5/v2/#/";
            self.URLDomain =        @"test.yxt.easypass.cn";
            self.urlType =          CYTURLTypeTest;
        }
            break;
        case 2://生产
        {
            self.APIURLBase =       @"https://cxtapi.easypass.cn/api";
            self.H5URLBase =        @"https://yxt.easypass.cn/h5/v2/#/";
            self.URLDomain =        @"yxt.easypass.cn";
            self.urlType =          CYTURLTypeProduction;
        }
            break;
        case 3://生产http(灰度)
        {
            self.APIURLBase =       @"http://cxtapi2.easypass.cn/api";
            self.H5URLBase =        @"http://cxtapi2.easypass.cn/h5/v2/#/";
            self.URLDomain =        @"cxtapi2.easypass.cn";
            self.urlType =          CYTURLTypeProductionWNS;
        }
            break;
        default:
            break;
    }
    
    [self setAllAPIURL];
}

- (BOOL)canChangeURLType {
    NSString *domainType = ([[[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"]] valueForKey:kURLTypeKey]);
    if ([domainType integerValue] == 2) {
        return NO;
    }
    return YES;
}

- (void)setAllAPIURL {
    [self launchAd];
    [self carSource];
    [self seekCar];
    [self orderAndPay];
    [self orderAndPay];
    [self logisticsNeed];
    [self loginAndRegister];
    [self message];
    [self h5Views];
    [self yicheCoin];
    [self otherURLs];
}
#pragma mark- 开屏
- (void)launchAd{
    self.basic_index_getSpreadAd        =   APIURLHandle(@"basic/index/getSpreadAd");
}

#pragma mark- 车源
- (void)carSource {
    self.car_source_detail                          =   APIURLHandle(@"car/source/detail");
    self.car_source_addContact                      =   APIURLHandle(@"car/source/addContact");
    self.car_source_list                            =   APIURLHandle(@"car/source/list");
    self.car_source_add                             =   APIURLHandle(@"car/source/add");
    self.car_source_modify                          =   APIURLHandle(@"car/source/modify");
    self.indexer_carmodel_search                    =   APIURLHandle(@"indexer/carmodel/search");
    self.car_source_hisList                         =   APIURLHandle(@"car/source/hisList");
    self.car_source_saleCarSourceItem               =   APIURLHandle(@"car/source/saleCarSourceItem");
    self.car_source_refresh                         =   APIURLHandle(@"car/source/refresh");
    self.car_source_myList                          =   APIURLHandle(@"car/source/myList");
    
    
    self.car_common_getArrivalPortDate              =   APIURLHandle(@"car/common/GetArrivalPortDate");
    self.car_common_getGroupCarInfoListByModelId    =   APIURLHandle(@"car/common/getGroupCarInfoListByModelId");
    self.car_common_getCarSeriesColor               =   APIURLHandle(@"car/common/GetCarSeriesColor");
    self.car_common_getCarSourceTypeList            =   APIURLHandle(@"car/common/getCarSourceTypeList");
    self.car_common_GetParallelImportCarTypeList    =   APIURLHandle(@"car/common/GetParallelImportCarTypeList");
    self.car_common_getCarProcedures                =   APIURLHandle(@"car/common/getCarProcedures");
    self.car_common_carReferPriceQuery              =   APIURLHandle(@"car/common/carReferPriceQuery");
    self.car_common_getNoGroupProvinceCity          =   APIURLHandle(@"car/common/getNoGroupProvinceCity");
    self.car_common_getBannerInfo                   =   APIURLHandle(@"car/common/GetBannerInfo");
    self.basic_index_getBannerInfo                  =   APIURLHandle(@"basic/index/getBannerInfo");
    self.basic_index_getIndexFunctionButtons        =   APIURLHandle(@"basic/index/getIndexFunctionButtons");
    self.basic_index_getIndexStoreAuthList          =   APIURLHandle(@"basic/index/getIndexStoreAuthList");
    self.basic_index_getIndexRecommendList          =   APIURLHandle(@"basic/index/getIndexRecommendList");
    self.car_source_getRecommendCarSourceList       =   APIURLHandle(@"car/source/getRecommendCarSourceList");
    self.car_source_getSourceInfoSubmitOrder        =   APIURLHandle(@"car/source/getSourceInfoSubmitOrder");
    self.car_common_getMasterBrandList              =   APIURLHandle(@"car/common/getMasterBrandList");
    self.car_common_GetVehicleTools                 =   APIURLHandle(@"car/common/GetVehicleTools");
    self.car_common_GetVehicleProcedureDocuments    =   APIURLHandle(@"car/common/GetVehicleProcedureDocuments");
    self.car_common_getCarBrandSerialData           =   APIURLHandle(@"car/common/getCarBrandSerialData");
    self.car_source_getFilterCondition              =   APIURLHandle(@"car/source/getFilterCondition");
    self.car_source_getListByConditions             =   APIURLHandle(@"car/source/getListByConditions");
}
#pragma mark- 寻车
- (void)seekCar {
    self.car_seek_searchList                        =   APIURLHandle(@"car/seek/searchList");
    self.car_seek_list                              =   APIURLHandle(@"car/seek/list");
    self.car_seek_modify                            =   APIURLHandle(@"car/seek/modify");
    self.car_seek_add                               =   APIURLHandle(@"car/seek/add");
    self.car_seek_detail                            =   APIURLHandle(@"car/seek/detail");
    self.car_seek_refresh                           =   APIURLHandle(@"car/seek/refresh");
    self.car_seek_pushOnOffLineSeekCar              =   APIURLHandle(@"car/seek/pushOnOffLineSeekCar");
    self.car_seek_myList                            =   APIURLHandle(@"car/seek/myList");
    self.car_seek_getSeekCarInfoSubmitOrder         =   APIURLHandle(@"car/seek/getSeekCarInfoSubmitOrder");
    self.car_seek_getListByConditions               =   APIURLHandle(@"car/seek/getListByConditions");
    self.car_seek_addContact                        =   APIURLHandle(@"car/seek/addContact");
}

#pragma mark- 车辆订单、物流订单、支付操作
- (void)orderAndPay {
    self.order_sourceCar_createOrder                =   APIURLHandle(@"order/sourceCar/createOrder");
    self.order_seekCar_createOrder                  =   APIURLHandle(@"order/seekCar/createOrder");
    self.order_car_GetOrderList                     =   APIURLHandle(@"order/car/GetOrderList");
    self.order_car_getSendCarInfo                   =   APIURLHandle(@"order/car/getSendCarInfo");
    self.order_Refund_SellerRefundProc              =   APIURLHandle(@"order/Refund/SellerRefundProc");
    
    self.order_car_getOrderDetail                   =   APIURLHandle(@"order/car/getOrderDetail");
    self.order_car_orderExtend                      =   APIURLHandle(@"order/car/orderExtend");
    self.order_car_cancelOrder                      =   APIURLHandle(@"order/car/cancelOrder");
    
    self.order_car_sendCarConfirmed                 =   APIURLHandle(@"order/car/sendCarConfirmed");
    self.order_car_sendCar                          =   APIURLHandle(@"order/car/sendCar");
    self.order_car_receiveCar                       =   APIURLHandle(@"order/car/receiveCar");
    
    //物流订单
    self.order_express_ConfirmOrderInfo             =   APIURLHandle(@"order/express/ConfirmOrderInfo");
    self.order_express_getOrderList                 =   APIURLHandle(@"order/express/getOrderList");
    self.order_express_CreateExpressOrder           =   APIURLHandle(@"order/express/CreateExpressOrder");
    self.order_express_getOrderDetail               =   APIURLHandle(@"order/express/getOrderDetail");
    self.order_express_callExpress                  =   APIURLHandle(@"order/express/callExpress");
    self.order_express_sureorderover                =   APIURLHandle(@"order/express/sureorderover");
    
    //支付操作
    self.order_pay_index                            =   APIURLHandle(@"order/pay/index");
    self.order_pay_AppPay                           =   APIURLHandle(@"order/pay/AppPay");
    self.order_pay_payResult                        =   APIURLHandle(@"order/pay/payResult");
    self.order_pay_BalancePay                       =   APIURLHandle(@"order/pay/BalancePay");
    self.order_pay_payPromptMsg                     =   APIURLHandle(@"order/pay/payPromptMsg");
}
#pragma mark- 登录、注册、认证、用户操作
- (void)loginAndRegister {
    //车商圈
    self.user_moments_post                          =   APIURLHandle(@"user/moments/post");
    self.user_moments_delete                        =   APIURLHandle(@"user/moments/delete");
    self.user_file_uploadImage                      =   APIURLHandle(@"user/file/uploadImage");
    
    //登录、注册、认证
    self.user_identity_auth                         =   APIURLHandle(@"user/identity/auth");
    self.user_identity_BindJPushDevice              =   APIURLHandle(@"user/identity/BindJPushDevice");
    self.user_feedback_add                          =   APIURLHandle(@"user/feedback/add");
    
    self.user_authorization_inputTelPhoneValidate   =   APIURLHandle(@"user/authorization/inputTelPhoneValidate");
    self.user_authorization_validateTelCode         =   APIURLHandle(@"user/authorization/validateTelCode");
    self.user_authorization_validateCodePhone       =   APIURLHandle(@"user/authorization/validateCodePhone");
    self.user_identity_register                     =   APIURLHandle(@"user/identity/register");
    self.user_identity_resetPassword                =   APIURLHandle(@"user/identity/resetPassword");
    self.user_file_userUpLoadImg                    =   APIURLHandle(@"user/file/userUpLoadImg");
    self.user_authorization_IDCardValidate          =   APIURLHandle(@"user/authorization/IDCardValidate");
    self.user_authorization_submitAuthenticateAduit =   APIURLHandle(@"user/authorization/submitAuthenticateAduit");
    
    self.user_info_GetBusinessModel                 =   APIURLHandle(@"user/info/GetBusinessModel");
    self.user_info_getRefuseAuthenicateType         =   APIURLHandle(@"user/info/getRefuseAuthenicateType");
    self.user_authorization_fillAuthenticateInfo    =   APIURLHandle(@"user/authorization/fillAuthenticateInfo");
    self.user_identity_logOut                       =   APIURLHandle(@"user/identity/LogOut");
    self.user_info_getUserInfo                      =   APIURLHandle(@"user/info/getUserInfo");
    self.user_info_getUserAuthenticateInfo          =   APIURLHandle(@"user/info/getUserAuthenticateInfo");
    
    //车商主页
    self.user_info_getpersonalhomepageinfo          =   APIURLHandle(@"user/info/getpersonalhomepageinfo");
    self.user_authorization_getAuthImageList        =   APIURLHandle(@"user/authorization/getAuthImageList");
    self.user_evaluation_getServiceEvalList         =   APIURLHandle(@"user/evaluation/getServiceEvalList");
    self.user_evaluation_postServiceEval            =   APIURLHandle(@"user/evaluation/postServiceEval");
    self.user_info_searchDealer                     =   APIURLHandle(@"user/info/searchDealer");
    self.user_ranking_GetPraiseCountList            =   APIURLHandle(@"user/ranking/GetPraiseCountList");
    self.user_ranking_GetSaleCountList              =   APIURLHandle(@"user/ranking/GetSaleCountList");
    
    //地址管理
    self.user_address_getList                       =   APIURLHandle(@"user/address/getList");
    self.user_address_delete                        =   APIURLHandle(@"user/address/delete");
    self.user_address_setDefault                    =   APIURLHandle(@"user/address/setDefault");
    self.user_address_addOrUpdate                   =   APIURLHandle(@"user/address/addOrUpdate");
    
    //收发车联系人
    self.user_contacts_addOrUpdate                  =   APIURLHandle(@"user/contacts/addOrUpdate");
    self.user_contacts_getList                      =   APIURLHandle(@"user/contacts/getList");
    self.user_contacts_setDefault                   =   APIURLHandle(@"user/contacts/setDefault");
    self.user_contacts_delete                       =   APIURLHandle(@"user/contacts/delete");
    
    self.user_account_SetWithdrawalPassword         =   APIURLHandle(@"user/account/SetWithdrawalPassword");
    self.user_useraccount_myaccount                 =   APIURLHandle(@"user/useraccount/myaccount");
    self.user_info_updateAvatar                     =   APIURLHandle(@"user/info/updateAvatar");
    self.user_useraccount_withdraw                  =   APIURLHandle(@"user/useraccount/withdraw");
    self.user_info_getMyCount                       =   APIURLHandle(@"user/info/getMyCount");
    
    self.user_account_SendTelCode                   =   APIURLHandle(@"user/account/SendTelCode");
    self.user_share_app                             =   APIURLHandle(@"user/share/app");
    self.user_share_car                             =   APIURLHandle(@"user/share/car");
    self.user_share_setShareResult                  =   APIURLHandle(@"user/share/setShareResult");
    self.user_authorization_getstoreauthapplystatus =   APIURLHandle(@"user/authorization/getstoreauthapplystatus");
    self.user_authorization_poststoreauthapply      =   APIURLHandle(@"user/authorization/poststoreauthapply");
}
#pragma mark- 物流需求
- (void)logisticsNeed {
    self.express_recommend_bestline                 =   APIURLHandle(@"express/recommend/bestline");
    self.express_purpose_list                       =   APIURLHandle(@"express/purpose/list");
    self.express_purpose_demandinfo                 =   APIURLHandle(@"express/purpose/demandinfo");
    self.express_purpose_cancel                     =   APIURLHandle(@"express/purpose/cancel");
    self.express_purpose_add                        =   APIURLHandle(@"express/purpose/add");
    self.express_evaluate_add                       =   APIURLHandle(@"express/evaluate/add");
    self.coupon_ExpressCoupon_CouponList            =   APIURLHandle(@"coupon/ExpressCoupon/CouponList");
    self.coupon_ExpressCoupon_ChooseCouponList      =   APIURLHandle(@"coupon/ExpressCoupon/ChooseCouponList");
    self.express_recommend_recommendLine            =   APIURLHandle(@"express/recommend/recommendLine");
}

#pragma mark- 消息
- (void)message {
    self.message_center_typeList                    =   APIURLHandle(@"message/center/typeList");
    self.message_center_list                        =   APIURLHandle(@"message/center/list");
    self.message_center_getUnread                   =   APIURLHandle(@"message/center/getUnread");
    self.message_center_read                        =   APIURLHandle(@"message/center/read");
}
#pragma mark- h5
- (void)h5Views {
    self.kLoginHelpUrl                              =   [NSString stringWithFormat:@"%@%@",self.H5URLBase,@"help/RegisterHelp"];
    self.kUserProtocolUrl                           =   [NSString stringWithFormat:@"%@%@",self.H5URLBase,@"help/registerprotocol"];
    self.kURL_myAccount                             =   [NSString stringWithFormat:@"%@%@",self.H5URLBase,@"account/my"];
    self.kURL_Home_help                             =   [NSString stringWithFormat:@"%@%@",self.H5URLBase,@"help/adHelp"];
    self.kURL_expressProcess                        =   [NSString stringWithFormat:@"%@%@",self.H5URLBase,@"express/detail"];
    self.kURL_me_set_deal                           =   [NSString stringWithFormat:@"%@%@",self.H5URLBase,@"help/tradeprotocol"];
    self.kURL_carFriends_home                       =   [NSString stringWithFormat:@"%@%@",self.H5URLBase,@"moments/list2"];
    self.kURL_shareLink                             =   [NSString stringWithFormat:@"%@%@",self.H5URLBase,@"moments/weChatShare"];
    self.kURL_me_set_transport                      =   [NSString stringWithFormat:@"%@%@",self.H5URLBase,@"help/transferprotocol"];
    self.kURLLogistics_publishNeed_help             =   [NSString stringWithFormat:@"%@%@",self.H5URLBase,@"help/express"];
    self.kURLCoupon_used_help                       =   [NSString stringWithFormat:@"%@%@",self.H5URLBase,@"help/coupon"];
    self.KURL_mall_goodsList                        =   [NSString stringWithFormat:@"%@%@",self.H5URLBase,@"mall/goodsList"];
}

#pragma mark- 易车币
- (void)yicheCoin {
    self.user_ycbhome_SignInState   =   APIURLHandle(@"user/ycbhome/SignInState");
    self.user_ycbhome_signin        =   APIURLHandle(@"user/ycbhome/signin");
    self.user_ycbhome_ycbRecords    =   APIURLHandle(@"user/ycbhome/ycbRecords");
    self.user_ycbhome_tasks         =   APIURLHandle(@"user/ycbhome/tasks");
    self.user_ycbhome_ReceiveReward =   APIURLHandle(@"user/ycbhome/ReceiveReward");
    self.user_ycbhome_goods         =   APIURLHandle(@"user/ycbhome/goods");
    self.user_YCBGoods_exchange     =   APIURLHandle(@"user/YCBGoods/exchange");


}

#pragma mark- 其他
- (void)otherURLs {
    self.app_checkUpdate                            =   APIURLHandle(@"app/checkUpdate");
    self.basic_index_getBannerInfo                  =   APIURLHandle(@"basic/index/getBannerInfo");
    self.car_contactRecord_getContactedMeList       =   APIURLHandle(@"car/contactRecord/getContactedMeList");
    self.car_seek_GetMyContactedSeekCarList       =   APIURLHandle(@"car/seek/GetMyContactedSeekCarList");
    self.car_source_contactList                     =   APIURLHandle(@"car/source/contactList");
    self.mall_goodsDetail                     =   [NSString stringWithFormat:@"%@%@",self.H5URLBase,@"mall/goodsDetail"];
}

@end
