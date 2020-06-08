//
//  CYTBrandSelect_customCars.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/4.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBrandSelect_customCars.h"

@interface CYTBrandSelect_customCars ()<UITextFieldDelegate>
///flagLabel
@property (nonatomic, strong) UILabel *flagLabel;
///textfiled
@property (nonatomic, strong) UITextField *textField;
///button
@property (nonatomic, strong) UIButton *saveButton;

@end

@implementation CYTBrandSelect_customCars

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *title = [NSString stringWithFormat:@"%@ 自定义车型",self.titleName];
    [self createNavBarWithBackButtonAndTitle:title];
    [self loadUI];
}

- (void)loadUI {
    [self.view addSubview:self.flagLabel];
    [self.view addSubview:self.textField];
    [self.view addSubview:self.saveButton];
    
    [self.flagLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTItemMarginH);
        make.right.equalTo(-CYTItemMarginH);
        make.top.equalTo(CYTViewOriginY+CYTAutoLayoutV(40));
        make.height.equalTo(CYTAutoLayoutV(40));
    }];
    [self.textField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTItemMarginH);
        make.right.equalTo(-CYTItemMarginH);
        make.top.equalTo(self.flagLabel.bottom).offset(CYTAutoLayoutV(40));
        make.height.equalTo(CYTAutoLayoutV(40));
    }];
    [self.saveButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTItemMarginH);
        make.right.equalTo(-CYTItemMarginH);
        make.top.equalTo(self.textField.bottom).offset(CYTAutoLayoutV(130));
        make.height.equalTo(CYTAutoLayoutV(80));
    }];
}

- (void)textDidChange {
    NSString *text = self.textField.text;
    if (text.length>25) {
        text = [text substringToIndex:25];
        self.textField.text = text;
    }
    
    self.saveButton.enabled = (text.length>0);
}

#pragma mark- get
- (UILabel *)flagLabel {
    if (!_flagLabel) {
        _flagLabel = [UILabel labelWithFontPxSize:30 textColor:kFFColor_title_L1];
        _flagLabel.text = @"自定义车型名称：";
        UIView *line = [UIView new];
        line.backgroundColor = kFFColor_line;
        [_flagLabel addSubview:line];
        [line makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(0.5);
        }];
    }
    return _flagLabel;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField new];
        _textField.delegate = self;
        _textField.font = CYTFontWithPixel(30);
        _textField.textColor = kFFColor_title_L3;
        
        [_textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
        _textField.placeholder = @"请输入年款和车款名称，不超过25个字";
        _textField.placeholderColor = kFFColor_title_gray;
        UIView *line = [UIView new];
        line.backgroundColor = kFFColor_line;
        [_textField addSubview:line];
        [line makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(0.5);
        }];
    }
    return _textField;
}

- (UIButton *)saveButton {
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithFontPxSize:38 textColor:[UIColor whiteColor] text:@"保存"];
        _saveButton.backgroundColor = kFFColor_green;
        [_saveButton radius:2 borderWidth:0.5 borderColor:[UIColor clearColor]];
        @weakify(self);
        _saveButton.enabled = NO;
        [[_saveButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            //暂时不校验，没有用
//            if ([CYTTools haveInvalidCharacterWithString:self.textField.text]) {
//                [CYTToast errorToastWithMessage:@"不能有特殊字符"];
//            }else {
//                //保存退出
//                if (self.stringBlock) {
//                    self.stringBlock(self.textField.text);
//                }
//            }
            
            //保存退出
            if (self.stringBlock) {
                self.stringBlock(self.textField.text);
            }
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
    }
    return _saveButton;
}

@end
