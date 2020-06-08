//
//  FFBasicSegmentView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFBasicSegmentView.h"

@interface FFBasicSegmentView ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
///指示条
@property (nonatomic, strong) UIView *indicatorBgView;
@property (nonatomic, strong) UIView *indicatorLine;
///底部细线
@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, strong) FFBasicSegmentItemView *lastItem;

@end

@implementation FFBasicSegmentView

- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];

    _showBottomLine = NO;
    _showIndicatorLine = YES;
    _lineHeight = 2;
    _itemContentInsect = UIEdgeInsetsZero;
    _titleNorColor = kFFColor_title_L1;
    _titleSelColor = kFFColor_green;
    _indicatorBgColor = kFFColor_title_gray;
    _indicatorSelColor = kFFColor_green;
    _itemArray = [NSMutableArray array];
    
}

- (void)ff_addSubViewAndConstraints {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    
    [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.width.height.equalTo(self);
    }];
    [self.contentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.top.equalTo(self.scrollView);
        make.height.equalTo(self.scrollView);
    }];
}

- (void)itemSelectWithIndex:(NSInteger)index {
    self.index = index;
}

- (void)addIndicatorView {
    if (self.showIndicatorLine) {
        [self.contentView addSubview:self.indicatorBgView];
        [self.contentView addSubview:self.indicatorLine];
        [self.indicatorBgView remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.bottom.equalTo(-self.lineBottomOffset);
            make.height.equalTo(self.lineHeight);
        }];
        [self.indicatorLine remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(-self.lineBottomOffset);
            make.height.equalTo(self.lineHeight);
            make.width.equalTo(0);
            make.left.equalTo(self.contentView.left).offset(0);
        }];
    }
}

- (void)addBottomLineView {
    if (_bottomLine) {
        [_bottomLine removeFromSuperview];
    }
    if (self.showBottomLine) {
        [self addSubview:self.bottomLine];
        [self.bottomLine makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.height.equalTo(0.5);
            make.left.equalTo(self.bottomLineOffset);
            make.right.equalTo(-self.bottomLineOffset);
        }];
    }
}

- (void)addItemViewWithArray:(NSArray *)itemArray isCustom:(BOOL)isCustom{
    NSArray *subViews = self.contentView.subviews;
    for (UIView *obj in subViews) {
        [obj removeFromSuperview];
    }
    [self.itemArray removeAllObjects];
    
    UIView *lastView;
    for (int i=0; i<itemArray.count; i++) {
        FFBasicSegmentItemView *itemView = [FFBasicSegmentItemView new];
        if (isCustom) {
            itemView = itemArray[i];
        }else {
            itemView.title = [itemArray objectAtIndex:i];
        }
        
        [itemView.titleButton setContentEdgeInsets:self.itemContentInsect];
        itemView.bubbleView.bubbleButton.backgroundColor = self.bubbleBgColor;
        
        @weakify(self);
        [itemView setSelectBlock:^{
            @strongify(self);
            [self itemSelectWithIndex:i];
        }];
        [self.contentView addSubview:itemView];
        [itemView makeConstraints:^(MASConstraintMaker *make) {
            if (lastView) {
                make.left.equalTo(lastView.right);
            }else {
                make.left.equalTo(0);
            }
            make.top.equalTo(self.contentView);
            //line
            float bottomOffset = 0;
            if (self.showIndicatorLine) {
                bottomOffset = self.lineHeight;
            }
            make.bottom.equalTo(-bottomOffset);
            
            //width
            if (self.type == FFBasicSegmentTypeAverage) {
                make.width.equalTo(self).multipliedBy(1*1.0/itemArray.count);
            }
            //min width
            make.width.greaterThanOrEqualTo(self.itemMinWidth);
        }];
        lastView = itemView;
        [self.itemArray addObject:itemView];
    }
    if (lastView) {
        [lastView makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(0);
        }];
    }
}

- (id)itemWithIndex:(NSInteger)index {
    if (index<self.itemArray.count) {
        return self.itemArray[index];
    }
    return nil;
}

#pragma mark- set
- (void)setShowBottomLine:(BOOL)showBottomLine {
    _showBottomLine = showBottomLine;
    [self addBottomLineView];
}

- (void)setBottomLineOffset:(float)bottomLineOffset {
    _bottomLineOffset = bottomLineOffset;
    [self addBottomLineView];
}

- (void)setShowBubble:(BOOL)showBubble {
    _showBubble = showBubble;
    //便利所有item
    for (int i=0; i<self.itemArray.count; i++) {
        FFBasicSegmentItemView *item = self.itemArray[i];
        item.bubbleView.hidden = !showBubble;
    }
}

- (void)setBubbleBgColor:(UIColor *)bubbleBgColor {
    _bubbleBgColor = bubbleBgColor;
    
    //便利所有item
    for (int i=0; i<self.itemArray.count; i++) {
        FFBasicSegmentItemView *item = self.itemArray[i];
        item.bubbleView.bubbleButton.backgroundColor = bubbleBgColor;
    }
}

//赋值时再显示bubble
- (void)bubbleNumber:(NSString *)bubble withIndex:(NSInteger)index {
    
    BOOL showBubble = self.showBubble;
    if (self.itemArray.count>index) {
        FFBasicSegmentItemView *item = self.itemArray[index];
        if (!bubble || bubble.length == 0 || [bubble isEqualToString:@"0"]) {
            showBubble = NO;
        }else {
            NSString *numberString = [NSString stringWithFormat:@"%@",bubble];
            [item.bubbleView.bubbleButton setTitle:numberString forState:UIControlStateNormal];
        }
        
        item.bubbleView.hidden = !showBubble;
    }
}

#pragma mark- set

- (void)setLineHeight:(float)lineHeight {
    _lineHeight = lineHeight;
    //重新布局整个segment
    self.titlesArray = self.titlesArray;
}

- (void)setLineBottomOffset:(float)lineBottomOffset {
    _lineBottomOffset = lineBottomOffset;
    [self addIndicatorView];
}

- (void)setShowIndicatorLine:(BOOL)showIndicatorLine {
    _showIndicatorLine = showIndicatorLine;
    //重新布局整个segment
    self.titlesArray = self.titlesArray;
}

- (void)setTitlesArray:(NSArray *)titlesArray {
    _titlesArray = titlesArray;
    
    //如果自定义item，则直接返回
    if (self.customItemArray.count!=0) {
        return;
    }
    
    if (titlesArray.count==0) {
        return;
    }
    
    [self addItemViewWithArray:titlesArray isCustom:NO];
    [self addIndicatorView];
    [self addBottomLineView];
}

- (void)setCustomItemArray:(NSArray *)customItemArray {
    _customItemArray = customItemArray;
    
    if (customItemArray.count == 0) {
        return;
    }
    
    [self addItemViewWithArray:customItemArray isCustom:YES];
    [self addIndicatorView];
    [self addBottomLineView];
}

- (void)setType:(FFBasicSegmentType)type {
    _type = type;
    //重新布局整个segment
    self.titlesArray = self.titlesArray;
}

- (void)setIndex:(NSInteger)index {
    if (self.lastItem) {
        self.lastItem.titleColor = self.titleNorColor;
    }
    
    if (index<0 || index >=self.itemArray.count) {
        return;
    }
    
    _index = index;
    FFBasicSegmentItemView *currentItem = self.itemArray[index];
    currentItem.titleColor = self.titleSelColor;
    
    self.lastItem = currentItem;
    
    //将当前item移动到中心
    if (self.type == FFBasicSegmentTypeDynamic) {
        
        float contentWidth = self.scrollView.contentSize.width;
        float scrollWidth = self.frame.size.width;
        if (contentWidth > scrollWidth) {
            CGRect rect = [self.contentView convertRect:self.lastItem.frame toView:self.scrollView];
            float centerx = rect.origin.x+rect.size.width/2.0;
            float centerOffset = (centerx-self.frame.size.width/2.0);
            float rectOffset = contentWidth-scrollWidth;//大于0
            
            if (centerOffset <0) {
                centerOffset = 0;
            }
            if (centerOffset >rectOffset) {
                centerOffset = rectOffset;
            }
            [self.scrollView setContentOffset:CGPointMake(centerOffset, 0) animated:YES];
        }
    }
    
    //line 动画
    [self.superview layoutIfNeeded];
    
    if (self.showIndicatorLine) {
        float left = self.lastItem.frame.origin.x;
        //计算indicator的宽度
        float width = self.lastItem.frame.size.width;
        CGSize size = [self.lastItem.title ff_sizeWithFont:self.lastItem.titleButton.titleLabel.font andMaxSize:CGSizeMake(width, 100)];
        float minWidth = MIN(width, size.width);
        float offset = (width-minWidth)/2.0;
        
        CGRect frame = self.indicatorLine.frame;
        frame.origin.x = left+offset;
        frame.size.width = minWidth;

        [UIView animateWithDuration:kFFAnimationDuration animations:^{
            self.indicatorLine.frame = frame;
        }];
    }
    
    if (self.indexChangeBlock) {
        self.indexChangeBlock(index);
    }
}

#pragma mark- get
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
    }
    return _contentView;
}

- (UIView *)indicatorLine {
    if (!_indicatorLine) {
        _indicatorLine = [UIView new];
        _indicatorLine.backgroundColor = self.indicatorSelColor;
    }
    return _indicatorLine;
}

- (UIView *)indicatorBgView {
    if (!_indicatorBgView) {
        _indicatorBgView = [UIView new];
        _indicatorBgView.backgroundColor = self.indicatorBgColor;
    }
    return _indicatorBgView;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = kFFColor_line;
    }
    return _bottomLine;
}

@end
