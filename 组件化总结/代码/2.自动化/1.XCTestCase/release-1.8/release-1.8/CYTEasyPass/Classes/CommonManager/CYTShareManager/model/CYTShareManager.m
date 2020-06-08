//
//  CYTShareManager.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/31.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTShareManager.h"

@implementation CYTShareManager

+ (void)shareWithRequestModel:(CYTShareRequestModel *)requestModel {
    if (requestModel.type == ShareTypeId_applink) {
        //分享app，不需要登录
    }else {
        //分享车源和寻车，需要登录
        if (![CYTAuthManager manager].isLogin) {
            //弹出登录页面
            [[CYTAuthManager manager] goLoginView];
            return;
        }
    }
    
    if (requestModel.plant == SharePlant_link) {
        //复制链接，提示成功
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = kURL.kURL_shareLink;
        [CYTToast successToastWithMessage:@"已复制链接"];
    }else if (requestModel.plant == SharePlant_wx) {
        //微信好友
        [self requestShareContentWithModel:requestModel];
    }else if (requestModel.plant == SharePlant_friends) {
        //朋友圈
        [self requestShareContentWithModel:requestModel];
    }
}

///请求分项数据
+ (void)requestShareContentWithModel:(CYTShareRequestModel *)model {
    
    NSDictionary *parameters = @{@"id":@(model.idCode),
                                 @"type":@(model.type)};
    //根据参数请求分享数据
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeNotEditable];
    NSString *requestUrl = (model.type == ShareTypeId_applink)?kURL.user_share_app:kURL.user_share_car;
    
    [CYTNetworkManager GET:requestUrl parameters:parameters dataTask:nil showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
        [CYTLoadingView hideLoadingView];
        if (!responseObject.resultEffective) {
            [CYTToast messageToastWithMessage:responseObject.resultMessage];
        }
        
        if (responseObject.resultEffective) {
            //如果请求成功进行接口调用，分享到对应平台
            CYTShareResponseModel *shareModel = [CYTShareResponseModel mj_objectWithKeyValues:responseObject.dataDictionary];
            [self shareToPlantWithModel:model andShareModel:shareModel];
        }
    }];
}

///构建分享数据，并分享
+ (void)shareToPlantWithModel:(CYTShareRequestModel *)model andShareModel:(CYTShareResponseModel *)shareModel{
    //根据返回数据模型和相关参数，构建分享平台数据模型
    WXMediaMessage *message = [WXMediaMessage message];
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    //------
    req.type = model.type;
    
    //type:1.网页 2.文字 3.图片 4.语音 5.视频
    if (shareModel.type==ShareContentForm_netView || shareModel.type==0) {
        CYTShareResponseWebBeanModel *webBean = shareModel.webBean;
        message.title = webBean.title;
        message.description = webBean.webBeanDescription;
        
        NSData *imgData =[[NSData alloc]initWithBase64EncodedString:webBean.thumb options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage *image = [UIImage imageWithData:imgData];
        
        if (!image) {
            image = [UIImage imageNamed:@"iconDefault"];
        }
        [message setThumbImage:image];
        
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = webBean.url;
        message.mediaObject = ext;
        req.message = message;
        req.bText = NO;
    }else if (shareModel.type==ShareContentForm_text) {
        req.text = shareModel.shareText;
        req.bText = YES;
    }else if (shareModel.type==ShareContentForm_image) {
        
    }else if (shareModel.type==ShareContentForm_voice) {
        
    }else if (shareModel.type==ShareContentForm_video) {
        
    }


    //分享到平台
    if (model.plant == SharePlant_wx) {
        //发送到聊天界面
        req.scene = WXSceneSession;
    }else if (model.plant == SharePlant_friends) {
        //朋友圈
        req.scene = WXSceneTimeline;
    }
    
    [WXApi sendReq:req];
}

#pragma mark- 分享结果
+ (void)feedBackShareResultWithType:(ShareTypeId)type andBusinessId:(NSInteger)businessId{
    if (type==ShareTypeId_seekCar || type==ShareTypeId_carSource) {
        NSDictionary *parameters = @{@"businessId":@(businessId),
                                     @"businessType":@(type),
                                     };
        [CYTNetworkManager POST:kURL.user_share_setShareResult parameters:parameters dataTask:nil showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
            [CYTLoadingView hideLoadingView];
            //none
        }];
    }
}

@end
