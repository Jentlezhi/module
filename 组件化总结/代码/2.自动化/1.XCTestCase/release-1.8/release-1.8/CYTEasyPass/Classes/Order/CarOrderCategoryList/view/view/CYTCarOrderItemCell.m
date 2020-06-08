//
//  CYTCarOrderItemCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/29.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarOrderItemCell.h"
#import "CYTCarOrderItemVM.h"

#define kComment                @"去评价"
#define kRefundPass             @"同意"
#define kRefundReject           @"不同意"
#define kCancelOrder            @"取消订单"
#define kPayMoney               @"去支付"
#define kCarInfo                @"发车信息"
#define kAffirmOrder            @"确认订单"
#define kAffirmSend             @"确认接单"
#define kAffirmReceive          @"确认成交"
#define kNeedLogisticService    @"叫个物流"

@interface CYTCarOrderItemCell ()
///订单状态，全部，待付款，待发车等
@property (nonatomic, assign) CarOrderState orderState;
///订单类型，卖车、买车
@property (nonatomic, assign) CarOrderType orderType;
///showaction
@property (nonatomic, assign) BOOL showAction;

@end

@implementation CYTCarOrderItemCell

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.numberView,self.infoView,self.bottomInfoView,self.actionView];
    block(views,^{
        self.hideBottomLine = YES;
    });
}

- (void)updateConstraints {
    [self.numberView updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(0);
        make.height.equalTo(CYTAutoLayoutV(70));
    }];
    [self.infoView updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.ffContentView);
        make.top.equalTo(self.numberView.bottom);
    }];
    [self.bottomInfoView updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.ffContentView);
        make.top.equalTo(self.infoView.bottom);
    }];
    [self.actionView updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.ffContentView);
        make.top.equalTo(self.bottomInfoView.bottom);
        make.height.equalTo(0);
        make.bottom.equalTo(0);
    }];
    
    if (self.showAction) {
        self.actionView.hidden = NO;
        [self.actionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(CYTAutoLayoutV(90));
        }];
    }else {
        self.actionView.hidden = YES;
        [self.actionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(CYTAutoLayoutV(0));
        }];
    }
    
    [super updateConstraints];
}

- (void)setModel:(CYTCarOrderItemModel_item *)model {
    _model = model;
    
    //订单号赋值
    self.numberView.contentLabel.text = model.orderCode;
    self.numberView.assistantLabel.text = model.orderStatusDesc;
    
    //-1 取消，311 成功,300待评价
    if (model.orderStatus == CarOrderStateCancel || model.orderStatus == CarOrderStateSucceed || model.orderStatus == CarOrderStateUnComment) {
        self.numberView.assistantLabel.textColor = kFFColor_title_L2;
    }else {
        self.numberView.assistantLabel.textColor = CYTRedColor;
    }

    //info赋值
    CYTCarSourceListModel *infoModel = [CYTCarOrderItemVM carInfoModelWithOrderModel:model];
    self.infoView.carSourceListModel = infoModel;
    
    //下单时间赋值
    self.bottomInfoView.createOrderTime = model.createOrderTime;
    self.bottomInfoView.payment = model.payDesc;
}

- (void)configActionWithOrderType:(CarOrderType)orderType andOrderState:(CarOrderState)orderState {
    self.orderType = orderType;
    self.orderState = orderState;
    NSArray *titleArray = [self getActionTitleArray];
    
    NSString *leftString;
    NSString *rightString;
    NSString *midString;
    if (titleArray.count == 0) {
        //0
        leftString = @"";
        rightString = @"";
    }else if (titleArray.count == 1) {
        //1
        leftString = @"";
        rightString = titleArray[0];
    }else if (titleArray.count == 2){
        //2
        leftString = titleArray[0];
        rightString = titleArray[1];
    }else if (titleArray.count == 3) {
        //3
        leftString = titleArray[0];
        rightString = titleArray[1];
        midString = titleArray[2];
    }
    
    [self configActionViewWithLeft:leftString right:rightString mid:midString];
    
}

- (void)configActionViewWithLeft:(NSString *)leftString right:(NSString *)rightString mid:(NSString *)midString{
    [self.actionView.firstButton setTitle:leftString forState:UIControlStateNormal];
    [self.actionView.secondButton setTitle:rightString forState:UIControlStateNormal];
    [self.actionView.midButton setTitle:midString forState:UIControlStateNormal];
    self.showAction = !([leftString isEqualToString:@""] && [rightString isEqualToString:@""]);
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    self.actionView.midButton.hidden = YES;
    
    if ([leftString isEqualToString:@""]) {
        self.actionView.firstButton.hidden = YES;
        
        //如果是评价则显示绿色，否则灰色
        if (self.orderState == CarOrderStateUnComment) {
            self.actionView.secondButton.backgroundColor = kFFColor_green;
            [self.actionView.secondButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.actionView.secondButton radius:1 borderWidth:1 borderColor:kFFColor_green];
        }else {
            self.actionView.secondButton.backgroundColor = [UIColor whiteColor];
            [self.actionView.secondButton setTitleColor:kFFColor_title_L1 forState:UIControlStateNormal];
            [self.actionView.secondButton radius:1 borderWidth:1 borderColor:kFFColor_line];
        }
    }else{
        self.actionView.firstButton.hidden = NO;
        
        self.actionView.secondButton.backgroundColor = kFFColor_green;
        [self.actionView.secondButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.actionView.secondButton radius:1 borderWidth:1 borderColor:kFFColor_green];
        
        if (midString.length>0) {
            self.actionView.midButton.hidden = NO;
            [self.actionView.firstButton remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(CYTAutoLayoutV(10));
                make.size.equalTo(CGSizeMake(CYTAutoLayoutH(180), CYTAutoLayoutV(58)));
                make.right.equalTo(self.actionView.midButton.mas_left).offset(-CYTAutoLayoutH(20));
            }];
        }else {
            [self.actionView.firstButton remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(CYTAutoLayoutV(10));
                make.size.equalTo(CGSizeMake(CYTAutoLayoutH(180), CYTAutoLayoutV(58)));
                make.right.equalTo(self.actionView.secondButton.mas_left).offset(-CYTAutoLayoutH(20));
            }];
        }
    }
}

- (NSArray *)getActionTitleArray {
    NSMutableArray *result = [NSMutableArray array];
    
    NSString *leftString;
    NSString *rightString;
    NSString *midString;
    
    switch (self.orderState) {
        case CarOrderStateUnPay:
        {
            if (self.orderType == CarOrderTypeBought) {
                //买车
                leftString = kCancelOrder;
                rightString = kPayMoney;
            }else {
                //卖车
                rightString = kCancelOrder;
            }
        }
            break;
        case CarOrderStateUnSendCar:
        {
            if (self.orderType == CarOrderTypeBought) {
                //买车
                leftString = kCancelOrder;
                rightString = kNeedLogisticService;
            }else {
                //卖车
                leftString = kCancelOrder;
                rightString = kAffirmSend;
            }
        }
            break;
        case CarOrderStateUnReceiveCar:
        {
            if (self.orderType == CarOrderTypeBought) {
                //买车
                leftString = kCarInfo;
                rightString = kAffirmReceive;
                midString = kNeedLogisticService;
            }else {
                //卖车
                rightString = kCarInfo;
            }
        }
            break;
        case CarOrderStateUnComment:
        {
            if (self.orderType == CarOrderTypeBought) {
                //买车
                rightString = kComment;
            }else {
                //卖车
                rightString = kComment;
            }
        }
            break;
        case CarOrderStateRefundSellerDo:
        {
            if (self.orderType == CarOrderTypeBought) {
                //买车
            }else {
                //卖车
                leftString = kRefundReject;
                rightString = kRefundPass;
            }
        }
            break;
            
        default:
            break;
    }
    
    
    if (leftString) {
        [result addObject:leftString];
    }
    
    if (rightString) {
        [result addObject:rightString];
    }
    
    if (midString) {
        [result addObject:midString];
    }
    
    return result;
}

#pragma mark- get
- (CYTCarOrderItemCell_orderNum *)numberView {
    if (!_numberView) {
        _numberView = [CYTCarOrderItemCell_orderNum new];
    }
    return _numberView;
}

- (CYTCarListInfoView *)infoView {
    if (!_infoView) {
        _infoView = [CYTCarListInfoView carListInfoWithType:CYTCarListInfoTypeCarSource hideTopBar:YES];
    }
    return _infoView;
}

- (CYTOrderBottomInfoView *)bottomInfoView {
    if (!_bottomInfoView) {
        _bottomInfoView = [CYTOrderBottomInfoView new];
    }
    return _bottomInfoView;
}

- (CYTCarOrderItemCell_action *)actionView {
    if (!_actionView) {
        _actionView = [CYTCarOrderItemCell_action new];
        @weakify(self);
        [_actionView setFirstBlock:^(NSInteger index) {
            @strongify(self);
            if (self.actionBlock) {
                self.actionBlock(self,index);
            }
        }];
        
        [_actionView setSecondBlock:^(NSInteger index) {
            @strongify(self);
            if (self.actionBlock) {
                self.actionBlock(self,index);
            }
        }];
        
        [_actionView setMidBlock:^(NSInteger index) {
            @strongify(self);
            if (self.actionBlock) {
                self.actionBlock(self,index);
            }
        }];
    }
    return _actionView;
}

@end
