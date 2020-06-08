//
//  CYTGetColorBasicVM.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"

typedef NS_ENUM(NSInteger,CarColorType) {
    ///全部
    CarColorTypeAll,
    ///色全
    CarColorTypeColorAll,
    ///不限
    CarColorTypeNoLimit,
};

@interface CYTGetColorBasicVM : CYTExtendViewModel
///颜色数据
@property (nonatomic, strong) NSArray *inColorArray;
@property (nonatomic, strong) NSArray *exColorArray;

///当前选择的内饰颜色
@property (nonatomic, copy) NSString *inColorSel;
///当前选择外观颜色
@property (nonatomic, copy) NSString *exColorSel;

///处理颜色数据
+ (NSArray *)colorArray:(NSArray *)colorArray withType:(CarColorType)type;

@end
