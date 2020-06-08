//
//  FFBasicView.m
//  FFObjC
//
//  Created by xujunquan on 16/10/18.
//  Copyright © 2016年 org_ian. All rights reserved.
//

#import "FFBasicView.h"

@interface FFBasicView()
@property (nonatomic, strong) id priViewModel;

@end

@implementation FFBasicView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ff_keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ff_keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        [self ff_initWithViewModel:_priViewModel];
        [self ff_bindViewModel];
        [self ff_addSubViewAndConstraints];
    }
    return self;
}

- (instancetype)initWithViewModel:(FFExtendViewModel *)viewModel {
    _priViewModel = viewModel;
    return [self initWithFrame:CGRectZero];
}

#pragma mark- control

- (void)ff_initWithViewModel:(id)viewModel {
    
}

- (void)ff_bindViewModel {
    
}

- (void)ff_addSubViewAndConstraints {

}

- (void)ff_keyboardWillShow:(NSNotification *)notification {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        //取出键盘最终的frame
//        CGRect rect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//        //取出键盘弹出需要花费的时间
//        double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    });
}

- (void)ff_keyboardWillHide:(NSNotification *)notification {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        //取出键盘最终的frame
//        CGRect rect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//        //取出键盘弹出需要花费的时间
//        double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    });
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
