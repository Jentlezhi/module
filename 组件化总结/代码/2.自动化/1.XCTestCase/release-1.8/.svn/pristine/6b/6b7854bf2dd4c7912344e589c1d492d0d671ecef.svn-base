//
//  CYTImagePickToolBarView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYTImagePickToolBarView : UIView

/** 最大选中个数 */
@property(assign, nonatomic) NSUInteger maxSelectNum;
/** 已选中个数 */
@property(assign, nonatomic) NSUInteger selectNum;
/** 预览是否可点击 */
@property(assign, nonatomic,getter=isPreviewBtnEnable) BOOL previewBtnEnable;
/** 完成是否可点击 */
@property(assign, nonatomic,getter=isCompleteBtnEnable) BOOL completeBtnEnable;
/** 预览 */
@property(copy, nonatomic) void(^previewAction)();
/** 完成 */
@property(copy, nonatomic) void(^completeAction)();
/** 双击手势 */
@property(copy, nonatomic) void(^doupleTapAction)();

@end
