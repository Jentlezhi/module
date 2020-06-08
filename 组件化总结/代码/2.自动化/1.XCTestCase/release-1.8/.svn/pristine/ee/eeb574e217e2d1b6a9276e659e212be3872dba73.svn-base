//
//  CYTHomeDataViewModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTHomeDataViewModel : NSObject
/** 获取banner */
@property(strong, nonatomic) RACCommand *getBannerInfoCommand;
/** 获取未读消息 */
@property(strong, nonatomic) RACCommand *getUnreadCommand;
/** 获取实店认证的商家列表 */
@property(strong, nonatomic) RACCommand *getStoreAuthListCommand;
/** 获取推荐 */
@property(strong, nonatomic) RACCommand *getRecommendCommand;
/** 获取特价车源 */
@property(strong, nonatomic) RACCommand *getRecommendListCommand;
/** 请求类型 */
@property(assign, nonatomic) CYTRequestType requestType;
/** 数据请求完成 */
@property(copy, nonatomic) void(^finishRequestData)(CYTRootResponseModel *storeAuthListData,CYTRootResponseModel *recommendListData,CYTRootResponseModel *carSourceListDataData);
///功能按键数据
@property(strong, nonatomic) NSArray *functionArray;

- (void)requestOtherData;


@end
