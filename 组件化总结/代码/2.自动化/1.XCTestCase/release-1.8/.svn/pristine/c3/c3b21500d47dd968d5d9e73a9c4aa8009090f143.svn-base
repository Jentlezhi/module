//
//  CYTCouponCardViewCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/28.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCouponCardViewCell.h"
#import "CYTCouponCardView.h"
#import "CYTCouponListItemModel.h"

@interface CYTCouponCardViewCell()

/** 备注信息 */
@property(strong, nonatomic) NSMutableArray *couponMarkLabels;

@end

@implementation CYTCouponCardViewCell
{
    //背景
    UIView *_bgView;
    //右半圆
    UIImageView *_rightLeftView;
    //卡片
    CYTCouponCardView *_couponCardView;
    //券名称
    UILabel *_couponNameLabel;
    //限制使用日期
    UILabel *_limitUseTimeLabel;
    //已使用/已过期
    UIImageView *_rightTagView;
    //选中标识
    UIImageView *_selectedIcon;
}

- (NSMutableArray *)couponMarkLabels{
    if (!_couponMarkLabels) {
        _couponMarkLabels = [NSMutableArray array];
    }
    return _couponMarkLabels;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self couponCardViewCellBasicConfig];
        [self initCouponCardViewCellComponents];
        [self makeConstrains];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)couponCardViewCellBasicConfig{
    self.backgroundColor = CYTLightGrayColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.clipsToBounds = YES;
}
/**
 *  初始化子控件
 */
- (void)initCouponCardViewCellComponents{
    //背景
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    _bgView = bgView;

    //右半圆
    UIImageView *rightLeftView = [UIImageView imageViewWithImageName:@"pic_half_right16x30_dl"];
    [bgView addSubview:rightLeftView];
    _rightLeftView = rightLeftView;
    
    //券名称
    UILabel *couponNameLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft font:CYTBoldFontWithPixel(32.f) setContentPriority:NO];
    [bgView addSubview:couponNameLabel];
    _couponNameLabel = couponNameLabel;
    
    //限制使用日期
    UILabel *limitUseTimeLabel = [UILabel labelWithTextColor:CYTHexColor(@"#999999") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    [bgView addSubview:limitUseTimeLabel];
    _limitUseTimeLabel = limitUseTimeLabel;
    
    //已使用/已过期
    UIImageView *rightTagView = [[UIImageView alloc] init];
    [self addSubview:rightTagView];
    _rightTagView = rightTagView;
    
    //选中标识
    UIImageView *selectedIcon = [UIImageView imageViewWithImageName:@"selected"];
    [bgView addSubview:selectedIcon];
    _selectedIcon = selectedIcon;
    
}
/**
 *  布局控件
 */
- (void)makeConstrains{
    [_bgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTMarginV);
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
    }];
    
    [_rightLeftView makeConstraints:^(MASConstraintMaker *make) {
        make.right.centerY.equalTo(_bgView);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(16.f), CYTAutoLayoutV(30.f)));
    }];
    
    //右上角标签
    [_rightTagView makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(_bgView);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(150.f), CYTAutoLayoutV(100.f)));
    }];
    
    [_selectedIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(-CYTAutoLayoutH(14.f));
        make.width.height.equalTo(CYTAutoLayoutV(40.f));
    }];
    
    [_couponCardView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(_bgView);
        make.width.equalTo(CYTAutoLayoutH(264.f));
    }];
}

+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    CYTCouponCardViewCell *cell =  [[CYTCouponCardViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    return cell;
}
/**
 *  模型赋值 卡券传入
 */
- (void)setCouponListItemModel:(CYTCouponListItemModel *)couponListItemModel{
    if (!couponListItemModel)return;
    [self createCouponWithCouponModel:couponListItemModel];
    [self setValueWithCouponListItemModel:couponListItemModel];
    [self makeConstrainsWithCouponModel:couponListItemModel];
}

/**
 *  创建优惠卡片
 */
- (void)createCouponWithCouponModel:(CYTCouponListItemModel *)couponListItemModel{
    CYTCouponCardView *couponCardView = [[CYTCouponCardView alloc] initWithCouponModel:couponListItemModel];
    [_bgView addSubview:couponCardView];
    _couponCardView = couponCardView;
}

- (void)setValueWithCouponListItemModel:(CYTCouponListItemModel *)couponListItemModel{
    //券名称
    NSString *couponNameStr = couponListItemModel.couponName.length?couponListItemModel.couponName:@"";
    _couponNameLabel.text = couponNameStr;
    //限制使用日期
    NSString *limitUseTimeStr = [NSString stringWithFormat:@"限%@-%@",couponListItemModel.beginTime,couponListItemModel.endTime];
    _limitUseTimeLabel.text = limitUseTimeStr;
    //选中标识
    _selectedIcon.hidden = !couponListItemModel.isSelected;
    //已使用/已过期
    NSString *rightTagImageN = [NSString string];
    CYTCouponStatusType couponStatusType = couponListItemModel.status;
    switch (couponStatusType) {
        case CYTCouponStatusTypeUnused:
        {
            _rightTagView.hidden = YES;
        }
            break;
        case CYTCouponStatusTypeUsed:
        {
            _rightTagView.hidden = NO;
            rightTagImageN = @"pic_used_dl";
        }
            break;
        case CYTCouponStatusTypeExpired:
        {
            _rightTagView.hidden = NO;
            rightTagImageN = @"pic_dated_dl";
        }
            break;
        default:
            break;
    }
    _rightTagView.image = [UIImage imageNamed:rightTagImageN];
    
    //使用条件等备注
    [self.couponMarkLabels enumerateObjectsUsingBlock:^(UILabel *markLabel, NSUInteger idx, BOOL * _Nonnull stop) {
        [markLabel removeFromSuperview];
    }];
    [self.couponMarkLabels removeAllObjects];
    NSArray *couponMarks = [couponListItemModel.couponMarks copy];
    for (NSString *mark in couponMarks) {
        if (!mark.length) continue;
        UILabel *markLabel = [UILabel labelWithTextColor:CYTHexColor(@"#999999") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
        markLabel.numberOfLines = 0;
        markLabel.text = mark;
        [self.contentView addSubview:markLabel];
        [self.couponMarkLabels addObject:markLabel];
    }
}
/**
 *  条件布局控件
 */
- (void)makeConstrainsWithCouponModel:(CYTCouponListItemModel *)couponListItemModel{
    //布局处理
    NSInteger marksNum = self.couponMarkLabels.count;
    //券名称和限制日期布局
    if (marksNum == 0) {//没有备注
        [_couponCardView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(_bgView);
            make.bottom.equalTo(_bgView);
            make.width.equalTo(CYTAutoLayoutH(264.f));
            make.height.equalTo(CYTAutoLayoutV(200.f));
        }];
        [_couponNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(CYTAutoLayoutV(51.f));
            make.left.equalTo(_couponCardView.mas_right).offset(CYTAutoLayoutH(44.f));
            make.right.equalTo(_bgView).offset(-CYTAutoLayoutH(20.f));
        }];
        
        [_limitUseTimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_couponNameLabel);
            make.top.equalTo(_couponNameLabel.mas_bottom).offset(CYTAutoLayoutV(40.f));
            make.bottom.equalTo(-CYTAutoLayoutV(51.f));
        }];
    }else {//有备注
        [_couponCardView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(_bgView);
            make.width.equalTo(CYTAutoLayoutH(264.f));
        }];
        [_couponNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(CYTMarginV);
            make.left.equalTo(_couponCardView.mas_right).offset(CYTAutoLayoutH(44.f));
            make.right.equalTo(_bgView).offset(-CYTAutoLayoutH(20.f));
        }];
        
        [_limitUseTimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_couponNameLabel);
            make.top.equalTo(_couponNameLabel.mas_bottom).offset(CYTAutoLayoutV(32.f));
        }];
        
    }
    for (NSInteger index = 0; index < marksNum; index++) {
        UILabel *markLabel = self.couponMarkLabels[index];
        if (index == 0) {
            [markLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_limitUseTimeLabel.mas_bottom).offset(CYTAutoLayoutV(10));
                make.left.right.equalTo(_limitUseTimeLabel);
                if (index == marksNum - 1 ) {
                    make.bottom.equalTo(-CYTItemMarginV);
                }
            }];
        }else{
            UILabel *priorMarkLabel = self.couponMarkLabels[index-1];
            [markLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(priorMarkLabel.mas_bottom).offset(CYTAutoLayoutV(10));
                make.left.right.equalTo(_limitUseTimeLabel);
                if (index == marksNum - 1 ) {
                    make.bottom.equalTo(-CYTItemMarginV);
                }
            }];
        }
    }
}


@end
