//___FILEHEADER___

#import "___FILEBASENAME___.h"

@interface ___FILEBASENAMEASIDENTIFIER___ ()

@end

@implementation ___FILEBASENAMEASIDENTIFIER___

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark- flow control
///cell加载子视图
- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[];
    block(views,^{
        
    });
}

///cell布局
- (void)updateConstraints {
    [super updateConstraints];
}

///自定义cell样式
- (void)setFfCustomizeCellModel:(FFExtendTableViewCellModel *)ffCustomizeCellModel {
    
}

#pragma mark- api

#pragma mark- method

#pragma mark- set
///cell赋值
- (void)setFfModel:(id)ffModel {
    
}

#pragma mark- get



@end
