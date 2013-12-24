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
#import "BXBUtil.h"

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
            [BXBUtil logDebug:[@"tracker ID = "
                               stringByAppendingString:[TiUtils stringValue:kGAITrackingId properties:args]]];
            [self createTrackerWithId:[TiUtils stringValue:kGAITrackingId properties:args] withParams:args];
            [BXBUtil logDebug:@"tracker with ID created"];
        }else{
            [self createDefaultTracker:args];
            [BXBUtil logDebug:@"default tracker created"];
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
            [BXBUtil logDebug:[@"setting key = " stringByAppendingString:key]];
            [BXBUtil logDebug:[@"setting value = " stringByAppendingString:[TiUtils stringValue:key properties:args]]];
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

    [BXBUtil logDebug:@"Starting sendEvent"];
    [_tracker send:[[GAIDictionaryBuilder createEventWithCategory:[TiUtils stringValue:@"category"
                                                                            properties:args def:nil]     // Event category (required)
                                                          action:[TiUtils stringValue:@"action" properties:args def:nil]  // Event action (required)
                                                           label:[TiUtils stringValue:@"label" properties:args def:nil]          // Event label
                                                           value:[NSNumber numberWithFloat:[TiUtils floatValue:@"value" properties:args def:0]]] build]];    // Event value
    [BXBUtil logDebug:@"Finished sendEvent"];
}

-(void)sendSocial:(id)args
{
    ENSURE_UI_THREAD(sendSocial,args);
    ENSURE_SINGLE_ARG(args,NSDictionary);
 
    [BXBUtil logDebug:@"Starting sendSocial"];
    [_tracker send:[[GAIDictionaryBuilder createSocialWithNetwork:[TiUtils stringValue:@"network"
                                                                          properties:args def:nil]// Social network (required)
                                                         action:[TiUtils stringValue:@"action"
                                                                          properties:args def:nil]// Social action (required)
                                                          target:[TiUtils stringValue:@"target"
                                                                           properties:args def:nil]] build]];  // Social target
    [BXBUtil logDebug:@"Finished sendSocial"];
}

-(void)sendException:(id)value
{
    ENSURE_UI_THREAD(sendException,value);
    ENSURE_SINGLE_ARG(value, NSString);
    
    [BXBUtil logDebug:@"Starting sendException"];
    // Exception description. May be truncated to 100 chars.
    [_tracker send:[[GAIDictionaryBuilder
                     createExceptionWithDescription:value withFatal:NO] build]];
    [BXBUtil logDebug:@"Finished sendException"];
}

-(void)addCustomDimension:(id)args
{
    ENSURE_UI_THREAD(addCustomDimension,args);
    ENSURE_SINGLE_ARG(args,NSDictionary);
    [BXBUtil logDebug:@"Starting addCustomDimension"];
    
    [_tracker set:[GAIFields customDimensionForIndex:[TiUtils intValue:@"index" properties:args]]
             value:[TiUtils stringValue:@"dimesion" properties:args]];
    [_tracker send:[[GAIDictionaryBuilder createAppView] build]];

    [BXBUtil logDebug:@"Finished addCustomDimension"];
}

-(void)addCustomMetric:(id)args
{
    ENSURE_UI_THREAD(addCustomMetric,args);
    ENSURE_SINGLE_ARG(args,NSDictionary);
    [BXBUtil logDebug:@"Starting addCustomMetric"];
    
    [_tracker set:[GAIFields customMetricForIndex:[TiUtils intValue:@"index" properties:args]]
            value:[[NSNumber numberWithDouble:[TiUtils doubleValue:@"metric" properties:args]] stringValue]];
    [_tracker send:[[GAIDictionaryBuilder createAppView] build]];
    
    [BXBUtil logDebug:@"Finish addCustomMetric"];
}

-(void)sendView:(id)value
{
    ENSURE_UI_THREAD(sendView,value);
    ENSURE_SINGLE_ARG(value, NSString);
    
    [BXBUtil logDebug:[@"Starting sendView, view = " stringByAppendingString:value]];
    [_tracker set:kGAIScreenName value:value];
    [_tracker send:[[GAIDictionaryBuilder createAppView]  build]];
    [BXBUtil logDebug:@"Finished sendView"];
}


-(void)sendTiming:(id)args
{
    ENSURE_UI_THREAD(sendTiming,args);
    ENSURE_SINGLE_ARG(args,NSDictionary);
    [BXBUtil logDebug:@"Start sendTiming"];
    
    [_tracker send:[[GAIDictionaryBuilder createTimingWithCategory:[TiUtils stringValue:@"category"
                                                             properties:args def:nil]   // Timing category (required)
                                          interval:[NSNumber numberWithDouble:[TiUtils doubleValue:@"value" properties:args]]// Timing interval (required)
                                              name:[TiUtils stringValue:@"name"
                                                             properties:args def:nil]  // Timing name
                                             label:[TiUtils stringValue:@"label"
                                                             properties:args def:nil]] build]];

    [BXBUtil logDebug:@"Finish sendTiming"];
}

-(NSString*)getValue:(id)key
{
    ENSURE_SINGLE_ARG(key, NSString);
    ENSURE_UI_THREAD(getValue,key);
    [BXBUtil logDebug:[@"getValue key = " stringByAppendingString:key]];
    
    return [_tracker get:key];
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
    
    [BXBUtil logDebug:[@"setValue key = " stringByAppendingString:[TiUtils stringValue:[args objectAtIndex:kArgName]]]];
    [BXBUtil logDebug:[@"getValue value = " stringByAppendingString:[TiUtils stringValue:[args objectAtIndex:kArgValue]]]];
    
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
    [BXBUtil logDebug:@"Start startSession"];
    _sessionStart=YES;
    [_tracker set:kGAISessionControl
           value:@"start"];
    [BXBUtil logDebug:@"Finish startSession"];
}

-(void)endSession:(id)unused
{
    ENSURE_UI_THREAD(endSession,unused);
    [BXBUtil logDebug:@"Start endSession"];
    _sessionStart=NO;
    [_tracker set:kGAISessionControl
            value:@"end"];
    [BXBUtil logDebug:@"Finish endSession"];
}

-(void) sendSession:(id)unused
{
    [BXBUtil logDebug:@"Start sendSession"];
    [_tracker send:[[GAIDictionaryBuilder createAppView] build]];
    [BXBUtil logDebug:@"Finish sendSession"];
}

-(void)send:(id)args
{
    ENSURE_UI_THREAD(send,args);
    
    if(args ==nil){
        [BXBUtil logDebug:@"Start send without dictionary"];
        [_tracker send:[[GAIDictionaryBuilder createAppView] build]];
        [BXBUtil logDebug:@"Finish send without dictionary"];
    }else{
        ENSURE_SINGLE_ARG(args, NSDictionary);
        [BXBUtil logDebug:@"Start send with dictionary"];
        [_tracker send:[[[GAIDictionaryBuilder createAppView] setAll:args] build]];
        [BXBUtil logDebug:@"Finish send with dictionary"];
    }
}

-(void)sendCampaign:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);
    ENSURE_UI_THREAD(sendCampaign,args);
    [BXBUtil logDebug:@"Start sendCampaign"];
    
    NSDictionary *campaignData = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [TiUtils stringValue:@"source"properties:args def:nil],kGAICampaignSource ,
                                  [TiUtils stringValue:@"medium"properties:args def:nil], kGAICampaignMedium,
                                  [TiUtils stringValue:@"name"properties:args def:nil], kGAICampaignName,
                                  [TiUtils stringValue:@"content"properties:args def:nil], kGAICampaignContent,
                                  nil];
    
    [_tracker send:[[[GAIDictionaryBuilder createAppView] setAll:campaignData] build]];
    [BXBUtil logDebug:@"Finish sendCampaign"];

}
-(void)createTransactionWithId:(id)args
{
    
    ENSURE_SINGLE_ARG(args, NSDictionary);
    ENSURE_UI_THREAD(createTransactionWithId,args);
    [BXBUtil logDebug:@"Start createTransactionWithId"];
    
    [_tracker send:[[GAIDictionaryBuilder createTransactionWithId:
                            [TiUtils stringValue:@"transID" properties:args def:nil]
                                                     affiliation:[TiUtils stringValue:@"affiliation" properties:args def:nil]
                                                         revenue:[NSNumber numberWithDouble:
                                                                  [TiUtils doubleValue:@"revenue" def:0.0f]]
                                                              tax:[NSNumber numberWithDouble:
                                                                    [TiUtils doubleValue:@"tax" def:0.0f]]
                                                         shipping:[NSNumber numberWithDouble:
                                                                   [TiUtils doubleValue:@"shipping" def:0.0f]]
                                                    currencyCode:[TiUtils stringValue:@"currencyCode"
                                                                           properties:args def:nil]] build]];
    [BXBUtil logDebug:@"Finish createTransactionWithId"];
}
-(void)createItemWithTransactionId:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);
    ENSURE_UI_THREAD(createTransactionWithId,args);
    [BXBUtil logDebug:@"Start createItemWithTransactionId"];
    
    [_tracker send:[[GAIDictionaryBuilder createItemWithTransactionId:[TiUtils stringValue:@"transID"
                                                                                properties:args def:nil]
                                                                name:[TiUtils stringValue:@"name" properties:args def:nil]
                                                                 sku:[TiUtils stringValue:@"sku" properties:args def:nil]
                                                            category:[TiUtils stringValue:@"category"
                                                                               properties:args def:nil]
                                                                price:[NSNumber numberWithDouble:
                                                                       [TiUtils doubleValue:@"price" def:0.0f]]
                                                            quantity:[NSNumber numberWithInt:
                                                                      [TiUtils intValue:@"quantity" def:1]]
                                                         currencyCode:[TiUtils stringValue:@"currencyCode"
                                                                                properties:args def:nil]] build]];
    [BXBUtil logDebug:@"Finish createItemWithTransactionId"];
}
@end
