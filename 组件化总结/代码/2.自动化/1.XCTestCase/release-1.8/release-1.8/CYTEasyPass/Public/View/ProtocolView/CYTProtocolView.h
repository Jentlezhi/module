//
//  CYTProtocolView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/8/31.
//  Copyright © 2017年 EasyPass. All rights reserved.
//
/*
 CYTProtocolView *protocolView = [[CYTProtocolView alloc] initWithContent:@"已阅读并同意以下《车销通用户注册协议》，接受免除或限制责任、诉讼管辖约定，愿意创建车销通账户。" link:@"《车销通用户注册协议》"];
 protocolView.backgroundColor = CYTLightGrayColor;
 protocolView.aggreeProtocol = ^(BOOL aggree) {
 [CYTToast messageToastWithMessage:[NSString stringWithFormat:@"%@",aggree?@"同意":@"拒绝"]];
 };
 protocolView.protocolClick = ^{
 [CYTToast successToastWithMessage:@"点击了协议"];
 };
 protocolView.frame = CGRectMake(0, 0, kScreenWidth, protocolView.height);
 self.mainTableView.tableFooterView = protocolView;
 */

#import <UIKit/UIKit.h>

@interface CYTProtocolView : UIView

/** 是否同意协议的回调 */
@property(copy, nonatomic) void(^aggreeProtocol)(BOOL agree);
/** 点击协议的回调 */
@property(copy, nonatomic) void(^protocolClick)();

/** 高度 */
@property(assign, nonatomic) CGFloat height;

- (instancetype)initWithContent:(NSString *)content link:(NSString *)link;

@end
