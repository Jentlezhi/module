//
//  CYTMessageCenterVM.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"

typedef NS_ENUM(NSInteger,LinkSourceType) {
    ///跳转为push发起
    LinkSourceTypePush,
    ///跳转是消息点击发起
    LinkSourceTypeMessage,
};

@interface CYTMessageCenterVM : CYTExtendViewModel
///单例类
+ (instancetype)manager;
///气泡数
@property (nonatomic, assign) NSInteger badgeNumber;
///上传极光id
@property (nonatomic, strong) RACCommand *uploadCommand;
/** dialog回调 */
@property(copy, nonatomic) void(^dialogCallBack)(NSArray *pars);

///上传极光登录id
- (void)uploadJPUSHID;
///保存jpushid
- (void)saveJPUSHID:(NSString *)jpushId;

///处理极光消息推送数据(info：数据，channelType：数据获取途径)
- (void)handleJPUSHInfo:(NSDictionary *)info channelType:(FFChannelType)channelType;
///处理消息跳转(http和cxt)
- (void)handleMessageURL:(NSString *)urlString;
///处理外部跳转
- (void)handleJumpWithURL:(NSString *)urlString;


@end
