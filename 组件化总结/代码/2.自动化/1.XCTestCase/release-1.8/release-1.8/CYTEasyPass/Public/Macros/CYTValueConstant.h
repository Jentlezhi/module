//
//  CYTValueConstant.h
//  CYTEasyPass
//
//  Created by Juniort on 2017/3/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

//设备唯一标识
#define CYTDeviceUUIDKey        @"CYTDeviceUUIDKey"
///客服电话
#define kServicePhoneNumer      @"4000-716-719"
#define kServicePhoneAlert      @"打电话给客服?"
#define kLogisticsPhoneNumber   @"13022841750"

//加密key
#define Token_Value             @"11111111"
//appScheme，支付宝使用，不要修改。
#define kAppScheme              @"CYTAppSchemeValue"
//应用内外跳转使用，APPdelegate handleURL使用
#define kappschemeSmall         @"cytappschemevalue"

#define kAnimationDurationInterval  (0.25)
#define kImageCompressedMaxSize     (500.f)
#define kDefaultPlaceholderImage    [UIImage imageNamed:@"carSource_carDefault"]
#define kPlaceholderImage           [UIImage imageNamed:@"img_picture_750x450_hl"]
#define kPlaceholderHeaderImage     [UIImage imageNamed:@"pic_user80x80_hl"]
#define CYTUserIdKey                 @"CYTUserIdKey"
#define CYTAuthorizationKey          @"CYTAuthorizationKey"
#define CYTAuthenticateResultKey     @"CYTAuthenticateResultKey"

#define CYTUserId                   (([CYTAccountManager sharedAccountManager].userKeyInfoModel.userId)?:@"")
///token
#define CYTAuthorization            CYTValueForKey(CYTAuthorizationKey)


#define UserDefaultGetValueForKey(key) \
[[NSUserDefaults standardUserDefaults] stringForKey:key];


//图片删除通知（addImageView使用）
#define CYTDeletePhotoAddImageViewKey   (@"CYTDeletePhotoAddImageViewKey")
//图片删除通知（外部使用）
#define CYTDeletePhontoKey        @"CYTDeletePhontoKey"
////认证状态
//#define CYTAuthenticateKey        @"CYTAuthenticateKey"
////认证状态描述
//#define CYTAuthenticateDecKey     @"CYTAuthenticateDecKey"
////认证ID
//#define CYTAuthenticateIDKey     @"CYTAuthenticateIDKey"
////实店认证
#define CYTIsStoreAuthKey        @"CYTIsStoreAuthKey"
//是否实店认证
#define CYTIsStoreAuth           CYTValueForKey(CYTIsStoreAuthKey)


/**
 *  手机号、验证码和密码等位数限制
 */
#define CYTAccountLengthMax 11
#define CYTPwdLengthMin 6
#define CYTPwdLengthMax 20
#define CYTCodeLengthMax 6
#define CYTSelectBrandMax 8
#define CYTNameLengthMax 100
#define CYTIdCardLengthMax 18
#define CYTCompanyNameLengthMax 100
#define CYTRegisterAddressMax 150
#define CYTCarVinLengthMax 17

/**
 *  校验提示
 */
#define CYTAccountError      @"请输入正确的手机号"
#define CYTPwdError          @"密码格式错误"
#define CYTPwdNil            @"请输入密码"
#define CYTTowPwdError       @"两次密码不一致"
#define CYTCodeError         @"验证码为6位"
#define CYTCodeNil           @"请输入验证码"
#define CYTSelectBrandMaxTip @"主营品牌最多可选8个"
#define CYTNetworkError      @"网络异常，请稍后重试！"
#define CYTNoNetwork         @"当前无网络，请检查网络设置。"
//个人认证
#define CYTNameError                 @"姓名格式有误"
#define CYTNameNil                   @"请输入姓名"
#define CYTNameOnlyChinese           @"只支持中文姓名"
#define CYTIdCardError               @"请输入正确的身份证号"
#define CYTIdCardFrontError          @"请选择身份证正面图片"
#define CYTIdCardBackError           @"请选择身份证反面图片"
#define CYTIdCardFrontWithHandError  @"请选择手持身份证正面图片"
#define CYTReUploadFrontIDImageTip   @"请重新上传身份证正面图片"
#define CYTReUploadBackIDImageTip    @"请重新上传身份证反面图片"
#define CYTReUploadHoldIDImageTip    @"请重新上传手持身份证正面图片"
#define CYTUploadImageError          @"图片上传失败，请重新上传！"
#define CYTUploadImageSuccess        @"图片上传成功"
//企业认证
#define CYTFillAddressTip             @"请填写详细地址"
#define CYTSelectRegisterAddressTip   @"请选择你的注册地址"
#define CYTSelectManageTypeTip        @"请选择你的公司类型"
#define CYTSelectManageBrandTip       @"请选择你的主营品牌"
#define CYTSelectBusinessLicenseTip   @"请选择营业执照图片"
//弹框
#define CYTCardViewCarSourceNeverShowKey  @"CYTCardViewCarSourceNeverShow"
#define CYTCardViewSeekCarNeverShowKey    @"CYTCardViewSeekCarNeverShow"
#define CYTCardViewLogisticCommentNeverShowKey    @"CYTCardViewLogisticCommentNeverShowKey"








