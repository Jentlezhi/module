//
//  CYTManageBrandCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTManageBrandCell.h"
#import "CYTManageBrandModel.h"

@interface CYTManageBrandCell()

/** 选中标识 */
@property(weak, nonatomic) UIImageView *selectIcon;
/** 未选中标识 */
@property(weak, nonatomic) UIImageView *unselectIcon;
/** 公司类型 */
@property(weak, nonatomic) UILabel *companyBrandLabel;

@end

@implementation CYTManageBrandCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self manageBrandCellBasicConfig];
        [self initManageBrandCellComponents];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)manageBrandCellBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

/**
 *  初始化子控件
 */
- (void)initManageBrandCellComponents{
    //选中标识
    UIImageView *selectIcon = [[UIImageView alloc] init];
    selectIcon.image = [UIImage imageNamed:@"selected"];
    [self.contentView addSubview:selectIcon];
    _selectIcon = selectIcon;
    [selectIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(CYTMarginH);
        make.centerY.equalTo(self.contentView);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(40), CYTAutoLayoutV(40)));
    }];
    //未选中标识
    UIImageView *unselectIcon = [[UIImageView alloc] init];
    unselectIcon.image = [UIImage imageNamed:@"unselected"];
    [self.contentView addSubview:unselectIcon];
    _unselectIcon = unselectIcon;
    [unselectIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(CYTMarginH);
        make.centerY.equalTo(self.contentView);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(40), CYTAutoLayoutV(40)));
    }];
    //类型
    UILabel *companyBrandLabel = [[UILabel alloc] init];
    companyBrandLabel.textAlignment = NSTextAlignmentLeft;
    companyBrandLabel.font = CYTFontWithPixel(30);
    companyBrandLabel.textColor = [UIColor colorWithHexColor:@"#333333"];
    [self.contentView addSubview:companyBrandLabel];
    _companyBrandLabel = companyBrandLabel;
    [companyBrandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(selectIcon.mas_right).offset(CYTMarginH);
        make.centerY.equalTo(selectIcon);
        make.right.equalTo(self.contentView).offset(-CYTMarginH);
        make.height.equalTo(CYTAutoLayoutV(34));
    }];
    
    //分割线
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self.contentView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTMarginH);
        make.right.equalTo(self).offset(-CYTMarginH);
        make.bottom.equalTo(self);
        make.height.equalTo(CYTDividerLineWH);
    }];
}
- (void)setCellSelected:(BOOL)cellSelected{
    _cellSelected = cellSelected;
    _unselectIcon.hidden = cellSelected;
    _selectIcon.hidden = !cellSelected;
}

+ (instancetype)manageBrandCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTManageBrandCell";
    CYTManageBrandCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTManageBrandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setManageBrandModel:(CYTManageBrandModel *)manageBrandModel{
    _manageBrandModel = manageBrandModel;
    _companyBrandLabel.text = manageBrandModel.brandName;
}

@end
