
//  CYTEasyPass
//
//  Created by xujunquan on 17/2/28.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

/*
 仅在车源，寻车列表、和搜索页面使用
 */
#import <UIKit/UIKit.h>

@interface CYTCustomNavBar : FFExtendView<UITextFieldDelegate>
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UILabel *rightTitleLabel;

@property (nonatomic, strong) UITextField *searchTextFiled;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, copy) void (^publishBlock) (void);
@property (nonatomic, copy) void (^searchBlock) (void);

@end
