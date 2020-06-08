//
//  FFBasicLayoutMacro.h
//  FFBasicProject
//
//  Created by xujunquan on 17/6/29.
//  Copyright © 2017年 ian. All rights reserved.
//

#ifndef FFBasicLayoutMacro_h
#define FFBasicLayoutMacro_h

//line
#define kFFLayout_line      (0.5)

#pragma mark- 自动布局宽高适配(iphone6标准)
#define kFFAutolayoutH(x)    ((x) * kFF_SCREEN_WIDTH/750.0)
#define kFFAutolayoutV(y)    ((y) * kFF_SCREEN_HEIGHT/1334.0)

#define kFFStatusBarHeight      ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define kFFNavigationBarHeight  (44)
#define kFFNavigationItemSpace  (10)
#define kFFNavigationLineHeight (0.6)


#endif /* FFBasicLayoutMacro_h */
