//
//  CYTColorInputViewController.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTColorInputViewController.h"
#import "CYTGetColorConst.h"
#import "CYTCarColorSelectTableController.h"

#define kMaxLenth   (20)
#define kPlaceholder    (@"请输入您要添加的颜色（1~20个字）")

@interface CYTColorInputViewController ()
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *line;

@end

@implementation CYTColorInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
}

- (void)loadUI {
    [self createNavBarWithTitle:@"自定义颜色" andShowBackButton:YES showRightButtonWithTitle:@"完成"];
    self.view.backgroundColor = kFFColor_bg_nor;
    
    self.rightItemButton.titleLabel.font = CYTFontWithPixel(28);
    [self.rightItemButton setTitleColor:kFFColor_title_L2 forState:UIControlStateNormal];
    [self.view addSubview:self.textField];
    [self.view addSubview:self.line];
    
    [self.textField makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(CYTViewOriginY);
        make.height.equalTo(40);
    }];
    [self.line makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.textField.bottom);
        make.height.equalTo(CYTLineH);
    }];
    
}

- (void)rightButtonClick:(UIButton *)rightButton {
    //验证字符,1中文，2
    if (self.textField.text.length == 0) {
        [CYTToast messageToastWithMessage:@"颜色不能为空"];
    }
    
    //不需要判断了
//    if (![CYTCommonTool isChinese:self.textField.text]) {
//        [CYTToast messageToastWithMessage:@"颜色必须是中文"];
//        return;
//    }

    //保存颜色
    if (self.inColor) {
        self.viewModel.inColorSel = self.textField.text;
        //完成
        [[NSNotificationCenter defaultCenter] postNotificationName:kGetColorFinished object:nil];
    }else {
        self.viewModel.exColorSel = self.textField.text;
        //进入内饰页面
        CYTCarColorSelectTableController *inColorCtr = [CYTCarColorSelectTableController new];
        inColorCtr.viewModel = self.viewModel;
        inColorCtr.inColor = YES;
        [self.navigationController pushViewController:inColorCtr animated:YES];
    }
}

#pragma mark- get
- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField new];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.font = CYTFontWithPixel(26);
        
        UIView *leftView = [UIView new];
        leftView.size = CGSizeMake(CYTAutoLayoutH(30), 10);
        _textField.leftView = leftView;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.placeholder = kPlaceholder;
        @weakify(self);
        [[_textField rac_textSignal] subscribeNext:^(NSString *string) {
            @strongify(self);
            
            if (string.length>kMaxLenth) {
                self.textField.text = [string substringToIndex:kMaxLenth];
            }
            
        }];
    }
    return _textField;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = kFFColor_line;
    }
    return _line;
}

@end
