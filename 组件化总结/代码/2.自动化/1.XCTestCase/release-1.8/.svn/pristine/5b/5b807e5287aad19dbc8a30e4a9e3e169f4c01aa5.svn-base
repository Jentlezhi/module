//
//  CYTCarSearchView.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/21.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"

@interface CYTCarSearchView : FFExtendView<UITextFieldDelegate>
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UITextField *searchTextFiled;
///设置placeholder
@property (nonatomic, copy) NSString *searchPlaceholder;
///清空
@property (nonatomic, strong) UIButton *clearButton;
@property (nonatomic, copy) void (^backBlock) (void);
///实时返回
@property (nonatomic, copy) void (^associationBlock) (NSString *string,UITextField *textField);
///开始编辑
@property (nonatomic, copy) void (^beginBlock) (void);
///点击搜索
@property (nonatomic, copy) void (^searchItemBlock) (NSString *string);

@end
