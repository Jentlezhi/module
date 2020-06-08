//
//  CYTSetEditDeleteBarView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/15.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CYTCarContactsModel;
@class CYTAddressModel;
@interface CYTSetEditDeleteBarView : UIView
/** 联系人模型 */
@property(strong, nonatomic) CYTCarContactsModel *carContactsModel;
/** 地址模型 */
@property(strong, nonatomic) CYTAddressModel *addressModel;
/** 默认标题 */
@property(copy, nonatomic) NSString *defaultTitle;

/** 设置为默认 */
@property(copy, nonatomic) void(^setDefault)();
/** 编辑 */
@property(copy, nonatomic) void(^editOperation)();
/** 删除 */
@property(copy, nonatomic) void(^deleteOperation)();

@end
