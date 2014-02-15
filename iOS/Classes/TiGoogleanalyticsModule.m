/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "TiGoogleanalyticsModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation TiGoogleanalyticsModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"d8446e59-4726-44a6-b1e9-a33d5cb4742f";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"ti.googleanalytics";
}

#pragma mark Lifecycle

-(void)startup
{
	[super startup];
    
    // Optional: automatically send uncaught exceptions to Google Analytics.
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // Optional: set Logger to VERBOSE for debug information.
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
}

-(void)shutdown:(id)sender
{
	[[GAI sharedInstance] dispatch];
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Utility

-(id)proxify:(id<GAITracker>)tracker
{
    return [[TiGoogleanalyticsTracker alloc] initWithTracker:tracker];
}

#pragma mark Public APIs

-(void)closeTracker:(id)trackingId
{
    ENSURE_SINGLE_ARG(trackingId, NSString);
    [[GAI sharedInstance] removeTrackerByName:trackingId];
}
-(id)defaultTracker
{
    return [self proxify:[GAI sharedInstance].defaultTracker];
}
-(id)getTracker:(id)args
{
    NSString *trackingId;
    NSString *trackingName;
    id<GAITracker> retVal;
    ENSURE_ARG_OR_NIL_AT_INDEX(trackingId, args, 1, NSString);
    if (trackingId != nil) {
        ENSURE_ARG_AT_INDEX(trackingName, args, 0, NSString);
        retVal = [[GAI sharedInstance] trackerWithName:trackingName trackingId:trackingId];
    } else {
        ENSURE_ARG_AT_INDEX(trackingId, args, 0, NSString);
        retVal = [[GAI sharedInstance] trackerWithTrackingId:trackingId];
    }
    return [self proxify:retVal];
}

-(id)optOut
{
    return NUMBOOL([GAI sharedInstance].optOut);
}
-(void)setOptOut:(id)value
{
    ENSURE_SINGLE_ARG(value, NSObject);
    [GAI sharedInstance].optOut = [TiUtils boolValue:value];
}

-(id)dryRun
{
    return NUMBOOL([GAI sharedInstance].dryRun);
}
-(void)setDryRun:(id)value
{
    ENSURE_SINGLE_ARG(value, NSObject);
    [GAI sharedInstance].dryRun = [TiUtils boolValue:value];
}

-(id)MapBuilder
{
    return [[TiGoogleanalyticsMapBuilder alloc] init];
}
-(id)getMapBuilder:(id)args
{
    return [self MapBuilder];
}

-(id)Fields
{
    return [TiGoogleanalyticsFields fields];
}

-(id)getFields:(id)args
{
    return [self Fields];
}

@end
