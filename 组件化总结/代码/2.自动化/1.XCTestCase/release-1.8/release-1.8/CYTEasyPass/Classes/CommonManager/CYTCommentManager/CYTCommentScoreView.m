//
//  CYTCommentScoreView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCommentScoreView.h"

@interface CYTCommentScoreView ()
@property (nonatomic, strong) NSArray *norImageArray;
@property (nonatomic, strong) NSArray *selImageArray;
@property (nonatomic, strong) FFOtherView_1 *lastItem;
@property (nonatomic, strong) NSMutableArray *allItemArray;

@end

@implementation CYTCommentScoreView

- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
    
    self.allItemArray = [NSMutableArray array];
    self.norImageArray = @[@"dealer_comment_good_nor",@"dealer_comment_mid_nor",@"dealer_comment_bad_nor"];
    self.selImageArray = @[@"dealer_comment_good_sel",@"dealer_comment_mid_sel",@"dealer_comment_bad_sel"];
}

- (void)ff_addSubViewAndConstraints {
    [self clearMethod];
    
    [self addSubview:self.flagLabel];
    [self.flagLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(-3);
        make.left.equalTo(CYTAutoLayoutH(34));
    }];
    [self addItemView];
}

- (void)clearMethod {
    for (UIView *obj in self.subviews) {
        [obj removeFromSuperview];
    }
    self.allItemArray = [NSMutableArray array];
}

- (void)addItemView {
    
    NSArray *titleArray = @[@"好评",@"中评",@"差评"];
    
    UIView *lastView;
    for (int i=0; i<titleArray.count; i++) {
        FFOtherView_1 *item = [FFOtherView_1 new];
        item.tag = i;
        [item setClickedBlock:^(FFOtherView_1 *tmp) {
            [self clickeWithItem:tmp];
        }];
        item.titleLabel.text = titleArray[i];
        item.titleLabel.textColor = kFFColor_title_gray;
        item.imageView.image = [UIImage imageNamed:self.norImageArray[i]];
        [self addSubview:item];
        [item makeConstraints:^(MASConstraintMaker *make) {
            if (lastView) {
                make.left.equalTo(lastView.right).offset(CYTAutoLayoutH(80));
            }else {
                make.left.equalTo(self.flagLabel.right).offset(CYTAutoLayoutH(45));
            }
            make.centerY.equalTo(self);
            make.width.equalTo(CYTAutoLayoutH(90));
        }];
        lastView = item;
        [self.allItemArray addObject:item];
    }
}

- (void)clickeWithItem:(FFOtherView_1 *)item {
    //清空所有
    if (self.lastItem) {
        self.lastItem.titleLabel.textColor = kFFColor_title_gray;
        self.lastItem.imageView.image = [UIImage imageNamed:self.norImageArray[self.lastItem.tag]];
    }
    
    self.lastItem = item;
    //选中当前
    item.titleLabel.textColor = CYTRedColor;
    item.imageView.image = [UIImage imageNamed:self.selImageArray[item.tag]];
    
    //返回选项
    if (self.indexBlock) {
        self.indexBlock(item.tag);
    }
}

#pragma mark- set
- (void)setIndex:(NSInteger)index {
    _index = index;
    if (self.allItemArray.count>index) {
        [self clickeWithItem:self.allItemArray[index]];
    }
}

#pragma mark- get
- (UILabel *)flagLabel {
    if (!_flagLabel) {
        _flagLabel = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L1];
        _flagLabel.text = @"服务评价：";
    }
    return _flagLabel;
}

@end
