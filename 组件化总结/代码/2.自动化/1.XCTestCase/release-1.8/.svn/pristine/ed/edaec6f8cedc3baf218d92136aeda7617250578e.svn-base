//
//  CYTImagePickToolBarView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTImagePickToolBarView.h"

@interface CYTImagePickToolBarView()

/** 预览按钮 */
@property(weak, nonatomic) UIButton *previewBtn;
/** 完成按钮 */
@property(weak, nonatomic) UIButton *completeBtn;

@end

@implementation CYTImagePickToolBarView

#pragma mark - 初始化方法

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self imagePickToolBarBasicConfig];
        [self initImagePickToolBarComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)imagePickToolBarBasicConfig{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
}
/**
 *  初始化子控件
 */
- (void)initImagePickToolBarComponents{
    //预览按钮
    UIButton *previewBtn = [self itemBtnWithTitle:@"预览"];
    [[previewBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        !self.previewAction?:self.previewAction();
    }];
    [self addSubview:previewBtn];
    _previewBtn = previewBtn;
    //完成按钮
    UIButton *completeBtn = [self itemBtnWithTitle:@"完成"];
    [[completeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        !self.completeAction?:self.completeAction();
    }];
    [self addSubview:completeBtn];
    _completeBtn = completeBtn;
    
    //双击手势
    CYTWeakSelf
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] init];
    doubleTapGesture.numberOfTapsRequired = 2;
    [[doubleTapGesture rac_gestureSignal] subscribeNext:^(UITapGestureRecognizer *doubleTapGesture) {
        !weakSelf.doupleTapAction?:weakSelf.doupleTapAction();
    }];
    
    [self addGestureRecognizer:doubleTapGesture];
    
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    [_previewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(CYTMarginH);
    }];
    
    [_completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_previewBtn);
        make.right.equalTo(-CYTMarginH);
    }];
}

- (UIButton *)itemBtnWithTitle:(NSString *)title{
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [customBtn setTitle:title forState:UIControlStateNormal];
    [customBtn setTitleColor:CYTHexColor(@"#FFFFFF") forState:UIControlStateNormal];
    [customBtn setTitleColor:CYTHexColor(@"#999999") forState:UIControlStateDisabled];
    customBtn.titleLabel.font = CYTFontWithPixel(34.f);
    customBtn.enabled = NO;
    [customBtn sizeToFit];
    return customBtn;
}

#pragma mark - 设置设置

- (void)setPreviewBtnEnable:(BOOL)previewBtnEnable{
    _previewBtnEnable = previewBtnEnable;
    _previewBtn.enabled = previewBtnEnable;
}

- (void)setCompleteBtnEnable:(BOOL)completeBtnEnable{
    _completeBtnEnable = completeBtnEnable;
    _completeBtn.enabled = completeBtnEnable;
}

- (void)setSelectNum:(NSUInteger)selectNum{
    _selectNum = selectNum;
    NSString *title = nil;
    if (selectNum > 0) {
        title = [NSString stringWithFormat:@"完成(%ld/%ld)",selectNum,self.maxSelectNum];
    }else{
        title = @"完成";
    }
    [self.completeBtn setTitle:title forState:UIControlStateNormal];
}

@end
