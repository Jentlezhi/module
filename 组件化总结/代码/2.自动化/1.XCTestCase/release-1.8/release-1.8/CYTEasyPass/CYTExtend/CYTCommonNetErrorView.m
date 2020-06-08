//
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/10.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCommonNetErrorView.h"
#import "FFBasicMacro.h"
#import "UIView+FFCommon.h"

@interface CYTCommonNetErrorView ()

@end

@implementation CYTCommonNetErrorView

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.imageView];
    [self addSubview:self.contentLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.actionButton];
    
    //设置样式
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = kFFColor_title_gray;
    
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    self.contentLabel.textColor = kFFColor_title_gray;
    
    self.actionButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.actionButton setTitle:@"点击加载" forState:UIControlStateNormal];
    [self.actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.actionButton radius:4 borderWidth:0.5 borderColor:[UIColor clearColor]];
    [self.actionButton setBackgroundColor:kFFColor_green];
    
    //设置图片压缩优先级低，则图片被压缩显示，不会造成label无法显示的状况,重要方法
//    [self.imageView setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(@35);
        make.left.greaterThanOrEqualTo(0);
        make.right.lessThanOrEqualTo(0);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.imageView.mas_bottom).offset(kFFAutolayoutV(40));
        make.left.greaterThanOrEqualTo(0);
        make.right.lessThanOrEqualTo(0);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(3);
        make.left.greaterThanOrEqualTo(0);
        make.right.lessThanOrEqualTo(0);
    }];
    [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(kFFAutolayoutV(80));
        make.size.mas_equalTo(CGSizeMake(kFFAutolayoutH(180), kFFAutolayoutV(64)));
        make.bottom.equalTo(self.mas_bottom);
    }];
}

@end
