//
//  CYTPersonalCertificateViewModel.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPersonalCertificateViewModel.h"
#import "CYTPersonalCertificateModel.h"

@implementation CYTPersonalCertificateViewModel
{
    CYTPersonalCertificateModel *_personalCertificateModel;
    
}

- (CYTPersonalCertificateModel *)personalCertificateModel{
    if (!_personalCertificateModel) {
        _personalCertificateModel = [[CYTPersonalCertificateModel alloc] init];
    }
    return _personalCertificateModel;
}

/**
 *  初始化方法
 *
 *  @return self
 */
- (instancetype)init{
    if (self = [super init]) {
        [self personalCertificateBasicConfig];
    }
    return self;
}
/**
 * 基本配置
 */
- (void)personalCertificateBasicConfig{
    //下一步按钮是否可点击
    _netStepEnableSiganl = [RACSignal combineLatest:@[RACObserve(self, name),RACObserve(self, idCardNum)] reduce:^id(NSString *nameString,NSString *idCardNumString){
        return @(nameString.length && idCardNumString.length);
    }];
    
    //下一步按钮的点击事件
    _netStepCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSString *nameStr = _name;
                NSString *idCardNumStr = _idCardNum;
                if (_name.length>CYTNameLengthMax) {
                    nameStr = [_name substringToIndex:CYTNameLengthMax];
                }
                
                if (_idCardNum.length>CYTIdCardLengthMax) {
                    idCardNumStr = [_idCardNum substringToIndex:CYTIdCardLengthMax];
                }
            /*认证结果 备注：-2：认证被驳回；0：初始化（未填写认证信息）；1：已填写/提交认证信息；2：认证审核通过*/
            NSInteger authStatus = [CYTAccountManager sharedAccountManager].authStatus;
            if (authStatus == 0) {//首次注册或未填写认证信息
                //校验
                if (nameStr.length == 0) {
                    [CYTToast errorToastWithMessage:CYTNameNil];
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                }else if (![CYTCommonTool isChinese:nameStr]){
                    [CYTToast errorToastWithMessage:CYTNameOnlyChinese];
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                }else if (![CYTCommonTool validateRealName:nameStr]) {
                    [CYTToast errorToastWithMessage:CYTNameError];
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                }else if (![CYTCommonTool validateIDCardNumber:idCardNumStr]){
                    [CYTToast errorToastWithMessage:CYTIdCardError];
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                }else if (!self.certificatePhotos){
                    [CYTToast errorToastWithMessage:CYTIdCardFrontError];
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                }else if ([[self.certificatePhotos firstObject] isKindOfClass:[NSString class]] && [[self.certificatePhotos firstObject] isEqualToString:@""]){
                    [CYTToast errorToastWithMessage:CYTIdCardFrontError];
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                }else if ([self.certificatePhotos[1] isKindOfClass:[NSString class]] && [self.certificatePhotos[1] isEqualToString:@""]){
                    [CYTToast errorToastWithMessage:CYTIdCardBackError];
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                }else if ([[self.certificatePhotos lastObject] isKindOfClass:[NSString class]] && [[self.certificatePhotos lastObject] isEqualToString:@""]){
                    [CYTToast errorToastWithMessage:CYTIdCardFrontWithHandError];
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                }else{
                    [self defaultParWithNameStr:nameStr idCard:idCardNumStr];
                    [subscriber sendNext:self.personalCertificateModel];
                    [subscriber sendCompleted];
                }
            }else if ([CYTAccountManager sharedAccountManager].authStatus != 0){//已经提交
                [self defaultParWithNameStr:nameStr idCard:idCardNumStr];
                [subscriber sendNext:self.personalCertificateModel];
                [subscriber sendCompleted];
            }
            
            return nil;
        }];
        
    }];
}

/**
 * 参数
 */
- (void)defaultParWithNameStr:(NSString *)nameStr  idCard:(NSString *)idCardNumStr {
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
    [CYTLoadingView hideLoadingViewWithDuration:0.2f];
    CYTAppManager *appManager = [CYTAppManager sharedAppManager];
    appManager.UserName = nameStr;
    appManager.IDCard = idCardNumStr;
    self.personalCertificateModel.UserName = nameStr;
    self.personalCertificateModel.IDCard = idCardNumStr;
    self.personalCertificateModel.FrontIDCardOriginalPic = appManager.FrontIDCardOriginalPic;
    self.personalCertificateModel.OppositeIDCardOriginalPic = appManager.OppositeIDCardOriginalPic;
    self.personalCertificateModel.HoldIDCardOriginalPic = appManager.HoldIDCardOriginalPic;
}

@end
