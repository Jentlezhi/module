//
//  JZCircleScrollView.h
//  MainFrame_Example
//
//  Created by Jentle on 2017/12/24.
//  Copyright © 2017年 Jentlezhi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CycleViewStyleNone,
    CycleViewStyleTitle,
    CycleViewStylePageControl,
    CycleViewStyleBoth
} CycleViewStyle;

@protocol CycleViewDelegate <NSObject>

@optional

- (void)whenCycleClick:(NSInteger)index;

@end


@interface JZCircleScrollView : UIView

{
    float _automaticScrollDelay;
    CycleViewStyle _cycleViewStyle;
}

@property(nonatomic, strong) NSArray *picDataArray;
@property(nonatomic, strong) NSArray *titleDataArray;
@property(nonatomic, assign) NSUInteger currentImageIndex;
@property(nonatomic, weak) UIFont *titleLabelTextFont;
@property(nonatomic, weak) UIColor *titleLabelTextColor;
@property(nonatomic, weak) UIColor *pageControlTintColor;
@property(nonatomic, weak) UIColor *pageControlCurrentColor;

@property(nonatomic, assign) BOOL isAutomaticScroll;
@property(nonatomic, copy) NSString *currentImageName;
@property(nonatomic, assign) float automaticScrollDelay;
@property(nonatomic, assign) CycleViewStyle cycleViewStyle;

@property(nonatomic, weak) id<CycleViewDelegate> delegate;

@end
