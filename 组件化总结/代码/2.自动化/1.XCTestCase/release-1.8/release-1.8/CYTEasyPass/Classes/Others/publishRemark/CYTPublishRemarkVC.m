//
//  CYTPublishRemarkVC.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPublishRemarkVC.h"

#define kMaxlenth   (200)

@interface CYTPublishRemarkVC ()
@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIView *bgView;

@end

@implementation CYTPublishRemarkVC

- (instancetype)init {
    if (self = [super init]) {
        _configPlaceholder = @"请输入相关配置（1~200个字）";
        _avaliableAreaPlaceholder = @"请输入可售区域（1~200个字）";
        _remarkPlaceholder = @"请填写相关备注信息（1~200个字）";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.textView.placeholder = placeholder;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
    self.textView.text = self.content;
}

- (void)loadUI {
    [self createNavBarWithBackButtonAndTitle:self.titleString];
    self.view.backgroundColor = kFFColor_bg_nor;
    
    
    [self.view addSubview:self.saveButton];
    [self.view addSubview:self.bgView];
    
    [self.saveButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTStatusBarHeight);
        make.height.equalTo(44);
        make.right.equalTo(-CYTNavBarItemMarigin);
    }];
    [self.bgView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(CYTViewOriginY);
        make.height.equalTo(CYTAutoLayoutV(360));
    }];
    
    [self.bgView addSubview:self.textView];
    [self.textView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bgView).insets(UIEdgeInsetsMake(CYTAutoLayoutV(26/2.0), CYTAutoLayoutH(30/2.0), CYTAutoLayoutV(26/2.0), CYTAutoLayoutH(30/2.0)));
    }];
}

- (void)rightButtonClickMethod {
    //返回数据
    if (self.configBlock) {
        self.configBlock(self.textView.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setRightButtonState:(NSString *)string {
    BOOL valid = (string.length>0);
    self.saveButton.userInteractionEnabled = valid;
    [self.saveButton setTitleColor:(valid)?kFFColor_title_L1:kFFColor_title_gray forState:UIControlStateNormal];
}

#pragma mark- get
- (UITextView *)textView {
    if (!_textView) {
        _textView = [UITextView new];
        _textView.font = CYTFontWithPixel(28);
        _textView.textColor = kFFColor_title_L2;
        _textView.placeholderColor = kFFColor_title_gray;
        
        @weakify(self);
        [[_textView rac_textSignal] subscribeNext:^(NSString *string) {
            @strongify(self);
            
            if (string.length > kMaxlenth) {
                self.textView.text = [string substringToIndex:kMaxlenth];
            }else {
//                [self setRightButtonState:string];
            }
        }];
    }
    return _textView;
}

- (UIButton *)saveButton {
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithFontPxSize:28 textColor:kFFColor_title_L2 text:@"完成"];
        @weakify(self);
        [[_saveButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self rightButtonClickMethod];
        }];
    }
    return _saveButton;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

@end
