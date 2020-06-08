//
//  SeekCarDetailCarTitleCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "SeekCarDetailCarTitleCell.h"
#import "CYTSeekCarDetailModel.h"

@interface SeekCarDetailCarTitleCell()


@end


@implementation SeekCarDetailCarTitleCell
{
    //分割条
    UIView *_topBar;
    //车款标题
    UILabel *_carTitleLabel;
    //国产/合资车
    UILabel *_carTypeLabel;
    //过期图片
    UIImageView *_expiredImageView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self seekCarDetailCarInfoBasicConfig];
        [self initSeekCarDetailCarInfoComponents];
        [self makeConstrains];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)seekCarDetailCarInfoBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
/**
 *  初始化子控件
 */
- (void)initSeekCarDetailCarInfoComponents{
    //分割条
    UIView *topBar = [[UIView alloc] init];
    topBar.backgroundColor = kFFColor_bg_nor;
    [self.contentView addSubview:topBar];
    _topBar = topBar;
    //车款标题
    UILabel *carTitleLabel = [UILabel labelWithTextColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:30.f setContentPriority:NO];
    carTitleLabel.numberOfLines = 0;
    [self.contentView addSubview:carTitleLabel];
    _carTitleLabel = carTitleLabel;
    
    //国产/合资车
    UILabel *carTypeLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    [self.contentView addSubview:carTypeLabel];
    _carTypeLabel = carTypeLabel;
    
    //过期图片
    UIImageView *expiredImageView = [UIImageView ff_imageViewWithImageName:@"logistics_need_expired"];
    expiredImageView.hidden = YES;
    [self.contentView addSubview:expiredImageView];
    _expiredImageView = expiredImageView;
    
    //测试数据
//    carTitleLabel.text = @"东风悦达起亚 智跑 16款 2.0L 自动 两驱GL";
//    carTypeLabel.text = @"国产/合资车";
    
}
/**
 *  布局控件
 */
- (void)makeConstrains{
    //布局间隔条
    [_topBar makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(CYTAutoLayoutV(20));
    }];
    //车款标题
    [_carTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.top.equalTo(_topBar.mas_bottom).offset(CYTMarginV);
    }];
    //国产/合资车
    [_carTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(_carTitleLabel.mas_bottom).offset(CYTItemMarginV);
        make.bottom.equalTo(-CYTItemMarginV);
    }];
    
    [_expiredImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-CYTMarginH);
        make.centerY.equalTo(self.contentView).offset(CYTAutoLayoutV(10));
    }];
}

+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"SeekCarDetailCarTitleCell";
    SeekCarDetailCarTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[SeekCarDetailCarTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
/**
 *  需求详情 模型传入
 */
- (void)setSeekCarDetailModel:(CYTSeekCarDetailModel *)seekCarDetailModel{
    if (!seekCarDetailModel) return;
    _seekCarDetailModel = seekCarDetailModel;
    _carTitleLabel.text = seekCarDetailModel.seekCarInfo.fullCarName;
    _carTypeLabel.text = seekCarDetailModel.seekCarInfo.carSourceTypeName;
    _expiredImageView.hidden = [seekCarDetailModel.seekCarInfo.seekCarStatus integerValue] != 0;
}


@end
