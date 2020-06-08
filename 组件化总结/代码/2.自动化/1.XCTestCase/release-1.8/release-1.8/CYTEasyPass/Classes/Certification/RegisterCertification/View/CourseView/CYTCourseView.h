//
//  CYTCourseView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/18.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYTCourseView : UIView

+ (instancetype)showCourseViewWithType:(CYTIdType)idType finish:(void(^)())fishBlock;

@end
