//
//  CYTShareBottomView.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/4/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"

typedef NS_ENUM(NSInteger,ShareViewType) {
    ShareViewType_normal,
    ShareViewType_carInfo,
};

@interface CYTShareBottomView : FFExtendView
@property (nonatomic, assign) ShareViewType type;

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *itemArray;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *cancelButton;

///-1 取消，0好友，1朋友圈，2链接
@property (nonatomic, copy) void (^clickedBlock) (NSInteger tag);

@end
