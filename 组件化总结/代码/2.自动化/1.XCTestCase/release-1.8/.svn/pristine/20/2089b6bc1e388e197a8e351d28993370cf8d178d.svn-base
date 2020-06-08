//
//  CYTStarView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/8/2.
//  Copyright © 2017年 EasyPass. All rights reserved.
// 星星控件
/*
 用法
 CYTStarView *star = [[CYTStarView alloc] init];
 star.starTotalNum = 7;
 star.starValue = 5;
 [self.view addSubview:star];
 extern CGFloat starWidth;
 extern CGFloat starHeight;
 [star mas_makeConstraints:^(MASConstraintMaker *make) {
 make.center.equalTo(self.view);
 make.size.equalTo(CGSizeMake(CYTAutoLayoutV(starWidth)*star.starTotalNum, CYTAutoLayoutV(starHeight)));
 }];
 */

#import <UIKit/UIKit.h>


@interface CYTStarView : UIView

/** 总数 */
@property(assign, nonatomic) NSInteger starTotalNum;//默认5个
/** 星星值 */
@property(assign, nonatomic) CGFloat starValue;


@end
