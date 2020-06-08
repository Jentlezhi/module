//
//  C4BraveSDK.h
//  Pods
//
//  Created by ishaolin on 2017/8/1.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, C4LoginAccountType) {
    C4LoginAccountTypeCustom,
    C4LoginAccountTypeEmail,
    C4LoginAccountTypeMobile
};

@interface C4BraveSDK : NSObject

/** 初始化SDK, app启动时优先调用，此方法禁止重复调用
 *
 * @param options app的启动参数
 * @param appKey 由易车分配的appkey（请提前联系申请）
 * @param channel 默认“App Store”
 * @param enableAutoTrack 是否开启自动埋点（即是否允许hook方法）
 *
 */
+ (void)launchWithOptions:(nullable NSDictionary<NSString *, id> *)options
                   appKey:(NSString *)appKey
                  channel:(nullable NSString *)channel
          enableAutoTrack:(BOOL)enableAutoTrack;

/**
 *  返回appKey，如果设置了appKey，则返回实际的值，否则返回nil
 */
+ (nullable NSString *)appKey;

/**
 *  返回渠道id，如果设置了渠道id，则返回实际的值，否则返回nil
 */
+ (nullable NSString *)channel;

/** 设置是否打印SDK的log信息，默认NO(不打印log)
 *
 * @param enabled 设置为YES， SDK会输出log信息可供调试参考。除非特殊需要，否则发布产品时需改回NO
 *
 */
+ (void)setLogEnabled:(BOOL)enabled;

/** 启动自动埋点的圈选功能需要调用
 *
 */
+ (void)handleOpenURL:(NSURL *)url;

/** 易车账号登录统计
 *
 * @param userName 易车账号
 * @param accountType 账号类型（手机号，邮箱，普通用户名）
 *
 */
+ (void)loginWithYicheUserName:(NSString *)userName accountType:(C4LoginAccountType)accountType;

/** 第三方账号登录统计
 *
 * @param userName 可填登录账号或第三方登录成功后返回的唯一标识
 * @param type 登录方式，建议使用拼音缩写。如：wx表示微信，qq表示QQ，wb表示微博
 *
 */
+ (void)loginWithThirdPartyUserName:(NSString *)userName type:(NSString *)type;

/** 手动页面时长统计, 记录某个页面展示的时长.
 *
 * @param duration 时长，单位为秒
 * @param pageName 统计的页面名称(禁用中文)
 *
 */
+ (void)recordDuration:(NSUInteger)duration forPageName:(NSString *)pageName;

/** 自动页面时长统计, 开始记录某个页面展示时长.
 * 使用方法：必须配对调用recordControllerViewDidAppear:和recordControllerViewDidDisappear:两个函数来完成自动统计，若只调用某一个函数不会生成有效数据。
 * 在该页面展示时调用recordControllerViewDidAppear:，当退出该页面时调用recordControllerViewDidDisappear:
 *
 * @param pageName 统计的页面名称。(禁用中文)
 *
 */
+ (void)recordControllerViewDidAppear:(NSString *)pageName;

/** 自动页面时长统计, 开始记录某个页面展示时长.
 * 使用方法：必须配对调用recordControllerViewDidAppear:和recordControllerViewDidDisappear:两个函数来完成自动统计，若只调用某一个函数不会生成有效数据。
 * 在该页面展示时调用recordControllerViewDidAppear:，当退出该页面时调用recordControllerViewDidDisappear:
 *
 * @param pageName 统计的页面名称。(禁用中文)
 *
 */
+ (void)recordControllerViewDidDisappear:(NSString *)pageName;

/** 初始化webView记录对象
 * 建议在- (void)viewDidLoad;调用
 *
 */
+ (void)readyToRecordWebViewEvent;

/** 建议在- (void)webViewDidStartLoad:(UIWebView *)webView;调用
 *
 */
+ (void)startRecordWebViewDuration;

/** 建议在- (void)webViewDidFinishLoad:(UIWebView *)webView;调用
 *
 * @param url UIWebView对象加载的url地址
 *
 */
+ (void)recordWebViewDurationWithUrl:(NSString *)url;

/** 建议在- (void)viewDidDisappear:(BOOL)animated;调用
 */
+ (void)endRecordWebViewDuration;

/** 点击次数统计
 *
 * @param  eventId 事件id.
 *
 */
+ (void)recordClickCountWithEvent:(NSString *)eventId;

/** 自定义内容统计
 *
 * @param  eventId 事件id.
 * @param  params 事件内容（key－value），key和value必须是NSString类型，否则数仓无法处理
 *
 */
+ (void)recordEvent:(NSString *)eventId params:(nullable NSDictionary<NSString *, NSString *> *)params;

/** 地理位置统计
 *
 */
+ (void)recordLocation:(CLLocation *)location;

+ (void)recordLocationCoordinate:(CLLocationCoordinate2D)coordinate;

@end

NS_ASSUME_NONNULL_END
