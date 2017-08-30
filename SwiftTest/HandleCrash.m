//
//  HandleCrash.m
//  SwiftTest
//
//  Created by 张琳 on 2017/8/21.
//  Copyright © 2017年 张琳. All rights reserved.
//

#import "HandleCrash.h"
#import <stdatomic.h>
#include <execinfo.h>

@implementation HandleCrash
NSString * const UncaughtExceptionHandlerSignalExceptionName = @"UncaughtExceptionHandlerSignalExceptionName";
NSString * const UncaughtExceptionHandlerSignalKey = @"UncaughtExceptionHandlerSignalKey";
NSString * const UncaughtExceptionHandlerAddressesKey = @"UncaughtExceptionHandlerAddressesKey";

atomic_int UncaughtExceptionCount = 0;
const int32_t UncaughtExceptionMaximum = 10;

const NSInteger UncaughtExceptionHandlerSkipAddressCount = 4;
const NSInteger UncaughtExceptionHandlerReportAddressCount = 5;


+ (NSString *)crash:(int)signal {
    int exceptionCount = atomic_fetch_add_explicit(&UncaughtExceptionCount, 1,  memory_order_relaxed);
    if (exceptionCount > UncaughtExceptionMaximum) {
        return @"";
    }
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:signal]
                                                                       forKey:UncaughtExceptionHandlerSignalKey];
    NSArray *callStack = [self backtrace];
    [userInfo setObject:callStack
                 forKey:UncaughtExceptionHandlerAddressesKey];
    
    NSException *exception = [NSException
                              exceptionWithName: UncaughtExceptionHandlerSignalExceptionName reason: [NSString stringWithFormat:
                                                                                                      NSLocalizedString(@"Signal %d was raised.", nil),
                                                                                                      signal] userInfo: userInfo];
    return [NSString stringWithFormat:@"%@, %@, %@", exception.name, exception.reason, exception.userInfo];
}

+ (NSArray *)backtrace
{
    void* callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    
    int i;
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (
         i = UncaughtExceptionHandlerSkipAddressCount;
         i < UncaughtExceptionHandlerSkipAddressCount +
         UncaughtExceptionHandlerReportAddressCount;
         i++)
    {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    
    return backtrace;

}
@end
