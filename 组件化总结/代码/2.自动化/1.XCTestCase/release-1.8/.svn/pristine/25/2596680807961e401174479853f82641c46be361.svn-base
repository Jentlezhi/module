//
//  CYTHomeSearchBarView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/21.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTHomeSearchBarView.h"

@implementation CYTHomeSearchBarView

- (void)ff_addSubViewAndConstraints {
//    [self radius:1 borderWidth:1 borderColor:CYTRedColor];
    
    [self addSubview:self.bgView];
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.messageBorderView];
    [self addSubview:self.messageView];
    [self addSubview:self.bubbleView];
    
    [self.bgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self.messageView.left).offset(CYTAutoLayoutH(-20));
    }];
    [self.messageBorderView makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self);
        make.width.equalTo(60);
    }];
    [self.messageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(self);
    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(CYTAutoLayoutH(20));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.imageView.mas_right).offset(CYTAutoLayoutH(10));
    }];
    [self.bubbleView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.top);
        make.centerX.equalTo(self.messageView).offset(CYTAutoLayoutH(18));
    }];
}

- (void)showBubbleView:(BOOL)show {
    self.bubbleView.hidden = !show;
}

#pragma mark- get
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColorFromRGB(0xffffff) colorWithAlphaComponent:0.3];
        [_bgView radius:CYTAutoLayoutV(30) borderWidth:1 borderColor:[UIColor clearColor]];
        
        UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
        @weakify(self);
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            @strongify(self);
            if (self.searchBlock) {
                self.searchBlock();
            }
        }];
        [_bgView addGestureRecognizer:tap];
        
    }
    return _bgView;
}
   
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.image = [UIImage imageNamed:@"home_search"];
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = CYTFontWithPixel(28);
        _titleLabel.text = @"搜索品牌/车系/指导价";
    }
    return _titleLabel;
}

- (UIButton *)messageBorderView {
    if (!_messageBorderView) {
        _messageBorderView = [UIButton buttonWithType:UIButtonTypeCustom];
        @weakify(self);
        [[_messageBorderView rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.messageBlock) {
                self.messageBlock();
            }
        }];
    }
    return _messageBorderView;
}

- (FFOtherView_1 *)messageView {
    if (!_messageView) {
        _messageView = [FFOtherView_1 new];
        _messageView.titleLabel.textColor = [UIColor whiteColor];
        _messageView.titleLabel.text = @"消息";
        _messageView.titleLabel.font = CYTFontWithPixel(20);
        _messageView.midOffset = 0;
        _messageView.topOffset = 0;
        _messageView.botOffset = 0;
        UIImage *image = [UIImage imageNamed:@"home_mess_border"];
        _messageView.imageView.image = image;
        
        @weakify(self);
        [_messageView setClickedBlock:^(FFOtherView_1 *tmp) {
            @strongify(self);
            if (self.messageBlock) {
                self.messageBlock();
            }
        }];
    }
    return _messageView;
}

- (UIImageView *)bubbleView {
    if (!_bubbleView) {
        _bubbleView = [UIImageView ff_imageViewWithImageName:@"home_mess_bubble"];
        _bubbleView.hidden = YES;
    }
    return _bubbleView;
}

- (void)setTranslucence:(BOOL)translucence{
    _translucence = translucence;
    translucence?[self lucencyType]:[self opaqueType];
}
/**
 *  透明效果
 */
- (void)lucencyType{
    self.bgView.backgroundColor = [UIColorFromRGB(0xffffff) colorWithAlphaComponent:0.3];
    self.imageView.image = [UIImage imageNamed:@"home_search"];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.messageView.imageView.image = [UIImage imageNamed:@"home_mess_border"];
    self.messageView.titleLabel.textColor = [UIColor whiteColor];
}
/**
 *  非透明效果
 */
- (void)opaqueType{
    self.bgView.backgroundColor = [CYTHexColor(@"#F5F5F5") colorWithAlphaComponent:1.0f];
    self.imageView.image = [[UIImage imageNamed:@"home_search"] renderWithColor:CYTHexColor(@"#999999")];
    self.titleLabel.textColor = CYTHexColor(@"#999999");
    self.messageView.imageView.image = [[UIImage imageNamed:@"home_mess_border"] renderWithColor:CYTHexColor(@"#686868")];
    self.messageView.titleLabel.textColor = CYTHexColor(@"#666666");
    
}

@end
