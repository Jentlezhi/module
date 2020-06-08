//
//  CYTProgressPieView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/10.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "M13ProgressViewPie.h"

@interface CYTProgressPieView : M13ProgressViewPie

/** 外圈颜色 */
@property(strong, nonatomic) UIColor *circleColor;
/** 进度颜色 */
@property(strong, nonatomic) UIColor *progressColor;
/** 进度值 */
@property(assign, nonatomic) CGFloat pieProgressValue;


@end
