//
//  CYTCoinTaskCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/15.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCoinTaskCell.h"
#import "CYTTaskModel.h"
#import "CYTGetCoinModel.h"
#import "CYTCoinCardView.h"
#import "CYTIndicatorView.h"

@interface CYTCoinTaskCell()

/** 分割线 */
@property(strong, nonatomic) UILabel *dividerLine;
/** 标题 */
@property(strong, nonatomic) UILabel *titleLabel;
/** 奖励金币 */
@property(strong, nonatomic) UILabel *rewardValueLabel;
/** 指示文字 */
@property(strong, nonatomic) UILabel *indicateLabel;
/** 指示箭头 */
@property(strong, nonatomic) UIImageView *arrowIcon;
/** 领取 */
@property(strong, nonatomic) UIButton *getBtn;
/** 任务说明 */
@property(strong, nonatomic) UIButton *taskDescBtn;

@end

@implementation CYTCoinTaskCell

- (void)initSubComponents{
    [self.contentView addSubview:self.dividerLine];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.rewardValueLabel];
    [self.contentView addSubview:self.indicateLabel];
    [self.contentView addSubview:self.arrowIcon];
    [self.contentView addSubview:self.getBtn];
    [self.contentView addSubview:self.taskDescBtn];
}

- (void)makeSubConstrains{
    [self.dividerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(CYTItemMarginH);
        make.right.equalTo(-CYTItemMarginH);
        make.height.equalTo(CYTDividerLineWH);
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTItemMarginH);
        make.top.equalTo(CYTMarginV);
        make.bottom.equalTo(-CYTMarginV);
    }];

    [self.rewardValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(CYTAutoLayoutH(10.f));
        make.centerY.equalTo(self.contentView);
        make.right.lessThanOrEqualTo(-CYTAutoLayoutH(195.f));
    }];

    [self.arrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(CYTAutoLayoutV(44.f));
        make.right.equalTo(-CYTAutoLayoutH(10.f));
        make.centerY.equalTo(self.contentView);
    }];

    [self.indicateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowIcon.mas_left);
        make.centerY.equalTo(self.contentView);
    }];

    [self.getBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(-CYTAutoLayoutH(12.f));
    }];

    [self.taskDescBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(-CYTAutoLayoutH(22.f));
    }];
}

#pragma mark - 懒加载
- (UILabel *)dividerLine{
    if (!_dividerLine) {
        _dividerLine = [UILabel dividerLineLabel];
    }
    return _dividerLine;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithTextColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:30.f setContentPriority:NO];
    }
    return _titleLabel;
}

- (UILabel *)rewardValueLabel{
    if (!_rewardValueLabel) {
        _rewardValueLabel = [UILabel labelWithTextColor:CYTHexColor(@"#C39F5B") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:YES];
    }
    return _rewardValueLabel;
}
- (UILabel *)indicateLabel{
    if (!_indicateLabel) {
        _indicateLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentRight fontPixel:26.f setContentPriority:YES];
    }
    return _indicateLabel;
}
- (UIImageView *)arrowIcon{
    if (!_arrowIcon) {
        _arrowIcon = [UIImageView ff_imageViewWithImageName:@"arrow_right"];
    }
    return _arrowIcon;
}
- (UIButton *)getBtn{
    if (!_getBtn) {
        _getBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getBtn setBackgroundImage:[UIImage imageNamed:@"btn_lingqu"] forState:UIControlStateNormal];
        _getBtn.titleLabel.font = CYTFontWithPixel(26.f);
        [_getBtn setTitleColor:CYTHexColor(@"#FFFFFF") forState:UIControlStateNormal];
        [_getBtn setTitle:@"领取" forState:UIControlStateNormal];
        [[_getBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            NSString *taskId = _taskModel.taskId;
            NSMutableDictionary *par = [NSMutableDictionary dictionary];
            [par setValue:taskId forKey:@"taskId"];
            CYTWeakSelf
//            CYTGetCoinModel *getCoinModel = CYTGetCoinModel.new;
//            getCoinModel.rewardValue = @"50";
//            getCoinModel.isAllFinished = YES;
//            getCoinModel.amount = @"3000";
//            !weakSelf.receiveAward?:weakSelf.receiveAward(getCoinModel);
            CYTIndicatorView *indicatorView = [CYTIndicatorView showIndicatorViewWithType:CYTIndicatorViewTypeEditNavBar];
            indicatorView.infoMessage = @"";
            [CYTNetworkManager POST:kURL.user_ycbhome_ReceiveReward parameters:par dataTask:nil showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
                [CYTIndicatorView hideIndicatorView];
                CYTGetCoinModel *getCoinModel = [CYTGetCoinModel mj_objectWithKeyValues:responseObject.dataDictionary];
                !weakSelf.receiveAward?:weakSelf.receiveAward(getCoinModel);
            }];
        }];
    }
    return _getBtn;
}

- (UIButton *)taskDescBtn{
    if (!_taskDescBtn) {
        _taskDescBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_taskDescBtn setBackgroundImage:[UIImage imageNamed:@"btn_renwu_hl"] forState:UIControlStateNormal];
        _taskDescBtn.titleLabel.font = CYTFontWithPixel(26.f);
        [_taskDescBtn setTitleColor:CYTHexColor(@"#C39F5B") forState:UIControlStateNormal];
        [_taskDescBtn setTitle:@"任务说明" forState:UIControlStateNormal];
        [[_taskDescBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            NSString *html = [_taskModel.scheme replaceOccurrences:@"cxt://dialog/task?description="];
            [CYTCoinCardView showSuccessWithType:CYTCoinCardTypeTaskSpecification model:html];
        }];
    }
    return _taskDescBtn;
}

- (void)setTaskModel:(CYTTaskModel *)taskModel{
    _taskModel = taskModel;
    self.titleLabel.text = taskModel.title;
    NSString *rewardValue = taskModel.rewardValue.length ? [NSString stringWithFormat:@"+%@币",taskModel.rewardValue]:@"";
    self.rewardValueLabel.text = rewardValue;

    NSInteger taskType = taskModel.taskType;
    /** 任务状态（1去完成 ，2待领取，3任务说明，4已结束，5已完成，6结果链接）*/
    NSInteger taskStatus = taskModel.taskStatus;
    if (taskType == 1) {//新手任务
        self.indicateLabel.text = @"去完成";
        self.indicateLabel.textColor = CYTHexColor(@"#666666");
        self.indicateLabel.hidden = taskStatus != 1;
        self.arrowIcon.hidden = taskStatus != 1;
        self.taskDescBtn.hidden = YES;
        self.getBtn.hidden = taskStatus == 1;
    }else{//活动任务
        NSString *indicateText = @"";
        UIColor *indicateColor;
        if(taskStatus == 4){
            indicateText = @"已结束";
            indicateColor = CYTHexColor(@"#999999");
        }else if (taskStatus == 5){
            indicateText = @"已完成";
            indicateColor = CYTHexColor(@"#999999");
        }else if (taskStatus == 6){
            indicateText = @"活动结果";
            indicateColor = CYTHexColor(@"#666666");
        }
        self.indicateLabel.text = indicateText;
        self.indicateLabel.textColor = indicateColor;
        self.indicateLabel.hidden = !(taskStatus == 4 || taskStatus == 5 || taskStatus == 6);
        self.arrowIcon.hidden = taskStatus != 6;
        self.taskDescBtn.hidden = taskStatus != 3;
        self.getBtn.hidden = taskStatus != 2;
    }
}

@end
