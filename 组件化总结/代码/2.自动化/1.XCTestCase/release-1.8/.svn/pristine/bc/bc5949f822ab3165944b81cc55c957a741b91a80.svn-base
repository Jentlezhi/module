//
//  CYTInfoTipView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTInfoTipView.h"

@implementation CYTInfoTipView
{
    UILabel *_infoLabel;
    UIButton *_removeBtn;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self infoTipViewBasicConfig];
        [self initInfoTipViewComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)infoTipViewBasicConfig{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];;
}
/**
 *  初始化子控件
 */
- (void)initInfoTipViewComponents{
    UILabel *infoLabel = [[UILabel alloc] init];
    infoLabel.numberOfLines = 0;
    infoLabel.textColor = CYTHexColor(@"#ffffff");
    infoLabel.font = CYTFontWithPixel(26.f);
    [self addSubview:infoLabel];
    _infoLabel = infoLabel;
    
    CYTWeakSelf
    UIButton *removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [removeBtn setBackgroundImage:[UIImage imageNamed:@"btn_delete_50_dl"] forState:UIControlStateNormal];
    [[removeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [UIView animateWithDuration:0.35f animations:^{
            self.alpha = 0.1f;
        } completion:^(BOOL finished) {
            !weakSelf.removeActionBlock?:weakSelf.removeActionBlock();
            [self removeFromSuperview];
        }];
    }];
    [self addSubview:removeBtn];
    _removeBtn = removeBtn;


}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    [_removeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(CYTAutoLayoutV(50.f));
        make.centerY.equalTo(self);
        make.right.equalTo(-CYTAutoLayoutH(26.f));
    }];

    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(_removeBtn.mas_left).offset(-CYTMarginH);
    }];
    

}

- (void)setMessage:(NSString *)message{
    _message = message;
    _infoLabel.text = message;
}

@end
