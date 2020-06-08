//
//  CYTVouchersCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTVouchersCell.h"
#import "CYTImageCollectionView.h"

@interface CYTVouchersCell()

/** 图片添加视图 */
@property(weak, nonatomic) CYTImageCollectionView *imageCollectionView;

@end

@implementation CYTVouchersCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self vouchersCelllBasicConfig];
        [self initVouchersCellComponents];
        [self makeConstrains];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)vouchersCelllBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.height = _imageCollectionView.collectionViewHeight;
    self.contentView.height = _imageCollectionView.collectionViewHeight;
}

/**
 *  初始化子控件
 */
- (void)initVouchersCellComponents{
    CYTWeakSelf
    CYTImageCollectionView *imageCollectionView = [[CYTImageCollectionView alloc] init];
    imageCollectionView.selectedMaxNum = 9;
    imageCollectionView.reLayout = ^{
        weakSelf.height = weakSelf.imageCollectionView.collectionViewHeight;
        [UIView animateWithDuration:kAnimationDurationInterval animations:^{
            [weakSelf layoutIfNeeded];
            !weakSelf.reSetcontentInset?:weakSelf.reSetcontentInset(weakSelf.imageCollectionView.layoutHeight);
        }];
    };
    [self.contentView addSubview:imageCollectionView];
    _imageCollectionView = imageCollectionView;
}

#pragma mark - 属性配置

- (NSMutableArray<CYTSelectImageModel *> *)selectedImageModels{
    return self.imageCollectionView.selectedImageModels;
}

- (CGFloat)vouchersCellHeight{
    return self.imageCollectionView.collectionViewHeight;
}

/**
 *  布局子控件
 */
- (void)makeConstrains{
    [_imageCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
        make.height.equalTo(_imageCollectionView.collectionViewHeight).priorityMedium();
    }];
}
+ (instancetype)vouchersCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTVouchersCell";
    CYTVouchersCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTVouchersCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

@end
