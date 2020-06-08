//
//  CYTCarSourceDetailCell_code.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/10.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSourceDetailCell_code.h"

@implementation CYTCarSourceDetailCell_code

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self.contentView addSubview:self.copyButton];
        [self.copyButton makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(-CYTMarginH);
            make.width.equalTo(CYTAutoLayoutH(80));
            make.height.equalTo(CYTAutoLayoutV(38));
        }];
        self.cellView.contentRightOffset = -CYTAutoLayoutH(130);
    }
    return self;
}

#pragma mark- get
- (UIButton *)copyButton {
    if (!_copyButton) {
        _copyButton = [UIButton buttonWithFontPxSize:24 textColor:kFFColor_title_L3 text:@"复制"];
        [_copyButton radius:1 borderWidth:0.5 borderColor:kFFColor_line];
        @weakify(self);
        [[_copyButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            !self.copyBlock?:self.copyBlock();
        }];
    }
    return _copyButton;
}

@end
