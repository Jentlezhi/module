//
//  CYTTextView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/24.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTTextView.h"

@interface CYTTextView()

/** 占位符 */
@property(weak, nonatomic) UILabel *placeholderLabel;

@end

@implementation CYTTextView

+ (instancetype)textViewWithFrame:(CGRect)rect{
    
    return [[self alloc] initWithFrame:rect];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self basicConfig];
        [self initCellComponents];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

/**
 *  基本配置
 */
- (void)basicConfig{
    //设置默认字体
    self.font = [UIFont systemFontOfSize:16];
    self.textAlignment = NSTextAlignmentRight;
    //监听文本的输入
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
}

/**
 *  文本开始输入
 */
- (void)textDidChange{
    _placeholderLabel.hidden = self.text.length != 0;
}

- (void)setText:(NSString *)text{
    [super setText:text];
    [self textDidChange];
}

/**
 *  初始化子控件
 */
- (void)initCellComponents{
    //占位符
    UILabel *placeholderLabel = [UILabel labelWithTextColor:[UIColor lightGrayColor] textAlignment:NSTextAlignmentRight font:[UIFont systemFontOfSize:16] setContentPriority:YES];
    placeholderLabel.numberOfLines = 0;
    [self addSubview:placeholderLabel];
    _placeholderLabel = placeholderLabel;
}
/**
 *  布局子控件
 */
- (void)updateConstraints{
    [super updateConstraints];
    [_placeholderLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(8);
        make.left.equalTo(self).offset(5);
        make.width.equalTo(CYTAutoLayoutH(488.f));
        make.right.bottom.equalTo(self);
    }];
}

/**
 *  placeholder的setter方法
 */
- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = [placeholder copy];
    _placeholderLabel.text = placeholder;
    [self setNeedsDisplay];
    
}
/**
 *  placeholderColor的setter方法
 */
- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    _placeholderLabel.textColor = placeholderColor;
}

/**
 *  font的setter方法
 */
- (void)setFont:(UIFont *)font{
    [super setFont:font];
    _placeholderLabel.font = font;
    [self setNeedsDisplay];
}
/**
 *  销毁通知
 */
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSString *)detailAddress{
    return self.text;
}

@end
