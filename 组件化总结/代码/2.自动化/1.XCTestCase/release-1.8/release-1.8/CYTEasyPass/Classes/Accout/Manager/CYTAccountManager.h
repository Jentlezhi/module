//
//  CYTAccountManager.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYTUserKeyInfoModel.h"
#import "CYTUserInfoModel.h"

@interface CYTAccountManager : NSObject
/** 用户Id */
@property(copy, nonatomic) NSString *userId;
/** 用户手机号 */
@property(copy, nonatomic) NSString *userPhoneNum;
/** Token */
@property(copy, nonatomic) NSString *accessToken;
/** 用于更新Token的刷新Token */
@property(copy, nonatomic) NSString *refreshToken;
/** 认证状态  备注：-2：认证被驳回；0：初始化（未填写认证信息）；1：已填写/提交认证信息；2：认证审核通过 */
@property(assign, nonatomic) NSInteger authStatus;
/** 是否已登录 */
@property(assign, nonatomic) BOOL isLogin;
/** 用户关键信息 */
@property(strong, nonatomic) CYTUserKeyInfoModel *userKeyInfoModel;
/** 用户基本信息 */
@property(strong, nonatomic) CYTUserInfoModel *userAuthenticateInfoModel;
/**
 *  单例
 */
+ (instancetype)sharedAccountManager;
/**
 *  清空数据
 */
- (void)cleanUserData;
/**
 *  更新用户认证信息
 */
/**
 *  更新用户认证信息
 */
- (void)updateUserInfoCompletion:(void(^)(CYTUserInfoModel *userAuthenticateInfoModel))completion;
/**
 *  过期获取Token
 */
- (void)getTokenByRefreshTokenComplation:(void(^)(CYTUserKeyInfoModel *userKeyInfoModel))complation;



@end
