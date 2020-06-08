//
//  CYTSendCarSupernatant.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/15.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTSendCarSupernatant.h"

@implementation CYTSendCarSupernatant

- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self addSubview:self.contentView];
    [self.contentView makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self);
        make.bottom.equalTo(0);
    }];
}

- (void)ff_showSupernatantView {
    //从本地读取状态
    BOOL hide = [[NSUserDefaults standardUserDefaults] boolForKey:@"hideSendSupernatant"];
    if (!hide) {
        [super ff_showSupernatantView];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hideSendSupernatant"];
    }
}

///版本更新时会再次有效
- (void)reShow {
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"hideSendSupernatant"];
}

#pragma mark- get
- (CYTSendCarSupernatantContent *)contentView {
    if (!_contentView) {
        _contentView = [CYTSendCarSupernatantContent new];
        _contentView.userInteractionEnabled = NO;
    }
    return _contentView;
}

@end
