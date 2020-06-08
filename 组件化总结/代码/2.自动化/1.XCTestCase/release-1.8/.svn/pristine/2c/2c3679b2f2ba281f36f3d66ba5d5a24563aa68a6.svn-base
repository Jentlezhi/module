//
//  CYTUsersInfoModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/10.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTUsersInfoModel : NSObject

/** 用户ID */
@property(copy, nonatomic) NSString *ID;
/** 手机号 */
@property(copy, nonatomic) NSString *Telphone;
/** 图片原图 */
@property(copy, nonatomic) NSString *FaceOriginalPic;
/** 图片缩略图 */
@property(copy, nonatomic) NSString *FaceThumbnailPic;
/**  */
@property(assign, nonatomic) int UserState;
/**  */
@property(copy, nonatomic) NSString *UserAgent;
/** 认证结果 */
/*
备注：-2：认证被驳回；0：初始化（未填写认证信息）；1：已填写/提交认证信息；2：认证审核通过
 */
@property(copy, nonatomic) NSString *AuthenticateResult;
/** 令牌 */
@property(copy, nonatomic) NSString *Token;
/** 是否认证完成 */
@property(assign, nonatomic) BOOL IsFinishAuthenticate;

@end
