//
//  FFNavigationItemView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/25.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFNavigationItemView.h"

@interface FFNavigationItemView()
@property (nonatomic, strong) UIButton *item;

@end

@implementation FFNavigationItemView

- (void)ff_initWithViewModel:(id)viewModel {
    self.font = [UIFont systemFontOfSize:16];
}

- (void)ff_addSubViewAndConstraints {
#ifdef DEBUG
#ifdef kFFDebug
    [self.item radius:8 borderWidth:1 borderColor:kFFDebugViewColor];
#endif
#endif
    
    [self addSubview:self.item];
    [self.item makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark- set
- (void)setContentInsect:(UIEdgeInsets)contentInsect {
    _contentInsect = contentInsect;
    [self.item setContentEdgeInsets:contentInsect];
}

- (void)setImageInsect:(UIEdgeInsets)imageInsect {
    _imageInsect = imageInsect;
    [self.item setImageEdgeInsets:imageInsect];
}

- (void)setFont:(UIFont *)font {
    _font = font;
    self.item.titleLabel.font = font;
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    [self.item setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.item setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self.item setTitle:title forState:UIControlStateNormal];
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    [self.item setTitleColor:titleColor forState:UIControlStateNormal];
}

#pragma mark- get
- (UIButton *)item {
    if (!_item) {
        _item = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        @weakify(self);
        [[_item rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.clickedBlock) {
                self.clickedBlock(self);
            }
        }];
    }
    return _item;
}


@end
