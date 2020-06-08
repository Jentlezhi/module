//
//  FFSideSlideContentView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/31.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFSideSlideContentView.h"

@interface FFSideSlideContentView()<UIGestureRecognizerDelegate>
@property (nonatomic, weak) UIView *ffSuperView;
@property (nonatomic, assign) CGPoint beganPoint;

@end

@implementation FFSideSlideContentView

- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
    
    self.showing = NO;
    self.topOffset = CYTViewOriginY;
    FFExtendViewModel *vm = viewModel;
    self.ffSuperView = vm.ffObj;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    self.viewWidth = kFF_SCREEN_WIDTH*2/3.0;
    
    UITapGestureRecognizer *tapGes = [UITapGestureRecognizer new];
    @weakify(self);
    [[tapGes rac_gestureSignal] subscribeNext:^(id x) {
        @strongify(self);
        [self hideHalfView];
        if (self.willDismissBlock) {
            self.willDismissBlock();
        }
    }];
    tapGes.delegate = self;
    [self addGestureRecognizer:tapGes];
    
    UIPanGestureRecognizer *panGes = [UIPanGestureRecognizer new];
    [[panGes rac_gestureSignal] subscribeNext:^(id x) {
        if (!x) {
            return ;
        }
        
        //有bug，先关闭手势关闭操作
//        [self handlePanGesture:x];
        
    }];
    [self addGestureRecognizer:panGes];
    
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGes {
    CGPoint offsetPoint = [panGes translationInView:self];
    
    if (panGes.state == UIGestureRecognizerStateBegan) {
        self.beganPoint = [panGes locationInView:self];
    }else {
        float ox = kFF_SCREEN_WIDTH-self.viewWidth;
        if (self.beganPoint.x<ox) {
            return;
        }
        float offsetx = ox+offsetPoint.x;
        if (offsetx>kFF_SCREEN_WIDTH) {
            offsetx = kFF_SCREEN_WIDTH;
        }else if (offsetx<ox) {
            offsetx = ox;
        }
        
        if (panGes.state == UIGestureRecognizerStateEnded) {
            if (offsetx>(kFF_SCREEN_WIDTH-self.viewWidth/2.0)) {
                [self hideHalfViewWithTimeinterval:kFFAnimationDuration];
            }else {
                [self.contentController.view updateConstraints:^(MASConstraintMaker *make) {
                    float offset = kFF_SCREEN_WIDTH-self.viewWidth;
                    make.left.equalTo(offset);
                }];
                [UIView animateWithDuration:kFFAnimationDuration/2.0 animations:^{
                    [self layoutIfNeeded];
                }];
            }
            
            //清空
            self.beganPoint = CGPointZero;
            
        }else if (panGes.state == UIGestureRecognizerStateChanged) {
            //移动中
            [self.contentController.view updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(offsetx);
            }];
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[FFSideSlideContentView class]]) {
        return YES;//返回yes表示响应手势事件，
    }
    return NO;//不响应
}

#pragma mark- 动画
- (void)showHalfView {
    [self.ffSuperView addSubview:self];
    [self makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.ffSuperView);
        make.top.equalTo(self.topOffset);
    }];
    
    [self addSubview:self.contentController.view];
    [self.contentController.view makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(0);
        make.width.equalTo(self.viewWidth);
        make.left.equalTo(kFF_SCREEN_WIDTH);
    }];
    [self layoutIfNeeded];
    
    [self.contentController.view updateConstraints:^(MASConstraintMaker *make) {
        float offset = kFF_SCREEN_WIDTH-self.viewWidth;
        make.left.equalTo(offset);
    }];
    [UIView animateWithDuration:kFFAnimationDuration animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self layoutIfNeeded];
    }completion:^(BOOL finished) {
        self.showing = YES;
    }];
}

- (void)hideHalfView {
    [self hideHalfViewWithTimeinterval:kFFAnimationDuration];
}

- (void)hideHalfViewWithTimeinterval:(NSTimeInterval)interval {
    [self layoutIfNeeded];
    
    [self.contentController.view updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kFF_SCREEN_WIDTH);
    }];
    
    [UIView animateWithDuration:interval animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        [self layoutIfNeeded];
    }completion:^(BOOL finished) {
        self.showing = NO;
        [self removeFromSuperview];
    }];
}

@end
