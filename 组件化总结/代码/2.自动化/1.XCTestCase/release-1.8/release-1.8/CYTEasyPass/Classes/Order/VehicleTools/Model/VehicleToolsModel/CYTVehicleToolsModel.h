//
//  CYTVehicleToolsModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTVehicleToolsModel : NSObject

/** 内容 */
@property(copy, nonatomic) NSString *name;
/** 是否选中 */
@property(assign, nonatomic) BOOL selected;
/** 图标名称 */
@property(copy, nonatomic) NSString *imageName;
/** 是否隐藏分割线 */
@property(assign, nonatomic) BOOL hideDividerLine;
/** 添加选项 */
@property(assign, nonatomic) BOOL addItem;

@end
