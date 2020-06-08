//
//  CYTSeekCarDetailCarInfoCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTSeekCarDetailCarInfoCell.h"
#import "CYTOptionTagModel.h"

@interface CYTSeekCarDetailCarInfoCell()

/** 费用合计 */
@property(weak, nonatomic) UILabel *expenseTotalLabel;


@end


@implementation CYTSeekCarDetailCarInfoCell
{
    //分割线
    UILabel *_lineLabel;
    //车款标题
    UILabel *_titleLabel;
    //内容
    UILabel *_contentLabel;
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
    //分割线
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self.contentView addSubview:lineLabel];
    _lineLabel = lineLabel;
    
    //标题
    UILabel *titleLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:YES];
    [self.contentView addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    //内容
    UILabel *contentLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:NO];
    contentLabel.numberOfLines = 0;
    [self.contentView addSubview:contentLabel];
    _contentLabel = contentLabel;
    
//    //测试数据
//    titleLabel.text  = @"颜色";
//    contentLabel.text = @"金色/黑色";
    
}
/**
 *  布局控件
 */
- (void)makeConstrains{
    //分割线
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.top.equalTo(self.contentView);
        make.height.equalTo(CYTDividerLineWH);
    }];
    CGFloat marginTopBottom = CYTAutoLayoutV(25.f);
    //标题
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineLabel.mas_bottom).offset(CYTItemMarginV);
        make.left.equalTo(CYTMarginH);
    }];
    //内容
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_right);
        make.top.equalTo(_titleLabel);
        make.right.equalTo(-CYTMarginH);
        make.bottom.equalTo(-marginTopBottom);
    }];
}

+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTSeekCarDetailCarInfoCell";
    CYTSeekCarDetailCarInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTSeekCarDetailCarInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setOptionTagModel:(CYTOptionTagModel *)optionTagModel{
    if (!optionTagModel) return;
    _optionTagModel = optionTagModel;
    _titleLabel.text = [optionTagModel.tagTitle stringByAppendingString:@"："];
    NSString *contentStr = optionTagModel.content.length?optionTagModel.content:@"无";
    _contentLabel.text = contentStr;
}


@end
