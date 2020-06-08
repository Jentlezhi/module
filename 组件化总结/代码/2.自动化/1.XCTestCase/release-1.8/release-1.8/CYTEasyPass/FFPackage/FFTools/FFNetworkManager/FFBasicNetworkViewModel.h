//
//  FFBasicNetworkViewModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/18.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendViewModel.h"
#import "FFBasicNetworkManager.h"

@interface FFBasicNetworkViewModel : FFExtendViewModel
///command
@property (nonatomic, strong) RACCommand *requestCommand;
///hud,0显示，1隐藏
@property (nonatomic, strong) RACSubject *hudSubject;
///网络请求
@property (nonatomic, strong) FFBasicNetworkManager *request;

///请求数据
- (FFBasicNetworkManager *)requestWithModel:(FFBasicNetworkRequestModel *)model andBlock:(void (^)(FFBasicNetworkResponseModel *responseModel))block;

///获取数据模型
- (void)genModel:(FFBasicNetworkResponseModel *)model
       effective:(BOOL)effective
         message:(NSString *)message
            data:(NSDictionary *)data
        httpCode:(NSInteger)httpCode
     handleBlock:(void (^)(FFBasicNetworkResponseModel *responseModel))handleBlock;


#pragma mark- 获取command
///获取requestCommand
- (RACCommand *)commandWithRequestModel:(FFBasicNetworkRequestModel*(^)(void))requestBlock
                            andOtherObj:(void(^)(id))otherObj
                              andHandle:(void (^)(FFBasicNetworkResponseModel *responseModel))handleBlock;

///获取requestCommand
- (RACCommand *)commandWithRequestModel:(FFBasicNetworkRequestModel*(^)(void))requestBlock
                              andHandle:(void (^)(FFBasicNetworkResponseModel *responseModel))handleBlock;

#pragma mark- 对输入输出参数进行操作
///子类重写----对输入参数进行操作
- (FFBasicNetworkRequestModel *)requestModelHandleWithModel:(FFBasicNetworkRequestModel *)model;

///子类重写----对返回参数进行操作
- (void)responseModelHandleWithModel:(FFBasicNetworkResponseModel *)inputModel andHandle:(void (^)(FFBasicNetworkResponseModel *))handle;
///子类重写----对返回参数进行操作
- (void)responseModelHandleWithModel_success:(FFBasicNetworkResponseModel *)inputModel andHandle:(void (^)(FFBasicNetworkResponseModel *))handle;
///子类重写----对返回参数进行操作
- (void)responseModelHandleWithModel_codeError:(FFBasicNetworkResponseModel *)inputModel andHandle:(void (^)(FFBasicNetworkResponseModel *))handle;
///子类重写----对返回参数进行操作
- (void)responseModelHandleWithModel_structError:(FFBasicNetworkResponseModel *)inputModel andHandle:(void (^)(FFBasicNetworkResponseModel *))handle;

///错误码处理
- (void)handleErrorCodeWithResponseModel:(FFBasicNetworkResponseModel *)responseModel andHandle:(void (^)(FFBasicNetworkResponseModel *))handle;

@end
