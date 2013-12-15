/**
 * Ti.GA - Google Analytics for Titanium
 * Copyright (c) 2013 by Benjamin Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the MIT License
 * Please see the LICENSE included with this distribution for details.
 *
 * Available at https://github.com/benbahrenburg/Ti.GA
 *
 */

#import "TiGaTrackerObjectProxy.h"
#import "TiUtils.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"

id<GAITracker>  _tracker;

@implementation TiGaTrackerObjectProxy

-(void)_configure
{
    _sessionStart = NO;
    [super _configure];
}

-(void)createDefaultTracker:(NSDictionary*)args
{
    if(![NSThread isMainThread]){
        TiThreadPerformOnMainThread(^{
        [self createDefaultTracker:args];
        }, NO);
    }else{
        _tracker = [GAI sharedInstance].defaultTracker;
        [self applyTrackerValues:args];
    }
}

-(void)createTrackerWithId:(NSString*)value withParams:(NSDictionary*)params
{
    _trackingId = [TiUtils stringValue:value];
    if(![NSThread isMainThread]){
        TiThreadPerformOnMainThread(^{
            [self createTrackerWithId:value withParams:params];
            [self applyDefaults];
        }, NO);
    }else{
        _tracker = [[GAI sharedInstance] trackerWithTrackingId:_trackingId];
        [self applyTrackerValues:params];
    }
}
-(id)initWithDefaultTracker
{
    if(self =[super init]){
        [self createDefaultTracker:nil];
    }
    return self;
}


-(id)initWithParams:(NSDictionary*)args
{
    if(self =[super init]){
        
        if ([args objectForKey:kGAITrackingId]){
            [self createTrackerWithId:[TiUtils stringValue:kGAITrackingId properties:args] withParams:args];
        }else{
            [self createDefaultTracker:args];
        }
        
    }
    
    return self;
}

-(void)applyDefaults
{
    [_tracker set:kGAIAppId
            value:[[NSBundle mainBundle] bundleIdentifier]];
    [_tracker set:kGAIAppName
            value:[[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleName"]];
    [_tracker set:kGAIAppVersion
            value:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
}

-(void)applyTrackerValues:(NSDictionary*)args
{

    [self applyDefaults];
    
    for (NSString* key in args) {
        if ([args objectForKey:key]){
            [_tracker set:key value:[TiUtils stringValue:key properties:args]];
        }
    }
}


-(NSString*)trackingId
{
    return _trackingId;
}

-(void)sendEvent:(id)args
{
    ENSURE_UI_THREAD(sendEvent,args);
    ENSURE_SINGLE_ARG(args,NSDictionary);

 
    [_tracker send:[[GAIDictionaryBuilder createEventWithCategory:[TiUtils stringValue:@"category"
                                                                            properties:args def:nil]     // Event category (required)
                                                          action:[TiUtils stringValue:@"action" properties:args def:nil]  // Event action (required)
                                                           label:[TiUtils stringValue:@"label" properties:args def:nil]          // Event label
                                                           value:[NSNumber numberWithFloat:[TiUtils floatValue:@"value" properties:args def:0]]] build]];    // Event value
}

-(void)sendSocial:(id)args
{
    ENSURE_UI_THREAD(sendSocial,args);
    ENSURE_SINGLE_ARG(args,NSDictionary);
 
    [_tracker send:[[GAIDictionaryBuilder createSocialWithNetwork:[TiUtils stringValue:@"network"
                                                                          properties:args def:nil]// Social network (required)
                                                         action:[TiUtils stringValue:@"action"
                                                                          properties:args def:nil]// Social action (required)
                                                          target:[TiUtils stringValue:@"target"
                                                                           properties:args def:nil]] build]];  // Social target
}

-(void)sendException:(id)value
{
    ENSURE_UI_THREAD(sendException,value);
    ENSURE_SINGLE_ARG(value, NSString);
    
    // Exception description. May be truncated to 100 chars.
    [_tracker send:[[GAIDictionaryBuilder
                     createExceptionWithDescription:value withFatal:NO] build]];
}

-(void)addCustomDimension:(id)args
{
    ENSURE_UI_THREAD(addCustomDimension,args);
    ENSURE_SINGLE_ARG(args,NSDictionary);
    
    [_tracker set:[GAIFields customDimensionForIndex:[TiUtils intValue:@"index" properties:args]]
             value:[TiUtils stringValue:@"dimesion" properties:args]];

}

-(void)addCustomMetric:(id)args
{
    ENSURE_UI_THREAD(addCustomMetric,args);
    ENSURE_SINGLE_ARG(args,NSDictionary);

    [_tracker set:[GAIFields customMetricForIndex:[TiUtils intValue:@"index" properties:args]]
            value:[[NSNumber numberWithDouble:[TiUtils doubleValue:@"metric" properties:args]] stringValue]];
}

-(void)sendView:(id)value
{
    ENSURE_UI_THREAD(sendView,value);
    ENSURE_SINGLE_ARG(value, NSString);
    [_tracker set:kGAIScreenName value:value];
    [_tracker send:[[GAIDictionaryBuilder createAppView]  build]];
}


-(void)sendTiming:(id)args
{
    ENSURE_UI_THREAD(sendTiming,args);
    ENSURE_SINGLE_ARG(args,NSDictionary);
 
    [_tracker send:[[GAIDictionaryBuilder createTimingWithCategory:[TiUtils stringValue:@"category"
                                                             properties:args def:nil]   // Timing category (required)
                                          interval:[NSNumber numberWithDouble:[TiUtils doubleValue:@"value" properties:args]]// Timing interval (required)
                                              name:[TiUtils stringValue:@"name"
                                                             properties:args def:nil]  // Timing name
                                             label:[TiUtils stringValue:@"label"
                                                             properties:args def:nil]] build]];
}

-(NSString*)getValue:(id)name
{
    ENSURE_SINGLE_ARG(name, NSString);
    ENSURE_UI_THREAD(getValue,name);
    return [_tracker get:name];
}

-(void)setValue:(id)args
{
    ENSURE_UI_THREAD(setValue,args);
    
    enum Args {
        kArgName = 0,
        kArgValue,
        kArgCount
    };
    
    // Validate correct number of arguments
    ENSURE_ARG_COUNT(args, kArgCount);
    
    [_tracker set:[TiUtils stringValue:[args objectAtIndex:kArgName]]
            value:[TiUtils stringValue:[args objectAtIndex:kArgValue]]];
}

-(NSNumber*)isSessionStarted:(id)unused
{
    ENSURE_UI_THREAD(isSessionStarted,unused);
    return NUMBOOL(_sessionStart);
}

-(void)startSession:(id)unused
{
    ENSURE_UI_THREAD(startSession,unused);
    _sessionStart=YES;
    [_tracker set:kGAISessionControl
           value:@"start"];
}

-(void)endSession:(id)unused
{
    ENSURE_UI_THREAD(endSession,unused);
    _sessionStart=NO;
    [_tracker set:kGAISessionControl
            value:@"end"];
}

-(void)send:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);
    ENSURE_UI_THREAD(send,args);
    
    [_tracker send:[[[GAIDictionaryBuilder createAppView] setAll:args] build]];
}

-(void)sendCampaign:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);
    ENSURE_UI_THREAD(sendCampaign,args);
    
    NSDictionary *campaignData = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [TiUtils stringValue:@"source"properties:args def:nil],kGAICampaignSource ,
                                  [TiUtils stringValue:@"medium"properties:args def:nil], kGAICampaignMedium,
                                  [TiUtils stringValue:@"name"properties:args def:nil], kGAICampaignName,
                                  [TiUtils stringValue:@"content"properties:args def:nil], kGAICampaignContent,
                                  nil];
    
    [_tracker send:[[[GAIDictionaryBuilder createAppView] setAll:campaignData] build]];

}

@end
