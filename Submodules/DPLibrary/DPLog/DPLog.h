//
//  DPLog.h
//  Created by sig
//
//  DigiPeople Inc.
//  http://digipeople.ru/
//
//  Copyright (c) 2013. All rights reserved.

#import <Foundation/Foundation.h>

@interface DPLog : NSObject

#if (DEBUG == 1 && RUN_KIF_TESTS != 1)

// Быстрое логирование :: <функция> + <текст>
+ (void)function:(char*)functionName format:(NSString*)format, ...;
#define DPLogFast(s,...) [DPLog function: (char *)__FUNCTION__ format:(s),##__VA_ARGS__]

// Логирование :: <функция> + <текст>
+ (void)shouldLog:(int)shouldLog function:(char*)functionName format:(NSString*)format, ...;
#define DPLog(n,s,...) [DPLog shouldLog:n function: (char *)__FUNCTION__ format:(s),##__VA_ARGS__]

// Логирование :: <файл> + <строка> + <текст>
+ (void)shouldLog:(int)shouldLog file:(char*)sourceFile lineNumber:(int)lineNumber format:(NSString*)format, ...;
#define DPLogFile(n,s,...) [DPLog shouldLog:n  file:__FILE__ lineNumber:__LINE__ format:(s),##__VA_ARGS__]

// Логирование :: <файл> + <строка> + <функция> + <текст>
+ (void)shouldLog:(int)shouldLog file:(char*)sourceFile function:(char*)functionName lineNumber:(int)lineNumber format:(NSString*)format, ...;
#define DPLogFull(n,s,...) [DPLog shouldLog:n  file:__FILE__ function: (char *)__FUNCTION__ lineNumber:__LINE__ format:(s),##__VA_ARGS__]

#else
#define DPLogFast(s,...)
#define DPLog(n,s,...)
#define DPLogFile(n,s,...)
#define DPLogFull(n,s,...)
#endif

@end