//
//  CYTCertificationPreviewSectionHeader.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/4.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCertificationPreviewSectionHeader.h"

@interface CYTCertificationPreviewSectionHeader()

/** 分组标题 */
@property(weak, nonatomic) UILabel *sectionTitleLabel;

@end

@implementation CYTCertificationPreviewSectionHeader

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self certificationPreviewBasicConfig];
        [self initCertificationPreviewComponents];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)certificationPreviewBasicConfig{
    self.backgroundColor = CYTHexColor(@"#f6f6f6");
}

/**
 *  初始化子控件
 */
- (void)initCertificationPreviewComponents{
    
    //标题文字
    UILabel *sectionTitleLabel = [[UILabel alloc] init];
    sectionTitleLabel.textAlignment = NSTextAlignmentLeft;
    sectionTitleLabel.font = CYTFontWithPixel(26.f);
    sectionTitleLabel.textColor = [UIColor colorWithHexColor:@"#666666"];
    [self addSubview:sectionTitleLabel];
    _sectionTitleLabel = sectionTitleLabel;
    [sectionTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTAutoLayoutH(30.f));
        make.right.equalTo(-CYTAutoLayoutH(30.f));
        make.top.bottom.equalTo(self);
    }];
    
}

- (void)setTitle:(NSString *)title{
    _title = title;
    _sectionTitleLabel.text = title;
}


@end
