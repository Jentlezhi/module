//
//  CYTMessageJPUSHModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/20.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"

typedef NS_ENUM(NSInteger,CYTMessageLCType) {
    ///退出登录
    CYTMessageLCTypeLogout = 401,
    ///更新
    CYTMessageLCTypeUpdate = 888,
};

@interface CYTMessageJPUSHAlertModel : FFExtendModel
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *title;

@end

@interface CYTMessageJPUSHAPSModel : FFExtendModel
//@property (nonatomic, strong) CYTMessageJPUSHAlertModel *alert;
@property (nonatomic, copy) NSString *badge;
@property (nonatomic, copy) NSString *sound;

@end

@interface CYTMessageJPUSHModel : FFExtendModel
@property (nonatomic, copy) NSString *_j_business;
@property (nonatomic, copy) NSString *_j_msgid;
@property (nonatomic, copy) NSString *_j_uid;
@property (nonatomic, strong) CYTMessageJPUSHAPSModel *aps;
///自定义字段
@property (nonatomic, copy) NSString *url;

@end

@interface CYTMessageJpushLCModel : FFExtendModel
@property (nonatomic, assign) NSInteger messageType;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *url;

@end
