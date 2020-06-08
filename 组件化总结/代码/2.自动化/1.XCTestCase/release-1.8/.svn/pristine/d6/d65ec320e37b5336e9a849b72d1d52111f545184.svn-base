//
//  CYTLogisticsNeedWriteInputCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/22.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticsNeedWriteInputCell.h"

@implementation CYTLogisticsNeedWriteInputCell
@synthesize cellView = _cellView;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFfModel:(id)ffModel {
    self.model = ffModel;
}

- (void)setModel:(CYTLogisticsNeedWriteCellModel *)model {
    _model = model;
    
    self.cellView.flagLabel.text = model.title;
    if (self.ffCustomizeCellModel.ffIndexPath.row == 2) {
        NSString *priceS = @"总价";
        UIFont *font = self.cellView.flagLabel.font;
        NSRange range = [model.title rangeOfString:priceS];
        [self.cellView.flagLabel updateWithRange:range font:font color:CYTRedColor];
    }

    self.cellView.textFiled.placeholder = model.placeholder;
    self.cellView.textFiled.text = model.contentString;
    self.cellView.textFiled.placeholderColor = kFFColor_title_gray;
    self.cellView.textFiled.keyboardType = (self.ffCustomizeCellModel.ffIndexPath.row == 1)?UIKeyboardTypeNumberPad:UIKeyboardTypeDecimalPad;
    self.cellView.assistantLabel.text = model.subtitle;
    self.cellView.assistantLabel.hidden = NO;
    
    if (self.ffCustomizeCellModel.ffIndexPath.row == 1) {
        self.cellView.assistantLabel.textColor = kFFColor_title_L1;
    }else if (self.ffCustomizeCellModel.ffIndexPath.row == 2) {
        //价格
        self.cellView.assistantLabel.textColor = kFFColor_title_L1;
        NSRange range = [model.subtitle rangeOfString:@"万"];
        [self.cellView.assistantLabel updateWithRange:range font:CYTFontWithPixel(28) color:CYTRedColor];
        
        NSRange range2 = [model.title rangeOfString:@"单价"];
        [self.cellView.flagLabel updateWithRange:range2 font:CYTFontWithPixel(28) color:CYTRedColor];
    }else {
        //价格
        self.cellView.assistantLabel.hidden = (model.contentString.length==0);
        self.cellView.assistantLabel.textColor = kFFColor_title_L1;
        NSRange range = [model.subtitle rangeOfString:@"万"];
        [self.cellView.assistantLabel updateWithRange:range font:CYTFontWithPixel(28) color:CYTRedColor];
        
        NSRange range2 = [model.title rangeOfString:@"总价"];
        [self.cellView.flagLabel updateWithRange:range2 font:CYTFontWithPixel(28) color:CYTRedColor];
    }
}

- (void)setCallLogisticsService:(BOOL)callLogisticsService {
    _callLogisticsService = callLogisticsService;
    
    self.cellView.textFiled.textColor = (callLogisticsService)?kFFColor_title_gray:kFFColor_title_L2;
    BOOL cellEnable = NO;
    if (self.ffCustomizeCellModel.ffIndexPath.row!=3) {
        cellEnable = !callLogisticsService;
    }
    self.cellView.textFiled.userInteractionEnabled = cellEnable;
    
}

#pragma mark- get
- (FFCellView_Style_input *)cellView {
    if (!_cellView) {
        _cellView = [FFCellView_Style_input new];
        @weakify(self);
        [_cellView setTextBlock:^(NSString *text) {
            @strongify(self);
            
            if (self.ffCustomizeCellModel.ffIndexPath.row == 1) {
                //最大值99
                if (text.length>2) {
                    NSString *textString = [text substringToIndex:2];
                    self.cellView.textFiled.text = textString;
                    return ;
                }
                //不能为0
                if ([text isEqualToString:@"0"]) {
                    self.cellView.textFiled.text = @"";
                    return ;
                }
                
            }else if (self.ffCustomizeCellModel.ffIndexPath.row == 2) {
                //none
            }else {
                return;
            }
            
            if (self.textBlock) {
                self.textBlock(text);
            }
        }];
    }
    return _cellView;
}


@end
