//
//  CYTCouponCardView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/27.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCouponCardView.h"
#import "CYTCouponListItemModel.h"

@interface CYTCouponCardView()

/** 渐变颜色 */
@property(strong, nonatomic) NSArray *gradientColors;

/** 券模型 */
@property(strong, nonatomic) CYTCouponListItemModel *couponListItemModel;

@end

@implementation CYTCouponCardView
{
    CYTCouponListItemModel *_couponListItemModel;
    //左边分割块
    UIImageView *_halfLeftView;
    //添加右边分割块
    UIImageView *_outskirtsView;
    //添加标签
    UIImageView *_tagView;
    //设置价格
    UILabel *_priceLabel;
    //使用条件
    UILabel *_useConditionLabel;
    //价格和使用条件父视图
    UIView *_priceAndLimitView;
}

- (CYTCouponListItemModel *)couponListItemModel{
    if (!_couponListItemModel) {
        _couponListItemModel = [[CYTCouponListItemModel alloc] init];
    }
    return _couponListItemModel;
}

- (NSArray *)gradientColors{
    if (!_gradientColors) {
        _gradientColors = [NSArray array];
    }
    return _gradientColors;
}
/**
 *  绘图
 */
- (void)drawRect:(CGRect)rect{
    [self gradientColorWithDirection:CYTGradientDirectionVertical colors:self.gradientColors frame:rect];
    [self initCouponCardComponentsWithCouponModel:self.couponListItemModel rect:rect];
    [self makeConstrainsWithCouponModel:self.couponListItemModel rect:rect];
}

- (instancetype)initWithCouponModel:(CYTCouponListItemModel *)couponListItemModel{
    if (self = [super init]) {
        [self couponCardBasicConfigWithCouponModel:couponListItemModel];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)couponCardBasicConfigWithCouponModel:(CYTCouponListItemModel *)couponListItemModel{
    self.backgroundColor = [UIColor clearColor];
    //模型赋值
    self.couponListItemModel = couponListItemModel;
}
/**
 *  初始化子控件
 */
- (void)initCouponCardComponentsWithCouponModel:(CYTCouponListItemModel *)couponListItemModel rect:(CGRect)rect{
    
    //添加左边分割块
    UIImageView *halfLeftView = [UIImageView imageViewWithImageName:@"pic_half_left_16x30_dl"];
    [self addSubview:halfLeftView];
    _halfLeftView = halfLeftView;
    
    //添加右边分割块
    UIImage *outskirtsImage = [UIImage imageNamed:@"pic_outskirts_4x8_dl"];
    CGFloat outskirtsViewW = CYTAutoLayoutV(4);
    CGFloat outskirtsViewH = CYTAutoLayoutV(8);
    CGFloat outskirtsViewX = rect.size.width - outskirtsViewW;
    CGFloat outskirtsViewY = 0;
    NSUInteger outskirtsNum = rect.size.height/outskirtsViewH + 1;
    for (NSUInteger index = 0; index < outskirtsNum; index ++) {
        UIImageView *outskirtsView = [UIImageView imageViewWithImage:outskirtsImage];
        outskirtsViewY = index*outskirtsViewH;
        outskirtsView.frame = CGRectMake(outskirtsViewX, outskirtsViewY, outskirtsViewW, outskirtsViewH);
        [self addSubview:outskirtsView];
    }
    //添加标签
    [self createTagWithModel:couponListItemModel];
    
    UIView *priceAndLimitView = [[UIView alloc] init];
    [self addSubview:priceAndLimitView];
    _priceAndLimitView = priceAndLimitView;
    
    //设置价格
    CGFloat priceLabelFontP = 0.f;
    if ([CYTCommonTool isChinese:couponListItemModel.reduceMoney]) {
        priceLabelFontP = 52.f;
    }else{
        priceLabelFontP = 60.f;
    }
    NSString *priceStr = [NSString stringWithFormat:@"￥%@",couponListItemModel.reduceMoney];
    UILabel *priceLabel = [UILabel labelWithTextColor:CYTHexColor(@"#FFFFFF") textAlignment:NSTextAlignmentCenter fontPixel:priceLabelFontP setContentPriority:NO];
    NSMutableAttributedString *priceAttributedStr = [NSMutableAttributedString attributedStringWithContent:priceStr keyWord:@"￥" keyFontPixel:44.f keyWordColor:priceLabel.textColor];
    priceLabel.attributedText = priceAttributedStr;
    priceLabel.hidden = !couponListItemModel.reduceMoney.length;
    [priceAndLimitView addSubview:priceLabel];
    _priceLabel = priceLabel;
    
    //使用条件
    NSString *useConditionStr = couponListItemModel.limitDesc.length?couponListItemModel.limitDesc:@"";
    UILabel *useConditionLabel = [UILabel labelWithTextColor:CYTHexColor(@"#FFFFFF") textAlignment:NSTextAlignmentCenter font:CYTBoldFontWithPixel(28.f) setContentPriority:NO];
    [priceAndLimitView addSubview:useConditionLabel];
    useConditionLabel.text = useConditionStr;
    _useConditionLabel = useConditionLabel;
    
}
/**
 *  状态
 */
- (void)createTagWithModel:(CYTCouponListItemModel *)couponListItemModel{
    //添加类型标签
    UIImageView *tagView = [[UIImageView alloc] init];
    [self addSubview:tagView];
    _tagView = tagView;
    
    NSString *tagImageName = [NSString string];
    CYTCouponType couponType = couponListItemModel.couponType;
    CYTCouponStatusType couponStatusType = couponListItemModel.status;
    switch (couponStatusType) {
        case CYTCouponStatusTypeUnused://未使用
        case CYTCouponStatusTypeUsed://已使用
        {
            switch (couponType) {
                case CYTCouponTypeVoucher:
                    tagImageName = @"pic_yellowdiyong_nor";
                    break;
                case CYTCouponTypeFreeShipping:
                    tagImageName = @"pic_bluefree_nor";
                    break;
                case CYTCouponTypeDiscount:
                    tagImageName = @"";
                default:
                    break;
            }
        }
            break;
        case CYTCouponStatusTypeExpired://已过期
        {
            switch (couponType) {
                case CYTCouponTypeVoucher:
                    tagImageName = @"pic_diyong_unsel";
                    break;
                case CYTCouponTypeFreeShipping:
                    tagImageName = @"pic_free_unsel";
                    break;
                case CYTCouponTypeDiscount:
                    tagImageName = @"";
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
    _tagView.image = [UIImage imageNamed:tagImageName];
}



/**
 *  布局控件
 */
- (void)makeConstrainsWithCouponModel:(CYTCouponListItemModel *)couponListItemModel rect:(CGRect)rect{
    [_halfLeftView makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(self);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(16.f), CYTAutoLayoutV(30.f)));
    }];
    
    [_priceAndLimitView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(CYTAutoLayoutV(112.f));
        make.centerY.equalTo(self);
    }];
    
    [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.width.height.equalTo(CYTAutoLayoutV(84));
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceAndLimitView);
        make.left.right.equalTo(self);
    }];
    
    [_useConditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_priceLabel);
        make.bottom.equalTo(_priceAndLimitView);
    }];
    
}

- (void)setCouponListItemModel:(CYTCouponListItemModel *)couponListItemModel{
    _couponListItemModel = couponListItemModel;
    NSArray *tempArray = [NSArray array];
    CYTCouponType couponType = couponListItemModel.couponType;
    CYTCouponStatusType couponStatusType = couponListItemModel.status;
    if (couponType == CYTCouponTypeVoucher) {
        tempArray = @[CYTHexColor(@"#E5C156"),CYTHexColor(@"#E5D55A"),CYTHexColor(@"#E4D66B")];
    }else if (couponType == CYTCouponTypeFreeShipping){
        tempArray = @[CYTHexColor(@"#7799D8"),CYTHexColor(@"#86B8E2"),CYTHexColor(@"#90C1EB")];
    }else if (couponType == CYTCouponTypeDiscount){
        tempArray = @[CYTHexColor(@"#E5C156"),CYTHexColor(@"#E5D55A"),CYTHexColor(@"#E4D66B")];
    }
    if(couponStatusType == CYTCouponStatusTypeExpired){//过期
        tempArray = @[CYTHexColor(@"#DBDBDB"),CYTHexColor(@"#DBDBDB"),CYTHexColor(@"#DBDBDB")];
    }
    self.gradientColors = [tempArray copy];
    
}


@end
