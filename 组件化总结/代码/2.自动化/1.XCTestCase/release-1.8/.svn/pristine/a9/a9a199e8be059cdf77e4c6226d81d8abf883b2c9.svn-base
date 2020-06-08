//
//  CYTCarSourceAddImageFooter.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/24.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSourceAddImageFooter.h"

@interface CYTCarSourceAddImageFooter()

/** 完成按钮 */
@property(strong, nonatomic) UIButton *completionBtn;

@end

@implementation CYTCarSourceAddImageFooter

- (UIButton *)completionBtn{
    if (!_completionBtn) {
        _completionBtn = [UIButton buttonWithTitle:@"完 成" enabled:NO];
        [[_completionBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            NSString *btnTitle = _completionBtn.currentTitle;
            if ([btnTitle isEqualToString:@"完 成"]) {
                !self.completionAction?:self.completionAction();
            }else{
                !self.deleteAction?:self.deleteAction();
            }
        }];
    }
    return _completionBtn;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self carSourceAddImageBasicConfig];
        [self initCarSourceAddImageComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)carSourceAddImageBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}
/**
 *  初始化子控件
 */
- (void)initCarSourceAddImageComponents{
    [self addSubview:self.completionBtn];
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    [self.completionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(CYTAutoLayoutV(79.f));
    }];
}

- (void)setBtnTitle:(NSString *)btnTitle{
    _btnTitle = btnTitle;
    [_completionBtn setTitle:btnTitle forState:UIControlStateNormal];

}

- (void)setWaitDeleteImageArray:(NSMutableArray *)waitDeleteImageArray{
    _waitDeleteImageArray = waitDeleteImageArray;
    NSInteger selectedNum = waitDeleteImageArray.count;
    if (selectedNum == 0) {
        _completionBtn.enabled = NO;
    }else{
        _completionBtn.enabled = YES;
    }
}

- (void)setSelectedImageArray:(NSMutableArray *)selectedImageArray{
    _selectedImageArray = selectedImageArray;
    NSInteger selectedNum = selectedImageArray.count;
    if (selectedNum == 0) {
        _completionBtn.enabled = NO;
    }else{
        _completionBtn.enabled = YES;
    }
}

@end
