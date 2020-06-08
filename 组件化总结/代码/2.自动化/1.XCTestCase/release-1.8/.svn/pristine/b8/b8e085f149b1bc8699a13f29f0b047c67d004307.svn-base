//
//  CYTBasicTableViewCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicTableViewCell.h"

CYTBasicTableViewCell *cell;

@implementation CYTBasicTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self basicTableViewCellBasicConfig];
        [self initSubComponents];
        [self makeSubConstrains];
    }
    return self;
}

/**
 *  基本配置
 */
- (void)basicTableViewCellBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

+ (instancetype)celllForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    NSString *identifier = NSStringFromClass([self class]);
    Class c = NSClassFromString(identifier);
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[c alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)initSubComponents{
    
}

/**
 *  布局子控件
 */
- (void)makeSubConstrains{
    
}

@end
