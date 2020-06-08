//
//  CYTUpdateView.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/20.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTUpdateView.h"

@implementation CYTUpdateView
@synthesize viewModel = _viewModel;

- (void)ff_bindViewModel {
    [super ff_bindViewModel];
    @weakify(self);
    [self.viewModel setBgClickedBlock:^{
        @strongify(self);
        [self normalUpdate];
    }];
}

- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self addSubview:self.imageView];
    [self addSubview:self.cancelButton];
    
    [self.imageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(CYTAutoLayoutV(217));
        make.width.equalTo(CYTAutoLayoutH(620));
        make.height.equalTo(CYTAutoLayoutH(820));
    }];
    [self.cancelButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.imageView.bottom).offset(CYTAutoLayoutV(80));
    }];
}

- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
}

- (void)setViewModel:(CYTUpdateManager *)viewModel {
    _viewModel = viewModel;
}

- (CYTUpdateManager *)viewModel {
    return _viewModel;
}

#pragma mark- method
- (void)normalUpdate {
    if (self.viewModel.updateModel.forceUpdate) {
        return ;
    }
    
    if (self.updateBlock) {
        self.updateBlock(0);
    }
    
    [self ff_hideSupernatantView];
}

- (void)forceUpdate {
    if (self.updateBlock) {
        self.updateBlock(1);
    }
}

- (void)ff_showSupernatantView {
    if (self.viewModel.updateModel.forceUpdate || self.viewModel.updateModel.needUpdate) {
        //设置图片
        NSURL *url = [NSURL URLWithString:self.viewModel.updateModel.tipImage];
        [self.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"update_imageDefault"]];
        self.cancelButton.hidden = (self.viewModel.updateModel.forceUpdate);
        [super ff_showSupernatantView];
    }
}

#pragma mark- get
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView ff_imageViewWithImageName:nil];
        
        _imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [UITapGestureRecognizer new];
        @weakify(self);
        [[tapGes rac_gestureSignal] subscribeNext:^(id x) {
            @strongify(self);
            [self forceUpdate];
        }];
        [_imageView addGestureRecognizer:tapGes];
    }
    return _imageView;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setImage:[UIImage imageNamed:@"update_cancel"] forState:UIControlStateNormal];
        [_cancelButton setImage:[UIImage imageNamed:@"update_cancel"] forState:UIControlStateHighlighted];
        @weakify(self);
        [[_cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self normalUpdate];
        }];
    }
    return _cancelButton;
}

@end
