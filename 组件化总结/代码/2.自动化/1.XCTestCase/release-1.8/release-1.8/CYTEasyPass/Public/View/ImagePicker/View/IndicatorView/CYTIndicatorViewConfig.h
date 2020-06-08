//
//  CYTIndicatorViewConfig.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#ifndef CYTIndicatorViewConfig_h
#define CYTIndicatorViewConfig_h

typedef enum : NSUInteger {
    CYTIndicatorViewTypeNotEditable = 0,       //用户不可编辑
    CYTIndicatorViewTypeEditNavBar,            //导航栏区域可编辑
    CYTIndicatorViewTypeEditTabBar,            //tabBar区域可编辑
    CYTIndicatorViewTypeEditNavBarAndTabBar    //导航栏区域和tabBar区域可编辑
} CYTIndicatorViewType;


#endif /* CYTIndicatorViewConfig_h */
