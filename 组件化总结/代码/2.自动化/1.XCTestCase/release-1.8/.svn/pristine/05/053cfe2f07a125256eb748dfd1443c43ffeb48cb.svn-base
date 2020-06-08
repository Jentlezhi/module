//
//  CYTProtocolView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/8/31.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTProtocolView.h"
#import "TTTAttributedLabel.h"

static NSString *const selectIcon   = @"user_authenticated";
static NSString *const unSelectIcon = @"m_seleectable_";
static CGFloat   const edgeInset = 15.f;

@interface CYTProtocolView()<TTTAttributedLabelDelegate>

/** 内容 */
@property(copy, nonatomic) NSString *content;

@end

@implementation CYTProtocolView
{
    //按钮
    UIButton *_protocalBtn;
    //内容
    TTTAttributedLabel *_protocolLabel;
}

- (instancetype)initWithContent:(NSString *)content link:(NSString *)link{
    if (self = [super init]) {
        [self protocolViewBasicConfig];
        [self initProtocolViewComponentsWithContent:content link:link];
        [self makeConstrains];
    }
    return  self;
}

/**
 *  基本配置
 */
- (void)protocolViewBasicConfig{
    self.backgroundColor = [UIColor redColor];
}
/**
 *  初始化子控件
 */
- (void)initProtocolViewComponentsWithContent:(NSString *)content link:(NSString *)link{
    self.content = content;
    //按钮
    UIButton *protocalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    protocalBtn.adjustsImageWhenHighlighted = NO;
    CGFloat margin = CYTAutoLayoutV(edgeInset);
    protocalBtn.contentEdgeInsets = UIEdgeInsetsMake(margin, margin, margin, margin);
    [protocalBtn setImage:[UIImage imageNamed:selectIcon] forState:UIControlStateNormal];
    [protocalBtn setImage:[UIImage imageNamed:unSelectIcon] forState:UIControlStateSelected];
    CYTWeakSelf
    [[protocalBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (protocalBtn.isSelected) {
            protocalBtn.selected = NO;
            !weakSelf.aggreeProtocol?:weakSelf.aggreeProtocol(YES);
        }else{
            protocalBtn.selected = YES;
            !weakSelf.aggreeProtocol?:weakSelf.aggreeProtocol(NO);
        }
    }];
    [self addSubview:protocalBtn];
    _protocalBtn = protocalBtn;
    
    //内容
    TTTAttributedLabel *protocolLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    protocolLabel.delegate = self;
    protocolLabel.textColor = CYTHexColor(@"#3333333");
    protocolLabel.font = CYTFontWithPixel(22);
    protocolLabel.numberOfLines = 0;
    protocolLabel.text = content;
    NSString *keyword = link;
    protocolLabel.activeLinkAttributes = [NSDictionary dictionaryWithObject:CYTGreenNormalColor forKey:(NSString *)kCTForegroundColorAttributeName];
    [protocolLabel setText:content afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString){
        NSRange boldRange = [[mutableAttributedString string] rangeOfString:keyword options:NSCaseInsensitiveSearch];
        UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:CYTAutoLayoutV(24)];
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
        if (font) {
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:boldRange];
            [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[CYTGreenNormalColor CGColor] range:boldRange];
            CFRelease(font);
        }
        return mutableAttributedString;
    }];
    NSMutableDictionary *linkAttributes = [NSMutableDictionary dictionary];
    [linkAttributes setValue:[NSNumber numberWithBool:NO] forKey:(NSString *)kCTUnderlineStyleAttributeName];
    [linkAttributes setValue:(__bridge id)CYTGreenNormalColor.CGColor forKey:(NSString *)kCTForegroundColorAttributeName];
    protocolLabel.linkAttributes = linkAttributes;
    NSRange linkRange = [content rangeOfString:keyword];
    NSURL *url = [NSURL URLWithString:@""];
    [protocolLabel addLinkToURL:url withRange:linkRange];
    
    [self addSubview:protocolLabel];
    _protocolLabel = protocolLabel;
    
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    [_protocalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTAutoLayoutV(15.f));
        make.width.height.equalTo(CYTAutoLayoutV(60));
        make.centerY.equalTo(_protocolLabel);
    }];
    
    [_protocolLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_protocalBtn.mas_right);
        make.top.equalTo(CYTAutoLayoutV(44));
        make.right.equalTo(-CYTMarginH);
        make.bottom.equalTo(-CYTMarginV);
    }];
}

#pragma mark - <TTTAttributedLabelDelegate>

- (void)attributedLabel:(__unused TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url{
    !self.protocolClick?:self.protocolClick();
}

- (CGFloat)height{
    CGFloat margin = CYTAutoLayoutV(edgeInset-2);
    return [self.content sizeWithFont:_protocolLabel.font maxSize:CGSizeMake(kScreenWidth - CYTAutoLayoutV(60) - 2*CYTMarginH, CGFLOAT_MAX)].height + margin + 2*CYTMarginV;
}

@end
