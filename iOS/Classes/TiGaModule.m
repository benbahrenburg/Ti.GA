/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "TiGaModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "GAI.h"
#import "TiGaTrackerObjectProxy.h"

@implementation TiGaModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"957d2892-5405-4a7f-8d44-8afaffeb17b1";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"ti.ga";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
}

-(void)shutdown:(id)sender
{	
	// you *must* call the superclass
	[super shutdown:sender];
    
    if(![NSThread isMainThread]){
        TiThreadPerformOnMainThread(^{
            [[GAI sharedInstance] dispatch];
        }, NO);
    }
}

#pragma mark Cleanup 


#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	[super didReceiveMemoryWarning:notification];
}

-(id)createTracker:(id)args
{
    if(args == nil){
        return [[TiGaTrackerObjectProxy alloc] initWithDefaultTracker];
    }
    
    ENSURE_SINGLE_ARG(args,NSDictionary);
    ENSURE_TYPE(args,NSDictionary);
    return [[TiGaTrackerObjectProxy alloc] initWithParams:args];
}

-(id)debug
{
    return NUMBOOL([[GAI sharedInstance].logger logLevel] == kGAILogLevelNone);
}

-(void) setDebug:(id)value
{
    if([TiUtils boolValue:value]){
        [[GAI sharedInstance].logger setLogLevel:kGAILogLevelNone];
    }else{
        [[GAI sharedInstance].logger setLogLevel:kGAILogLevelVerbose];
    }
}

-(id)optOut
{
    return NUMBOOL([[GAI sharedInstance] optOut]);
}
-(void)setOptOut:(id)value
{
    [[GAI sharedInstance] setOptOut:[TiUtils boolValue:value]];
}

-(id)dispatchInterval
{
    return [NSNumber numberWithDouble:[GAI sharedInstance].dispatchInterval];
}
-(void)setDispatchInterval:(id)value
{
    ENSURE_SINGLE_ARG(value,NSNumber);
    [GAI sharedInstance].dispatchInterval = [TiUtils doubleValue:value];
}

-(id) trackUncaughtExceptions
{
    return NUMBOOL([GAI sharedInstance].trackUncaughtExceptions);
}
-(void) setTrackUncaughtExceptions:(id)value
{
    ENSURE_SINGLE_ARG(value,NSNumber);
    [GAI sharedInstance].trackUncaughtExceptions = [TiUtils boolValue:value];
}

-(void)dispatch:(id)unused
{
    ENSURE_UI_THREAD(dispatch,unused);    
    [[GAI sharedInstance] dispatch];
}
@end
