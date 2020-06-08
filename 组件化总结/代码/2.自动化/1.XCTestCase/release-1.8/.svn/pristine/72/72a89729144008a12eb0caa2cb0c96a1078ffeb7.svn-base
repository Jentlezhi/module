//
//  CYTLogisticsNeedDetailBottomView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticsNeedDetailBottomView.h"

@interface CYTLogisticsNeedDetailBottomView ()
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *line;
///1 待下单  2完成    3过期
@property (nonatomic, assign) CYTLogisticsNeedStatus status;

@end

@implementation CYTLogisticsNeedDetailBottomView

- (void)ff_initWithViewModel:(id)viewModel {
    self.status = [viewModel integerValue];
}

- (void)ff_addSubViewAndConstraints {
    
    self.backgroundColor = [UIColor whiteColor];
    if (self.status == CYTLogisticsNeedStatusUnOrder || self.status == CYTLogisticsNeedStatusFinished) {
        [self addSubview:self.serviceView];
        [self addSubview:self.rightButton];
        [self addSubview:self.line];
        [self addSubview:self.topLine];
        
        [self.serviceView makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.equalTo(self);
            make.width.equalTo(CYTAutoLayoutH(200));
        }];
        [self.rightButton makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self);
            make.left.equalTo(self.serviceView.right);
        }];
        [self.line makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self.serviceView.right);
            make.width.equalTo(CYTLineH);
        }];
        [self.topLine makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.equalTo(CYTLineH);
        }];
        
    }else {
        //取消、过期，不显示任何东西
    }
}

#pragma mark- get
- (FFOtherView_1 *)serviceView {
    if (!_serviceView) {
        _serviceView = [FFOtherView_1 new];
        _serviceView.titleLabel.text = @"客服";
        _serviceView.titleLabel.font = CYTFontWithPixel(20);
        _serviceView.midOffset = 0;
        _serviceView.botOffset = -CYTAutoLayoutV(4);
        _serviceView.imageView.image = [UIImage imageNamed:@"ic_kefu_hl_new"];
        
        @weakify(self);
        [_serviceView setClickedBlock:^(FFOtherView_1 *tmp) {
            @strongify(self);
            if (self.serviceBlock) {
                self.serviceBlock();
            }
        }];
    }
    return _serviceView;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = kFFColor_line;
    }
    return _line;
}

- (UIView *)topLine {
    if (!_topLine) {
        _topLine = [UIView new];
        _topLine.backgroundColor = kFFColor_line;
    }
    return _topLine;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setTitleColor:kFFColor_title_L1 forState:UIControlStateNormal];
        _rightButton.titleLabel.font = CYTFontWithPixel(30);
        
        if (self.status == CYTLogisticsNeedStatusUnOrder) {
            [_rightButton setTitle:@"取消物流需求" forState:UIControlStateNormal];
            _rightButton.backgroundColor = [UIColor whiteColor];
            [_rightButton setTitleColor:kFFColor_title_L1 forState:UIControlStateNormal];
            
        }else if (self.status == CYTLogisticsNeedStatusFinished) {
            [_rightButton setTitle:@"查看物流订单" forState:UIControlStateNormal];
            _rightButton.backgroundColor = kFFColor_green;
            [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }
        
        @weakify(self);
        [[_rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.rightActionBlock) {
                self.rightActionBlock();
            }
        }];
    }
    return _rightButton;
}

@end
