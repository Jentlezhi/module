//
//  CYTSelectImageTool.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/21.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@class CYTSelectImageModel;

@interface CYTSelectImageTool : UIView
/** 相册资源模型 */
@property(strong, nonatomic) NSMutableArray <CYTSelectImageModel *>*imageModels;
/** 图片间隔 */
@property(assign, nonatomic) CGFloat itemMargin;//默认15个pixel
/** 顶部间隔 */
@property(assign, nonatomic) CGFloat topBottomMargin;//默认30个pixel
/** 左右间隔 */
@property(assign, nonatomic) CGFloat leftRightMargin;//默认30个pixel
/** 每行显示个数 */
@property(assign, nonatomic) NSInteger eachLineNum;//默认3个
/** 可选最大图片个数 */
@property(assign, nonatomic) NSInteger selectedMaxNum;//默认9个
/** 添加操作 */
@property(copy, nonatomic) void(^addImageAction)();
/** 按钮是否可点击 */
@property(copy, nonatomic) void(^editAble)(BOOL editAble);
/** 删除完的回调 */
@property(copy, nonatomic) void(^deleteEmpty)();
/** 是否编辑模式 */
@property(assign, nonatomic,getter=isEditMode) BOOL editMode;
/** 完成 */
@property(copy, nonatomic) void(^completion)(NSMutableArray <CYTSelectImageModel *>*images);
/** 点击编辑按钮 */
@property(copy, nonatomic) void(^clickEditBtnBlock)();

@end
