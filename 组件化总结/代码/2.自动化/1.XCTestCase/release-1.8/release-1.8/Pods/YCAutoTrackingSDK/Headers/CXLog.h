//
//  CXLog.h
//  Pods
//
//  Created by ishaolin on 2017/7/4.
//
//

#ifndef CXLog_h
#define CXLog_h

#import "CXLogger.h"

#define _CX_POSSIBLE_LOG(level, format, ...) \
do { _CXLog(level, __FILE__, __FUNCTION__, __LINE__, format, ##__VA_ARGS__); } while(0)

#define CXLogFatel(format, ...)     _CX_POSSIBLE_LOG(CXLogLevelFatel, format, ##__VA_ARGS__)
#define CXLogError(format, ...)     _CX_POSSIBLE_LOG(CXLogLevelError, format, ##__VA_ARGS__)
#define CXLogWarn(format, ...)      _CX_POSSIBLE_LOG(CXLogLevelWarn, format, ##__VA_ARGS__)
#define CXLogInfo(format, ...)      _CX_POSSIBLE_LOG(CXLogLevelInfo, format, ##__VA_ARGS__)
#define CXLogTrace(format, ...)     _CX_POSSIBLE_LOG(CXLogLevelTrace, format, ##__VA_ARGS__)
#define CXLogDebug(format, ...)     _CX_POSSIBLE_LOG(CXLogLevelDebug, format, ##__VA_ARGS__)

#define CXAssert(condition, format, ...) \
do { _CXAssert((condition) ? YES : NO, __FILE__, __FUNCTION__, __LINE__, format, ##__VA_ARGS__); } while(0)

#define CXLog(format, ...)  CXLogInfo(format, ##__VA_ARGS__)
#define CXLogBreakpoint(format, ...) CXAssert(NO, format, ##__VA_ARGS__)

#endif /* CXLog_h */
