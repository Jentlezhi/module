//
//  CYTImageListCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTImageListCell.h"
#import "CYTImageAssetManager.h"
#import "CYTAssetModel.h"

@interface CYTImageListCell()

/** 图片 */
@property(weak, nonatomic) UIImageView *coverImageView;
/** 相册名称 */
@property(weak, nonatomic) UILabel *albumNameLabel;
/** 相册图片个数 */
@property(weak, nonatomic) UILabel *albumTotalNumLabel;
/** 箭头 */
@property(weak, nonatomic) UIImageView *arrow;
/** 分割线 */
@property(weak, nonatomic) UILabel *lineLabel;
/** 图片资源管理 */
@property(strong, nonatomic) CYTImageAssetManager *imageAssetManager;

@end

@implementation CYTImageListCell

#pragma mark - 基本设置

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self imageListCellBasicConfig];
        [self initImageListCellComponents];
        [self makeConstrains];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)imageListCellBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    UIView *selectedBackgroundView = [[UIView alloc] init];
    selectedBackgroundView.backgroundColor = CYTHexColor(@"#F5F5F5");
    self.selectedBackgroundView = selectedBackgroundView;
    self.clipsToBounds = YES;
}

/**
 *  初始化子控件
 */
- (void)initImageListCellComponents{
    //图片
    UIImageView *coverImageView = [[UIImageView alloc] init];
    coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    coverImageView.clipsToBounds = YES;
    [self.contentView addSubview:coverImageView];
    _coverImageView = coverImageView;
    
    //箭头
    UIImageView *arrow = [UIImageView imageViewWithImageName:@"arrow_right"];
    [self.contentView addSubview:arrow];
    _arrow = arrow;
    
    //相册名称
    UILabel *albumNameLabel = [UILabel labelWithTextColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    [self.contentView addSubview:albumNameLabel];
    _albumNameLabel = albumNameLabel;
    
    //相册图片数目
    UILabel *albumTotalNumLabel = [UILabel labelWithTextColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    [self.contentView addSubview:albumTotalNumLabel];
    _albumTotalNumLabel = albumTotalNumLabel;
    
    //分割线
    UILabel *lineLabel = [UILabel dividerLineLabel];
    [self.contentView addSubview:lineLabel];
    _lineLabel = lineLabel;
    
    //测试数据
//    _coverImageView.image = [UIImage imageWithColor:CYTGreenNormalColor];
//    _albumNameLabel.text = @"微博";
//    _albumTotalNumLabel.text = @"12张";
}
/**
 *  布局控件
 */
- (void)makeConstrains{
    [_coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(CYTItemMarginH);
        make.width.height.equalTo(CYTAutoLayoutV(130.f));
    }];
    
    [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(CYTAutoLayoutV(44.f));
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(-CYTItemMarginH);
    }];
    
    [_albumNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTAutoLayoutV(63.f));
        make.left.equalTo(_coverImageView.mas_right).offset(CYTItemMarginH);
        make.right.equalTo(_arrow.mas_right).offset(-CYTItemMarginH);
    }];
    
    [_albumTotalNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_albumNameLabel);
        make.top.equalTo(_albumNameLabel.mas_bottom).offset(CYTAutoLayoutV(23.f));
    }];
    
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTItemMarginH);
        make.right.equalTo(-CYTItemMarginH);
        make.bottom.equalTo(-CYTDividerLineWH);
        make.height.equalTo(CYTDividerLineWH);
    }];
}

+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTImageListCell";
    CYTImageListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTImageListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setAssetModel:(CYTAssetModel *)assetModel{
    _assetModel = assetModel;
    [self setValueWithAssetModel:assetModel];
}

- (void)setValueWithAssetModel:(CYTAssetModel *)assetModel{
    NSString *albumName = assetModel.albumsTitle.length?assetModel.albumsTitle:@"";
    _albumNameLabel.text = albumName;
    NSString *albumTotalNum = assetModel.albumTotalNum?[NSString stringWithFormat:@"%ld张",assetModel.albumTotalNum]:@"0张";
    _albumTotalNumLabel.text = albumTotalNum;
    
    self.imageAssetManager = [CYTImageAssetManager sharedAssetManager];
    [self.imageAssetManager fetchAlbumCoverImageWithAlbumModel:assetModel coverWidth:100.f completion:^(UIImage *image) {
        _coverImageView.image = image;
    }];
}


@end
