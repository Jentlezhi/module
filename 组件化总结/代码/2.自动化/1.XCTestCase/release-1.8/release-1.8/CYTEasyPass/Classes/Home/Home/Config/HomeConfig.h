//
//  HomeConfig.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#ifndef HomeConfig_h
#define HomeConfig_h

#define kSearchBgColor [UIColor whiteColor]
#define kSearchBgViewDefaultAlpha (0.01f)
#define kBannerViewHeightPixel (350.f)
#define kToolViewHeightPixel (150.f)
#define kDealerRecommendViewHeightPixel (90.f)
#define kAdsInfoViewHeightPixel (170.f)
#define kNoNetworkViewY (CYTAutoLayoutV(kBannerViewHeightPixel + kToolViewHeightPixel))
#define kNoDateViewY (CYTAutoLayoutV(kBannerViewHeightPixel + kToolViewHeightPixel + kDealerRecommendViewHeightPixel + kAdsInfoViewHeightPixel + 80.f) + 3*CYTItemMarginV)
#endif /* HomeConfig_h */
