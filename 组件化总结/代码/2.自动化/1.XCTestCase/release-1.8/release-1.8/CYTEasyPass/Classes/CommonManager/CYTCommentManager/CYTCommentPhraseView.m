//
//  CYTCommentPhraseView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCommentPhraseView.h"

@interface CYTCommentPhraseView ()
@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, strong) UIButton *lastButton;

@end

@implementation CYTCommentPhraseView

- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
    self.itemArray = [NSMutableArray array];
}

- (void)setPhraseArray:(NSArray *)phraseArray {
    _phraseArray = phraseArray;
    
    for (UIView *obj in self.subviews) {
        [obj removeFromSuperview];
    }
    self.itemArray = [NSMutableArray array];
    
    for (int i=0; i<phraseArray.count; i++) {
        UIButton *itemButton = [UIButton buttonWithFontPxSize:26 textColor:kFFColor_title_L3 text:phraseArray[i]];
        itemButton.tag = i;
        [itemButton radius:2 borderWidth:0.5 borderColor:kFFColor_line];
        [[itemButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self selectWithItem:x];
        }];
        
        [self addSubview:itemButton];
        
        //行
        NSInteger line = i/2;
        //列
        NSInteger vline = i%2;
        
        float x = (vline==0)?CYTAutoLayoutH(95):CYTAutoLayoutH(395);
        float y = (line ==0)?CYTAutoLayoutV(10):CYTAutoLayoutV(90);
        float width = CYTAutoLayoutH(260);
        float height = CYTAutoLayoutV(60);
        
        [itemButton makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(x);
            make.top.equalTo(y);
            make.width.equalTo(width);
            make.height.equalTo(height);
        }];
        [self.itemArray addObject:itemButton];
    }
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    if (self.itemArray.count>index) {
        UIButton *button = self.itemArray[index];
        [self selectWithItem:button];
    }
}

- (void)selectWithItem:(UIButton *)item {
    item.exState = !item.exState;
    
    UIColor *borderColor = (item.exState == 0) ? kFFColor_line : kFFColor_green;
    UIColor *textColor = (item.exState == 0) ?kFFColor_title_L3 : kFFColor_green;
    UIColor *contentColor = (item.exState == 0)?[UIColor whiteColor] : [UIColorFromRGB(0x2CB63E) colorWithAlphaComponent:0.06];
    
    [item radius:2 borderWidth:0.5 borderColor:borderColor];
    [item setTitleColor:textColor forState:UIControlStateNormal];
    item.backgroundColor = contentColor;
    
    if (self.phraseBlock) {
        BOOL insert = (item.exState == 1);
        self.phraseBlock(item.titleLabel.text,insert);
    }
    
}

@end
