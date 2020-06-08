//
//  CYTMessageCenterVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTMessageCenterVM.h"
#import "CYTMessageCenterURLModel.h"
#import "CYTMessageJPUSHModel.h"
#import "CYTEditCarContactsViewController.h"
#import "CYTIDcardTextField.h"
#import<AudioToolbox/AudioToolbox.h>
#import "CYTLinkHandler.h"
#import "CYTUpdateManager.h"

#define kJPUSHTokenId   @"kJPUSHTokenId"

@interface CYTMessageCenterVM ()

@end

@implementation CYTMessageCenterVM

+ (instancetype)manager {
    static CYTMessageCenterVM *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [CYTMessageCenterVM new];
    });
    return instance;
}

//当id发生变化，会再次执行
- (void)uploadJPUSHID {
    
    NSString *jpushId = [self getJPUSHID];
    NSString *userId = CYTUserId;
    if (jpushId && (userId && userId.length>0)) {
        //都存在，则上传
        [self.uploadCommand execute:nil];
    }
}

- (void)saveJPUSHID:(NSString *)jpushId {
    if (jpushId && jpushId.length>0) {
        [[NSUserDefaults standardUserDefaults] setValue:jpushId forKey:kJPUSHTokenId];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (NSString *)getJPUSHID {
    NSString *string = [[NSUserDefaults standardUserDefaults] valueForKey:kJPUSHTokenId];
    if (string && string.length >0) {
        return string;
    }else {
        return nil;
    }
}

- (void)setBadgeNumber:(NSInteger)badgeNumber {
    _badgeNumber = badgeNumber;
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badgeNumber];
    [JPUSHService setBadge:badgeNumber];
}

- (void)handleJPUSHInfo:(NSDictionary *)info channelType:(FFChannelType)channelType {
    
    if (channelType == FFChannelTypeApns) {
        //apns消息
        //发送通知，刷新相关页面
        [[NSNotificationCenter defaultCenter] postNotificationName:kReceivePushKey object:nil];
        
        if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
            //在前台 无操作,增加铃音
            AudioServicesPlaySystemSound(1012);
        }else {
            //不在前台
            //执行跳转方法，如果有链接则跳转，如果没有链接则进入前台即可。
            CYTMessageJPUSHModel *jpushModel = [CYTMessageJPUSHModel mj_objectWithKeyValues:info];
            if (jpushModel && jpushModel.url) {
                [self handleMessageURL:jpushModel.url];
            }
        }
    }else if (channelType == FFChannelTypeJpush){
        //极光长连接消息,区分  1）其他设备登录 2）强制更新
        CYTMessageJpushLCModel *lcModel = [CYTMessageJpushLCModel mj_objectWithKeyValues:info[@"content"]];
        if (lcModel.messageType == CYTMessageLCTypeLogout) {
            //1）其他设备登录,清除用户数据，提示异常，
            //请求token，如果401，则清空数据，否则无操作。
            FFBasicNetworkRequestModel *reqMod = [FFBasicNetworkRequestModel new];
            reqMod.needHud = NO;
            reqMod.requestURL = kURL.user_identity_auth;
            reqMod.requestParameters = [CYTTools loginParameters].mj_keyValues;
            reqMod.httpHeadFiledDictionary = [CYTTools headFiledDictionary];
            
            [self.request postWithModel:reqMod result:^(FFBasicNetworkResponseModel *responseObj) {
                CYTRequestResponseModel *cytResponse = [CYTRequestResponseModel mj_objectWithKeyValues:responseObj.responseObject];
                if(cytResponse.errorCode == 401){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[CYTAccountManager sharedAccountManager] cleanUserData];
                        [CYTToast errorToastWithMessage:lcModel.content];
                    });
                }
            }];
            
        }else if (lcModel.messageType == CYTMessageLCTypeUpdate) {
            //2）强制更新,调用更新接口
            [CYTUpdateManager update];
        }else {
            //其他
        }
    }
}

///某些情况下不用跳转处理
- (BOOL)doNotNeedHandle {
    if ([[FFCommonCode topViewController] isKindOfClass:[UIAlertController class]]) {
        return YES;
    }else {
        NSArray *subviews = kWindow.subviews;
        for (UIView *obj in subviews) {
            if ([obj isKindOfClass:[CYTAlertView class]] || [obj isKindOfClass:[CYTLoadingView class]]) {
                return YES;
            }
        }
    }
    return NO;
}

#pragma mark- 跳转链接处理
- (void)handleMessageURL:(NSString *)urlString{
    //如果是空，则不处理
    if (urlString.length==0) {return;}
    
    //某几个页面不作处理
    if ([self doNotNeedHandle]) {return;}

    BOOL isDialog = [[NSString hostWithUrl:urlString] containsString:@"dialog"];
    //清空window上所有自定义view
    if (!isDialog) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kHideWindowSubviewsKey object:nil];
    }
    //http https
    if ([[[NSURL URLWithString:urlString] scheme] hasPrefix:@"http"]) {
        //如果是web链接，则进入web展示页面
        CYTH5WithInteractiveCtr *protocolVC = [[CYTH5WithInteractiveCtr alloc] init];
        protocolVC.requestURL = urlString;
        [[FFCommonCode topViewController].navigationController pushViewController:protocolVC animated:YES];
    }else if (isDialog){
        CYTLinkHandler *linkHandler = [CYTLinkHandler new];
        [linkHandler handleAPPInnerLinkWithURL:urlString];
        NSArray *pars = [linkHandler getURLParamerers];
        !self.dialogCallBack?:self.dialogCallBack(pars);
    } else {
        //处理app内部跳转
        [[CYTLinkHandler new] handleAPPInnerLinkWithURL:urlString];
    }
}

- (void)handleJumpWithURL:(NSString *)urlString {
    
}

#pragma mark- get
- (RACCommand *)uploadCommand {
    if (!_uploadCommand) {
        _uploadCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.requestURL = kURL.user_identity_BindJPushDevice;
            model.needHud = NO;
            NSString *jpushId = [self getJPUSHID];
            NSString *userId = CYTUserId;
            NSDictionary *parameters = @{@"UserId":userId,
                                         @"JPushRegistrationId":jpushId};
            model.requestParameters = parameters;
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *x) {
            //none
        }];
    }
    return _uploadCommand;
}

@end
