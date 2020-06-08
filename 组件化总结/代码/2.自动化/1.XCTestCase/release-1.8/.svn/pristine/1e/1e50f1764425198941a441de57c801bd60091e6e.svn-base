//
//  FFBasicView.h
//  FFObjC
//
//  Created by xujunquan on 16/10/18.
//  Copyright © 2016年 org_ian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFExtendViewModel.h"

@interface FFBasicView : UIView
///引用计数
@property (nonatomic, assign) NSInteger refcount;

//流程控制
- (void)ff_initWithViewModel:(id)viewModel;
- (void)ff_bindViewModel;
- (void)ff_addSubViewAndConstraints;

//使用viewModel初始化控制器(对rac的支持)
- (instancetype)initWithViewModel:(FFExtendViewModel *)viewModel;

///键盘监听
- (void)ff_keyboardWillShow:(NSNotification *)notification;
- (void)ff_keyboardWillHide:(NSNotification *)notification;

@end
