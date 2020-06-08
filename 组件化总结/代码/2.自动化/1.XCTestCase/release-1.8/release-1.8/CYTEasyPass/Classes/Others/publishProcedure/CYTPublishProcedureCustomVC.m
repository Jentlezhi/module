//
//  CYTPublishProcedureCustomVC.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPublishProcedureCustomVC.h"

#define kMaxlenth   (20)
#define kPlaceholder    (@"请输入自定义手续时间（1~20个字）")


@interface CYTPublishProcedureCustomVC ()
@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) UITextField *textFiled;
@property (nonatomic, strong) UIView *line;

@end

@implementation CYTPublishProcedureCustomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.textFiled becomeFirstResponder];
    self.textFiled.text = self.content;
}

- (void)loadUI {
    [self createNavBarWithBackButtonAndTitle:@"自定义手续时间"];
    self.view.backgroundColor = kFFColor_bg_nor;
    
    [self.view addSubview:self.saveButton];
    [self.view addSubview:self.textFiled];
    [self.view addSubview:self.line];
    
    [self.saveButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTStatusBarHeight);
        make.height.equalTo(44);
        make.right.equalTo(-CYTNavBarItemMarigin);
    }];
    [self.textFiled makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(CYTViewOriginY);
        make.height.equalTo(CYTAutoLayoutV(90));
    }];
    [self.line makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.textFiled.bottom);
        make.height.equalTo(CYTLineH);
    }];
}

- (void)rightButtonClickMethod {
    if (self.procedureBlock) {
        self.procedureBlock(self.textFiled.text);
    }
    
    NSInteger index= [[self.navigationController viewControllers]indexOfObject:self];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-2]animated:YES];
}

- (void)setRightButtonState:(NSString *)string {
    BOOL valid = (string.length>0);
    self.saveButton.userInteractionEnabled = valid;
    [self.saveButton setTitleColor:(valid)?kFFColor_title_L1:kFFColor_title_gray forState:UIControlStateNormal];
}

#pragma mark- get
- (UITextField *)textFiled {
    if (!_textFiled) {
        _textFiled = [UITextField new];
        _textFiled.backgroundColor = [UIColor whiteColor];
        _textFiled.font = CYTFontWithPixel(26);
        UIView *leftView = [UIView new];
        leftView.size = CGSizeMake(CYTAutoLayoutH(30), 10);
        _textFiled.leftView = leftView;
        _textFiled.leftViewMode = UITextFieldViewModeAlways;
        _textFiled.placeholder = kPlaceholder;
        _textFiled.placeholderColor = kFFColor_title_gray;
        _textFiled.textColor = kFFColor_title_L2;
        
        @weakify(self);
        [[_textFiled rac_textSignal] subscribeNext:^(NSString *string) {
            @strongify(self);
            
            if (string.length > kMaxlenth) {
                self.textFiled.text = [string substringToIndex:kMaxlenth];
            }else {
                [self setRightButtonState:string];
            }
        }];
    }
    return _textFiled;
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

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = kFFColor_line;
    }
    return _line;
}

@end
