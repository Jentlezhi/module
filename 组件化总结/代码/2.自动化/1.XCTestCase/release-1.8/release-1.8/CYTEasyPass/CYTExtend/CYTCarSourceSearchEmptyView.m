//
//  CYTCarSourceSearchEmptyView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSourceSearchEmptyView.h"

@implementation CYTCarSourceSearchEmptyView

- (void)ff_addSubViewAndConstraints {
    self.dznLabel.text = @"- 抱歉，暂无符合条件的结果 -";
    self.dznImageView.image = [UIImage imageNamed:@"dzn_empty_2"];
    //设置图片压缩优先级低，则图片被压缩显示，不会造成label无法显示的状况,重要方法
    [self.dznImageView setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
    [self.dznButton radius:4 borderWidth:0.5 borderColor:kFFColor_green];
    
    self.dznButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.dznButton setTitle:@"发布寻车" forState:UIControlStateNormal];
    [self.dznButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.dznButton.backgroundColor = kFFColor_green;
    
    [self addSubview:self.dznImageView];
    [self addSubview:self.dznLabel];
    [self addSubview:self.dznButton];
    
    [self.dznImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.right.equalTo(self);
    }];
    
    [self.dznLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.dznImageView.mas_bottom).offset(10);
    }];
    
    [self.dznButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.dznLabel.bottom).offset(CYTAutoLayoutV(110));
        make.width.equalTo(CYTAutoLayoutH(320));
        make.height.equalTo(CYTAutoLayoutV(80));
        make.bottom.equalTo(self).offset(CYTAutoLayoutV(-100));
    }];
}

@end
