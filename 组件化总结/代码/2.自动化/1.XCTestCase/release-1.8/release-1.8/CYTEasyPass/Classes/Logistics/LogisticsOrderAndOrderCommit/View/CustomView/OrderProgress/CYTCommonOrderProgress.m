//
//  CYTCommonOrderProgress.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCommonOrderProgress.h"
#import "CYTCommonOrderStatusBar.h"

#define kOrderCancelHighlightColor CYTHexColor(@"#999999")
#define kOrderNormalHighlightColor CYTGreenNormalColor


@interface CYTCommonOrderProgress()

/** 标题 */
@property(strong, nonatomic) NSArray *titlesArray;

@end

@implementation CYTCommonOrderProgress

- (NSArray *)titlesArray{
    if (!_titlesArray) {
        _titlesArray = [NSArray array];
    }
    return _titlesArray;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonOrderProgressBasicConfig];
        [self initCommonOrderProgressComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)commonOrderProgressBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}
/**
 *  初始化子控件
 */
- (void)initCommonOrderProgressComponents{
    //进度条
//    CYTCommonOrderStatusBar *bar = [[CYTCommonOrderStatusBar alloc] init];
//    [self addSubview:bar];
//    [bar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self);
//        make.size.equalTo(CGSizeMake(110.f, CYTAutoLayoutV((28+10)*2 + 32.f)));
//    }];
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    
}

+ (instancetype)orderProgressWithStatus:(NSUInteger)status highlightColor:(UIColor *)highlightColor titlesArray:(NSArray *)titlesArray{
    if (!titlesArray || titlesArray.count == 0) return nil;
    NSUInteger barNum = titlesArray.count;
    status = status>=barNum?barNum:status;
    CYTCommonOrderProgress *commonOrderProgress = [[CYTCommonOrderProgress alloc] init];
    commonOrderProgress.titlesArray = [titlesArray copy];
    CYTCommonOrderStatusBarType commonOrderStatusBarType = CYTCommonOrderStatusBarTitleUp;
    NSString *title = [NSString string];
    CGFloat leftRightMargin = CYTMarginH;
    CGFloat barW = (kScreenWidth-2*leftRightMargin)/barNum;
    CGFloat barX = 0;
    CGFloat barY = 0;
    CGFloat barH = CYTAutoLayoutV((28+10)*2 + 32.f);
    NSMutableArray *barsArray = [NSMutableArray array];
    for (NSUInteger index = 0; index<barNum; index++) {
        commonOrderStatusBarType = index%2==0?CYTCommonOrderStatusBarTitleUp:CYTCommonOrderStatusBarTitleDown;
        title = titlesArray[index];
        CYTCommonOrderStatusBar *orderStatusBar = [CYTCommonOrderStatusBar commonOrderStatusBarWithStyle:commonOrderStatusBarType title:title highlightColor:highlightColor];
        //处理首尾进度点左右条
        orderStatusBar.hideLeftBar = index == 0;
        orderStatusBar.hideRightBar = index == barNum-1;
        //处理高亮状态
        orderStatusBar.highlighted = status>index;
        CYTCommonOrderStatusBar *preStatusBar = index<1?nil:barsArray[index-1];
        orderStatusBar.highlightedLeftBar = preStatusBar.highlighted;
        //设置frame
        barX = preStatusBar?CGRectGetMaxX(preStatusBar.frame):leftRightMargin;
        orderStatusBar.frame = CGRectMake(barX, barY, barW, barH);
        [commonOrderProgress addSubview:orderStatusBar];
        //存放进度条
        [barsArray addObject:orderStatusBar];

    }
    return commonOrderProgress;
}

+ (instancetype)logisticOrderProgressWithStatus:(CYTLogisticOrderStatus)logisticOrderStatus orderStatusStyle:(CYTOrderStatusStyle)orderStatusStyle{
    UIColor *highlightColor = orderStatusStyle == CYTOrderStatusStyleNormal?kOrderNormalHighlightColor:kOrderCancelHighlightColor;
    CYTCommonOrderProgress *commonOrderProgress = [CYTCommonOrderProgress orderProgressWithStatus:logisticOrderStatus highlightColor:highlightColor titlesArray:@[@"提交订单",@"待配板",@"待司机上门",@"运输中",@"已完成"]];
    return commonOrderProgress;
}

+ (instancetype)orderProgressWithOrderType:(CYTOrderProgressStatusType)orderProgressStatusType status:(NSInteger)orderStatus orderStatusStyle:(CYTOrderStatusStyle)orderStatusStyle{
    UIColor *highlightColor = orderStatusStyle == CYTOrderStatusStyleNormal?kOrderNormalHighlightColor:kOrderCancelHighlightColor;
    NSArray *titlesArray = [NSArray array];
    if (orderProgressStatusType == CYTOrderProgressStatusTypeCarsource) {
        titlesArray = @[@"发起交易",@"卖家确认",@"买家支付",@"卖家发车",@"买家收车",@"交易完成"];
    }else{
        titlesArray = @[@"发起交易",@"买家支付",@"卖家发车",@"买家收车",@"交易完成"];
    }
    CYTCommonOrderProgress *commonOrderProgress = [CYTCommonOrderProgress orderProgressWithStatus:orderStatus highlightColor:highlightColor titlesArray:titlesArray];
    return commonOrderProgress;
}


@end
