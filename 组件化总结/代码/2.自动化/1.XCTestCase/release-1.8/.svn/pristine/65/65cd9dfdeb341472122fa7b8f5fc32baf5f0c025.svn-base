//
//  CYTCertificationImageView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/26.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYTCertificationImageView : UIImageView

/** 图片类型 */
@property(assign, nonatomic) CYTIdType idType;
/** 身份证正面回调 */
@property(copy, nonatomic) void(^identityCardFront)();

/** 身份反面回调 */
@property(copy, nonatomic) void(^identityCardBack)();

/** 手持身份正面回调 */
@property(copy, nonatomic) void(^identityCardWithHand)();

/** 添加营业执照回调 */
@property(copy, nonatomic) void(^addBusinessLicenseBack)();

/** 添加展厅照片回调 */
@property(copy, nonatomic) void(^addShrowroomBack)();

/** 图片已添加的回调 */
@property(copy, nonatomic) void(^imageAdd)(UIImage *,CYTIdType);

/** 图片是否上传成功 */
@property(assign, nonatomic,getter=isUploadSuccess) BOOL uploadSuccess;

@end
