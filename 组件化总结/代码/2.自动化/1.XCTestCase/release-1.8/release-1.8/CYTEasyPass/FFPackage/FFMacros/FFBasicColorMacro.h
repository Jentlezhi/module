//
//  FFBasicColorMacro.h
//  FFBasicProject
//
//  Created by xujunquan on 17/6/29.
//  Copyright © 2017年 ian. All rights reserved.
//

#ifndef FFBasicColorMacro_h
#define FFBasicColorMacro_h


///cell line
#define kFFColor_line                       FFColorFromRGB(0xdbdbdb)
///view背景色,separator背景色
#define kFFColor_bg_nor                     FFColorFromRGB(0xf6f6f6)


///文字标题1颜色
#define kFFColor_title_L1                   FFColorFromRGB(0x333333)
///文字标题2颜色
#define kFFColor_title_L2                   FFColorFromRGB(0x666666)
///文字标题3颜色
#define kFFColor_title_L3                   FFColorFromRGB(0x999999)
///浅色文字颜色
#define kFFColor_title_gray                 FFColorFromRGB(0xb6b6b6)

///绿色
#define kFFColor_green                      FFColorFromRGB(0x35B445)


///导航默认颜色
#define kFFNavigationBarDefaultColor        FFColorFromRGB(0xF7F9F8)
///导航线默认颜色
#define kFFNavigationBarLineDefaultColor    FFColorFromRGB(0xB2B2B2)

#pragma mark- tool
#define FFColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#endif /* FFBasicColorMacro_h */
