//
//  CYTManageTypeCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTManageTypeCell.h"
#import "CYTManageTypeModel.h"

@interface CYTManageTypeCell()

/** 选中标识 */
@property(weak, nonatomic) UIImageView *selectIcon;
/** 未选中标识 */
@property(weak, nonatomic) UIImageView *unselectIcon;
/** 公司类型 */
@property(weak, nonatomic) UILabel *companyTypeLabel;

@end

@implementation CYTManageTypeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self manageTypeCellBasicConfig];
        [self initManageTypeCellComponents];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)manageTypeCellBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

/**
 *  初始化子控件
 */
- (void)initManageTypeCellComponents{
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
    UILabel *companyTypeLabel = [[UILabel alloc] init];
    companyTypeLabel.textAlignment = NSTextAlignmentLeft;
    companyTypeLabel.font = CYTFontWithPixel(30);
    companyTypeLabel.textColor = [UIColor colorWithHexColor:@"#333333"];
    [self.contentView addSubview:companyTypeLabel];
    _companyTypeLabel = companyTypeLabel;
    [companyTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    _selectIcon.hidden =!selected;
    _unselectIcon.hidden = selected;
}

+ (instancetype)manageTypeCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTManageTypeCell";
    CYTManageTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTManageTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setManageTypeModel:(CYTManageTypeModel *)manageTypeModel{
    _manageTypeModel = manageTypeModel;
    _companyTypeLabel.text = manageTypeModel.levelName;
}



@end
