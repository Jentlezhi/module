//
//  CYTShareView2.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/14.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTShareView2.h"
#import "CYTShareItemView.h"

@interface CYTShareView2()
@property (nonatomic, strong) UIView *borderView;
@property (nonatomic, strong) CYTShareItemView *wxView;
@property (nonatomic, strong) CYTShareItemView *friendsView;
@property (nonatomic, strong) NSArray *itemDataArray;

@end

@implementation CYTShareView2

- (void)ff_initWithViewModel:(id)viewModel {
    NSDictionary *dic1 = @{@"image":@"share_friends",@"title":@"微信好友"};
    NSDictionary *dic2 = @{@"image":@"share_circle",@"title":@"朋友圈"};
    self.itemDataArray = @[dic1,dic2];
    self.userInteractionEnabled = YES;
}

- (void)ff_addSubViewAndConstraints {
    [self.borderView addSubview:self.wxView];
    [self.borderView addSubview:self.friendsView];
    [self.wxView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.borderView);
        make.height.equalTo(CYTAutoLayoutV(160));
        make.width.equalTo(CYTAutoLayoutH(120));
    }];
    [self.friendsView makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self.borderView);
        make.height.equalTo(CYTAutoLayoutV(160));
        make.left.equalTo(self.wxView.right).offset(CYTAutoLayoutH(140));
        make.width.equalTo(CYTAutoLayoutH(120));
    }];
    
    
    [self addSubview:self.lineImageView];
    [self addSubview:self.shareLabel];
    [self addSubview:self.borderView];
    
    [self.lineImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTAutoLayoutH(30));
        make.right.equalTo(CYTAutoLayoutH(-30));
        make.centerY.equalTo(self.shareLabel);
        make.height.equalTo(CYTAutoLayoutV(9));
    }];
    [self.shareLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.centerX.equalTo(self);
    }];
    [self.borderView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(CYTAutoLayoutV(74));
        make.bottom.equalTo(0);
    }];

}

#pragma mark- get
- (UIImageView *)lineImageView {
    if (!_lineImageView) {
        _lineImageView = [UIImageView new];
        _lineImageView.contentMode = UIViewContentModeScaleAspectFit;
        _lineImageView.image = [UIImage imageNamed:@"carSource_publish_success_line"];
    }
    return _lineImageView;
}

- (UILabel *)shareLabel {
    if (!_shareLabel) {
        _shareLabel = [UILabel labelWithFontPxSize:32 textColor:UIColorFromRGB(0x5a5a5a)];
        _shareLabel.text = @"分 享 至";
    }
    return _shareLabel;
}

- (CYTShareItemView *)wxView {
    if (!_wxView) {
        _wxView = [CYTShareItemView new];
        _wxView.userInteractionEnabled = YES;
        _wxView.tag = 0;
        NSDictionary *itemDic = self.itemDataArray[0];
        _wxView.imageView.image = [UIImage imageNamed:itemDic[@"image"]];
        _wxView.titleLabel.text = itemDic[@"title"];
        @weakify(self);
        [_wxView setClickedBlock:^(NSInteger index) {
            @strongify(self);
            if (self.clickBlock) {
                self.clickBlock(index);
            }
        }];
    }
    return _wxView;
}

- (CYTShareItemView *)friendsView {
    if (!_friendsView) {
        _friendsView = [CYTShareItemView new];
        _friendsView.tag = 1;
        NSDictionary *itemDic = self.itemDataArray[1];
        _friendsView.imageView.image = [UIImage imageNamed:itemDic[@"image"]];
        _friendsView.titleLabel.text = itemDic[@"title"];
        @weakify(self);
        [_friendsView setClickedBlock:^(NSInteger index) {
            @strongify(self);
            if (self.clickBlock) {
                self.clickBlock(index);
            }
        }];
    }
    return _friendsView;
}

- (UIView *)borderView {
    if (!_borderView) {
        _borderView = [UIView new];
    }
    return _borderView;
}

@end
