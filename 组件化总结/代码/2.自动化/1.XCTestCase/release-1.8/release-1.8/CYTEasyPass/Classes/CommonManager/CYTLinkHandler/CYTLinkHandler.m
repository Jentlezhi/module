//
//  CYTMessageLinkHandleVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/18.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLinkHandler.h"
#import "CYTMyAccountCtr.h"
#import "CYTSeekCarDetailViewController.h"
#import "CYTPersonalCertificateViewController.h"
#import "CYTOrderDetailViewController.h"
#import "CYTLogisticsNeedDetailTableController.h"
#import "CYTLogisticsOrderDetail3DController.h"
#import "CYTMessageCategoryTableController.h"
#import "CYTDealerCommentViewController.h"
#import "CYTMyCouponViewController.h"
#import "CYTSettingViewController.h"
#import "CYTCertificationPreviewController.h"
#import "CYTCarSourceDetailTableController.h"
#import "CYTOrderDetailViewController.h"
#import "CYTDealerMeHomeTableController.h"
#import "CYTDealerHisHomeTableController.h"
#import "CYTLogisticsHomeTableController.h"
#import "CYTCarSourcePublishViewController.h"
#import "CYTSeekCarNeedPublishViewController.h"
#import "CYTMyCarSourceViewController.h"
#import "CYTContactMeViewController.h"
#import "CYTWithdrawPwdSetTableController.h"
#import "CYTGetCashCtr.h"
#import "CYTMySeekCarViewController.h"
#import "CYTMyContactViewController.h"
#import "CYTStoreCertificationViewController.h"
#import "CYTCarTradeCircleCtr.h"
#import "CYTCarDealerChartController.h"
#import "CYTMyYicheCoinViewController.h"

@interface CYTLinkHandler ()
@property (nonatomic, strong) CYTMessageCenterURLModel *urlModel;

@end

@implementation CYTLinkHandler

- (BOOL)handleAPPInnerLinkWithURL:(NSString *)urlString {
    BOOL valid = NO;
    //内外跳转都兼容所以是两种scheme
    NSString *uf8UrlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (uf8UrlString.length>0 && ([[[NSURL URLWithString:uf8UrlString] scheme] isEqualToString:@"cxt"] || [[[NSURL URLWithString:uf8UrlString] scheme] isEqualToString:kappschemeSmall] || [[[NSURL URLWithString:uf8UrlString] scheme] isEqualToString:kAppScheme])) {
        valid = YES;
    }
    
    if (valid) {
        //解析URL
        NSURL *linkURL = [NSURL URLWithString:uf8UrlString];
        self.urlModel.scheme = [linkURL scheme];
        self.urlModel.host = [linkURL host];
        self.urlModel.path = [linkURL path];
        self.urlModel.parameters = [[linkURL query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        return [self handleLinkWithModel:self.urlModel];
    }
    
    return NO;
}
/**
 * 懒加载
 */
- (CYTMessageCenterURLModel *)urlModel{
    if (!_urlModel) {
        _urlModel = CYTMessageCenterURLModel.new;
    }
    return _urlModel;
}

- (BOOL)handleLinkWithModel:(CYTMessageCenterURLModel *)model {
    if ([model.host containsString:@"dialog"]) return NO;
    NSString *path = [model.path stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    NSString *selName = [NSString stringWithFormat:@"%@%@",model.host,path];
    SEL selector = NSSelectorFromString(selName);
    if ([self respondsToSelector:selector]) {
        [self performSelector:selector withObject:model];
        return YES;
    }else {
        return NO;
    }
}

#pragma mark- method
- (void)handleJumpWithController:(UIViewController *)controller {
    [[FFCommonCode topViewController].navigationController pushViewController:controller animated:YES];
}

- (NSArray *)getURLParamerers {
    return [self.urlModel.parameters componentsSeparatedByString:@"&"];
}

- (NSString *)getURLParametersWithIndex:(NSInteger)index {
    NSArray *array = [self getURLParamerers];
    
    if (array && (array.count > index)) {
        return [array objectAtIndex:index];
    }else {
        return @"";
    }
}

- (NSInteger)getTabIndex {
    //"tab=1"
    NSString *string = [self getURLParametersWithIndex:0];
    NSInteger index = 0;
    if (string&&string.length>0) {
        NSArray *arrayTmp = [string componentsSeparatedByString:@"="];
        if (arrayTmp && arrayTmp.count >=2 ) {
            NSString *tabString = arrayTmp[1];
            index = [tabString integerValue];
        }
    }
//    index = (index-1)<0?0:(index-1);
    return index;
}

#pragma mark - 首页工具跳转配置

/**
 *  发布车源
 */
- (void)car_source_publish_carsource{
    CYTCarSourcePublishViewController *publish = CYTCarSourcePublishViewController.new;
    publish.ffobj = @(1);
    [[CYTCommonTool currentViewController].navigationController pushViewController:publish animated:YES];
}

/**
 *  发布寻车
 */
- (void)seek_car_publish_seekcar{
    CYTSeekCarNeedPublishViewController *publish = CYTSeekCarNeedPublishViewController.new;
    publish.ffobj = @(1);
    [[CYTCommonTool currentViewController].navigationController pushViewController:publish animated:YES];
}

/**
 *  车源管理/我的车源
 */
- (void)car_source_my_carsource_list{
    CYTMyCarSourceViewController *myCarSourceVC = CYTMyCarSourceViewController.new;
    [[CYTCommonTool currentViewController].navigationController pushViewController:myCarSourceVC animated:YES];
}

/**
 *  联系我的
 */
- (void)contact_contact_me{
    CYTContactMeViewController *contactMeVC = CYTContactMeViewController.new;
    NSInteger tagIndex = [self getTabIndex];
    if (tagIndex>=0 && tagIndex<=1) {
        contactMeVC.tagIndex = tagIndex;
    }
    [[CYTCommonTool currentViewController].navigationController pushViewController:contactMeVC animated:YES];
}
/**
 *  实体店认证
 */
- (void)setup_storeauth_apply{
    CYTStoreCertificationViewController *storeCertificationVC = CYTStoreCertificationViewController.new;
    [[CYTCommonTool currentViewController].navigationController pushViewController:storeCertificationVC animated:YES];
}

#pragma mark- tabbar
- (void)home_home_page {
    [kAppdelegate goHomeView];
}

- (void)home_carsource_list {
    [kAppdelegate goCarSourceView];
}

- (void)home_seekcar_list {
    [kAppdelegate goSeekCarView];
}

- (void)home_discover {
    [kAppdelegate goDiscover];
}

- (void)home_me {
    [kAppdelegate goMe];
}

#pragma mark- ycb
- (void)ycb_mall {
    CYTH5WithInteractiveCtr *mall = [[CYTH5WithInteractiveCtr alloc] initWithViewModel:NSStringFromUIEdgeInsets(UIEdgeInsetsZero)];
    mall.requestURL = kURL.KURL_mall_goodsList;
    mall.showIndicator = YES;
    [self handleJumpWithController:mall];
}

- (void)ycb_personalHome {
    CYTMyYicheCoinViewController *yichebi = [CYTMyYicheCoinViewController new];
    [self handleJumpWithController:yichebi];
}

#pragma mark- message
- (void)message_message_page {
    CYTMessageCategoryTableController *category = [CYTMessageCategoryTableController new];
    [self handleJumpWithController:category];
}

#pragma mark- moments
- (void)moments_home {
    CYTCarTradeCircleCtr *carDealerMoments = [CYTCarTradeCircleCtr new];
    carDealerMoments.requestURL = kURL.kURL_carFriends_home;;
    carDealerMoments.type = CarTradeViewTypeHome;
    [self handleJumpWithController:carDealerMoments];
}

#pragma mark- carSource

///已联系车源
- (void)car_source_contacts_carsource_list {
    CYTMyContactViewController *vc = [CYTMyContactViewController new];
    [self handleJumpWithController:vc];
}

///车源详情
- (void)car_source_carsource_detail {
    NSString *string0 = [self getURLParametersWithIndex:0];
    if (string0 && string0.length>0) {
        NSArray *arrayTmp = [string0 componentsSeparatedByString:@"="];
        if (arrayTmp.count >=2) {
            NSString *carSourceId = arrayTmp[1];
            if (carSourceId.length==0) {return;}
            CYTCarSourceDetailTableController *detail = [CYTCarSourceDetailTableController new];
            detail.viewModel.carSourceId = carSourceId;
            [self handleJumpWithController:detail];
        }
    }
}

#pragma mark- seekCar
///我的寻车列表
- (void)seek_car_my_seekcar_list {
    CYTMySeekCarViewController *list = [[CYTMySeekCarViewController alloc] init];
    [self handleJumpWithController:list];
}

///已联系寻车
- (void)seek_car_contacts_seekcar_list {
    CYTMyContactViewController *vc = [CYTMyContactViewController new];
    [self handleJumpWithController:vc];
}

///寻车详情
- (void)seek_car_seekcar_detail {
    NSString *string = [self getURLParametersWithIndex:0];
    if (string && string.length>0) {
        NSArray *arrayTmp = [string componentsSeparatedByString:@"="];
        if (arrayTmp.count >=2) {
            NSString *seekCarId = arrayTmp[1];
            if (seekCarId.length==0) {return;}
            CYTSeekCarDetailViewController *detail = [[CYTSeekCarDetailViewController alloc] init];
            detail.seekCarId = seekCarId;
            [self handleJumpWithController:detail];
        }
    }
}

#pragma mark- order
///订单详情
- (void)car_order_order_detail {
    NSString *par0 = [self getURLParametersWithIndex:0];
    NSString *par1 = [self getURLParametersWithIndex:1];
    NSString *par2 = [self getURLParametersWithIndex:2];
    NSString *par3 = [self getURLParametersWithIndex:3];
    NSArray *allArray = @[par0,par1,par2,par3];
   
    NSString *orderString = @"orderId";
    NSString *orderStatusString = @"orderStatus";
    NSString *isMyBuyCarString = @"isMyBuyCar";
    
    for (NSString *item in allArray) {
        if ([item containsString:orderString]) {
            orderString = item;
        }else if ([item containsString:isMyBuyCarString]) {
            isMyBuyCarString = item;
        }else if ([item containsString:orderStatusString]) {
            orderStatusString = item;
        }
    }
    
    if (orderString && orderString.length >0 ) {
        NSArray *tmp0 = [orderString componentsSeparatedByString:@"="];
        if (tmp0.count>=2) {
            orderString = tmp0[1];
        }
    }
    
    if (orderStatusString && orderStatusString.length>0 ) {
        NSArray *tmp0 = [orderString componentsSeparatedByString:@"="];
        if (tmp0.count>=2) {
            orderStatusString = tmp0[1];
        }
    }
    
    if (isMyBuyCarString && isMyBuyCarString.length>0) {
        NSArray *tmp0 = [isMyBuyCarString componentsSeparatedByString:@"="];
        if (tmp0.count>=2) {
            isMyBuyCarString = tmp0[1];
        }else {
            isMyBuyCarString = @"0";
        }
    }else {
        isMyBuyCarString = @"0";
    }
    
    if (orderString && orderString.length >0) {
        //orderString 是orderId
        BOOL isMyBuyCar = [isMyBuyCarString boolValue];
        //因为内部定义的正好相反。
        NSInteger myBuyCar = (isMyBuyCar)?0:1;
        CYTOrderDetailViewController *detail = [CYTOrderDetailViewController new];
        detail.orderStatus = orderStatusString.integerValue;
        detail.orderId = orderString;
        detail.orderType = myBuyCar;
        //跳转
        [self handleJumpWithController:detail];
    }
}

#pragma mark- logistics
- (void)logistics_home {
    [self handleJumpWithController:[CYTLogisticsHomeTableController new]];
}

///物流需求详情
- (void)logistics_demand_demand_detail {
    NSString *par0 = [self getURLParametersWithIndex:0];
    if (par0 && par0.length>0) {
        NSArray *arrayTmp = [par0 componentsSeparatedByString:@"="];
        if (arrayTmp.count >=2 ) {
            NSString *demandId = arrayTmp[1];
            CYTLogisticsNeedDetailTableController *detail = [CYTLogisticsNeedDetailTableController new];
            detail.viewModel.neeId = [demandId integerValue];
            [self handleJumpWithController:detail];
        }
    }
}

///物流订单详情
- (void)logistics_order_order_detail {
    NSString *par0 = [self getURLParametersWithIndex:0];
    if (par0 && par0.length >0) {
        NSArray *arrayTmp = [par0 componentsSeparatedByString:@"="];
        if (arrayTmp.count >=2) {
            NSString *orderId = arrayTmp[1];
            CYTLogisticsOrderDetail3DController *logisticsOrderDetailController = [[CYTLogisticsOrderDetail3DController alloc] init];
            logisticsOrderDetailController.orderId = orderId;
            [self handleJumpWithController:logisticsOrderDetailController];
        }
    }
}

#pragma mark- cash and coupon
///我的账户
- (void)capital_mgr_my_account {
    CYTMyAccountCtr *ctr = [[CYTMyAccountCtr alloc] init];
    ctr.requestURL = kURL.kURL_myAccount;    
    [self handleJumpWithController:ctr];
}

///设置交易密码
- (void)capital_mgr_set_password {
    CYTWithdrawPwdSetTableController *ctr = [CYTWithdrawPwdSetTableController new];
    [self handleJumpWithController:ctr];
}

///提现
- (void)capital_mgr_withdraw_cash {
    CYTGetCashCtr *ctr = [CYTGetCashCtr new];
    [self handleJumpWithController:ctr];
}

///物流优惠券
- (void)coupon_list {
    CYTMyCouponViewController *couponCtr = [CYTMyCouponViewController myCouponWithCouponCardType:CYTMyCouponCardTypeDefault];
    [self handleJumpWithController:couponCtr];
}

#pragma mark- setting
///个人企业认证
- (void)setup_authentication {
    CYTAuthManager *manager = [CYTAuthManager manager];
    //请求数据
    [manager getUserDealerInfoFromLocal:NO result:^(CYTUserInfoModel *model) {
        
        AccountState state = [manager getLocalAccountState];
        if (state == AccountStateAuthenticateFailed) {
            //如果失败和未认证进入提交页面
            CYTPersonalCertificateViewController *personalCertificateVC = [[CYTPersonalCertificateViewController alloc] init];
            personalCertificateVC.backType = CYTBackTypePop;
            [self handleJumpWithController:personalCertificateVC];
        }else if (state == AccountStateAuthenticationed) {
            //如果正在认证中进入浏览
            CYTCertificationPreviewController *certificationPreviewController = [[CYTCertificationPreviewController alloc] init];
            certificationPreviewController.accountState = state;
            certificationPreviewController.backType = CYTBackTypePop;
            [self handleJumpWithController:certificationPreviewController];
        }
    }];
}

///进入设置页面
- (void)setup_page {
    CYTSettingViewController *ctr = [[CYTSettingViewController alloc] init];
    [self handleJumpWithController:ctr];
}

#pragma mark- dealerHome
- (void)dealer_charts {
    NSString *string = [self getURLParametersWithIndex:0];
    if (string && string.length>0) {
        NSArray *arrayTmp = [string componentsSeparatedByString:@"="];
        if (arrayTmp.count >=2) {
            NSInteger index = [arrayTmp[1] integerValue];
            FFExtendViewModel *vm = [FFExtendViewModel new];
            vm.ffIndex = index;
            CYTCarDealerChartController *carDealerChart = [[CYTCarDealerChartController alloc] initWithViewModel:vm];
            [self handleJumpWithController:carDealerChart];
        }
    }
}

///我的车商评论列表
- (void)dealer_evaluate {
    NSString *string = [self getURLParametersWithIndex:0];
    if (string && string.length>0) {
        NSArray *arrayTmp = [string componentsSeparatedByString:@"="];
        if (arrayTmp.count >=2) {
            NSString *userId = arrayTmp[1];
            CYTDealerCommentViewController *comment = [CYTDealerCommentViewController new];
            comment.userId = userId;
            [self handleJumpWithController:comment];
        }
    }
}

//车商主页
- (void)dealer_personalPage {
    //判断id，进行不同页面跳转
    NSString *string0 = [self getURLParametersWithIndex:0];
    NSString *string1 = [self getURLParametersWithIndex:1];
    NSString *string2 = [self getURLParametersWithIndex:2];
    NSArray *allArray = @[string0,string1,string2];
    
    NSString *userIdString = @"userId";
    NSString *typeString = @"type";
    NSString *showString = @"isShowWindow";
    
    for (NSString *item in allArray) {
        if ([item containsString:userIdString]) {
            userIdString = item;
        }else if ([item containsString:typeString]) {
            typeString = item;
        }else if ([item containsString:showString]) {
            showString = item;
        }
    }
    
    if (userIdString && userIdString.length>0) {
        NSArray *arrayTmp = [userIdString componentsSeparatedByString:@"="];
        if (arrayTmp.count >=2) {
            userIdString = arrayTmp[1];
        }else {
            userIdString = nil;
        }
    }
    
    if (typeString && typeString.length>0) {
        NSArray *arrayTmp = [typeString componentsSeparatedByString:@"="];
        if (arrayTmp.count >=2) {
            typeString = arrayTmp[1];
        }else {
            typeString = nil;
        }
    }
    
    if (showString && showString.length>0) {
        NSArray *arrayTmp = [showString componentsSeparatedByString:@"="];
        if (arrayTmp.count >=2) {
            showString = arrayTmp[1];
        }else {
            showString = nil;
        }
    }
    
    NSInteger type = (typeString)?typeString.integerValue:0;
    NSInteger show = (showString)?showString.integerValue:0;
    if (!userIdString) {return;}
    
    if ([userIdString isEqualToString:CYTUserId]) {
        //我的
        CYTDealerMeHomeTableController *meHome = [CYTDealerMeHomeTableController new];
        meHome.viewModel.userId = CYTUserId;
        [self handleJumpWithController:meHome];
    }else {
        CYTDealerHisHomeTableController *hisHome = [CYTDealerHisHomeTableController new];
        hisHome.viewModel.userId = userIdString;
        hisHome.viewModel.commentShow = show;
        hisHome.viewModel.commentType = type;
        [self handleJumpWithController:hisHome];
    }
}

@end
