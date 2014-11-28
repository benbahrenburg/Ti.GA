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

-(id)initWithInfo:(NSString*)trackerId withSecure:(BOOL)secure
{
    if (self = [super init])
    {
        _trackerId = trackerId;
        if (![NSThread isMainThread])
        {
            TiThreadPerformOnMainThread(^{
                _tracker = [[GAI sharedInstance] trackerWithTrackingId:_trackerId];
                [_tracker set:kGAIUseSecure value:[(secure ? @YES : @NO) stringValue]];
            }, NO);
        }
    }
    return self;
}


-(void)startSession:(id)unused
{
    ENSURE_UI_THREAD(startSession, unused);
    
    GAIDictionaryBuilder *builder = [GAIDictionaryBuilder createScreenView];
    [builder set:@"start" forKey:kGAISessionControl];
    [_tracker send:[builder build]];
}

-(void)endSession:(id)unused
{
    ENSURE_UI_THREAD(endSession, unused);
    
    GAIDictionaryBuilder *builder = [GAIDictionaryBuilder createScreenView];
    [builder set:@"end" forKey:kGAISessionControl];
    [_tracker send:[builder build]];
}

-(void)createScreenView:(NSString*)screen
{
    ENSURE_UI_THREAD(createScreenView, screen);
    
    [_tracker set:kGAIScreenName value:screen];
    GAIDictionaryBuilder *builder = [GAIDictionaryBuilder createScreenView];
    [_tracker send:[builder build]];
}

-(void)createEvent:(id)args
{
    ENSURE_UI_THREAD(createEvent, args);
    ENSURE_TYPE(args, NSDictionary);
    
    NSString *category = [TiUtils stringValue:@"category" properties:args];
    NSString *action = [TiUtils stringValue:@"action" properties:args];
    NSString *label = [TiUtils stringValue:@"label" properties:args];
    NSNumber *value = [NSNumber numberWithFloat:[TiUtils floatValue:@"value" properties:args]];
    
    
    GAIDictionaryBuilder *builder = [GAIDictionaryBuilder createEventWithCategory:category
                                                                           action:action
                                                                            label:label
                                                                            value:value];
    [_tracker send:[builder build]];
}

-(void)createTiming:(id)args
{
    ENSURE_UI_THREAD(createTiming, args);
    ENSURE_TYPE(args, NSDictionary);
    
    NSString *category = [TiUtils stringValue:@"category" properties:args];
    NSNumber *time = [NSNumber numberWithFloat:[TiUtils floatValue:@"time" properties:args]];
    NSString *name = [TiUtils stringValue:@"name" properties:args];
    NSString *label = [TiUtils stringValue:@"label" properties:args];
    
    GAIDictionaryBuilder *builder = [GAIDictionaryBuilder createTimingWithCategory:category
                                                                          interval:time
                                                                              name:name
                                                                             label:label];
    [_tracker send:[builder build]];
}

-(void)createSocialNetwork:(id)args
{
    ENSURE_UI_THREAD(createSocialNetwork, args);
    ENSURE_TYPE(args, NSDictionary);
    
    NSString *network = [TiUtils stringValue:@"network" properties:args];
    NSString *action = [TiUtils stringValue:@"action" properties:args];
    NSString *target = [TiUtils stringValue:@"target" properties:args];
    
    GAIDictionaryBuilder *builder = [GAIDictionaryBuilder createSocialWithNetwork:network
                                                                           action:action
                                                                           target:target];
    [_tracker send:[builder build]];
    
}

@end
