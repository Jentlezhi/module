//
//  CYTFeedBackViewController.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/11.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTFeedBackViewController.h"

@interface CYTFeedBackViewController ()<UITextViewDelegate>
@property (nonatomic ,strong) UITextView *textView;
@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation CYTFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithBackButtonAndTitle:@"意见反馈"];
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f6);
    [self loadUI];
    [self bindViewModel];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UITextViewTextDidChangeNotification object:nil] subscribeNext:^(id x) {
        self.submitButton.enabled = (self.textView.text.length>0);
        self.submitButton.backgroundColor = (self.textView.text.length)>0?kFFColor_green:CYTBtnDisableColor;
    }];
    
}

- (void)loadUI {
    [self.view addSubview:self.textView];
    [self.view addSubview:self.submitButton];
    [self.textView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.top.equalTo(CYTViewOriginY+CYTMarginV);
        make.height.equalTo(CYTAutoLayoutV(360));
    }];
    [self.submitButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.textView);
        make.top.equalTo(self.textView.bottom).offset(CYTAutoLayoutV(30));
        make.height.equalTo(CYTAutoLayoutV(90));
    }];
}

- (void)bindViewModel {
    @weakify(self);
    [self.viewModel.hudSubject subscribeNext:^(id x) {
        if ([x integerValue]==0) {
            [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
        }else {
            [CYTLoadingView hideLoadingView];
        }
    }];
    [self.viewModel.requestCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
        @strongify(self);
        [CYTToast messageToastWithMessage:responseModel.resultMessage];
        if (responseModel.resultEffective) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

#pragma mark- get
- (CYTFeedBackVM *)viewModel {
    if (!_viewModel ) {
        _viewModel  = [CYTFeedBackVM new];
    }
    return _viewModel;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [UITextView new];
        _textView.placeholder = @"请输入您的宝贵意见和反馈(最多输入200字)";
        _textView.font = CYTFontWithPixel(32);
        _textView.textColor = kFFColor_title_L3;
        _textView.placeholderColor = kFFColor_title_gray;
        
    }
    return _textView;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithFontPxSize:34 textColor:[UIColor whiteColor] text:@"提 交"];
        _submitButton.backgroundColor = kFFColor_green;
        [_submitButton radius:2 borderWidth:1 borderColor:[UIColor clearColor]];
        _submitButton.enabled = NO;
        _submitButton.backgroundColor = CYTBtnDisableColor;
        @weakify(self);
        [[_submitButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            self.viewModel.content = self.textView.text;
            [self.viewModel.requestCommand execute:nil];
        }];
    }
    return _submitButton;
}

@end
