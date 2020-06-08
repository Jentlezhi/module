//
//  CYTAccountStateModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/14.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CYTUserInfoModel;

@interface CYTAccountStateModel : NSObject

/** 认证状态 */
@property(assign, nonatomic) AccountState state;
/** 认证描述 */
@property(copy, nonatomic) NSString *authDec;
/** 认证描述颜色 */
@property(strong, nonatomic) UIColor *authDecColor;
/** 是否显示评价星标 */
@property(assign, nonatomic,getter=isShowStarView) BOOL showStarView;
/** 信息模型 */
@property(strong, nonatomic) CYTUserInfoModel *userInfoModel;

@end
