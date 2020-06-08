//
//  CYTPersonalCertificateView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTIdPhotoModel;

@class CYTPersonalCertificateModel;

@interface CYTPersonalCertificateView : UIView
/** 调起键盘 */
@property(assign, nonatomic) BOOL showKeyboard;
/** 身份证正面回调 */
@property(copy, nonatomic) void(^identityCardFront)();

/** 身份反面回调 */
@property(copy, nonatomic) void(^identityCardBack)();

/** 手持身份正面回调 */
@property(copy, nonatomic) void(^identityCardWithHand)();

/** 下一步按钮 */
@property(copy, nonatomic) void(^personalCertificateNextStep)(CYTPersonalCertificateModel *,NSUInteger,NSMutableAttributedString *);

/** 图片的选择 */
@property(strong, nonatomic) CYTIdPhotoModel *photoModel;

@end
