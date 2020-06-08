//
//  FFCellView_Style_input.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/11.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"

@interface FFCellView_Style_input : FFExtendView<UITextFieldDelegate>
@property (nonatomic, strong) UIView *borderView;
@property (nonatomic, strong) UILabel *flagLabel;
@property (nonatomic, strong) UITextField *textFiled;
@property (nonatomic, strong) UILabel *assistantLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, copy) void (^textBlock) (NSString *text);
///显示或者隐藏cell
@property (nonatomic, assign) BOOL showNone;

@end
