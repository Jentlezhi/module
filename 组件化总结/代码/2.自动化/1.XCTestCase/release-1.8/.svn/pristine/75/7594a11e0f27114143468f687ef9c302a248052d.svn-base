//
//  CYTCarListInfoView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/8/2.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CYTCarListInfoTypeCarSource = 0,//车源列表
    CYTCarListInfoTypeSeekCar,//寻车列表
} CYTCarListInfoType;

@class CYTCarSourceListModel;
@class CYTSeekCarListModel;
@class CYTCarModel;


@interface CYTCarListInfoView : UIView

/** 列表模型 */
@property(strong, nonatomic) CYTCarSourceListModel *carSourceListModel;
/** 列表模型 */
@property(strong, nonatomic) CYTSeekCarListModel *seekCarListModel;
/** 数据模型 */
@property(strong, nonatomic) CYTCarModel *carModel;

+ (instancetype)carListInfoWithType:(CYTCarListInfoType)carListInfoType hideTopBar:(BOOL)hide;


@end
