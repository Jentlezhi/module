//
//  Pcms
//
//  Created by xujunquan on 16/11/18.
//  Copyright © 2016年 cig. All rights reserved.
//

#import "FFDZNLoadingView.h"

@implementation FFDZNLoadingView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self ff_addSubViewAndConstraints];
    }
    return self;
}

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.imageView];
    [self addSubview:self.contentLabel];
    
    //设置图片压缩优先级低，则图片被压缩显示，不会造成label无法显示的状况,重要方法
//    [self.imageView setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(10);
        make.left.right.bottom.equalTo(self);
    }];
}

#pragma mark- get
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textColor = [UIColor grayColor];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _contentLabel;
}

#pragma mark- set
- (void)setContentText:(NSString *)contentText {
    _contentText = contentText;
    self.contentLabel.text = contentText;
}

- (void)setContentImage:(NSString *)contentImage {
    _contentImage = contentImage;
    self.imageView.image = [UIImage imageNamed:contentImage];
}

- (void)setTopSpace:(float)topSpace {
    _topSpace = topSpace;
    [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(topSpace));
    }];
}

- (void)setBottomSpace:(float)bottomSpace {
    _bottomSpace = bottomSpace;
    [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(bottomSpace));
    }];
}

- (void)setBetSpace:(float)betSpace {
    _betSpace = betSpace;
    [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(betSpace);
    }];
}

@end
