//
//  CYTCommonTool.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/2.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TTTAttributedLabel;

@interface CYTCommonTool : NSObject
/**
 *  手机号校验
 *
 *  @param inputNum 输入
 *
 *  @return 是否为手机号
 */
+ (BOOL)isPhoneNumber:(NSString *)inputNum;
/**
 *  密码验证
 *
 *  @param inputNum 输入
 *
 *  @return 是否为密码
 */
+ (BOOL)isPassWord:(NSString *)inputNum;
/**
 *  中文验证
 *
 *  @param content 输入
 *
 *  @return 是否为中文
 */
+ (BOOL)isChinese:(NSString *)content;
/**
 *  是否为空
 */
+ (BOOL)isEmpty:(NSString *)content;
/**
 *  二次确认弹框
 *
 *  @param viewController 控制器
 *  @param title          标题
 *  @param message        信息
 *  @param confiemAction  确认响应事件
 *  @param cancelAction   取消响应事件
 */
+ (void)addSecConfirmAlertWithController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message confiemAction:(void(^)(UIAlertAction *action))confiemAction cancelAction:(void(^)(UIAlertAction *action))cancelAction;
/**
 *  二次确认弹框
 *
 *  @param viewController 控制器
 *  @param title          标题
 *  @param message        信息
 *  @param confiemAction  确认响应事件
 */
+ (void)addSecConfirmAlertWithController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message confiemAction:(void(^)(UIAlertAction *action))confiemAction;

+ (void)addSecConfirmAlertSignalBtnWithController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message confiemAction:(void(^)(UIAlertAction *action))confiemAction;

+ (void)attributeWithLabel:(TTTAttributedLabel *)aLabel keyWord:(NSString *)keyWord keyWordFontSize:(CGFloat)aSize keyWordColor:(UIColor *)aColor linkUrlStr:(NSString *)urlStr;

/**
 *  获取系统版本号String
 */
+ (NSString *)getIOSVersion;
/**
 *  获取系统版本号NSDecimalNumber
 */
+ (NSDecimalNumber * )deviceVersion;
/**
 *  偏好设置保存数据
 */
+ (void)setValue:(id)value forKey:(NSString *)key;
/**
 *  偏好设置取值
 */
+ (id)valueForKey:(NSString *)key;
/**
 *  移除偏好设置数据
 */
+ (void)removeValueForKey:(NSString *)key;
/**
 *  校验身份证合法性
 */
+ (BOOL)validateIDCardNumber:(NSString *)value;
/**
 *  校验姓名的合法性
 */
+ (BOOL)validateRealName:(NSString *)realName;
/**
 *  字典转json字符串
 */
+ (NSString *)jsonStringWithDict:(NSDictionary *)jsonDict;
/**
 *  数组转json字符串
 */
+ (NSString *)jsonStringWithArray:(NSArray *)jsonArray;
/**
 *  拨打电话
 */
+ (void)callPhoneWithNum:(NSString *)phoneNum;
/**
 *  获取当前控制器
 */
+ (UIViewController *)currentViewController;
/**
 *  获取当前控制器view
 */
+ (UIView *)currentControllerView;
/**
 *  当前设备
 */
+ (NSString *)devicePlatform;
/**
 *  是否为图片
 */
+ (BOOL)isImageWithData:(NSData *)data;
/**
 *  罗马数字转中文
 */
+ (NSString *)translationArabicNumerWithNum:(NSUInteger)num;

@end
