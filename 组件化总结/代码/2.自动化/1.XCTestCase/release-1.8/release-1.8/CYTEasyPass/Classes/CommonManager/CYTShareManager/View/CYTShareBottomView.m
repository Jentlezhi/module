//
//  CYTShareBottomView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/4/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTShareBottomView.h"
#import "CYTShareItemView.h"

@implementation CYTShareBottomView

- (void)ff_initWithViewModel:(id)viewModel {
    NSDictionary *dic1 = @{@"image":@"share_friends",@"title":@"微信好友"};
    NSDictionary *dic2 = @{@"image":@"share_circle",@"title":@"朋友圈"};
    NSDictionary *dic3 = @{@"image":@"share_link",@"title":@"复制链接"};
    self.dataArray = @[dic1,dic2,dic3];
    self.itemArray = [NSMutableArray array];
    self.backgroundColor = [UIColor whiteColor];
}

- (void)ff_addSubViewAndConstraints {
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.cancelButton];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(CYTAutoLayoutV(40));
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(-CYTAutoLayoutV(60));
    }];
    
    [self addItems];
    
}

- (void)addItems {
    if (self.dataArray.count == 0) {
        return;
    }
    float width = SCREEN_WIDTH*1.0/self.dataArray.count;
    for (int i=0; i<self.dataArray.count; i++) {
        NSDictionary *itemDic  = self.dataArray[i];
        CYTShareItemView *item = [CYTShareItemView new];
        item.tag = i;
        @weakify(self);
        [item setClickedBlock:^(NSInteger tag) {
            @strongify(self);
            if (self.clickedBlock) {
                self.clickedBlock(tag);
            }
        }];
        item.imageView.image = [UIImage imageNamed:itemDic[@"image"]];
        item.titleLabel.text = itemDic[@"title"];
        [self addSubview:item];
        [self.itemArray addObject:item];
        
        //两个图片布局
        if (self.dataArray.count == 2) {
            float offset = (kScreenWidth-CYTAutoLayoutH(120)*2-CYTAutoLayoutH(140))/2.0;
            offset = (i==0)?offset:(offset+CYTAutoLayoutH(120)+CYTAutoLayoutH(140));
            
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(CYTAutoLayoutV(138));
                make.height.equalTo(CYTAutoLayoutH(160));
                make.width.equalTo(CYTAutoLayoutH(120));
                make.left.equalTo(offset);
            }];
        //三个图片布局
        }else if (self.dataArray.count == 3) {
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(CYTAutoLayoutV(138));
                make.height.equalTo(CYTAutoLayoutH(160));
                make.width.equalTo(width);
                make.left.equalTo(i*width);
            }];
        }
        
    }
}

- (void)setType:(ShareViewType)type {
    _type = type;
    
    NSArray *subview = self.subviews;
    for (UIView *view in subview) {
        if (view.tag != 100 && view.tag != 101) {
            [view removeFromSuperview];
        }
    }
    
    NSDictionary *dic1 = @{@"image":@"share_friends",@"title":@"微信好友"};
    NSDictionary *dic2 = @{@"image":@"share_circle",@"title":@"朋友圈"};
    NSDictionary *dic3 = @{@"image":@"share_link",@"title":@"复制链接"};
    self.itemArray = [NSMutableArray array];
    if (type == ShareViewType_carInfo) {
        //两个-车信息
        self.dataArray = @[dic1,dic2];
    }else {
        //三个-有链接
        self.dataArray = @[dic1,dic2,dic3];
    }
    
    [self addItems];
    [self layoutIfNeeded];
}

#pragma mark- get
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.tag = 100;
        _titleLabel.font = CYTFontWithPixel(32);
        _titleLabel.textColor = kFFColor_title_L1;
        _titleLabel.text = @"分享到";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.tag = 101;
        [_cancelButton setImage:[UIImage imageNamed:@"share_cancel"] forState:UIControlStateNormal];
        @weakify(self);
        [[_cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.clickedBlock) {
                self.clickedBlock(-1);
            }
            
        }];
    }
    return _cancelButton;
}

@end
