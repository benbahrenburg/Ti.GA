/**
 * Benjamin Bahrenburg
 * Copyright (c) 2009-2013 by Benjamin Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiGaTrackerObjectProxy.h"
#import "TiUtils.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"

id<GAITracker>  _tracker;

@implementation TiGaTrackerObjectProxy

#define NSStringFromBOOL(aBOOL)    aBOOL? @"YES" : @"NO"

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
        
        if ([args objectForKey:@"trackingId"]){
            [self createTrackerWithId:[TiUtils stringValue:@"trackingId" properties:args] withParams:args];
        }else{
            [self createDefaultTracker:args];
        }
        
    }
    
    return self;
}

-(void)applyTrackerValues:(NSDictionary*)args
{
    [self setAppId:[[NSBundle mainBundle] bundleIdentifier]];
    [self setAppName:[[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleName"]];
    [self setAppVersion:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    
    if ([args objectForKey:@"appId"]){
        [self setAppId:[TiUtils stringValue:@"appId" properties:args]];
    }
    
    if ([args objectForKey:@"appName"]){
        [self setAppName:[TiUtils stringValue:@"appName" properties:args]];
    }
    if ([args objectForKey:@"appVersion"]){
        [self setAppVersion:[TiUtils stringValue:@"appVersion" properties:args]];
    }    
    if ([args objectForKey:@"useHttps"]){
        [self setUseHttps:[args objectForKey:@"useHttps"]];
    }
    if ([args objectForKey:@"anonymize"]){
        [self setAnonymize:[args objectForKey:@"anonymize"]];
    }
    if ([args objectForKey:@"sampleRate"]){
        [self setSampleRate:[args objectForKey:@"sampleRate"]];
    }
}


-(NSString*)appVersion
{
    return _appVersion;
}
-(void)setAppVersion:(id)value
{
    ENSURE_SINGLE_ARG(value, NSString);
    ENSURE_UI_THREAD(setAppVersion,value);
    _appVersion = [TiUtils stringValue:value];
    [_tracker set:kGAIAppVersion value:_appVersion];
}

-(NSString*)appName
{
    return _appName;
}
-(void)setAppName:(id)value
{
    ENSURE_SINGLE_ARG(value, NSString);
    ENSURE_UI_THREAD(setAppName,value);
    _appName = [TiUtils stringValue:value];
    [_tracker set:kGAIAppName value:_appName];
}

-(NSString*)appId
{
    return _appId;
}
-(void)setAppId:(id)value
{
    ENSURE_SINGLE_ARG(value, NSString);
    ENSURE_UI_THREAD(setAppId,value);
    _appId = [TiUtils stringValue:value];
    [_tracker set:kGAIAppId value:_appId];
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

-(id)anonymize
{
    return NUMBOOL(_anonymize);
}
-(void)setAnonymize:(id)value
{
    ENSURE_UI_THREAD(setAnonymize,value);
    ENSURE_SINGLE_ARG(value, NSNumber);
    _anonymize = [TiUtils boolValue:value];
    [_tracker set:kGAIAnonymizeIp value:NSStringFromBOOL(_anonymize)];
}

-(id)useHttps
{
    return NUMBOOL(_useHttps);
}

-(void)setUseHttps:(id)value
{
    ENSURE_UI_THREAD(setUseHttps,value);
    ENSURE_SINGLE_ARG(value, NSNumber);
    _useHttps = [TiUtils boolValue:value];
    [_tracker set:kGAIUseSecure value:NSStringFromBOOL(_useHttps)];
}

-(id)sampleRate
{
    return _sampleRate;
}
-(void)setSampleRate:(id)value
{
    ENSURE_UI_THREAD(setSampleRate,value);
    ENSURE_SINGLE_ARG(value, NSNumber);
    _sampleRate = value;
    [_tracker set:kGAISampleRate value:[NSString stringWithFormat:@"%f",[TiUtils doubleValue:_sampleRate]]];
}

-(id)sessionStarted
{
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

-(id)throttlingEnabled
{
    NSLog(@"[DEBUG] throttlingEnabled not supported on iOS");
    return NUMBOOL(NO);
}

-(void) setThrottlingEnabled:(id)value
{
    ENSURE_UI_THREAD(setThrottlingEnabled,value);
    NSLog(@"[DEBUG] throttlingEnabled not supported on iOS");
}


@end
