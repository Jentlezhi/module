//
//  CXLogger.h
//  Pods
//
//  Created by ishaolin on 2017/7/4.
//
//

#import <Foundation/Foundation.h>
#import "CXExternDefines.h"

typedef NS_ENUM(NSInteger, CXLogLevel){
    CXLogLevelFatel = 0,
    CXLogLevelError = 1,
    CXLogLevelWarn  = 2,
    CXLogLevelInfo  = 3,
    CXLogLevelTrace = 4,
    CXLogLevelDebug = 5
};

CX_FOUNDATION_EXTERN void _CXLog(CXLogLevel level,
                                 const char *file,
                                 const char *function,
                                 NSUInteger line,
                                 NSString *format, ...) NS_FORMAT_FUNCTION(5, 6);

CX_FOUNDATION_EXTERN void _CXAssert(BOOL condition,
                                    const char *file,
                                    const char *function,
                                    NSUInteger line,
                                    NSString *format, ...) NS_FORMAT_FUNCTION(5, 6);
