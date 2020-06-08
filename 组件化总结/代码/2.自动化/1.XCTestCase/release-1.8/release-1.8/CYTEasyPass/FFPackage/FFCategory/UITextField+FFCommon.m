//
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/11.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "UITextField+FFCommon.h"

static char cantPastKey;

@implementation UITextField (FFCommon)

#pragma mark- 禁止粘贴功能
- (BOOL)cantPast {
    NSNumber *cantPast =  objc_getAssociatedObject(self, &cantPastKey);
    return cantPast.boolValue;
}

- (void)setCantPast:(BOOL)cantPast {
    objc_setAssociatedObject(self, &cantPastKey, [NSNumber numberWithBool:cantPast], OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    // 禁用粘贴功能
    if (action == @selector(paste:))
        return !self.cantPast;
    
    // 禁用选择功能
    if (action == @selector(select:))
        return !self.cantPast;
    
    // 禁用全选功能
    if (action == @selector(selectAll:))
        return !self.cantPast;
    
    return [super canPerformAction:action withSender:sender];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    NSString *placeholderString = (self.placeholder)?self.placeholder:@"";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:placeholderString];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:placeholderColor
                        range:NSMakeRange(0, placeholder.length)];
    self.attributedPlaceholder = placeholder;
}

@end
