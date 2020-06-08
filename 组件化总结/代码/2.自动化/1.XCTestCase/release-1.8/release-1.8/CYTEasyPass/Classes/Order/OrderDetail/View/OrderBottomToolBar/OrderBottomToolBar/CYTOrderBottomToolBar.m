//
//  CYTOrderBottomToolBar.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/20.
//  Copyright © 2017年 EasyPass. All rights reserved.
//


#import "CYTOrderBottomToolBar.h"
#import "CYTOrderItemButton.h"

@interface CYTOrderBottomToolBar()



/** 客服 */
@property(weak, nonatomic) UIView *onlyContactServer;
/** 联系对方 */
@property(weak, nonatomic) UIView *onlyContactContact;

/** 客服 */
@property(weak, nonatomic) UIView *cancelOrderServer;
/** 联系对方 */
@property(weak, nonatomic) UIView *cancelOrderContact;
/** 取消订单 */
@property(weak, nonatomic) UIView *cancelOrderCancel;

/** 客服 */
@property(weak, nonatomic) UIView *sendbackServer;
/** 申请订金退回 */
@property(weak, nonatomic) UIButton *sendbackSendback;
/** 付订金给卖家 */
@property(weak, nonatomic) UIButton *sendbackPayforSeller;

/** 客服 */
@property(weak, nonatomic) UIView *confirmAndPayServer;
/** 确认并退回订金给买家 */
@property(weak, nonatomic) UIButton *confirmAndPayPay;

/** 客服 */
@property(weak, nonatomic) UIView *commitServer;
/** 提交 */
@property(weak, nonatomic) UIButton *commitBtn;


/** 客服 */
@property(weak, nonatomic) UIView *gotoPayServer;
/** 联系对方 */
@property(weak, nonatomic) UIView *gotoPayContact;
/** 取消订单 */
@property(weak, nonatomic) UIView *gotoPayPay;

/** 客服 */
@property(weak, nonatomic) UIView *confirmSendCarServer;
/** 联系对方 */
@property(weak, nonatomic) UIView *confirmSendCarContact;
/** 取消订单 */
@property(weak, nonatomic) UIView *confirmSendCarSend;

/** 客服 */
@property(weak, nonatomic) UIView *confirmRecCarServer;
/** 联系对方 */
@property(weak, nonatomic) UIView *confirmRecCarContact;
/** 取消订单 */
@property(weak, nonatomic) UIView *confirmRecCarRec;

/** 客服 */
@property(weak, nonatomic) UIView *seeExpressServer;
/** 联系对方 */
@property(weak, nonatomic) UIView *seeExpressContact;
/** 取消订单 */
@property(weak, nonatomic) UIView *seeExpressExpress;

/** 客服 */
@property(weak, nonatomic) UIView *cancelAndConfServer;
/** 联系对方 */
@property(weak, nonatomic) UIView *cancelAndConfCancel;
/** 取消订单 */
@property(weak, nonatomic) UIView *cancelAndConfConf;


@end

@implementation CYTOrderBottomToolBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self orderBottomToolBarBasicConfig];
        [self initOrderBottomToolBarComponents];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)orderBottomToolBarBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}

/**
 *  初始化子控件
 */
- (void)initOrderBottomToolBarComponents{
    
}

+ (instancetype)orderDetailToolBarReturnButtonWithTitles:(NSArray <NSString *>*)titles  imageNames:(NSArray <NSString *>*)imageNames firstBtnClick:(void(^)(UIButton *firstBtn))firstBtnClick secondBtnClick:(void(^)(UIButton *secondBtn))secondBtnClick thirdBtnClick:(void(^)(UIButton *thirdBtn))thirdBtnClick fourthBtnClick:(void(^)(UIButton *fourthBtn))fourthBtnClick{
    CYTOrderBottomToolBar *orderBottomToolBar = [[CYTOrderBottomToolBar alloc] init];
    if (!titles || titles.count<2 || !imageNames)return nil;
    if (titles.count == 2) {//2个按钮情况
        NSString *title1 = [titles firstObject];
        NSString *title2 = [titles lastObject];
        NSString *imageName = [imageNames firstObject];
        CYTOrderItemButton *titleBtn1 = [CYTOrderItemButton buttonWithImageName:imageName title:title1 buttonClickWithBtn:^(CYTOrderItemButton *customButton) {
            !firstBtnClick?:firstBtnClick(customButton);
        }];
        [orderBottomToolBar addSubview:titleBtn1];
        [titleBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(224.f));
        }];
        
        UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [customBtn setTitle:title2 forState:UIControlStateNormal];
        [customBtn setTitleColor:CYTHexColor(@"#FFFFFF") forState:UIControlStateNormal];
        [customBtn setBackgroundImage:[UIImage imageWithColor:CYTGreenNormalColor] forState:UIControlStateNormal];
        customBtn.titleLabel.font = CYTFontWithPixel(32.f);
        [[customBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            !secondBtnClick?:secondBtnClick(customBtn);
        }];
        [orderBottomToolBar addSubview:customBtn];
        [customBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(orderBottomToolBar);
            make.left.equalTo(titleBtn1.mas_right);
        }];
    }else if (titles.count == 3){//3个按钮情况
        NSString *title1 = [titles firstObject];
        NSString *title2 = titles[1];
        NSString *title3 = [titles lastObject];
        NSString *imageName1 = [imageNames firstObject];
        NSString *imageName2;
        if (imageNames.count>1) {
            imageName2 = imageNames[1];
        }
        
        CYTOrderItemButton *titleBtn1 = [CYTOrderItemButton buttonWithImageName:imageName1 title:title1 buttonClickWithBtn:^(CYTOrderItemButton *customButton) {
            !firstBtnClick?:firstBtnClick(customButton);
        }];
        [orderBottomToolBar addSubview:titleBtn1];
        [titleBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(172.f));
        }];
        
        CGFloat customBtnW = CYTAutoLayoutH(172.f);
        if (imageName2) {
            CYTOrderItemButton *titleBtn2 = [CYTOrderItemButton buttonWithImageName:imageName2 title:title2 buttonClickWithBtn:^(CYTOrderItemButton *customButton) {
                !secondBtnClick?:secondBtnClick(customButton);
            }];
            [orderBottomToolBar addSubview:titleBtn2];
            [titleBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(orderBottomToolBar);
                make.left.equalTo(titleBtn1.mas_right);
                make.width.equalTo(customBtnW);
            }];
            
            UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [customBtn setTitle:title3 forState:UIControlStateNormal];
            [customBtn setTitleColor:CYTHexColor(@"#FFFFFF") forState:UIControlStateNormal];
            [customBtn setBackgroundImage:[UIImage imageWithColor:CYTGreenNormalColor] forState:UIControlStateNormal];
            customBtn.titleLabel.font = CYTFontWithPixel(32.f);
            [[customBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                !thirdBtnClick?:thirdBtnClick(customBtn);
            }];
            [orderBottomToolBar addSubview:customBtn];
            [customBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.right.bottom.equalTo(orderBottomToolBar);
                make.left.equalTo(titleBtn2.mas_right);
            }];
            
        }else{
            UILabel *lineLabel = [UILabel dividerLineLabel];
            [orderBottomToolBar addSubview:lineLabel];
            [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(titleBtn1.mas_right);
                make.top.bottom.equalTo(orderBottomToolBar);
                make.width.equalTo(CYTDividerLineWH);
            }];
            
            
            UIButton *customBtn0 = [UIButton buttonWithType:UIButtonTypeCustom];
            [customBtn0 setTitle:title2 forState:UIControlStateNormal];
            [customBtn0 setTitleColor:CYTGreenNormalColor forState:UIControlStateNormal];
            [customBtn0 setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            customBtn0.titleLabel.font = CYTFontWithPixel(32.f);
            [[customBtn0 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                !secondBtnClick?:secondBtnClick(customBtn0);
            }];
            [orderBottomToolBar addSubview:customBtn0];
            [customBtn0 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(orderBottomToolBar);
                make.left.equalTo(lineLabel.mas_right);
                make.width.equalTo((kScreenWidth - customBtnW)*0.5);
            }];
            
            UIButton *customBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
            [customBtn1 setTitle:title3 forState:UIControlStateNormal];
            [customBtn1 setTitleColor:CYTHexColor(@"#FFFFFF") forState:UIControlStateNormal];
            [customBtn1 setBackgroundImage:[UIImage imageWithColor:CYTGreenNormalColor] forState:UIControlStateNormal];
            customBtn1.titleLabel.font = CYTFontWithPixel(32.f);
            [[customBtn1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                !thirdBtnClick?:thirdBtnClick(customBtn1);
            }];
            [orderBottomToolBar addSubview:customBtn1];
            [customBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(orderBottomToolBar);
                make.left.equalTo(customBtn0.mas_right);
                make.right.equalTo(orderBottomToolBar);
            }];
        }
    }else if (titles.count == 4){
        NSString *title1 = [titles firstObject];
        NSString *title2 = titles[1];
        NSString *title3 = titles[2];
        NSString *title4 = [titles lastObject];
        NSString *imageName1 = [imageNames firstObject];
        NSString *imageName2 = imageNames[1];
        NSString *imageName3 = [imageNames lastObject];
        CYTOrderItemButton *titleBtn1 = [CYTOrderItemButton buttonWithImageName:imageName1 title:title1 buttonClickWithBtn:^(CYTOrderItemButton *customButton) {
            !firstBtnClick?:firstBtnClick(customButton);
        }];
        
        [orderBottomToolBar addSubview:titleBtn1];
        [titleBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(138.f));
        }];
        
        CYTOrderItemButton *titleBtn2 = [CYTOrderItemButton buttonWithImageName:imageName2 title:title2 buttonClickWithBtn:^(CYTOrderItemButton *customButton) {
            !secondBtnClick?:secondBtnClick(customButton);
        }];
        [orderBottomToolBar addSubview:titleBtn2];
        [titleBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(orderBottomToolBar);
            make.left.equalTo(titleBtn1.mas_right);
            make.width.equalTo(titleBtn1);
        }];
        
        CYTOrderItemButton *titleBtn3 = [CYTOrderItemButton buttonWithImageName:imageName3 title:title3 buttonClickWithBtn:^(CYTOrderItemButton *customButton) {
            !thirdBtnClick?:thirdBtnClick(customButton);
        }];

        [orderBottomToolBar addSubview:titleBtn3];
        [titleBtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(orderBottomToolBar);
            make.left.equalTo(titleBtn2.mas_right);
            make.width.equalTo(titleBtn2);
        }];
        
        UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [customBtn setTitle:title4 forState:UIControlStateNormal];
        [customBtn setTitleColor:CYTHexColor(@"#FFFFFF") forState:UIControlStateNormal];
        [customBtn setBackgroundImage:[UIImage imageWithColor:CYTGreenNormalColor] forState:UIControlStateNormal];
        customBtn.titleLabel.font = CYTFontWithPixel(32.f);
        [[customBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            !fourthBtnClick?:fourthBtnClick(customBtn);
        }];
        [orderBottomToolBar addSubview:customBtn];
        [customBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(orderBottomToolBar);
            make.left.equalTo(titleBtn3.mas_right);
        }];
    }
    
    UILabel *upLineLabel = [UILabel dividerLineLabel];
    [orderBottomToolBar addSubview:upLineLabel];
    [upLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(orderBottomToolBar);
        make.height.equalTo(CYTDividerLineWH);
    }];
    return orderBottomToolBar;
}

/**
 *  订单详情页面底部按钮（新）
 */
+ (instancetype)orderDetailToolBarWithTitles:(NSArray <NSString *>*)titles  imageNames:(NSArray <NSString *>*)imageNames firstBtnClick:(void(^)())firstBtnClick secondBtnClick:(void(^)())secondBtnClick thirdBtnClick:(void(^)())thirdBtnClick fourthBtnClick:(void(^)())fourthBtnClick{
    
    NSMutableArray *allButtons = [NSMutableArray array];
    
    CYTOrderBottomToolBar *orderBottomToolBar = [[CYTOrderBottomToolBar alloc] init];
    if (!titles || titles.count<2 || !imageNames)return nil;
    if (titles.count == 2) {//2个按钮情况
        NSString *title1 = [titles firstObject];
        NSString *title2 = [titles lastObject];
        NSString *imageName = [imageNames firstObject];
        CYTOrderItemButton *titleBtn1 = [CYTOrderItemButton buttonWithImageName:imageName title:title1 buttonClick:^{
            !firstBtnClick?:firstBtnClick();
        }];
        [orderBottomToolBar addSubview:titleBtn1];
        [titleBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(224.f));
        }];
        
        UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [customBtn setTitle:title2 forState:UIControlStateNormal];
        [customBtn setTitleColor:CYTHexColor(@"#FFFFFF") forState:UIControlStateNormal];
        [customBtn setBackgroundImage:[UIImage imageWithColor:CYTGreenNormalColor] forState:UIControlStateNormal];
        customBtn.titleLabel.font = CYTFontWithPixel(32.f);
        [[customBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            !secondBtnClick?:secondBtnClick();
        }];
        [orderBottomToolBar addSubview:customBtn];
        [customBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(orderBottomToolBar);
            make.left.equalTo(titleBtn1.mas_right);
        }];
        
        [allButtons addObject:titleBtn1];
        [allButtons addObject:customBtn];
    }else if (titles.count == 3){//3个按钮情况
        NSString *title1 = [titles firstObject];
        NSString *title2 = titles[1];
        NSString *title3 = [titles lastObject];
        NSString *imageName1 = [imageNames firstObject];
        NSString *imageName2;
        if (imageNames.count>1) {
            imageName2 = imageNames[1];
        }
        
        CYTOrderItemButton *titleBtn1 = [CYTOrderItemButton buttonWithImageName:imageName1 title:title1 buttonClick:^{
            !firstBtnClick?:firstBtnClick();
        }];
        [orderBottomToolBar addSubview:titleBtn1];
        [titleBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(172.f));
        }];
        
        [allButtons addObject:titleBtn1];
        
        CGFloat customBtnW = CYTAutoLayoutH(172.f);
        if (imageName2) {
            CYTOrderItemButton *titleBtn2 = [CYTOrderItemButton buttonWithImageName:imageName2 title:title2 buttonClick:^{
                !secondBtnClick?:secondBtnClick();
            }];
            [orderBottomToolBar addSubview:titleBtn2];
            [titleBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(orderBottomToolBar);
                make.left.equalTo(titleBtn1.mas_right);
                make.width.equalTo(customBtnW);
            }];
            
            UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [customBtn setTitle:title3 forState:UIControlStateNormal];
            [customBtn setTitleColor:CYTHexColor(@"#FFFFFF") forState:UIControlStateNormal];
            [customBtn setBackgroundImage:[UIImage imageWithColor:CYTGreenNormalColor] forState:UIControlStateNormal];
            customBtn.titleLabel.font = CYTFontWithPixel(32.f);
            [[customBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                !thirdBtnClick?:thirdBtnClick();
            }];
            [orderBottomToolBar addSubview:customBtn];
            [customBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.right.bottom.equalTo(orderBottomToolBar);
                make.left.equalTo(titleBtn2.mas_right);
            }];

            [allButtons addObject:titleBtn2];
            [allButtons addObject:customBtn];
        }else{
            UILabel *lineLabel = [UILabel dividerLineLabel];
            [orderBottomToolBar addSubview:lineLabel];
            [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(titleBtn1.mas_right);
                make.top.bottom.equalTo(orderBottomToolBar);
                make.width.equalTo(CYTDividerLineWH);
            }];
            
            
            UIButton *customBtn0 = [UIButton buttonWithType:UIButtonTypeCustom];
            [customBtn0 setTitle:title2 forState:UIControlStateNormal];
            [customBtn0 setTitleColor:CYTGreenNormalColor forState:UIControlStateNormal];
            [customBtn0 setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            customBtn0.titleLabel.font = CYTFontWithPixel(32.f);
            [[customBtn0 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                !secondBtnClick?:secondBtnClick();
            }];
            [orderBottomToolBar addSubview:customBtn0];
            [customBtn0 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(orderBottomToolBar);
                make.left.equalTo(lineLabel.mas_right);
                make.width.equalTo((kScreenWidth - customBtnW)*0.5);
            }];
            
            UIButton *customBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
            [customBtn1 setTitle:title3 forState:UIControlStateNormal];
            [customBtn1 setTitleColor:CYTHexColor(@"#FFFFFF") forState:UIControlStateNormal];
            [customBtn1 setBackgroundImage:[UIImage imageWithColor:CYTGreenNormalColor] forState:UIControlStateNormal];
            customBtn1.titleLabel.font = CYTFontWithPixel(32.f);
            [[customBtn1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                !thirdBtnClick?:thirdBtnClick();
            }];
            [orderBottomToolBar addSubview:customBtn1];
            [customBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(orderBottomToolBar);
                make.left.equalTo(customBtn0.mas_right);
                make.right.equalTo(orderBottomToolBar);
            }];
            
            [allButtons addObject:customBtn0];
            [allButtons addObject:customBtn1];
        }
        
    }else if (titles.count == 4){
        NSString *title1 = [titles firstObject];
        NSString *title2 = titles[1];
        NSString *title3 = titles[2];
        NSString *title4 = [titles lastObject];
        NSString *imageName1 = [imageNames firstObject];
        NSString *imageName2 = imageNames[1];
        NSString *imageName3 = [imageNames lastObject];
        CYTOrderItemButton *titleBtn1 = [CYTOrderItemButton buttonWithImageName:imageName1 title:title1 buttonClick:^{
            !firstBtnClick?:firstBtnClick();
        }];
        [orderBottomToolBar addSubview:titleBtn1];
        [titleBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(138.f));
        }];
        
        CYTOrderItemButton *titleBtn2 = [CYTOrderItemButton buttonWithImageName:imageName2 title:title2 buttonClick:^{
            !secondBtnClick?:secondBtnClick();
        }];
        [orderBottomToolBar addSubview:titleBtn2];
        [titleBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(orderBottomToolBar);
            make.left.equalTo(titleBtn1.mas_right);
            make.width.equalTo(titleBtn1);
        }];
        
        CYTOrderItemButton *titleBtn3 = [CYTOrderItemButton buttonWithImageName:imageName3 title:title3 buttonClick:^{
            !thirdBtnClick?:thirdBtnClick();
        }];
        [orderBottomToolBar addSubview:titleBtn3];
        [titleBtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(orderBottomToolBar);
            make.left.equalTo(titleBtn2.mas_right);
            make.width.equalTo(titleBtn2);
        }];
        
        UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [customBtn setTitle:title4 forState:UIControlStateNormal];
        [customBtn setTitleColor:CYTHexColor(@"#FFFFFF") forState:UIControlStateNormal];
        [customBtn setBackgroundImage:[UIImage imageWithColor:CYTGreenNormalColor] forState:UIControlStateNormal];
        customBtn.titleLabel.font = CYTFontWithPixel(32.f);
        [[customBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            !fourthBtnClick?:fourthBtnClick();
        }];
        [orderBottomToolBar addSubview:customBtn];
        [customBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(orderBottomToolBar);
            make.left.equalTo(titleBtn3.mas_right);
        }];
        
        [allButtons addObject:titleBtn1];
        [allButtons addObject:titleBtn2];
        [allButtons addObject:titleBtn3];
        [allButtons addObject:customBtn];
    }

    UILabel *upLineLabel = [UILabel dividerLineLabel];
    [orderBottomToolBar addSubview:upLineLabel];
    [upLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(orderBottomToolBar);
        make.height.equalTo(CYTDividerLineWH);
    }];
    return orderBottomToolBar;
}

+ (instancetype)spe_orderDetailToolBarWithTitles:(NSArray <NSString *>*)titles  imageNames:(NSArray <NSString *>*)imageNames firstBtnClick:(void(^)())firstBtnClick secondBtnClick:(void(^)())secondBtnClick thirdBtnClick:(void(^)())thirdBtnClick fourthBtnClick:(void(^)())fourthBtnClick{
    
    NSMutableArray *allButtons = [NSMutableArray array];
    
    CYTOrderBottomToolBar *orderBottomToolBar = [[CYTOrderBottomToolBar alloc] init];
    if (!titles || titles.count<2 || !imageNames)return nil;
    if (titles.count == 4){
        NSString *title1 = [titles firstObject];
        NSString *title2 = titles[1];
        NSString *title3 = titles[2];
        NSString *title4 = [titles lastObject];
        NSString *imageName1 = [imageNames firstObject];
        NSString *imageName2 = imageNames[1];
        
        CYTOrderItemButton *titleBtn1 = [CYTOrderItemButton buttonWithImageName:imageName1 title:title1 buttonClick:^{
            !firstBtnClick?:firstBtnClick();
        }];
        [orderBottomToolBar addSubview:titleBtn1];
        [titleBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(138.f));
        }];
        
        CYTOrderItemButton *titleBtn2 = [CYTOrderItemButton buttonWithImageName:imageName2 title:title2 buttonClick:^{
            !secondBtnClick?:secondBtnClick();
        }];
        [orderBottomToolBar addSubview:titleBtn2];
        [titleBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(orderBottomToolBar);
            make.left.equalTo(titleBtn1.mas_right);
            make.width.equalTo(titleBtn1);
        }];
        
        UIButton *customBtn0 = [UIButton buttonWithType:UIButtonTypeCustom];
        [customBtn0 setTitle:title3 forState:UIControlStateNormal];
        [customBtn0 setTitleColor:kFFColor_title_L2 forState:UIControlStateNormal];
        customBtn0.backgroundColor = [UIColor whiteColor];
        customBtn0.titleLabel.font = CYTFontWithPixel(30.f);
        [[customBtn0 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            !thirdBtnClick?:thirdBtnClick();
        }];
        [orderBottomToolBar addSubview:customBtn0];
        [customBtn0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(orderBottomToolBar);
            make.left.equalTo(titleBtn2.mas_right);
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = kFFColor_line;
        [orderBottomToolBar addSubview:line];
        [line makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(orderBottomToolBar);
            make.right.equalTo(customBtn0.left);
            make.width.equalTo(kFFLayout_line);
        }];

        UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [customBtn setTitle:title4 forState:UIControlStateNormal];
        [customBtn setTitleColor:CYTHexColor(@"#FFFFFF") forState:UIControlStateNormal];
        [customBtn setBackgroundImage:[UIImage imageWithColor:CYTGreenNormalColor] forState:UIControlStateNormal];
        customBtn.titleLabel.font = CYTFontWithPixel(32.f);
        [[customBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            !fourthBtnClick?:fourthBtnClick();
        }];
        [orderBottomToolBar addSubview:customBtn];
        [customBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(orderBottomToolBar);
            make.left.equalTo(customBtn0.mas_right);
            make.width.equalTo(customBtn0);
        }];
        
        [allButtons addObject:titleBtn1];
        [allButtons addObject:titleBtn2];
        [allButtons addObject:customBtn0];
        [allButtons addObject:customBtn];
    }
    
    UILabel *upLineLabel = [UILabel dividerLineLabel];
    [orderBottomToolBar addSubview:upLineLabel];
    [upLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(orderBottomToolBar);
        make.height.equalTo(CYTDividerLineWH);
    }];
    return orderBottomToolBar;
}

+ (instancetype)orderDetailToolBarWithTitles:(NSArray <NSString *>*)titles  imageNames:(NSArray <NSString *>*)imageNames firstBtnClick:(void(^)())firstBtnClick secondBtnClick:(void(^)())secondBtnClick thirdBtnClick:(void(^)())thirdBtnClick fourthBtnClick:(void(^)())fourthBtnClick buttonsBlock:(void(^)(NSArray *))buttonsBlock{
    
    NSMutableArray *allButtons = [NSMutableArray array];
    
    CYTOrderBottomToolBar *orderBottomToolBar = [[CYTOrderBottomToolBar alloc] init];
    if (!titles || titles.count<2 || !imageNames)return nil;
    if (titles.count == 2) {//2个按钮情况
        NSString *title1 = [titles firstObject];
        NSString *title2 = [titles lastObject];
        NSString *imageName = [imageNames firstObject];
        CYTOrderItemButton *titleBtn1 = [CYTOrderItemButton buttonWithImageName:imageName title:title1 buttonClick:^{
            !firstBtnClick?:firstBtnClick();
        }];
        [orderBottomToolBar addSubview:titleBtn1];
        [titleBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(224.f));
        }];
        
        UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [customBtn setTitle:title2 forState:UIControlStateNormal];
        [customBtn setTitleColor:CYTHexColor(@"#FFFFFF") forState:UIControlStateNormal];
        [customBtn setBackgroundImage:[UIImage imageWithColor:CYTGreenNormalColor] forState:UIControlStateNormal];
        [customBtn setBackgroundImage:[UIImage imageWithColor:CYTBtnDisableColor] forState:UIControlStateDisabled];
        customBtn.titleLabel.font = CYTFontWithPixel(32.f);
        [[customBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            !secondBtnClick?:secondBtnClick();
        }];
        [orderBottomToolBar addSubview:customBtn];
        [customBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(orderBottomToolBar);
            make.left.equalTo(titleBtn1.mas_right);
        }];
        
        [allButtons addObject:titleBtn1];
        [allButtons addObject:customBtn];
    }else if (titles.count == 3){//3个按钮情况
        NSString *title1 = [titles firstObject];
        NSString *title2 = titles[1];
        NSString *title3 = [titles lastObject];
        NSString *imageName1 = [imageNames firstObject];
        NSString *imageName2;
        if (imageNames.count>1) {
            imageName2 = imageNames[1];
        }
        
        CYTOrderItemButton *titleBtn1 = [CYTOrderItemButton buttonWithImageName:imageName1 title:title1 buttonClick:^{
            !firstBtnClick?:firstBtnClick();
        }];
        [orderBottomToolBar addSubview:titleBtn1];
        [titleBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(172.f));
        }];
        
        [allButtons addObject:titleBtn1];
        
        CGFloat customBtnW = CYTAutoLayoutH(172.f);
        if (imageName2) {
            CYTOrderItemButton *titleBtn2 = [CYTOrderItemButton buttonWithImageName:imageName2 title:title2 buttonClick:^{
                !secondBtnClick?:secondBtnClick();
            }];
            [orderBottomToolBar addSubview:titleBtn2];
            [titleBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(orderBottomToolBar);
                make.left.equalTo(titleBtn1.mas_right);
                make.width.equalTo(customBtnW);
            }];
            
            UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [customBtn setTitle:title3 forState:UIControlStateNormal];
            [customBtn setTitleColor:CYTHexColor(@"#FFFFFF") forState:UIControlStateNormal];
            [customBtn setBackgroundImage:[UIImage imageWithColor:CYTGreenNormalColor] forState:UIControlStateNormal];
            customBtn.titleLabel.font = CYTFontWithPixel(32.f);
            [[customBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                !thirdBtnClick?:thirdBtnClick();
            }];
            [orderBottomToolBar addSubview:customBtn];
            [customBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.right.bottom.equalTo(orderBottomToolBar);
                make.left.equalTo(titleBtn2.mas_right);
            }];
            
            [allButtons addObject:titleBtn2];
            [allButtons addObject:customBtn];
        }else{
            UILabel *lineLabel = [UILabel dividerLineLabel];
            [orderBottomToolBar addSubview:lineLabel];
            [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(titleBtn1.mas_right);
                make.top.bottom.equalTo(orderBottomToolBar);
                make.width.equalTo(CYTDividerLineWH);
            }];
            
            
            UIButton *customBtn0 = [UIButton buttonWithType:UIButtonTypeCustom];
            [customBtn0 setTitle:title2 forState:UIControlStateNormal];
            [customBtn0 setTitleColor:CYTGreenNormalColor forState:UIControlStateNormal];
            [customBtn0 setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            [customBtn0 setTitleColor:CYTBtnDisableColor forState:UIControlStateDisabled];
            customBtn0.titleLabel.font = CYTFontWithPixel(32.f);
            [[customBtn0 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                !secondBtnClick?:secondBtnClick();
            }];
            [orderBottomToolBar addSubview:customBtn0];
            [customBtn0 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(orderBottomToolBar);
                make.left.equalTo(lineLabel.mas_right);
                make.width.equalTo((kScreenWidth - customBtnW)*0.5);
            }];
            
            UIButton *customBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
            [customBtn1 setTitle:title3 forState:UIControlStateNormal];
            [customBtn1 setTitleColor:CYTHexColor(@"#FFFFFF") forState:UIControlStateNormal];
            [customBtn1 setBackgroundImage:[UIImage imageWithColor:CYTGreenNormalColor] forState:UIControlStateNormal];
            [customBtn1 setBackgroundImage:[UIImage imageWithColor:CYTBtnDisableColor] forState:UIControlStateDisabled];
            customBtn1.titleLabel.font = CYTFontWithPixel(32.f);
            [[customBtn1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                !thirdBtnClick?:thirdBtnClick();
            }];
            [orderBottomToolBar addSubview:customBtn1];
            [customBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(orderBottomToolBar);
                make.left.equalTo(customBtn0.mas_right);
                make.right.equalTo(orderBottomToolBar);
            }];
            
            [allButtons addObject:customBtn0];
            [allButtons addObject:customBtn1];
        }
        
    }else if (titles.count == 4){
        NSString *title1 = [titles firstObject];
        NSString *title2 = titles[1];
        NSString *title3 = titles[2];
        NSString *title4 = [titles lastObject];
        NSString *imageName1 = [imageNames firstObject];
        NSString *imageName2 = imageNames[1];
        NSString *imageName3 = [imageNames lastObject];
        CYTOrderItemButton *titleBtn1 = [CYTOrderItemButton buttonWithImageName:imageName1 title:title1 buttonClick:^{
            !firstBtnClick?:firstBtnClick();
        }];
        [orderBottomToolBar addSubview:titleBtn1];
        [titleBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(138.f));
        }];
        
        CYTOrderItemButton *titleBtn2 = [CYTOrderItemButton buttonWithImageName:imageName2 title:title2 buttonClick:^{
            !secondBtnClick?:secondBtnClick();
        }];
        [orderBottomToolBar addSubview:titleBtn2];
        [titleBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(orderBottomToolBar);
            make.left.equalTo(titleBtn1.mas_right);
            make.width.equalTo(titleBtn1);
        }];
        
        CYTOrderItemButton *titleBtn3 = [CYTOrderItemButton buttonWithImageName:imageName3 title:title3 buttonClick:^{
            !thirdBtnClick?:thirdBtnClick();
        }];
        [orderBottomToolBar addSubview:titleBtn3];
        [titleBtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(orderBottomToolBar);
            make.left.equalTo(titleBtn2.mas_right);
            make.width.equalTo(titleBtn2);
        }];
        
        UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [customBtn setTitle:title4 forState:UIControlStateNormal];
        [customBtn setTitleColor:CYTHexColor(@"#FFFFFF") forState:UIControlStateNormal];
        [customBtn setBackgroundImage:[UIImage imageWithColor:CYTGreenNormalColor] forState:UIControlStateNormal];
        customBtn.titleLabel.font = CYTFontWithPixel(32.f);
        [[customBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            !fourthBtnClick?:fourthBtnClick();
        }];
        [orderBottomToolBar addSubview:customBtn];
        [customBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(orderBottomToolBar);
            make.left.equalTo(titleBtn3.mas_right);
        }];
        
        [allButtons addObject:titleBtn1];
        [allButtons addObject:titleBtn2];
        [allButtons addObject:titleBtn3];
        [allButtons addObject:customBtn];
    }
    
    UILabel *upLineLabel = [UILabel dividerLineLabel];
    [orderBottomToolBar addSubview:upLineLabel];
    [upLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(orderBottomToolBar);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    if (buttonsBlock) {
        buttonsBlock(allButtons);
    }
    
    return orderBottomToolBar;
}


/**
 *  自定义底部按钮（新）
 */
+ (instancetype)bottomToolBarrWithBarType:(CYTOrderToolBarType)orderToolBarType server:(void(^)(UIView *))server firstBtnTitle:(NSString *)firstTitle secondBtnTitle:(NSString *)secondTitle firstBtn:(void(^)(UIButton *firstButton))firstButton secondBtn:(void(^)(UIButton *secondBtn))secondBtn firstBtnAction:(void(^)(UIButton *))firstButtonBlock secondBtnAction:(void(^)(UIButton *))secondButtonBlock{
    CYTOrderBottomToolBar *orderBottomToolBar = [[CYTOrderBottomToolBar alloc] init];
    if (orderToolBarType == CYTOrderToolBarTypeContactServerAndOneCustomButton) {//客服和自定义按钮
        UIView *serviceBg = [[UIView alloc] init];
        serviceBg.backgroundColor = [UIColor whiteColor];
        [orderBottomToolBar addSubview:serviceBg];
        orderBottomToolBar.onlyContactServer = serviceBg;
        [serviceBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(200));
        }];
        
        __weak typeof(serviceBg) weakServiceBg = serviceBg;
        //客服点击回调
        [serviceBg addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
            !server?:server(weakServiceBg);
        }];
        
        //客服按钮
        UIImageView *serviceView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_kefu_hl_new"]];
        [serviceBg addSubview:serviceView];
        [serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(70), CYTAutoLayoutV(62)));
            make.top.equalTo(serviceBg).offset(CYTAutoLayoutV(5));
            make.centerX.equalTo(serviceBg);
        }];
        
        //客服文字
        UILabel *serviceLabel = [[UILabel alloc] init];
        serviceLabel.font = CYTFontWithPixel(24);
        serviceLabel.textColor = CYTGreenNormalColor;
        serviceLabel.text = @"客服";
        [serviceBg addSubview:serviceLabel];
        [serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(serviceView.mas_bottom);
            make.size.equalTo(CGSizeMake((serviceLabel.font.pointSize+2)*2, serviceLabel.font.pointSize+2));
            make.centerX.equalTo(serviceView);
        }];
        
        //自定义按钮
        UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [customBtn setBackgroundImage:[UIImage imageWithColor:CYTGreenNormalColor] forState:UIControlStateNormal];
        [customBtn setBackgroundImage:[UIImage imageWithColor:CYTBtnDisableColor] forState:UIControlStateDisabled];
        [customBtn setTitle:firstTitle forState:UIControlStateNormal];
        [customBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        customBtn.titleLabel.font = CYTFontWithPixel(32);
        customBtn.enabled = NO;
        [orderBottomToolBar addSubview:customBtn];
        orderBottomToolBar.sendbackSendback = customBtn;
        [customBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(serviceBg.mas_right);
            make.top.bottom.right.equalTo(orderBottomToolBar);
        }];
        
        //回调
        !firstButton?:firstButton(customBtn);
        
        //按钮点击
        [[customBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            !firstButtonBlock?:firstButtonBlock(customBtn);
        }];
        
        //顶部分割线
        UILabel *topLineLabel = [[UILabel alloc] init];
        topLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
        [orderBottomToolBar addSubview:topLineLabel];
        [topLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(orderBottomToolBar);
            make.top.equalTo(orderBottomToolBar);
            make.height.equalTo(CYTDividerLineWH);
        }];
        
    }else if (orderToolBarType == CYTOrderToolBarTypeContactServerWithCallAndCustomButton){
        UIView *serviceBg = [[UIView alloc] init];
        serviceBg.backgroundColor = [UIColor whiteColor];
        [orderBottomToolBar addSubview:serviceBg];
        orderBottomToolBar.onlyContactServer = serviceBg;
        [serviceBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(200));
        }];
        
        __weak typeof(serviceBg) weakServiceBg = serviceBg;
        //客服点击回调
        [serviceBg addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
            !server?:server(weakServiceBg);
        }];
        
        //客服按钮
        UIImageView *serviceView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_kefu_hl_new"]];
        [serviceBg addSubview:serviceView];
        [serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(70), CYTAutoLayoutV(62)));
            make.top.equalTo(serviceBg).offset(CYTAutoLayoutV(5));
            make.centerX.equalTo(serviceBg);
        }];
        
        //客服文字
        UILabel *serviceLabel = [[UILabel alloc] init];
        serviceLabel.font = CYTFontWithPixel(24);
        serviceLabel.textColor = CYTGreenNormalColor;
        serviceLabel.text = @"客服";
        [serviceBg addSubview:serviceLabel];
        [serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(serviceView.mas_bottom);
            make.size.equalTo(CGSizeMake((serviceLabel.font.pointSize+2)*2, serviceLabel.font.pointSize+2));
            make.centerX.equalTo(serviceView);
        }];
        
        //客服分割线
        UILabel *serviceLineLabel = [[UILabel alloc] init];
        serviceLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
        [orderBottomToolBar addSubview:serviceLineLabel];
        [serviceLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(orderBottomToolBar);
            make.right.equalTo(serviceBg);
            make.width.equalTo(CYTDividerLineWH);
        }];
        
        //联系对方
        UIView *contactBg = [[UIView alloc] init];
        contactBg.backgroundColor = [UIColor whiteColor];
        [orderBottomToolBar addSubview:contactBg];
        orderBottomToolBar.cancelOrderContact = contactBg;
        [contactBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(serviceBg.mas_right);
            make.top.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(278));
        }];
        
        [contactBg addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
            !firstButton?:firstButton(nil);
        }];
        
        //联系对方按钮
        UIImageView *contactView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_phone_hl_new"]];
        [contactBg addSubview:contactView];
        [contactView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(70), CYTAutoLayoutV(62)));
            make.top.equalTo(serviceView);
            make.centerX.equalTo(contactBg);
        }];
        
        //联系对方文字
        UILabel *contactLabel = [[UILabel alloc] init];
        contactLabel.userInteractionEnabled = YES;
        contactLabel.font = CYTFontWithPixel(24);
        contactLabel.textColor = CYTGreenNormalColor;
        contactLabel.text = firstTitle;
        contactLabel.textAlignment = NSTextAlignmentCenter;
        [contactBg addSubview:contactLabel];
        [contactLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(contactBg);
            make.height.equalTo(contactLabel.font.pointSize+2);
            make.top.equalTo(contactView.mas_bottom);
        }];
        
        //联系对方
        UILabel *contactLineLabel = [[UILabel alloc] init];
        contactLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
        [orderBottomToolBar addSubview:contactLineLabel];
        [contactLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(orderBottomToolBar);
            make.right.equalTo(contactBg);
            make.width.equalTo(CYTDividerLineWH);
        }];

        //自定义按钮
        UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [customBtn setBackgroundImage:[UIImage imageWithColor:CYTGreenNormalColor] forState:UIControlStateNormal];
        [customBtn setBackgroundImage:[UIImage imageWithColor:CYTBtnDisableColor] forState:UIControlStateDisabled];
        [customBtn setTitle:secondTitle forState:UIControlStateNormal];
        [customBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        customBtn.titleLabel.font = CYTFontWithPixel(32);
        customBtn.enabled = NO;
        [orderBottomToolBar addSubview:customBtn];
        orderBottomToolBar.sendbackSendback = customBtn;
        [customBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contactBg.mas_right);
            make.top.bottom.right.equalTo(orderBottomToolBar);
        }];
        
        //回调
        !secondBtn?:secondBtn(customBtn);
        
        //按钮点击
        [[customBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            !secondButtonBlock?:secondButtonBlock(customBtn);
        }];
        
        //顶部分割线
        UILabel *topLineLabel = [[UILabel alloc] init];
        topLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
        [orderBottomToolBar addSubview:topLineLabel];
        [topLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(orderBottomToolBar);
            make.top.equalTo(orderBottomToolBar);
            make.height.equalTo(CYTDividerLineWH);
        }];
    }
    return orderBottomToolBar;
}

+ (instancetype)bottomToolBarrWithBarType:(CYTOrderToolBarType)orderToolBarType {
    CYTOrderBottomToolBar *orderBottomToolBar = [[CYTOrderBottomToolBar alloc] init];

    if (orderToolBarType == CYTOrderToolBarTypeOnlyContact) {//客服和联系对方
        UIView *serviceBg = [[UIView alloc] init];
        serviceBg.backgroundColor = [UIColor whiteColor];
        [orderBottomToolBar addSubview:serviceBg];
        orderBottomToolBar.onlyContactServer = serviceBg;
        [serviceBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(200));
        }];
        
        //客服按钮
        UIImageView *serviceView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_kefu_hl_new"]];
        [serviceBg addSubview:serviceView];
        [serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(70), CYTAutoLayoutV(62)));
            make.top.equalTo(serviceBg).offset(CYTAutoLayoutV(5));
            make.centerX.equalTo(serviceBg);
        }];
        
        //客服文字
        UILabel *serviceLabel = [[UILabel alloc] init];
        serviceLabel.font = CYTFontWithPixel(24);
        serviceLabel.textColor = CYTGreenNormalColor;
        serviceLabel.text = @"客服";
        [serviceBg addSubview:serviceLabel];
        [serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(serviceView.mas_bottom);
            make.size.equalTo(CGSizeMake((serviceLabel.font.pointSize+2)*2, serviceLabel.font.pointSize+2));
            make.centerX.equalTo(serviceView);
        }];
        
        //联系对方
        UIView *contactBg = [[UIView alloc] init];
        contactBg.backgroundColor = CYTGreenNormalColor;
        [orderBottomToolBar addSubview:contactBg];
        orderBottomToolBar.onlyContactContact = contactBg;
        [contactBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(serviceBg.mas_right);
            make.top.bottom.right.equalTo(orderBottomToolBar);
        }];
        
        //联系对方按钮
        UIImageView *contactView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_white_phone_hl"]];
        [contactBg addSubview:contactView];
        [contactView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(70), CYTAutoLayoutV(62)));
            make.left.equalTo(contactBg).offset(CYTAutoLayoutH(118));
            make.centerY.equalTo(contactBg);
        }];
        
        //联系对方文字
        UILabel *contactLabel = [[UILabel alloc] init];
        contactLabel.font = CYTFontWithPixel(40);
        contactLabel.textColor = [UIColor whiteColor];
        contactLabel.text = @"联系对方";
        [contactBg addSubview:contactLabel];
        [contactLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contactView.mas_right).offset(CYTAutoLayoutH(24));
            make.size.equalTo(CGSizeMake((contactLabel.font.pointSize+2)*4, contactLabel.font.pointSize+2));
            make.centerY.equalTo(contactBg);
        }];
        
        //顶部分割线
        UILabel *topLineLabel = [[UILabel alloc] init];
        topLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
        [orderBottomToolBar addSubview:topLineLabel];
        [topLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(orderBottomToolBar);
            make.top.equalTo(orderBottomToolBar);
            make.height.equalTo(CYTDividerLineWH);
        }];
        
    }else if (orderToolBarType == CYTOrderToolBarTypeCancelOrder){//客服、联系对方和取消订单
        UIView *serviceBg = [[UIView alloc] init];
        serviceBg.backgroundColor = [UIColor whiteColor];
        [orderBottomToolBar addSubview:serviceBg];
        orderBottomToolBar.cancelOrderServer = serviceBg;
        [serviceBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(99));
        }];
        
        //客服按钮
        UIImageView *serviceView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_kefu_hl_new"]];
        [serviceBg addSubview:serviceView];
        [serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(70), CYTAutoLayoutV(62)));
            make.top.equalTo(serviceBg).offset(CYTAutoLayoutV(5));
            make.centerX.equalTo(serviceBg);
        }];
        
        //客服文字
        UILabel *serviceLabel = [[UILabel alloc] init];
        serviceLabel.font = CYTFontWithPixel(24);
        serviceLabel.textColor = CYTGreenNormalColor;
        serviceLabel.text = @"客服";
        [serviceBg addSubview:serviceLabel];
        [serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(serviceView.mas_bottom);
            make.size.equalTo(CGSizeMake((serviceLabel.font.pointSize+2)*2, serviceLabel.font.pointSize+2));
            make.centerX.equalTo(serviceView);
        }];
        //客服分割线
        UILabel *serviceLineLabel = [[UILabel alloc] init];
        serviceLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
        [orderBottomToolBar addSubview:serviceLineLabel];
        [serviceLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(orderBottomToolBar);
            make.right.equalTo(serviceBg);
            make.width.equalTo(CYTDividerLineWH);
        }];
        
        //联系对方
        UIView *contactBg = [[UIView alloc] init];
        contactBg.backgroundColor = [UIColor whiteColor];
        [orderBottomToolBar addSubview:contactBg];
        orderBottomToolBar.cancelOrderContact = contactBg;
        [contactBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(serviceBg.mas_right);
            make.top.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(278));
        }];
        
        //联系对方按钮
        UIImageView *contactView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_phone_hl_new"]];
        [contactBg addSubview:contactView];
        [contactView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(70), CYTAutoLayoutV(62)));
            make.top.equalTo(serviceView);
            make.centerX.equalTo(contactBg);
        }];
        
        //联系对方文字
        UILabel *contactLabel = [[UILabel alloc] init];
        contactLabel.userInteractionEnabled = YES;
        contactLabel.font = CYTFontWithPixel(24);
        contactLabel.textColor = CYTGreenNormalColor;
        contactLabel.text = @"联系对方";
        contactLabel.textAlignment = NSTextAlignmentCenter;
        [contactBg addSubview:contactLabel];
        [contactLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(contactBg);
            make.height.equalTo(contactLabel.font.pointSize+2);
            make.top.equalTo(contactView.mas_bottom);
        }];
        
        //联系对方
        UILabel *contactLineLabel = [[UILabel alloc] init];
        contactLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
        [orderBottomToolBar addSubview:contactLineLabel];
        [contactLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(orderBottomToolBar);
            make.right.equalTo(contactBg);
            make.width.equalTo(CYTDividerLineWH);
        }];
        
        //取消订单
        UIView *cancelOrderBg = [[UIView alloc] init];
        cancelOrderBg.backgroundColor = [UIColor whiteColor];
        [orderBottomToolBar addSubview:cancelOrderBg];
        orderBottomToolBar.cancelOrderCancel = cancelOrderBg;
        [cancelOrderBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contactBg.mas_right);
            make.right.top.bottom.equalTo(orderBottomToolBar);
        }];

        //取消订单
        UILabel *cancelOrderLabel = [[UILabel alloc] init];
        cancelOrderLabel.font = CYTFontWithPixel(32);
        cancelOrderLabel.textColor = kFFColor_title_L1;
        cancelOrderLabel.text = @"取消订单";
        cancelOrderLabel.textAlignment = NSTextAlignmentCenter;
        [cancelOrderBg addSubview:cancelOrderLabel];
        [cancelOrderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(cancelOrderBg);
        }];
        
        //顶部分割线
        UILabel *topLineLabel = [[UILabel alloc] init];
        topLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
        [orderBottomToolBar addSubview:topLineLabel];
        [topLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(orderBottomToolBar);
            make.top.equalTo(orderBottomToolBar);
            make.height.equalTo(CYTDividerLineWH);
        }];
    }else if(orderToolBarType == CYTOrderToolBarTypeSendbackAndPay){//申请订金退回和付订金给卖家
        UIView *serviceBg = [[UIView alloc] init];
        serviceBg.backgroundColor = [UIColor whiteColor];
        [orderBottomToolBar addSubview:serviceBg];
        orderBottomToolBar.sendbackServer = serviceBg;
        [serviceBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(99));
        }];
        
        //客服按钮
        UIImageView *serviceView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_kefu_hl_new"]];
        [serviceBg addSubview:serviceView];
        [serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(70), CYTAutoLayoutV(62)));
            make.top.equalTo(serviceBg).offset(CYTAutoLayoutV(5));
            make.centerX.equalTo(serviceBg);
        }];
        
        //客服文字
        UILabel *serviceLabel = [[UILabel alloc] init];
        serviceLabel.font = CYTFontWithPixel(24);
        serviceLabel.textColor = CYTGreenNormalColor;
        serviceLabel.text = @"客服";
        [serviceBg addSubview:serviceLabel];
        [serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(serviceView.mas_bottom);
            make.size.equalTo(CGSizeMake((serviceLabel.font.pointSize+2)*2, serviceLabel.font.pointSize+2));
            make.centerX.equalTo(serviceView);
        }];
        //客服分割线
        UILabel *serviceLineLabel = [[UILabel alloc] init];
        serviceLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
        [orderBottomToolBar addSubview:serviceLineLabel];
        [serviceLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(orderBottomToolBar);
            make.right.equalTo(serviceBg);
            make.width.equalTo(CYTDividerLineWH);
        }];
        
        //申请订金退回
        UIButton *customBtn = [[UIButton alloc] init];
        [customBtn setTitle:@"申请订金退回" forState:UIControlStateNormal];
        [customBtn setTitleColor:CYTHexColor(@"#999999") forState:UIControlStateDisabled];
        [customBtn setTitleColor:CYTGreenNormalColor forState:UIControlStateNormal];
        customBtn.titleLabel.font = CYTFontWithPixel(32);
        customBtn.enabled = NO;
        [orderBottomToolBar addSubview:customBtn];
        orderBottomToolBar.sendbackSendback = customBtn;
        [customBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(serviceBg.mas_right);
            make.top.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(276.f));
        }];

    
        UILabel *sendbackLineLabel = [[UILabel alloc] init];
        sendbackLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
        [customBtn addSubview:sendbackLineLabel];
        [sendbackLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(orderBottomToolBar);
            make.right.equalTo(customBtn);
            make.width.equalTo(CYTDividerLineWH);
        }];
        
        //付订金给卖家
        UIButton *payforSellerBtn = [[UIButton alloc] init];
        payforSellerBtn.enabled = NO;
        [payforSellerBtn setTitle:@"付订金给卖家" forState:UIControlStateNormal];
        [payforSellerBtn setBackgroundImage:[UIImage imageWithColor:CYTGreenNormalColor] forState:UIControlStateNormal];
        [payforSellerBtn setBackgroundImage:[UIImage imageWithColor:CYTBtnDisableColor] forState:UIControlStateDisabled];
        [payforSellerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        payforSellerBtn.titleLabel.font = CYTFontWithPixel(32);
        [orderBottomToolBar addSubview:payforSellerBtn];
        orderBottomToolBar.sendbackPayforSeller = payforSellerBtn;
        [payforSellerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(customBtn.mas_right);
            make.right.top.bottom.equalTo(orderBottomToolBar);
        }];
        
        //顶部分割线
        UILabel *topLineLabel = [[UILabel alloc] init];
        topLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
        [orderBottomToolBar addSubview:topLineLabel];
        [topLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(orderBottomToolBar);
            make.top.equalTo(orderBottomToolBar);
            make.height.equalTo(CYTDividerLineWH);
        }];

    }else if (orderToolBarType == CYTOrderToolBarTypeConfirmAndSendback){//确认并退回订金给买家
        UIView *serviceBg = [[UIView alloc] init];
        serviceBg.backgroundColor = [UIColor whiteColor];
        [orderBottomToolBar addSubview:serviceBg];
        orderBottomToolBar.confirmAndPayServer = serviceBg;
        [serviceBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(195));
        }];
        
        //客服按钮
        UIImageView *serviceView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_kefu_hl_new"]];
        [serviceBg addSubview:serviceView];
        [serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(70), CYTAutoLayoutV(62)));
            make.top.equalTo(serviceBg).offset(CYTAutoLayoutV(5));
            make.centerX.equalTo(serviceBg);
        }];
        
        //客服文字
        UILabel *serviceLabel = [[UILabel alloc] init];
        serviceLabel.font = CYTFontWithPixel(24);
        serviceLabel.textColor = CYTGreenNormalColor;
        serviceLabel.text = @"客服";
        [serviceBg addSubview:serviceLabel];
        [serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(serviceView.mas_bottom);
            make.size.equalTo(CGSizeMake((serviceLabel.font.pointSize+2)*2, serviceLabel.font.pointSize+2));
            make.centerX.equalTo(serviceView);
        }];
        //客服分割线
        UILabel *serviceLineLabel = [[UILabel alloc] init];
        serviceLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
        [orderBottomToolBar addSubview:serviceLineLabel];
        [serviceLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(orderBottomToolBar);
            make.right.equalTo(serviceBg);
            make.width.equalTo(CYTDividerLineWH);
        }];
        
        //确认并退回订金给买家
        UIButton *confirmAndPayBg = [[UIButton alloc] init];
        [confirmAndPayBg setBackgroundImage:[UIImage imageWithColor:CYTGreenNormalColor] forState:UIControlStateNormal];
        [confirmAndPayBg setBackgroundImage:[UIImage imageWithColor:CYTBtnDisableColor] forState:UIControlStateDisabled];
        confirmAndPayBg.enabled = NO;
        [orderBottomToolBar addSubview:confirmAndPayBg];
        orderBottomToolBar.confirmAndPayPay = confirmAndPayBg;
        [confirmAndPayBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(serviceBg.mas_right);
            make.right.top.bottom.equalTo(orderBottomToolBar);
        }];
        
        //确认并退回订金给买家文字
        UILabel *confirmAndPayLabel = [[UILabel alloc] init];
        confirmAndPayLabel.userInteractionEnabled = YES;
        confirmAndPayLabel.font = CYTFontWithPixel(32);
        confirmAndPayLabel.textColor = CYTHexColor(@"#FFFFFF");
        confirmAndPayLabel.text = @"确认并退回订金给买家";
        confirmAndPayLabel.textAlignment = NSTextAlignmentCenter;
        [confirmAndPayBg addSubview:confirmAndPayLabel];
        [confirmAndPayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(confirmAndPayBg);
        }];
        
        //顶部分割线
        UILabel *topLineLabel = [[UILabel alloc] init];
        topLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
        [orderBottomToolBar addSubview:topLineLabel];
        [topLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(orderBottomToolBar);
            make.top.equalTo(orderBottomToolBar);
            make.height.equalTo(CYTDividerLineWH);
        }];

    }else if (orderToolBarType == CYTOrderToolBarTypeCommit){
        UIView *serviceBg = [[UIView alloc] init];
        serviceBg.backgroundColor = [UIColor whiteColor];
        [orderBottomToolBar addSubview:serviceBg];
        orderBottomToolBar.commitServer = serviceBg;
        [serviceBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(195));
        }];
        
        //客服按钮
        UIImageView *serviceView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_kefu_hl_new"]];
        [serviceBg addSubview:serviceView];
        [serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(70), CYTAutoLayoutV(62)));
            make.top.equalTo(serviceBg).offset(CYTAutoLayoutV(5));
            make.centerX.equalTo(serviceBg);
        }];
        
        //客服文字
        UILabel *serviceLabel = [[UILabel alloc] init];
        serviceLabel.font = CYTFontWithPixel(24);
        serviceLabel.textColor = CYTGreenNormalColor;
        serviceLabel.text = @"客服";
        [serviceBg addSubview:serviceLabel];
        [serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(serviceView.mas_bottom);
            make.size.equalTo(CGSizeMake((serviceLabel.font.pointSize+2)*2, serviceLabel.font.pointSize+2));
            make.centerX.equalTo(serviceView);
        }];
        //客服分割线
        UILabel *serviceLineLabel = [[UILabel alloc] init];
        serviceLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
        [orderBottomToolBar addSubview:serviceLineLabel];
        [serviceLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(orderBottomToolBar);
            make.right.equalTo(serviceBg);
            make.width.equalTo(CYTDividerLineWH);
        }];
        
        //提交
        UIButton *commitBtn = [[UIButton alloc] init];
        [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [commitBtn setBackgroundImage:[UIImage imageWithColor:CYTGreenNormalColor] forState:UIControlStateNormal];
        [commitBtn setBackgroundImage:[UIImage imageWithColor:CYTBtnDisableColor] forState:UIControlStateDisabled];
        commitBtn.enabled = NO;
        [orderBottomToolBar addSubview:commitBtn];
        orderBottomToolBar.commitBtn = commitBtn;
        [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(serviceBg.mas_right);
            make.right.top.bottom.equalTo(orderBottomToolBar);
        }];
        
        //提交
//        UILabel *commitLabel = [[UILabel alloc] init];
//        commitLabel.font = CYTFontWithPixel(32);
//        commitLabel.textColor = CYTHexColor(@"#FFFFFF");
//        commitLabel.text = @"提交";
//        commitLabel.textAlignment = NSTextAlignmentCenter;
//        [commitBg addSubview:commitLabel];
//        [commitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.top.bottom.equalTo(commitBg);
//        }];
        
        //顶部分割线
        UILabel *topLineLabel = [[UILabel alloc] init];
        topLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
        [orderBottomToolBar addSubview:topLineLabel];
        [topLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(orderBottomToolBar);
            make.top.equalTo(orderBottomToolBar);
            make.height.equalTo(CYTDividerLineWH);
        }];
    }else if (orderToolBarType == CYTOrderToolBarTypeGotoPay){
        UIView *serviceBg = [[UIView alloc] init];
        serviceBg.backgroundColor = [UIColor whiteColor];
        [orderBottomToolBar addSubview:serviceBg];
        orderBottomToolBar.gotoPayServer = serviceBg;
        [serviceBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(99));
        }];
        
        //客服按钮
        UIImageView *serviceView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_kefu_hl_new"]];
        [serviceBg addSubview:serviceView];
        [serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(70), CYTAutoLayoutV(62)));
            make.top.equalTo(serviceBg).offset(CYTAutoLayoutV(5));
            make.centerX.equalTo(serviceBg);
        }];
        
        //客服文字
        UILabel *serviceLabel = [[UILabel alloc] init];
        serviceLabel.font = CYTFontWithPixel(24);
        serviceLabel.textColor = CYTGreenNormalColor;
        serviceLabel.text = @"客服";
        [serviceBg addSubview:serviceLabel];
        [serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(serviceView.mas_bottom);
            make.size.equalTo(CGSizeMake((serviceLabel.font.pointSize+2)*2, serviceLabel.font.pointSize+2));
            make.centerX.equalTo(serviceView);
        }];
        //客服分割线
        UILabel *serviceLineLabel = [[UILabel alloc] init];
        serviceLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
        [orderBottomToolBar addSubview:serviceLineLabel];
        [serviceLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(orderBottomToolBar);
            make.right.equalTo(serviceBg);
            make.width.equalTo(CYTDividerLineWH);
        }];
        
        //联系对方
        UIView *contactBg = [[UIView alloc] init];
        contactBg.backgroundColor = [UIColor whiteColor];
        [orderBottomToolBar addSubview:contactBg];
        orderBottomToolBar.gotoPayContact = contactBg;
        [contactBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(serviceBg.mas_right);
            make.top.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(278));
        }];
        
        //联系对方按钮
        UIImageView *contactView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_phone_hl_new"]];
        [contactBg addSubview:contactView];
        [contactView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(70), CYTAutoLayoutV(62)));
            make.top.equalTo(serviceView);
            make.centerX.equalTo(contactBg);
        }];
        
        //联系对方文字
        UILabel *contactLabel = [[UILabel alloc] init];
        contactLabel.userInteractionEnabled = YES;
        contactLabel.font = CYTFontWithPixel(24);
        contactLabel.textColor = CYTGreenNormalColor;
        contactLabel.text = @"联系对方";
        contactLabel.textAlignment = NSTextAlignmentCenter;
        [contactBg addSubview:contactLabel];
        [contactLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(contactBg);
            make.height.equalTo(contactLabel.font.pointSize+2);
            make.top.equalTo(contactView.mas_bottom);
        }];
        
        //联系对方
        UILabel *contactLineLabel = [[UILabel alloc] init];
        contactLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
        [orderBottomToolBar addSubview:contactLineLabel];
        [contactLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(orderBottomToolBar);
            make.right.equalTo(contactBg);
            make.width.equalTo(CYTDividerLineWH);
        }];
        
        //去支付
        UIView *cancelOrderBg = [[UIView alloc] init];
        cancelOrderBg.backgroundColor = CYTGreenNormalColor;
        [orderBottomToolBar addSubview:cancelOrderBg];
        orderBottomToolBar.gotoPayPay = cancelOrderBg;
        [cancelOrderBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contactBg.mas_right);
            make.right.top.bottom.equalTo(orderBottomToolBar);
        }];
        
        //去支付
        UILabel *cancelOrderLabel = [[UILabel alloc] init];
        cancelOrderLabel.font = CYTFontWithPixel(32);
        cancelOrderLabel.textColor = [UIColor whiteColor];
        cancelOrderLabel.text = @"去支付";
        cancelOrderLabel.textAlignment = NSTextAlignmentCenter;
        [cancelOrderBg addSubview:cancelOrderLabel];
        [cancelOrderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(cancelOrderBg);
        }];
        
        //顶部分割线
        UILabel *topLineLabel = [[UILabel alloc] init];
        topLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
        [orderBottomToolBar addSubview:topLineLabel];
        [topLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(orderBottomToolBar);
            make.top.equalTo(orderBottomToolBar);
            make.height.equalTo(CYTDividerLineWH);
        }];
    }else if(orderToolBarType == CYTOrderToolBarTypeConfirmSendCar){
        UIView *serviceBg = [[UIView alloc] init];
        serviceBg.backgroundColor = [UIColor whiteColor];
        [orderBottomToolBar addSubview:serviceBg];
        orderBottomToolBar.confirmSendCarServer = serviceBg;
        [serviceBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(99));
        }];
        
        //客服按钮
        UIImageView *serviceView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_kefu_hl_new"]];
        [serviceBg addSubview:serviceView];
        [serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(70), CYTAutoLayoutV(62)));
            make.top.equalTo(serviceBg).offset(CYTAutoLayoutV(5));
            make.centerX.equalTo(serviceBg);
        }];
        
        //客服文字
        UILabel *serviceLabel = [[UILabel alloc] init];
        serviceLabel.font = CYTFontWithPixel(24);
        serviceLabel.textColor = CYTGreenNormalColor;
        serviceLabel.text = @"客服";
        [serviceBg addSubview:serviceLabel];
        [serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(serviceView.mas_bottom);
            make.size.equalTo(CGSizeMake((serviceLabel.font.pointSize+2)*2, serviceLabel.font.pointSize+2));
            make.centerX.equalTo(serviceView);
        }];
        //客服分割线
        UILabel *serviceLineLabel = [[UILabel alloc] init];
        serviceLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
        [orderBottomToolBar addSubview:serviceLineLabel];
        [serviceLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(orderBottomToolBar);
            make.right.equalTo(serviceBg);
            make.width.equalTo(CYTDividerLineWH);
        }];
        
        //联系对方
        UIView *contactBg = [[UIView alloc] init];
        contactBg.backgroundColor = [UIColor whiteColor];
        [orderBottomToolBar addSubview:contactBg];
        orderBottomToolBar.confirmSendCarContact = contactBg;
        [contactBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(serviceBg.mas_right);
            make.top.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(278));
        }];
        
        //联系对方按钮
        UIImageView *contactView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_phone_hl_new"]];
        [contactBg addSubview:contactView];
        [contactView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(70), CYTAutoLayoutV(62)));
            make.top.equalTo(serviceView);
            make.centerX.equalTo(contactBg);
        }];
        
        //联系对方文字
        UILabel *contactLabel = [[UILabel alloc] init];
        contactLabel.userInteractionEnabled = YES;
        contactLabel.font = CYTFontWithPixel(24);
        contactLabel.textColor = CYTGreenNormalColor;
        contactLabel.text = @"联系对方";
        contactLabel.textAlignment = NSTextAlignmentCenter;
        [contactBg addSubview:contactLabel];
        [contactLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(contactBg);
            make.height.equalTo(contactLabel.font.pointSize+2);
            make.top.equalTo(contactView.mas_bottom);
        }];
        
        //联系对方
        UILabel *contactLineLabel = [[UILabel alloc] init];
        contactLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
        [orderBottomToolBar addSubview:contactLineLabel];
        [contactLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(orderBottomToolBar);
            make.right.equalTo(contactBg);
            make.width.equalTo(CYTDividerLineWH);
        }];
        
        //去支付
        UIView *cancelOrderBg = [[UIView alloc] init];
        cancelOrderBg.backgroundColor = CYTGreenNormalColor;
        [orderBottomToolBar addSubview:cancelOrderBg];
        orderBottomToolBar.confirmSendCarSend = cancelOrderBg;
        [cancelOrderBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contactBg.mas_right);
            make.right.top.bottom.equalTo(orderBottomToolBar);
        }];
        
        //去支付
        UILabel *cancelOrderLabel = [[UILabel alloc] init];
        cancelOrderLabel.font = CYTFontWithPixel(32);
        cancelOrderLabel.textColor = [UIColor whiteColor];
        cancelOrderLabel.text = @"确认发车";
        cancelOrderLabel.textAlignment = NSTextAlignmentCenter;
        [cancelOrderBg addSubview:cancelOrderLabel];
        [cancelOrderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(cancelOrderBg);
        }];
        
        //顶部分割线
        UILabel *topLineLabel = [[UILabel alloc] init];
        topLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
        [orderBottomToolBar addSubview:topLineLabel];
        [topLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(orderBottomToolBar);
            make.top.equalTo(orderBottomToolBar);
            make.height.equalTo(CYTDividerLineWH);
        }];
    }else if(orderToolBarType == CYTOrderToolBarTypeConfirmRevCar){
        UIView *serviceBg = [[UIView alloc] init];
        serviceBg.backgroundColor = [UIColor whiteColor];
        [orderBottomToolBar addSubview:serviceBg];
        orderBottomToolBar.confirmRecCarServer = serviceBg;
        [serviceBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(99));
        }];
        
        //客服按钮
        UIImageView *serviceView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_kefu_hl_new"]];
        [serviceBg addSubview:serviceView];
        [serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(70), CYTAutoLayoutV(62)));
            make.top.equalTo(serviceBg).offset(CYTAutoLayoutV(5));
            make.centerX.equalTo(serviceBg);
        }];
        
        //客服文字
        UILabel *serviceLabel = [[UILabel alloc] init];
        serviceLabel.font = CYTFontWithPixel(24);
        serviceLabel.textColor = CYTGreenNormalColor;
        serviceLabel.text = @"客服";
        [serviceBg addSubview:serviceLabel];
        [serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(serviceView.mas_bottom);
            make.size.equalTo(CGSizeMake((serviceLabel.font.pointSize+2)*2, serviceLabel.font.pointSize+2));
            make.centerX.equalTo(serviceView);
        }];
        //客服分割线
        UILabel *serviceLineLabel = [[UILabel alloc] init];
        serviceLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
        [orderBottomToolBar addSubview:serviceLineLabel];
        [serviceLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(orderBottomToolBar);
            make.right.equalTo(serviceBg);
            make.width.equalTo(CYTDividerLineWH);
        }];
        
        //联系对方
        UIView *contactBg = [[UIView alloc] init];
        contactBg.backgroundColor = [UIColor whiteColor];
        [orderBottomToolBar addSubview:contactBg];
        orderBottomToolBar.confirmRecCarContact = contactBg;
        [contactBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(serviceBg.mas_right);
            make.top.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(278));
        }];
        
        //联系对方按钮
        UIImageView *contactView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_phone_hl_new"]];
        [contactBg addSubview:contactView];
        [contactView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(70), CYTAutoLayoutV(62)));
            make.top.equalTo(serviceView);
            make.centerX.equalTo(contactBg);
        }];
        
        //联系对方文字
        UILabel *contactLabel = [[UILabel alloc] init];
        contactLabel.userInteractionEnabled = YES;
        contactLabel.font = CYTFontWithPixel(24);
        contactLabel.textColor = CYTGreenNormalColor;
        contactLabel.text = @"联系对方";
        contactLabel.textAlignment = NSTextAlignmentCenter;
        [contactBg addSubview:contactLabel];
        [contactLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(contactBg);
            make.height.equalTo(contactLabel.font.pointSize+2);
            make.top.equalTo(contactView.mas_bottom);
        }];
        
        //联系对方
        UILabel *contactLineLabel = [[UILabel alloc] init];
        contactLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
        [orderBottomToolBar addSubview:contactLineLabel];
        [contactLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(orderBottomToolBar);
            make.right.equalTo(contactBg);
            make.width.equalTo(CYTDividerLineWH);
        }];
        
        //去支付
        UIView *cancelOrderBg = [[UIView alloc] init];
        cancelOrderBg.backgroundColor = CYTGreenNormalColor;
        [orderBottomToolBar addSubview:cancelOrderBg];
        orderBottomToolBar.confirmRecCarRec = cancelOrderBg;
        [cancelOrderBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contactBg.mas_right);
            make.right.top.bottom.equalTo(orderBottomToolBar);
        }];
        
        //去支付
        UILabel *cancelOrderLabel = [[UILabel alloc] init];
        cancelOrderLabel.font = CYTFontWithPixel(32);
        cancelOrderLabel.textColor = [UIColor whiteColor];
        cancelOrderLabel.text = @"确认收车";
        cancelOrderLabel.textAlignment = NSTextAlignmentCenter;
        [cancelOrderBg addSubview:cancelOrderLabel];
        [cancelOrderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(cancelOrderBg);
        }];
        
        //顶部分割线
        UILabel *topLineLabel = [[UILabel alloc] init];
        topLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
        [orderBottomToolBar addSubview:topLineLabel];
        [topLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(orderBottomToolBar);
            make.top.equalTo(orderBottomToolBar);
            make.height.equalTo(CYTDividerLineWH);
        }];

    }else if(orderToolBarType == CYTOrderToolBarTypeSeeExpress){
        UIView *serviceBg = [[UIView alloc] init];
        serviceBg.backgroundColor = [UIColor whiteColor];
        [orderBottomToolBar addSubview:serviceBg];
        orderBottomToolBar.seeExpressServer = serviceBg;
        [serviceBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(99));
        }];
        
        //客服按钮
        UIImageView *serviceView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_kefu_hl_new"]];
        [serviceBg addSubview:serviceView];
        [serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(70), CYTAutoLayoutV(62)));
            make.top.equalTo(serviceBg).offset(CYTAutoLayoutV(5));
            make.centerX.equalTo(serviceBg);
        }];
        
        //客服文字
        UILabel *serviceLabel = [[UILabel alloc] init];
        serviceLabel.font = CYTFontWithPixel(24);
        serviceLabel.textColor = CYTGreenNormalColor;
        serviceLabel.text = @"客服";
        [serviceBg addSubview:serviceLabel];
        [serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(serviceView.mas_bottom);
            make.size.equalTo(CGSizeMake((serviceLabel.font.pointSize+2)*2, serviceLabel.font.pointSize+2));
            make.centerX.equalTo(serviceView);
        }];
        //客服分割线
        UILabel *serviceLineLabel = [[UILabel alloc] init];
        serviceLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
        [orderBottomToolBar addSubview:serviceLineLabel];
        [serviceLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(orderBottomToolBar);
            make.right.equalTo(serviceBg);
            make.width.equalTo(CYTDividerLineWH);
        }];
        
        //联系对方
        UIView *contactBg = [[UIView alloc] init];
        contactBg.backgroundColor = [UIColor whiteColor];
        [orderBottomToolBar addSubview:contactBg];
        orderBottomToolBar.seeExpressContact = contactBg;
        [contactBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(serviceBg.mas_right);
            make.top.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(278));
        }];
        
        //联系对方按钮
        UIImageView *contactView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_phone_hl_new"]];
        [contactBg addSubview:contactView];
        [contactView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(70), CYTAutoLayoutV(62)));
            make.top.equalTo(serviceView);
            make.centerX.equalTo(contactBg);
        }];
        
        //联系对方文字
        UILabel *contactLabel = [[UILabel alloc] init];
        contactLabel.userInteractionEnabled = YES;
        contactLabel.font = CYTFontWithPixel(24);
        contactLabel.textColor = CYTGreenNormalColor;
        contactLabel.text = @"联系对方";
        contactLabel.textAlignment = NSTextAlignmentCenter;
        [contactBg addSubview:contactLabel];
        [contactLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(contactBg);
            make.height.equalTo(contactLabel.font.pointSize+2);
            make.top.equalTo(contactView.mas_bottom);
        }];
        
        //联系对方
        UILabel *contactLineLabel = [[UILabel alloc] init];
        contactLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
        [orderBottomToolBar addSubview:contactLineLabel];
        [contactLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(orderBottomToolBar);
            make.right.equalTo(contactBg);
            make.width.equalTo(CYTDividerLineWH);
        }];
        
        //去支付
        UIView *cancelOrderBg = [[UIView alloc] init];
        cancelOrderBg.backgroundColor = CYTGreenNormalColor;
        [orderBottomToolBar addSubview:cancelOrderBg];
        orderBottomToolBar.seeExpressExpress = cancelOrderBg;
        [cancelOrderBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contactBg.mas_right);
            make.right.top.bottom.equalTo(orderBottomToolBar);
        }];
        
        //去支付
        UILabel *cancelOrderLabel = [[UILabel alloc] init];
        cancelOrderLabel.font = CYTFontWithPixel(32);
        cancelOrderLabel.textColor = [UIColor whiteColor];
        cancelOrderLabel.text = @"查看物流";
        cancelOrderLabel.textAlignment = NSTextAlignmentCenter;
        [cancelOrderBg addSubview:cancelOrderLabel];
        [cancelOrderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(cancelOrderBg);
        }];
        
        //顶部分割线
        UILabel *topLineLabel = [[UILabel alloc] init];
        topLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
        [orderBottomToolBar addSubview:topLineLabel];
        [topLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(orderBottomToolBar);
            make.top.equalTo(orderBottomToolBar);
            make.height.equalTo(CYTDividerLineWH);
        }];

    }else{
        UIView *serviceBg = [[UIView alloc] init];
        serviceBg.backgroundColor = [UIColor whiteColor];
        [orderBottomToolBar addSubview:serviceBg];
        orderBottomToolBar.cancelAndConfServer = serviceBg;
        [serviceBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(99));
        }];
        
        //客服按钮
        UIImageView *serviceView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_kefu_hl_new"]];
        [serviceBg addSubview:serviceView];
        [serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(70), CYTAutoLayoutV(62)));
            make.top.equalTo(serviceBg).offset(CYTAutoLayoutV(5));
            make.centerX.equalTo(serviceBg);
        }];
        
        //客服文字
        UILabel *serviceLabel = [[UILabel alloc] init];
        serviceLabel.font = CYTFontWithPixel(24);
        serviceLabel.textColor = CYTGreenNormalColor;
        serviceLabel.text = @"客服";
        [serviceBg addSubview:serviceLabel];
        [serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(serviceView.mas_bottom);
            make.size.equalTo(CGSizeMake((serviceLabel.font.pointSize+2)*2, serviceLabel.font.pointSize+2));
            make.centerX.equalTo(serviceView);
        }];
        //客服分割线
        UILabel *serviceLineLabel = [[UILabel alloc] init];
        serviceLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
        [orderBottomToolBar addSubview:serviceLineLabel];
        [serviceLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(orderBottomToolBar);
            make.right.equalTo(serviceBg);
            make.width.equalTo(CYTDividerLineWH);
        }];
        
        //取消
        UIView *cncenlBg = [[UIView alloc] init];
        cncenlBg.backgroundColor = [UIColor whiteColor];
        [orderBottomToolBar addSubview:cncenlBg];
        orderBottomToolBar.cancelAndConfCancel = cncenlBg;
        [cncenlBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(serviceBg.mas_right);
            make.top.bottom.equalTo(orderBottomToolBar);
            make.width.equalTo(CYTAutoLayoutH(278));
        }];
        
        UILabel *cancelLabel = [[UILabel alloc] init];
        cancelLabel.font = CYTFontWithPixel(32);
        cancelLabel.textColor = kFFColor_title_L1;
        cancelLabel.text = @"取消订单";
        cancelLabel.textAlignment = NSTextAlignmentCenter;
        [cncenlBg addSubview:cancelLabel];
        [cancelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(cncenlBg);
        }];
        
        
        //确认订单
        UIView *confirmBg = [[UIView alloc] init];
        confirmBg.backgroundColor = CYTGreenNormalColor;
        [orderBottomToolBar addSubview:confirmBg];
        orderBottomToolBar.cancelAndConfConf = confirmBg;
        [confirmBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cncenlBg.mas_right);
            make.right.top.bottom.equalTo(orderBottomToolBar);
        }];
        
        UILabel *cancelOrderLabel = [[UILabel alloc] init];
        cancelOrderLabel.font = CYTFontWithPixel(32);
        cancelOrderLabel.textColor = [UIColor whiteColor];
        cancelOrderLabel.text = @"确认订单";
        cancelOrderLabel.textAlignment = NSTextAlignmentCenter;
        [confirmBg addSubview:cancelOrderLabel];
        [cancelOrderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(confirmBg);
        }];
        
        //顶部分割线
        UILabel *topLineLabel = [[UILabel alloc] init];
        topLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
        [orderBottomToolBar addSubview:topLineLabel];
        [topLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(orderBottomToolBar);
            make.top.equalTo(orderBottomToolBar);
            make.height.equalTo(CYTDividerLineWH);
        }];
 
    }
    return orderBottomToolBar;
}

- (void)toolBarWithOnlyContactServer:(void(^)(UIView*))server contact:(void(^)(UIView*))contact {
    UITapGestureRecognizer *serverTap = [[UITapGestureRecognizer alloc] init];
    [[serverTap rac_gestureSignal] subscribeNext:^(id x) {
        if (server) {
            server(_onlyContactServer);
        }
    }];
    [_onlyContactServer addGestureRecognizer:serverTap];
    
    UITapGestureRecognizer *contactTap = [[UITapGestureRecognizer alloc] init];
    [[contactTap rac_gestureSignal] subscribeNext:^(id x) {
        if (contact) {
            contact(_onlyContactServer);
        }
    }];
    [_onlyContactContact addGestureRecognizer:contactTap];
}

- (void)toolBarWithCancelOrderServer:(void(^)(UIView*))server contact:(void(^)(UIView*))contact cancelOrder:(void(^)(UIView *))cancelOrder{
    UITapGestureRecognizer *serverTap = [[UITapGestureRecognizer alloc] init];
    [[serverTap rac_gestureSignal] subscribeNext:^(id x) {
        if (server) {
            server(_cancelOrderServer);
        }
    }];
    [_cancelOrderServer addGestureRecognizer:serverTap];
    
    UITapGestureRecognizer *contactTap = [[UITapGestureRecognizer alloc] init];
    [[contactTap rac_gestureSignal] subscribeNext:^(id x) {
        if (contact) {
            contact(_cancelOrderContact);
        }
    }];
    [_cancelOrderContact addGestureRecognizer:contactTap];
    
    UITapGestureRecognizer *cancelOrderTap = [[UITapGestureRecognizer alloc] init];
    [[cancelOrderTap rac_gestureSignal] subscribeNext:^(id x) {
        if (cancelOrder) {
            cancelOrder(_cancelOrderCancel);
        }
    }];
    [_cancelOrderCancel addGestureRecognizer:cancelOrderTap];
}

- (void)toolBarWithSendbackAndPayforServer:(void(^)(UIView*))server contact:(void(^)(UIView*))sendback cancelOrder:(void(^)(UIView *))payforSeller{
    UITapGestureRecognizer *serverTap = [[UITapGestureRecognizer alloc] init];
    [[serverTap rac_gestureSignal] subscribeNext:^(id x) {
        if (server) {
            server(_cancelOrderServer);
        }
    }];
    [_sendbackServer addGestureRecognizer:serverTap];
    
    UITapGestureRecognizer *sendbackTap = [[UITapGestureRecognizer alloc] init];
    [[sendbackTap rac_gestureSignal] subscribeNext:^(id x) {
        if (sendback) {
            sendback(_sendbackSendback);
        }
    }];
    [_sendbackSendback addGestureRecognizer:sendbackTap];
    
    UITapGestureRecognizer *payfoSellerTap = [[UITapGestureRecognizer alloc] init];
    [[payfoSellerTap rac_gestureSignal] subscribeNext:^(id x) {
        if (payforSeller) {
            payforSeller(_sendbackPayforSeller);
        }
    }];
    [_sendbackPayforSeller addGestureRecognizer:payfoSellerTap];
}

- (void)toolBarWithConfirmAndPayServer:(void(^)(UIView*))server contact:(void(^)(UIView*))pay{
    UITapGestureRecognizer *serverTap = [[UITapGestureRecognizer alloc] init];
    [[serverTap rac_gestureSignal] subscribeNext:^(id x) {
        if (server) {
            server(_confirmAndPayServer);
        }
    }];
    [_confirmAndPayServer addGestureRecognizer:serverTap];
    
    UITapGestureRecognizer *confirmAndPayTap = [[UITapGestureRecognizer alloc] init];
    [[confirmAndPayTap rac_gestureSignal] subscribeNext:^(id x) {
        if (pay) {
            pay(_confirmAndPayPay);
        }
    }];
    [_confirmAndPayPay addGestureRecognizer:confirmAndPayTap];
    
}

- (void)toolBarWithCommitServer:(void(^)(UIView*))server contact:(void(^)(UIView*))commit{
    UITapGestureRecognizer *serverTap = [[UITapGestureRecognizer alloc] init];
    [[serverTap rac_gestureSignal] subscribeNext:^(id x) {
        if (server) {
            server(_commitServer);
        }
    }];
    [_commitServer addGestureRecognizer:serverTap];
    
    UITapGestureRecognizer *commitAndPayTap = [[UITapGestureRecognizer alloc] init];
    [[commitAndPayTap rac_gestureSignal] subscribeNext:^(id x) {
        if (commit) {
            commit(_commitBtn);
        }
    }];
    [_commitBtn addGestureRecognizer:commitAndPayTap];
    
}

- (void)toolBarWithGotoPayWithSendbackServer:(void(^)(UIView*))server contact:(void(^)(UIView*))contact cancelOrder:(void(^)(UIView *))gotoPay{
    UITapGestureRecognizer *serverTap = [[UITapGestureRecognizer alloc] init];
    [[serverTap rac_gestureSignal] subscribeNext:^(id x) {
        if (server) {
            server(_gotoPayServer);
        }
    }];
    [_gotoPayServer addGestureRecognizer:serverTap];
    
    UITapGestureRecognizer *gotoPayContactTap = [[UITapGestureRecognizer alloc] init];
    [[gotoPayContactTap rac_gestureSignal] subscribeNext:^(id x) {
        if (contact) {
            contact(_gotoPayContact);
        }
    }];
    [_gotoPayContact addGestureRecognizer:gotoPayContactTap];
    
    UITapGestureRecognizer *gotoPayPayTap = [[UITapGestureRecognizer alloc] init];
    [[gotoPayPayTap rac_gestureSignal] subscribeNext:^(id x) {
        if (gotoPay) {
            gotoPay(_gotoPayPay);
        }
    }];
    [_gotoPayPay addGestureRecognizer:gotoPayPayTap];
}

- (void)toolBarWithConfirmSendCarWithSendbackServer:(void(^)(UIView*))server contact:(void(^)(UIView*))contact cancelOrder:(void(^)(UIView *))confirmSendCar{
    UITapGestureRecognizer *serverTap = [[UITapGestureRecognizer alloc] init];
    [[serverTap rac_gestureSignal] subscribeNext:^(id x) {
        if (server) {
            server(_confirmSendCarServer);
        }
    }];
    [_confirmSendCarServer addGestureRecognizer:serverTap];
    
    UITapGestureRecognizer *contactTap = [[UITapGestureRecognizer alloc] init];
    [[contactTap rac_gestureSignal] subscribeNext:^(id x) {
        if (contact) {
            contact(_confirmSendCarContact);
        }
    }];
    [_confirmSendCarContact addGestureRecognizer:contactTap];
    
    UITapGestureRecognizer *confirmSendCarTap = [[UITapGestureRecognizer alloc] init];
    [[confirmSendCarTap rac_gestureSignal] subscribeNext:^(id x) {
        if (confirmSendCar) {
            confirmSendCar(_confirmSendCarSend);
        }
    }];
    [_confirmSendCarSend addGestureRecognizer:confirmSendCarTap];
}

- (void)toolBarWithConfirmRecCarWithSendbackServer:(void(^)(UIView*))server contact:(void(^)(UIView*))contact confirmRecCar:(void(^)(UIView *))confirmRecCar{
    UITapGestureRecognizer *serverTap = [[UITapGestureRecognizer alloc] init];
    [[serverTap rac_gestureSignal] subscribeNext:^(id x) {
        if (server) {
            server(_confirmRecCarServer);
        }
    }];
    [_confirmRecCarServer addGestureRecognizer:serverTap];
    
    UITapGestureRecognizer *contactTap = [[UITapGestureRecognizer alloc] init];
    [[contactTap rac_gestureSignal] subscribeNext:^(id x) {
        if (contact) {
            contact(_confirmSendCarContact);
        }
    }];
    [_confirmRecCarContact addGestureRecognizer:contactTap];
    
    UITapGestureRecognizer *confirmSendCarTap = [[UITapGestureRecognizer alloc] init];
    [[confirmSendCarTap rac_gestureSignal] subscribeNext:^(id x) {
        if (confirmRecCar) {
            confirmRecCar(_confirmRecCarRec);
        }
    }];
    [_confirmRecCarRec addGestureRecognizer:confirmSendCarTap];
}

- (void)toolBarWithSeeExpressWithConfirmRecCarWithSendbackServer:(void(^)(UIView*))server contact:(void(^)(UIView*))contact cancelOrder:(void(^)(UIView *))seeExpress{
    UITapGestureRecognizer *serverTap = [[UITapGestureRecognizer alloc] init];
    [[serverTap rac_gestureSignal] subscribeNext:^(id x) {
        if (server) {
            server(_confirmRecCarServer);
        }
    }];
    [_seeExpressServer addGestureRecognizer:serverTap];
    
    UITapGestureRecognizer *contactTap = [[UITapGestureRecognizer alloc] init];
    [[contactTap rac_gestureSignal] subscribeNext:^(id x) {
        if (contact) {
            contact(_seeExpressContact);
        }
    }];
    [_seeExpressContact addGestureRecognizer:contactTap];
    
    UITapGestureRecognizer *confirmSendCarTap = [[UITapGestureRecognizer alloc] init];
    [[confirmSendCarTap rac_gestureSignal] subscribeNext:^(id x) {
        if (seeExpress) {
            seeExpress(_seeExpressExpress);
        }
    }];
    [_seeExpressExpress addGestureRecognizer:confirmSendCarTap];
}

- (void)toolBarWithCancelAndConfirmWithConfirmRecCarWithSendbackServer:(void(^)(UIView*))server contact:(void(^)(UIView*))cancel cancelOrder:(void(^)(UIView *))confirm{
    UITapGestureRecognizer *serverTap = [[UITapGestureRecognizer alloc] init];
    [[serverTap rac_gestureSignal] subscribeNext:^(id x) {
        if (server) {
            server(_cancelAndConfServer);
        }
    }];
    [_cancelAndConfServer addGestureRecognizer:serverTap];
    
    UITapGestureRecognizer *contactTap = [[UITapGestureRecognizer alloc] init];
    [[contactTap rac_gestureSignal] subscribeNext:^(id x) {
        if (cancel) {
            cancel(_cancelAndConfCancel);
        }
    }];
    [_cancelAndConfCancel addGestureRecognizer:contactTap];
    
    UITapGestureRecognizer *confirmSendCarTap = [[UITapGestureRecognizer alloc] init];
    [[confirmSendCarTap rac_gestureSignal] subscribeNext:^(id x) {
        if (confirm) {
            confirm(_cancelAndConfConf);
        }
    }];
    [_cancelAndConfConf addGestureRecognizer:confirmSendCarTap];
}

- (void)setSendbackSendbackEnable:(BOOL)sendbackSendbackEnable{
    _sendbackSendbackEnable = sendbackSendbackEnable;
    _sendbackSendback.enabled = sendbackSendbackEnable;
}

- (void)setSendbackPayforSellerEnable:(BOOL)sendbackPayforSellerEnable{
    _sendbackPayforSellerEnable = sendbackPayforSellerEnable;
    _sendbackPayforSeller.enabled = sendbackPayforSellerEnable;
}

- (void)setConfirmAndPayPayEnable:(BOOL)confirmAndPayPayEnable{
    _confirmAndPayPayEnable = confirmAndPayPayEnable;
    _confirmAndPayPay.enabled = confirmAndPayPayEnable;
}

- (void)setCommitBtnEnable:(BOOL)commitBtnEnable{
    _commitBtnEnable = commitBtnEnable;
    _commitBtn.enabled = commitBtnEnable;
}


@end
