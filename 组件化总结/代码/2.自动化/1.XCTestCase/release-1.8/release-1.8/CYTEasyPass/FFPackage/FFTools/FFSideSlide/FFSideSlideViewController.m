//
//  FFSideSlideViewController.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/31.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFSideSlideViewController.h"

@interface FFSideSlideViewController ()

@end

@implementation FFSideSlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)showSideView {
    [self.sideView showHalfView];
    [self.sideView.contentController showView];
}

- (void)hideSideView {
    [self.sideView hideHalfView];
    [self.sideView.contentController dismissView];
}

#pragma mark- get
- (FFSideSlideContentView *)sideView {
    if (!_sideView) {
        FFExtendViewModel *vm = [FFExtendViewModel new];
        vm.ffObj = self.view;
        _sideView = [[FFSideSlideContentView alloc] initWithViewModel:vm];
        _sideView.contentController = [FFSideSlideContentBasicController new];
    }
    return _sideView;
}

@end
