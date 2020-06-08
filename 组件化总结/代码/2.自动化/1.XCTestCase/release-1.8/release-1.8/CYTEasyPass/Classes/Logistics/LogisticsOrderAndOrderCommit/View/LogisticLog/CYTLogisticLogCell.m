//
//  CYTLogisticLogCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/22.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticLogCell.h"
#import "CYTLogisticLogModel.h"
#import "CYTLogisticTranOrderModel.h"

@implementation CYTLogisticLogCell
{
    //创建时间
    UILabel *_createTimeLabel;
    //状态
    UILabel *_statusDesLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self logisticLogCellBasicConfig];
        [self initLogisticLogCellComponents];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)logisticLogCellBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor clearColor];
}
/**
 *  初始化子控件
 */
- (void)initLogisticLogCellComponents{
    //创建时间
    UILabel *createTimeLabel = [UILabel labelWithText:@"" textColor:CYTHexColor(@"#999999") textAlignment:NSTextAlignmentLeft fontPixel:24.f setContentPriority:NO];
    [self.contentView addSubview:createTimeLabel];
//    [createTimeLabel setContentHuggingPriority:UILayoutPriorityRequired  forAxis:UILayoutConstraintAxisHorizontal];
    _createTimeLabel = createTimeLabel;
    
    //状态
    UILabel *statusDesLabel = [UILabel labelWithText:@"" textColor:CYTHexColor(@"#999999") textAlignment:NSTextAlignmentRight fontPixel:24.f setContentPriority:NO];
    statusDesLabel.numberOfLines = 0;
    [self.contentView addSubview:statusDesLabel];
    _statusDesLabel = statusDesLabel;
    
    
    //测试数据
//    _createTimeLabel.text = @"2015-12-15 12：48";
//    _statusDesLabel.text = @"上门取车费上门取车费上门取车费上门取车费上门取车费上门取车费上门取车费上门取车费上门取车费上门取车费上门取车费上门取车费上门取车费上门取车费上门取车费上门取车费";
    
}
/**
 *  布局控件
 */
- (void)makeConstrainsWithLogisticLogModel:(CYTLogisticLogModel *)logisticLogModel{
    CGFloat createTimeLabelH = _createTimeLabel.font.pointSize+2;
    [_createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTAutoLayoutV(15.f));
        make.left.equalTo(CYTMarginH);
        make.width.equalTo(createTimeLabelH*8);
        if (!logisticLogModel.statusText.length) {
            make.bottom.equalTo(self.contentView).offset(-CYTAutoLayoutV(15.f));
        }
    }];
    
    if (logisticLogModel.statusText.length && logisticLogModel.statusText){
        [_statusDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_createTimeLabel.mas_right).offset(CYTMarginH*0.5);
            make.right.offset(-CYTMarginH);
            make.top.equalTo(_createTimeLabel);
            make.bottom.equalTo(self.contentView).offset(-CYTAutoLayoutV(15.f));
        }];
    }
    

}
+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTLogisticLogCell";
    CYTLogisticLogCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTLogisticLogCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
/**
 * 物流订单详情 传入数据
 */
- (void)setLogisticLogModel:(CYTLogisticLogModel *)logisticLogModel{
    if (!logisticLogModel)return;
    _createTimeLabel.text = logisticLogModel.createOn;
    _statusDesLabel.text = logisticLogModel.statusText;
    //设置行间距
    NSAttributedString *aString = [NSAttributedString attributedWithLabel:_statusDesLabel lineSpacing:_statusDesLabel.font.pointSize*0.1];
    _statusDesLabel.attributedText = aString;
    _statusDesLabel.textAlignment = [self textAlignmentWithLabel:_statusDesLabel];
    
    //布局子控件
    [self makeConstrainsWithLogisticLogModel:logisticLogModel];
}
/**
 * 对齐方式
 */
- (NSTextAlignment)textAlignmentWithLabel:(UILabel *)label{
    CGFloat expCompanyMarkLabelH = [label.text sizeWithFont:label.font maxSize:CGSizeMake(kScreenWidth - 3*CYTMarginH - (_createTimeLabel.font.pointSize+2)*8, CGFLOAT_MAX)].height;
    if (expCompanyMarkLabelH>=label.font.pointSize*2) {
        return NSTextAlignmentLeft;
    }else{
        return NSTextAlignmentRight;
    }
}

@end
