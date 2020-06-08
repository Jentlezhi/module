//
//  CYTIDCardTextField.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/8/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTIDCardTextField.h"

@interface CYTIDCardTextField()<UITextFieldDelegate>

@end

@implementation CYTIDCardTextField

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self IDCardTextFieldBasicConfig];
    }
    return self;
}

- (void)IDCardTextFieldBasicConfig{
    self.delegate = self;
    self.keyboardType = UIKeyboardTypeASCIICapable;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789xX"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    if ([string isEqualToString:filtered]) {
        return YES;
    }else{
        return NO;
    }
}


@end
