//
//  ImagePickerMacro.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#ifndef ImagePickerMacro_h
#define ImagePickerMacro_h

typedef enum : NSUInteger {
    CYTAssetTypePhoto = 0,//仅图片
    CYTAssetTypeVideo = 1,//仅视频
    CYTAssetTypeAll = 2,//选择所有
} CYTAssetType;

//当前版本
#define Version(v)\
([[[UIDevice currentDevice] systemVersion] compare:[NSString stringWithFormat:@"%f",v] options:NSNumericSearch] == NSOrderedSame)

//当前版本之后的版本（不包括当前版本）
#define VersionLaterThan(v)\
([[[UIDevice currentDevice] systemVersion] compare:[NSString stringWithFormat:@"%f",v] options:NSNumericSearch] == NSOrderedDescending)

//当前版本之后的版本（包括当前版本）
#define VersionLaterOrEqualTo(v)\
([[[UIDevice currentDevice] systemVersion] compare:[NSString stringWithFormat:@"%f",v] options:NSNumericSearch] != NSOrderedAscending)

//当前版本之前的版本（不包括当前版本）
#define VersionEarlyThan(v)\
([[[UIDevice currentDevice] systemVersion] compare:[NSString stringWithFormat:@"%f",v] options:NSNumericSearch] == NSOrderedAscending)

//当前版本之前的版本（包括当前版本）
#define VersionEarlyOrEqualTo(v)\
([[[UIDevice currentDevice] systemVersion] compare:[NSString stringWithFormat:@"%f",v] options:NSNumericSearch] != NSOrderedDescending)


#endif /* ImagePickerMacro_h */
