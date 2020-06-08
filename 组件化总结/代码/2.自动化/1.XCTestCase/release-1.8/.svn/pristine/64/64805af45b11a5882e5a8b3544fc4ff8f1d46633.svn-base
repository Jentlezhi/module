//
//  CYTCarPublishSucceedController.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/27.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendViewController.h"

typedef enum : NSUInteger {
    CYTPublishTypeSeekCarPublish = 0, //发布寻车需求
    CYTPublishTypeCarsourcePublish,   //发布车源
} CYTPublishType;

@interface CYTCarPublishSucceedController : FFExtendViewController
@property (nonatomic, strong) UIImageView *succeedImageView;
@property (nonatomic, strong) UILabel *succeedLabel;
/** 发布类型（发布按钮的点击） */
@property(assign, nonatomic) CYTPublishType publishType;
///车源或者寻车发布成功后的id,分享使用
@property (nonatomic, assign) NSInteger idCode;

@end
