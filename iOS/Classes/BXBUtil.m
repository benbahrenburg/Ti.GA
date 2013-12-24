/**
 * Ti.GA - Google Analytics for Titanium
 * Copyright (c) 2013 by Benjamin Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the MIT License
 * Please see the LICENSE included with this distribution for details.
 *
 * Available at https://github.com/benbahrenburg/Ti.GA
 *
 */
#import "BXBUtil.h"
#import "TiGaModule.h"

@implementation BXBUtil

+(void)logInfo:(NSString*) message
{
    NSLog(@"[INFO] %@", message);
}

+(void)logDebug:(NSString*) message
{
    if([TiGaModule LOG_DEBUG]){
            NSLog(@"[DEBUG] %@", message);
    }
}

+(void)logError:(NSString*) message
{
    NSLog(@"[ERROR] %@", message);
}

@end
