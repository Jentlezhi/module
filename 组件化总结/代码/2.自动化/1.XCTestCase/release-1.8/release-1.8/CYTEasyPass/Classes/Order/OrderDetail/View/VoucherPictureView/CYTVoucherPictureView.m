//
//  CYTVoucherPictureView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTVoucherPictureView.h"
#import "CYTOrderModel.h"
#import "CYTImageVoucherModel.h"

static NSInteger const maxVoucherPic = 3;

@interface CYTVoucherPictureView()

/** 图片控件集合 */
@property(strong, nonatomic) NSMutableArray *imageViews;
/** 图片总计 */
@property(strong, nonatomic) UILabel *picTotalLabel;
/** 点击的当前索引 */
@property(assign, nonatomic) NSInteger currentIndex;

@end

@implementation CYTVoucherPictureView
{
    //分割线
    UILabel *_lineLabel;
    //标题
    UILabel *_titleLabel;
    //箭头
    UIImageView *_arrowImageView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self voucherPictureViewBasicConfig];
        [self initVoucherPictureViewComponents];
        [self makeConstrains];
    }
    return  self;
}

- (NSMutableArray *)imageViews{
    if (!_imageViews) {
        _imageViews = [NSMutableArray array];
    }
    return _imageViews;
}


/**
 *  基本配置
 */
- (void)voucherPictureViewBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    CYTWeakSelf
    [self addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
        !weakSelf.voucherPictureViewClick?:weakSelf.voucherPictureViewClick(0);
    }];
}
/**
 *  初始化子控件
 */
- (void)initVoucherPictureViewComponents{
    //分割线
    UILabel *lineLabel = [UILabel dividerLineLabel];
    [self addSubview:lineLabel];
    _lineLabel = lineLabel;
    
    //标题
    UILabel *titleLabel = [UILabel labelWithText:@"凭     证：" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:YES];
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    //箭头
    UIImageView *arrowImageView = [UIImageView ff_imageViewWithImageName:@"arrow_right"];
    [self addSubview:arrowImageView];
    _arrowImageView = arrowImageView;
    
    //图片总数
    [self addSubview:self.picTotalLabel];

}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(_lineLabel.mas_bottom).offset(CYTMarginV);
        make.bottom.equalTo(-CYTAutoLayoutV(121.f));
    }];
    
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(CYTAutoLayoutV(44.f));
        make.centerY.equalTo(_titleLabel);
        make.right.equalTo(-CYTItemMarginH);
    }];
}

- (UILabel *)picTotalLabel{
    if (!_picTotalLabel) {
        _picTotalLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:22.f setContentPriority:NO];
    }
    return _picTotalLabel;
}

- (void)setOrderModel:(CYTOrderModel *)orderModel{
    _orderModel = orderModel;
    [self setValueWithOrderModel:orderModel];
    [self layoutWithOrderModel:orderModel];
}

- (void)setValueWithOrderModel:(CYTOrderModel *)orderModel{
    NSInteger voucherPicNum = orderModel.customImageVouchers.count;
    NSInteger imageViewNum = voucherPicNum > maxVoucherPic ? maxVoucherPic:voucherPicNum;
    [self.imageViews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self.imageViews removeAllObjects];
    for (NSInteger index = 0; index<imageViewNum; index ++) {
        CYTImageVoucherModel *imageVoucherModel = orderModel.customImageVouchers[index];
        UIImageView *imageView = [[UIImageView alloc] init];
        CYTWeakSelf
        [imageView addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
            !weakSelf.voucherPictureViewClick?:weakSelf.voucherPictureViewClick(index);
        }];
        imageView.clipsToBounds = YES;
        [imageView sd_setImageWithURL:imageVoucherModel.thumbnailUrl placeholderImage:kPlaceholderImage];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imageView];
        [self.imageViews addObject:imageView];
    }
    NSString *picTotalDes = voucherPicNum>0? [NSString stringWithFormat:@"(共%ld张)",voucherPicNum] : @"";
    self.picTotalLabel.text = picTotalDes;
}
- (void)layoutWithOrderModel:(CYTOrderModel *)orderModel{
    for (NSInteger index = 0; index < self.imageViews.count; index++) {
        if (index == 0) {
            UIImageView *imageView = self.imageViews[index];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_lineLabel.mas_bottom).offset(CYTAutoLayoutV(25.f));
                make.left.equalTo(_titleLabel.mas_right);
                make.width.height.equalTo(CYTAutoLayoutV(120.f));
            }];
        }else{
            UIImageView *preImageView = self.imageViews[index-1];
            UIImageView *imageView = self.imageViews[index];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(preImageView);
                make.left.equalTo(preImageView.mas_right).offset(CYTAutoLayoutH(10.f));
                make.width.height.equalTo(CYTAutoLayoutV(120.f));
            }];
        }
    }
    
    UIImageView *lastImageView = [self.imageViews lastObject];
    if (!lastImageView) return;
    
    [_picTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lastImageView.mas_right).offset(CYTItemMarginH);
        make.bottom.equalTo(lastImageView);
    }];
}

@end
