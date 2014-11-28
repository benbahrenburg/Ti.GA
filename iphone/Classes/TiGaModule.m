/**
 * Ti.GA - Basic Google Analytics for Titanium
 * Copyright (c) 2014 by Benjamin Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiGaModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "GAI.h"
#import "TiGaTrackerProxy.h"

@implementation TiGaModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"9dd4ad61-4835-4b75-bcb8-13893111b978";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"ti.ga";
}

#pragma mark Lifecycle

-(void)startup
{
	[super startup];

    if (![NSThread isMainThread])
    {
        TiThreadPerformOnMainThread(^{
            _optOut = [[GAI sharedInstance] optOut];
            _dispatchInterval = [[GAI sharedInstance] dispatchInterval];
        }, NO);
    }
}

-(void)shutdown:(id)sender
{
    // Dispatch any stored tracking events
    if (![NSThread isMainThread])
    {
        TiThreadPerformOnMainThread(^{
            [[GAI sharedInstance] dispatch];
        }, NO);
    }
	// you *must* call the superclass
	[super shutdown:sender];
}




#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Cleanup

-(id)createTracker:(id)args
{
    ENSURE_UI_THREAD(createTracker, args);
    ENSURE_TYPE(args, NSDictionary);
    
    NSString* trackingId;
    ENSURE_ARG_FOR_KEY(trackingId, args, @"trackingId", NSString);
    BOOL useSSL = [TiUtils boolValue:@"useSecure" properties:args def:YES];
    return [[TiGaTrackerProxy alloc] initWithInfo:trackingId withSecure: useSSL];
}

-(id)optOut
{
    return [NSNumber numberWithBool:_optOut];
}

-(void)setOptOut:(id)value
{
    ENSURE_UI_THREAD(setOptOut, value);
    ENSURE_TYPE(value, NSNumber);
    _optOut = [TiUtils boolValue:value];
    [[GAI sharedInstance] setOptOut:_optOut];
}

-(id)dispatchInterval
{
    return [NSNumber numberWithDouble:_dispatchInterval];
}

-(void)setDispatchInterval:(id)value
{
    ENSURE_UI_THREAD(setDispatchInterval, value);
    ENSURE_TYPE(value, NSNumber);
    [GAI sharedInstance].dispatchInterval = _dispatchInterval = [value doubleValue];
}

-(void)setTrackUncaughtExceptions:(id)value
{
    ENSURE_UI_THREAD(setTrackUncaughtExceptions, value);
    ENSURE_TYPE(value, NSNumber);
    [GAI sharedInstance].trackUncaughtExceptions = [value boolValue];
}

@end
