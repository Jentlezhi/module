//
//  FFNavigationItemView.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/25.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"

#define kItemMinWidth   (44)

@interface FFNavigationItemView : FFExtendView
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, assign) UIEdgeInsets contentInsect;
@property (nonatomic, assign) UIEdgeInsets imageInsect;
@property (nonatomic ,copy) void (^clickedBlock) (FFNavigationItemView *itemView);

@end
