//
//  CYTAddImageView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYTAddImageModel.h"
@class CYTImageFileModel;

@interface CYTAddImageView : UIView
/** 添加按钮的回调 */
@property(copy, nonatomic) void(^addBtnClickBack)();
/** 点击图片的回调 */
@property(copy, nonatomic) void(^imageViewClickBack)(NSMutableArray *,NSInteger);
///删除回调
@property (nonatomic, copy) void (^deleteBlock) (NSArray *);
/** 已选图片 */
@property(weak, nonatomic) UIImage *selectImage;
///urlmodel
@property (nonatomic, strong) CYTImageFileModel *selectImageModel;

///根据每行不同图片个数返回的每行的高度
@property (nonatomic, assign) float imageWH;
///初始化方法
- (instancetype)initWithModel:(CYTAddImageModel *)model;

///进入编辑模式
- (void)editMode:(BOOL)editing withAnimate:(BOOL)animate;
///确认删除操作
- (void)deleteActionAffirm;
///清空选中
- (void)cleanSelect;

@end
