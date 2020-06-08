//
//  FFCell_Style_SimpleChoose.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/4/21.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFCell_Style_SimpleChoose.h"

@implementation FFCell_Style_SimpleChoose

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
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.cellView];
        
        [self.cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

#pragma mark- get
- (FFCellView_Sytle_SimpleChoose *)cellView {
    if (!_cellView) {
        _cellView = [FFCellView_Sytle_SimpleChoose new];
    }
    return _cellView;
}

@end
