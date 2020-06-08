//
//  CXBaseURLRequest.h
//  Pods
//
//  Created by ishaolin on 2017/7/3.
//
//  网络请求的基类，不能直接使用，需要子类继承并根据需要重写以下方法：
//  1. @selector(responseModelWithDictionary:) /*<json转model>*/
//  2. @selector(HTTPMethod)                   /*<请求方式: GET, POST>*/
//  3. @selector(host)                         /*<接口主机地址>*/
//  4. @selector(path)                         /*<接口path>*/
//  5. @selector(commonParams)                 /*<请求的公共参数，不需要时请返回nil>*/
//  6. @selector(sigWithAllParams:)            /*<请求参数签名，不需要时请将属性signEnabled设置为NO>*/
//  注意：其中3和4是必选实现，其他可选实现

#import "CXBaseResponseModel.h"
#import "CXHTTPMethod.h"

NS_ASSUME_NONNULL_BEGIN

@class CXHTTPSessionManager;

typedef void (^CXBaseURLRequestSuccessBlock)(NSURLSessionDataTask * _Nonnull dataTask, CXBaseResponseModel * _Nullable responseModel);

typedef void (^CXBaseURLRequestFailureBlock)(NSURLSessionDataTask * _Nullable dataTask, NSError * _Nullable error);

typedef void (^CXBaseURLRequestRetryBlock)(void);

@interface CXBaseURLRequest : NSObject

@property (nonatomic, strong, readonly, nullable) CXHTTPSessionManager *HTTPSessionManager;

/*!
 *  @brief 请求参数（不包含公共参数），公共参数自动添加
 */
@property (nonatomic, strong, readonly) NSDictionary<NSString *, id> *params;

/*!
 *  @brief 单次的请求超时时间，总的请求超时时间为timeoutInterval * autoRetryTimes
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/*!
 *  @brief 自动重试次数，默认1，既请求超时之后会自动重试，此值建议不要大于3
 */
@property (nonatomic, assign) NSUInteger autoRetryTimes;

/*!
 *  @brief 参数签名字符串传递给server的参数名，默认: 'sign'
 *
 */
@property (nonatomic, copy) NSString *signKey;

/*!
 *  @brief 是否启用请求参数签名，默认: YES
 *
 */
@property (nonatomic, assign, getter = isSignEnabled) BOOL signEnabled;

@property (nonatomic, assign) BOOL ignoreCallbackByCanceled; // 是否忽略取消的回调，默认:YES

#pragma mark 设置参数

/*!
 *  @brief param和params的value只能为NSString或NSNumber类型，其他的数据类型直接忽略
 *
 */
- (void)addParam:(id)param forKey:(NSString *)key;
- (void)addParams:(NSDictionary<NSString *, id> *)params;
- (void)removeParamForKey:(NSString *)key;
- (void)removeParamsForKeys:(NSArray<NSString *> *)keys;

/*!
 *  @brief 发送网络请求，子类重写时需要调用super
 *
 *  @param successBlock 请求成功的回调
 *  @param failureBlock 请求失败的回调
 */
- (void)loadRequestWithSuccess:(nullable CXBaseURLRequestSuccessBlock)successBlock
                       failure:(nullable CXBaseURLRequestFailureBlock)failureBlock;

/*!
 *  @brief 请求成功的json数据转model，子类必须重写
 *
 *  @param dictionary json数据
 *
 *  @return 转换之后的model
 */
- (nullable CXBaseResponseModel *)responseModelWithDictionary:(nullable NSDictionary<NSString *, id> *)dictionary;

/*!
 *  @brief 请求的Method，必须有值，默认CXHTTPMethod_GET
 *
 *  @return CXHTTPMethod类型
 */
- (CXHTTPMethod)HTTPMethod;

/*!
 *  @brief 如：https://www.baidu.com/，要求子类必须重写并返回实际的接口主机地址
 *
 */
- (NSString *)host;

/*!
 *  @brief 请求的URL的后半部分。如：api/order/getDetail，要求子类必须重写并返回实际的接口path
 *
 */
- (NSString *)path;

/*!
 *  @brief 公共参数
 *
 */
- (nullable NSDictionary<NSString *, id> *)commonParams;

/*!
 * @brief 参数签名，不使用默认签名方法时，子类需要重写此方法
 *
 * @param params 参数集
 * @return 签名字符串
 */
- (nullable NSString *)sigWithAllParams:(nullable NSDictionary<NSString *, id> *)params;

- (void)cancel;
- (void)suspend;
- (void)resume;

+ (void)cancelAll;
+ (void)setMaxConcurrentOperationCount:(NSUInteger)maxConcurrentOperationCount;

#pragma mark - 私有方法，子类可以重写

- (nullable NSURLSessionDataTask *)_loadRequestWithURL:(NSString *)url
                                               success:(nullable CXBaseURLRequestSuccessBlock)successBlock
                                               failure:(nullable CXBaseURLRequestFailureBlock)failureBlock;

#pragma mark - 私有方法，子类禁止重写

- (void)_onSuccess:(nullable CXBaseURLRequestSuccessBlock)successBlock
    responseObject:(nullable id)responseObject;

- (void)_onFailure:(nullable CXBaseURLRequestFailureBlock)failureBlock
        retryBlock:(nullable CXBaseURLRequestRetryBlock)retryBlock
             error:(nullable NSError *)error;

@end

CX_FOUNDATION_EXTERN NSTimeInterval const CXURLRequestDefaultTimeOutInterval;
CX_FOUNDATION_EXTERN NSUInteger const CXURLRequestDefaultAutoRetryTimes;
CX_FOUNDATION_EXTERN NSUInteger const CXURLRequestDefaultMaxConcurrentOperationCount;

NS_ASSUME_NONNULL_END
