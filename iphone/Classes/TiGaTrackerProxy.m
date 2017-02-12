/**
 * Ti.GA - Basic Google Analytics for Titanium
 * Copyright (c) 2014 by Benjamin Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiGaTrackerProxy.h"
#import "TiUtils.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"

@implementation TiGaTrackerProxy


-(void)createDefaultTracker:(id)unused
{
    ENSURE_UI_THREAD(createDefaultTracker, unused);
    _tracker = [[GAI sharedInstance] defaultTracker];
    if(_debug){
        NSLog(@"[DEBUG] Default Tracker created");
    }
}

-(void) createTracker:(NSString*)trackerId
{
    ENSURE_UI_THREAD(createTracker, trackerId);
    _tracker = [[GAI sharedInstance] trackerWithTrackingId:trackerId];
    if(_debug){
        NSLog(@"[DEBUG] Tracker with trackingId: %@ created",trackerId);
    }
}

-(void)_initWithProperties:(NSDictionary*)properties
{
    _debug = [TiUtils  boolValue:@"debug" properties:properties def:NO];
    if(_debug){
        NSLog(@"[DEBUG] Debug enabled");
    }
    _useSecure = [TiUtils  boolValue:@"useSecure" properties:properties def:YES];
    _trackerId = [TiUtils stringValue:@"trackingId" properties:properties];
    
    if(_trackerId==nil){
        [self createDefaultTracker:nil];
    }else{
        [self createTracker:_trackerId];
    }
    
    [_tracker set:kGAIAnonymizeIp value:@"1"];
    [_tracker set:kGAIUseSecure value:[(_useSecure? @YES : @NO) stringValue]];
    
    [super _initWithProperties:properties];
}

-(void)setUserID:(NSString*)userID // Not "args" like addScreenView because its prefixed with "set" and so expects a single value
{
    ENSURE_UI_THREAD(setUserID, userID);
    //ENSURE_TYPE(userID, NSString)
    if(_debug){
        NSLog(@"[DEBUG] setUserID: %@", userID);
    }
    [_tracker set:kGAIUserId value:userID];
}

-(NSString*)getUserID
{
    return [_tracker get:kGAIUserId];
}

-(void)clearUserID
{
    [_tracker set:kGAIUserId value:nil];
    if(_debug){
        NSLog(@"[DEBUG] clearUserID");
    }
}

-(void)startSession:(id)unused
{
    ENSURE_UI_THREAD(startSession, unused);
    if(_debug){
        NSLog(@"[DEBUG] Starting Session");
    }
    [_tracker send:[[[GAIDictionaryBuilder createScreenView] set:@"start" forKey:kGAISessionControl] build] ];
}

-(void)endSession:(id)unused
{
    ENSURE_UI_THREAD(endSession, unused);
    if(_debug){
        NSLog(@"[DEBUG] Ending Session");
    }
    [_tracker send:[[[GAIDictionaryBuilder createScreenView] set:@"end" forKey:kGAISessionControl] build] ];
}

-(void)addScreenView:(id)args
{
    ENSURE_UI_THREAD(addScreenView, args);
    ENSURE_ARG_COUNT(args,1);
    NSString* screen = [TiUtils stringValue:[args objectAtIndex:0]];
    if(_debug){
        NSLog(@"[DEBUG] addScreenView: %@", screen);
    }
    [_tracker set:kGAIScreenName value:screen];
    [_tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

-(void)addEvent:(id)args
{
    ENSURE_SINGLE_ARG(args,NSDictionary);
    ENSURE_TYPE(args,NSDictionary);
    ENSURE_UI_THREAD(addEvent, args);

    NSString *category = [TiUtils stringValue:@"category" properties:args];
    NSString *action = [TiUtils stringValue:@"action" properties:args];
    NSString *label = [TiUtils stringValue:@"label" properties:args];
    NSNumber *value = [NSNumber numberWithFloat:[TiUtils floatValue:@"value" properties:args]];
    
    if(_debug){
        NSLog(@"[DEBUG] addEvent category: %@", category);
        NSLog(@"[DEBUG] addEvent action: %@", action);
        NSLog(@"[DEBUG] addEvent label: %@", label);
        NSLog(@"[DEBUG] addEvent value: %f", value);
    }
    
    [_tracker send:[[GAIDictionaryBuilder createEventWithCategory:category
                                                            action:action
                                                            label:label
                                                            value:value] build]];
}

-(void)addTiming:(id)args
{
    ENSURE_SINGLE_ARG(args,NSDictionary);
    ENSURE_TYPE(args,NSDictionary);
    ENSURE_UI_THREAD(addTiming, args);
    
    NSString *category = [TiUtils stringValue:@"category" properties:args];
    NSNumber *time = [NSNumber numberWithFloat:[TiUtils floatValue:@"time" properties:args]];
    NSString *name = [TiUtils stringValue:@"name" properties:args];
    NSString *label = [TiUtils stringValue:@"label" properties:args];
    
    if(_debug){
        NSLog(@"[DEBUG] addTiming category: %@", category);
        NSLog(@"[DEBUG] addTiming name: %@", name);
        NSLog(@"[DEBUG] addTiming label: %@", label);
        NSLog(@"[DEBUG] addTiming time: %f", time);
    }
    
     [_tracker send:[[GAIDictionaryBuilder createTimingWithCategory:category
                                                                interval:time
                                                                name:name
                                                                label:label]build]];
}

-(void)addException:(id)args
{
    ENSURE_SINGLE_ARG(args,NSDictionary);
    ENSURE_TYPE(args,NSDictionary);
    ENSURE_UI_THREAD(addException, args);

    NSString *description = [TiUtils stringValue:@"description" properties:args];
    BOOL fatal = [TiUtils boolValue:@"fatal" properties:args def:NO];
    NSNumber *isFatal = (fatal) ? @YES : @NO;
    
    if(_debug){
        NSLog(@"[DEBUG] addException description: %@", description);
        NSLog(@"[DEBUG] addException fatal: %@", (fatal ? @"YES" : @"NO"));
    }
    
    [_tracker send:[[GAIDictionaryBuilder
                     createExceptionWithDescription:description
                     withFatal:isFatal] build]];
}

-(void)addSocialNetwork:(id)args
{
    ENSURE_SINGLE_ARG(args,NSDictionary);
    ENSURE_TYPE(args,NSDictionary);
    ENSURE_UI_THREAD(addSocialNetwork, args);
    
    NSString *network = [TiUtils stringValue:@"network" properties:args];
    NSString *action = [TiUtils stringValue:@"action" properties:args];
    NSString *target = [TiUtils stringValue:@"target" properties:args];
  
    if(_debug){
        NSLog(@"[DEBUG] addSocialNetwork network: %@", network);
        NSLog(@"[DEBUG] addSocialNetwork action: %@", action);
        NSLog(@"[DEBUG] addSocialNetwork target: %@", target);
    }
    
    [_tracker send:[[GAIDictionaryBuilder createSocialWithNetwork:network
                                                            action:action
                                                           target:target] build]];
    
}

@end
