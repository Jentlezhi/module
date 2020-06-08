//
//  CXExternDefines.h
//  Pods
//
//  Created by ishaolin on 2017/7/28.
//
//

#ifndef CXExternDefines_h
#define CXExternDefines_h

#import <Availability.h>

#if defined(__cplusplus)
#define CX_FOUNDATION_EXTERN   extern "C"
#else
#define CX_FOUNDATION_EXTERN   extern
#endif

#define CX_DEPRECATED(msg) __deprecated_msg(msg)

#define CX_CLASS_DEPRECATED(msg1, msg2) CX_DEPRECATED(msg2)

#endif /* CXExternDefines_h */
