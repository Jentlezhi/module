//
//  FFBaseTableViewCell.m
//  FFObjC
//
//  Created by xujunquan on 16/10/19.
//  Copyright © 2016年 org_ian. All rights reserved.
//

#import "FFBasicTableViewCell.h"

@interface FFBasicTableViewCell ()
///顶部line
@property (nonatomic, strong) FFExtendView *ffTopLine;
///底部line
@property (nonatomic, strong) FFExtendView *ffBottomLine;

@end

@implementation FFBasicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
#ifdef DEBUG
#ifdef kFFDebug
//        [self radius:8 borderWidth:0.5 borderColor:kFFDebugViewColor];
#endif
#endif
        _topLeftOffset = 0;
        _topRightOffset = 0;
        _topHeight = 0;
        _bottomLeftOffset = 0;
        _bottomRightOffset = 0;
        _bottomHeight = kFFLayout_line;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.ffTopLine];
        [self.contentView addSubview:self.ffBottomLine];
        [self.contentView addSubview:self.ffContentView];
        
        [self ffSubviewsAndConfig:^(NSArray *subviews, ffDefaultBlock config) {
            //添加子视图
            for (UIView *item in subviews) {
                [self.ffContentView addSubview:item];
            }
            //其他布局
            if (config) {
                config();
            }
        }];
    }
    return self;
}

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    block(nil,nil);
}

- (void)updateConstraints {
    [self.ffTopLine updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topLeftOffset);
        make.right.equalTo(self.topRightOffset);
        make.height.equalTo(self.topHeight).priorityHigh();
        make.top.equalTo(self.contentView);
    }];
    [self.ffBottomLine updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomLeftOffset);
        make.right.equalTo(self.bottomRightOffset);
        make.height.equalTo(self.bottomHeight).priorityHigh();
        make.bottom.equalTo(self.contentView);
    }];
    [self.ffContentView updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(self.topHeight, 0, self.bottomHeight, 0)).priority(1000);
    }];
    
    [super updateConstraints];
}

#pragma mark- set
- (void)setTopLeftOffset:(float)topLeftOffset {
    _topLeftOffset = topLeftOffset;
    [self setNeedsUpdateConstraints];
}

- (void)setTopRightOffset:(float)topRightOffset {
    _topRightOffset = topRightOffset;
    [self setNeedsUpdateConstraints];
}

- (void)setTopHeight:(float)topHeight {
    _topHeight = topHeight;
    [self setNeedsUpdateConstraints];
}

- (void)setBottomLeftOffset:(float)bottomLeftOffset {
    _bottomLeftOffset = bottomLeftOffset;
    [self setNeedsUpdateConstraints];
}

- (void)setBottomRightOffset:(float)bottomRightOffset {
    _bottomRightOffset = bottomRightOffset;
    [self setNeedsUpdateConstraints];
}

- (void)setBottomHeight:(float)bottomHeight {
    _bottomHeight = bottomHeight;
    [self setNeedsUpdateConstraints];
}

#pragma mark- color
- (void)setFfTopLineColor:(UIColor *)ffTopLineColor {
    _ffTopLineColor = ffTopLineColor;
    self.ffTopLine.backgroundColor = ffTopLineColor;
}

- (void)setFfBottomLineColor:(UIColor *)ffBottomLineColor {
    _ffBottomLineColor = ffBottomLineColor;
    self.ffBottomLine.backgroundColor = ffBottomLineColor;
}

#pragma mark- hide
- (void)setHideTopLine:(BOOL)hideTopLine {
    _hideTopLine = hideTopLine;
    self.ffTopLine.hidden = hideTopLine;
}

- (void)setHideBottomLine:(BOOL)hideBottomLine {
    _hideBottomLine = hideBottomLine;
    self.ffBottomLine.hidden = hideBottomLine;
}

#pragma mark- get
- (FFExtendView *)ffTopLine {
    if (!_ffTopLine) {
        _ffTopLine = [FFExtendView new];
        _ffTopLine.backgroundColor = kFFColor_line;
    }
    return _ffTopLine;
}

- (FFExtendView *)ffBottomLine {
    if (!_ffBottomLine) {
        _ffBottomLine = [FFExtendView new];
        _ffBottomLine.backgroundColor = kFFColor_line;
    }
    return _ffBottomLine;
}

- (FFExtendView *)ffContentView {
    if (!_ffContentView) {
        _ffContentView = [FFExtendView new];
    }
    return _ffContentView;
}


@end
