//
//  JentleTestTwoViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

/*
 #import <FBRetainCycleDetector/FBRetainCycleDetector.h>
 //    FBRetainCycleDetector *detector = [FBRetainCycleDetector new];
 //    [detector addCandidate:self];
 //    NSSet *retainCycles = [detector findRetainCycles];
 //    CYTLog(@"%@", retainCycles);
 FBRetainCycleDetector *detector = [FBRetainCycleDetector new];
 [detector addCandidate:myObject];
 NSSet *retainCycles = [detector findRetainCyclesWithMaxCycleLength:100];
 */

#import "JentleTestViewController.h"
#import "CYTOrderCommitViewController.h"
#import "CYTOrderBottomInfoView.h"
#import "CYTOrderTopInfoView.h"
#import "CYTProtocolView.h"
#import "CYTOrderExtendViewController.h"
#import "CYTOrderDetailViewController.h"
#import "CYTConfirmSendCarViewController.h"
#import "CYTVehicleToolsViewController.h"
#import "CYTLoginViewController.h"
#import "CYTOrderDetailViewController.h"
#import "CYTOrderCommitViewController.h"
#import "CYTVoucherPictureView.h"
#import "CYTPersonalCertificateViewController.h"
#import "CYTOrderDetailViewController.h"
#import "CYTOrderExtendViewController.h"
#import "CYTConfirmSendCarViewController.h"
#import "CYTCompleteUserInfoViewController.h"
#import "CYTImagePickerNavController.h"
#import "CYTCarSourceAddImageViewController.h"
#import "CYTHomeViewController.h"
#import "CYTContactMeViewController.h"
#import "CYTContactMeViewController.h"
#import "CYTMyContactViewController.h"
#import "CYTMyYicheCoinViewController.h"
#import "CYTCoinCardView.h"
#import "CYTCoinSignResultModel.h"
#import "CYTGoodsExchangeView.h"
#import "CYTCoinGoodsModel.h"
#import "CYTGetCoinModel.h"
#import "CYTProfitLossDetailsViewController.h"
#import "CYTStoreCertificationViewController.h"
@interface JentleTestViewController ()

@end

@implementation JentleTestViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"JentleTest"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [CYTCoinCardView showSuccessWithType:CYTCoinCardTypeTaskSpecification model:nil];
//    return;
//    CYTCoinSignResultModel *model = CYTCoinSignResultModel.new;
//    model.continuousDays = 5;
//    model.isSignIn = NO;
//    model.preBaseCoins = @"2";
//    model.sufBaseConis = @"5";
//    model.baseDay = @"2";
//    [CYTCoinCardView showSuccessWithType:CYTCoinCardTypeExchangeSuccess model:model];
//    return;
    CYTH5WithInteractiveCtr *h5 = [[CYTH5WithInteractiveCtr alloc] init];
    h5.requestURL = @"https://baike.baidu.com/item/SWIFT/14080957?fr=aladdin";
    [self.navigationController pushViewController:h5 animated:YES];
    return;
    CYTMyYicheCoinViewController *newVC = [CYTMyYicheCoinViewController new];
    [self.navigationController pushViewController:newVC animated:YES];
}



@end
