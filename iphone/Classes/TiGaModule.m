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

-(void)onStart:(id)unused
{
    ENSURE_UI_THREAD(onStart, unused);
    _optOut = [[GAI sharedInstance] optOut];
    _dispatchInterval = [[GAI sharedInstance] dispatchInterval];
}

-(void)startup
{
	[super startup];

    [self onStart:nil];
}

-(void)onShutdown:(id)unused
{
    ENSURE_UI_THREAD(onShutdown, unused);
    [[GAI sharedInstance] dispatch];
}
-(void)shutdown:(id)sender
{
    // Dispatch any stored tracking events
    [self onShutdown:nil];
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

#pragma our methods


-(id)optOut
{
    return [NSNumber numberWithBool:_optOut];
}

-(void)setDebug:(id)value
{
    ENSURE_UI_THREAD(setDebug, value);
    ENSURE_TYPE(value, NSNumber);
    BOOL debug = [TiUtils boolValue:value];
    if(debug){
        [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    }else{
        [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelError];
    }
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

-(void)dispatch:(id)unused
{
    ENSURE_UI_THREAD(dispatch, unused);
    [[GAI sharedInstance] dispatch];
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
