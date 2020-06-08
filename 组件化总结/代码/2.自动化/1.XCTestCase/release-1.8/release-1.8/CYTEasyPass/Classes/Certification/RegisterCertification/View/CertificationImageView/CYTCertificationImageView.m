//
//  CYTCertificationImageView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/26.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCertificationImageView.h"

@implementation CYTCertificationImageView


- (void)setImage:(UIImage *)image{
    [super setImage:image];
    if (!image) return;
//    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        obj.hidden = YES;
//    }];
    //添加图片成功
    !self.imageAdd?:self.imageAdd(image,self.idType);
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        switch (self.idType) {
            case CYTIdTypeFront:
                !self.identityCardFront?:self.identityCardFront();
                break;
            case CYTIdTypeBack:
                !self.identityCardBack?:self.identityCardBack();
                break;
            case CYTIdTypeFrontWithHand:
                !self.identityCardWithHand?:self.identityCardWithHand();
                break;
            case CYTIdTypeBusLen:
                !self.addBusinessLicenseBack?:self.addBusinessLicenseBack();
                break;
            case CYTIdTypeShrom:
                !self.addShrowroomBack?:self.addShrowroomBack();
                break;

        }
    }];
    [self addGestureRecognizer:tap];
}


@end
