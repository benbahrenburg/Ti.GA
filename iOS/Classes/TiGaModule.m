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

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	[super didReceiveMemoryWarning:notification];
}

-(id)debug
{
    return NUMBOOL([[GAI sharedInstance] debug]);
}

-(void) setDebug:(id)value
{
    [[GAI sharedInstance] setDebug:[TiUtils boolValue:value]];
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

@end
