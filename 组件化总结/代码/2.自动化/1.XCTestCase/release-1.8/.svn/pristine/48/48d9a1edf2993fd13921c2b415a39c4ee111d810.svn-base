//
//  CYTOtherHeaderCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/8/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTOtherHeaderCell.h"
#import "CYTOtherHeaderView.h"

@implementation CYTOtherHeaderCell
{
    //其他用户信息
    CYTOtherHeaderView *_otherHeaderView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self otherHeaderCellBasicConfig];
        [self initOtherHeaderCellComponents];
        [self makeConstrains];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)otherHeaderCellBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
/**
 *  初始化子控件
 */
- (void)initOtherHeaderCellComponents{
    //其他用户信息
    CYTOtherHeaderView *otherHeaderView = [[CYTOtherHeaderView alloc] init];
    [self.contentView addSubview:otherHeaderView];
    _otherHeaderView = otherHeaderView;
}
/**
 *  布局控件
 */
- (void)makeConstrains{
    [_otherHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
}
+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTOtherHeaderCell";
    CYTOtherHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTOtherHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setCarSourceFindCarDealerModel:(CYTDealer *)carSourceFindCarDealerModel{
    if (!carSourceFindCarDealerModel)return;
    _carSourceFindCarDealerModel = carSourceFindCarDealerModel;
    _otherHeaderView.carSourceFindCarDealerModel = carSourceFindCarDealerModel;
}

@end
