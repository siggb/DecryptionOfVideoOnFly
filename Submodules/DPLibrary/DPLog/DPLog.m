//
//  DPLog.m
//  Created by sig
//
//  DigiPeople Inc.
//  http://digipeople.ru/
//
//  Copyright (c) 2013. All rights reserved.

#import "DPLog.h"

@implementation DPLog

+ (void)function:(char*)functionName format:(NSString*)format, ...
{
    va_list ap;
    NSString *print, *function;
    va_start(ap,format);
    
    function = [NSString stringWithCString: functionName encoding:NSASCIIStringEncoding];
    print = [[NSString alloc] initWithFormat: format arguments: ap];
    va_end(ap);
    NSLog(@"⚑ %@ %@", function, print);
}

+ (void)shouldLog:(int)shouldLog function:(char*)functionName format:(NSString*)format, ...
{
    if (shouldLog == 1) {
        va_list ap;
        NSString *print, *function;
        va_start(ap,format);
        
        function = [NSString stringWithCString: functionName encoding:NSASCIIStringEncoding];
        print = [[NSString alloc] initWithFormat: format arguments: ap];
        va_end(ap);
        NSLog(@"⚑ %@ %@", function, print);
    }
}

+ (void)shouldLog:(int)shouldLog file:(char*)sourceFile lineNumber:(int)lineNumber format:(NSString*)format, ...
{
    if (shouldLog == 1) {
        va_list ap;
        NSString *print, *file;
        va_start(ap,format);
        file = [[NSString alloc] initWithBytes: sourceFile length: strlen(sourceFile) encoding: NSUTF8StringEncoding];
        
        print = [[NSString alloc] initWithFormat: format arguments: ap];
        va_end(ap);
        NSLog(@"⚑ -[ %@:%d ] %@", [file lastPathComponent], lineNumber, print);
    }
}

+ (void)shouldLog:(int)shouldLog file:(char*)sourceFile function:(char*)functionName lineNumber:(int)lineNumber format:(NSString*)format, ...
{
    if (shouldLog == 1) {
        va_list ap;
        NSString *print, *file, *function;
        va_start(ap,format);
        file = [[NSString alloc] initWithBytes: sourceFile length: strlen(sourceFile) encoding: NSUTF8StringEncoding];
        
        function = [NSString stringWithCString: functionName encoding:NSASCIIStringEncoding];
        print = [[NSString alloc] initWithFormat: format arguments: ap];
        va_end(ap);
        NSLog(@"⚑ -[ %@:%d %@ ] %@", [file lastPathComponent], lineNumber, function, print);
    }
}

@end

