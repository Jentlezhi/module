//
//  CYTCommonPwdInputView.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/24.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"

@interface CYTCommonPwdInputViewItem : FFExtendView
@property (nonatomic, strong) UIView *pointView;

@end

@interface CYTCommonPwdInputView : FFExtendView<UITextFieldDelegate>
@property (nonatomic, strong) NSMutableArray *itemArray;
///点击获取第一响应者
@property (nonatomic, copy) ffDefaultBlock clickBlock;
@property (nonatomic, strong) UITextField *textField;
- (void)clearAll;

@property (nonatomic, copy) void (^finishedBlock) (NSString *pwd);

@end
