//
//  CYTRoundButton.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/9.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CYTBtnCornerType) {
    CYTBtnCornerTypeNone = 0,
    CYTBtnCornerTypeTopBottomLeft,
    CYTBtnCornerTypeTopBottomRight,
    CYTBtnCornerTypeAll,
};

@interface CYTRoundButton : UIButton

/** 圆角类型 */
@property(assign, nonatomic) CYTBtnCornerType cornerType;

@end
