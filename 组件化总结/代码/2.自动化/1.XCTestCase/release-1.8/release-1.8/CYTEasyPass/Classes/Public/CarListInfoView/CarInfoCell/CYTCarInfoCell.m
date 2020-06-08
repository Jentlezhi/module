//
//  CYTCarInfoCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/8/30.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarInfoCell.h"
#import "CYTCarListInfoView.h"
#import "CYTOrderBottomInfoView.h"
#import "CYTCarSourceListModel.h"
#import "CYTSeekCarListModel.h"
#import "CYTSeekCarInfo.h"
#import "CYTCarSourceInfo.h"
#import "CYTDealer.h"
#import "CYTCarModel.h"
#import "CYTOrderModel.h"
#import "CYTCarInfoNumberView.h"

@interface CYTCarInfoCell()

/** <#注释#> */
@property(strong, nonatomic) NSDictionary *dict;

@end

@implementation CYTCarInfoCell
{
    //分割条
    UIView *_topBar;
    ///数量
    CYTCarInfoNumberView *_numberView;
    //车款信息
    CYTCarListInfoView *_carListInfoView;
    //订单底部信息
    CYTOrderBottomInfoView *_bottomInfoView;
}

#warning TODO:测试数据
- (NSDictionary *)dict{
    if (!_dict) {
        _dict = @{
//                  @"carInfo": @{
//                      @"carReferPrice": @"66.30",
//                      @"carReferPriceDesc": @"66.30万",
//                      @"carSourceId": @0,
//                      @"seekCarId": @948,
//                      @"brandName": @"梅赛德斯-奔驰",
//                      @"serialName": @"SLK级",
//                      @"carYearType": @"2011",
//                      @"carName": @"SLK 200 豪华运动型",
//                      @"fullCarName": @"2011款 SLK 200 豪华运动型",
//                      @"carSourceTypeName": @"美规现货",
//                      @"salePrice": @"",
//                      @"exteriorColor":@ "碧蓝",
//                      @"interiorColor": @"不限",
//                      @"carSourceAddress": @"宁德市",
//                      @"publishTime":@ "09-01",
//                      @"priceMode": @"",
//                      @"priceBasicPoint":@ ""
//                  },
//                  @"carSourceInfo":@{
//                          @"carReferPrice":@"0",
//                          @"carReferPriceDesc":@"",
//                          @"carSourceId":@32295,
//                          @"brandName":@"阿尔法·罗密欧",
//                          @"serialName":@"阿尔法罗密欧Gtv",
//                          @"carYearType":@2003,
//                          @"carName":@"Gtv",
//                          @"fullCarName":@"2003款 Gtv",
//                          @"carSourceTypeName":@"美规期货",
//                          @"salePrice":@"10.00",
//                          @"exteriorColor":@"多种可选",
//                          @"interiorColor":@"色全",
//                          @"carSourceAddress":@"重庆",
//                          @"publishTime":@"16:18",
//                          @"priceMode":@2,
//                          @"priceBasicPoint":@"10.00",
//                          @"rowId":@206250},
//                  @"dealer":@{
//                          
//                          }
                  };
    }
    return _dict;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style type:(CYTCarInfoCellType)carInfoCellType reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self carInfoBasicConfig];
        [self initCarInfoComponentsWithType:carInfoCellType];
        [self makeConstrainsWithType:carInfoCellType];
        
        UITapGestureRecognizer *tapGes = [UITapGestureRecognizer new];
        [[tapGes rac_gestureSignal] subscribeNext:^(id x) {
            if (self.clickedBlock) {
                self.clickedBlock(self.carModel);
            }
        }];
        [self addGestureRecognizer:tapGes];
    }
    return self;
}

/**
 *  基本配置
 */
- (void)carInfoBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
/**
 *  初始化子控件
 */
- (void)initCarInfoComponentsWithType:(CYTCarInfoCellType)carInfoCellType{
    //分割条
    UIView *topBar = [[UIView alloc] init];
    topBar.backgroundColor = kFFColor_bg_nor;
    [self.contentView addSubview:topBar];
    _topBar = topBar;
    
    //数量
    if(carInfoCellType == CYTCarInfoCellTypeOrderDetail){
        CYTCarInfoNumberView *numberView = [CYTCarInfoNumberView new];
        [self.contentView addSubview:numberView];
        _numberView = numberView;
    }
    
    //车款信息
    CYTCarListInfoType carListInfoType = CYTCarListInfoTypeCarSource;
    if (carInfoCellType == CYTCarInfoCellTypeCarSource) {
        carListInfoType = CYTCarListInfoTypeCarSource;
    }else if(carInfoCellType == CYTCarInfoCellTypeOrderDetail){
        carListInfoType = CYTCarListInfoTypeCarSource;
    }else{
        carListInfoType = CYTCarListInfoTypeSeekCar;
    }
    CYTCarListInfoView *carListInfoView = [CYTCarListInfoView carListInfoWithType:carListInfoType hideTopBar:YES];
    [self.contentView addSubview:carListInfoView];
    _carListInfoView = carListInfoView;
    
    //订单底部信息
    if (carInfoCellType == CYTCarInfoCellTypeOrderDetail) {
        CYTOrderBottomInfoView *bottomInfoView = [[CYTOrderBottomInfoView alloc] init];
        [self.contentView addSubview:bottomInfoView];
        _bottomInfoView = bottomInfoView;
    }
    //测试数据
//    CYTSeekCarListModel *seekCarListModel = [CYTSeekCarListModel mj_objectWithKeyValues:self.dict];
//    carListInfoView.seekCarListModel = seekCarListModel;
}
/**
 *  布局控件
 */
- (void)makeConstrainsWithType:(CYTCarInfoCellType)carInfoCellType{
    if (carInfoCellType == CYTCarInfoCellTypeSeekCar || carInfoCellType == CYTCarInfoCellTypeCarSource) {//提交订单
        [_topBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.contentView);
            make.height.equalTo(CYTAutoLayoutV(20));
        }];
        [_carListInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.top.equalTo(_topBar.mas_bottom).priorityMedium();
        }];
        return;
    }

    if (carInfoCellType == CYTCarInfoCellTypeOrderDetail) {
        CGFloat orderBottomInfoViewH = CYTAutoLayoutV(70.f);
        [_topBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.right.equalTo(self.contentView);
            make.height.equalTo(CYTAutoLayoutV(20));
        }];
        [_numberView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_topBar.mas_bottom);
            make.left.right.equalTo(self.contentView);
        }];
        [_carListInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(_numberView.mas_bottom);
            make.bottom.equalTo(-orderBottomInfoViewH);
        }];
        
        [_bottomInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_carListInfoView.mas_bottom);
            make.left.right.equalTo(_carListInfoView);
            make.height.equalTo(orderBottomInfoViewH);
        }];
        return;
    }
}

+ (instancetype)cellWithType:(CYTCarInfoCellType)carInfoCellType forTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"CYTCarInfoCell";
    CYTCarInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTCarInfoCell alloc] initWithStyle:UITableViewCellStyleDefault type:carInfoCellType reuseIdentifier:identifier ];
    }
    return cell;
}

- (void)setSeekCarInfo:(CYTSeekCarInfo *)seekCarInfo{
    if (!seekCarInfo) return;
    _seekCarInfo = seekCarInfo;
    CYTSeekCarListModel *seekCarListModel = [[CYTSeekCarListModel alloc] init];
    seekCarListModel.seekCarInfo = seekCarInfo;
    _carListInfoView.seekCarListModel = seekCarListModel;
}

- (void)setCarSourceInfo:(CYTCarSourceInfo *)carSourceInfo{
    if (!carSourceInfo) return;
    _carSourceInfo = carSourceInfo;
    CYTCarSourceListModel *carSourceListModel = [[CYTCarSourceListModel alloc] init];
    carSourceListModel.carSourceInfo = carSourceInfo;
    _carListInfoView.carSourceListModel = carSourceListModel;
}

- (void)setCarModel:(CYTCarModel *)carModel{
    _carModel = carModel;
    _numberView.number = carModel.orderModel.carNum;
    _carListInfoView.carModel = carModel;
    _bottomInfoView.createOrderTime = carModel.orderModel.createOrderTime;
    _bottomInfoView.payment = carModel.payDesc;
}


@end
