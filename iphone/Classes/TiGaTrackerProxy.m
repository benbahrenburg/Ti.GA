/**
 * Ti.GA - Basic Google Analytics for Titanium
 * Copyright (c) 2014 by Benjamin Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiGaTrackerProxy.h"
#import "TiUtils.h"
#import "TiGaDictionaryBuilderProxy.h"
#import "TiGaProductProxy.h"
#import "TiGaProductActionProxy.h"
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

    if(_trackerId == nil){
        [self createDefaultTracker: nil];
    }else{
        [self createTracker: _trackerId];
    }

    [_tracker set:kGAIAnonymizeIp value:@"1"];
    [_tracker set:kGAIUseSecure value:[(_useSecure? @YES : @NO) stringValue]];

    _tracker.allowIDFACollection = [TiUtils boolValue:@"enableAdvertisingIdCollection" properties:properties def:NO];

    [_tracker set:kGAIAnonymizeIp value:@"1"];
    [_tracker set:kGAIUseSecure value:[(_useSecure? @YES : @NO) stringValue]];

    [super _initWithProperties:properties];
}

-(void)setUserID:(NSString*)userID // Not "args" like addScreenView because its prefixed with "set" and so expects a single value
{
    ENSURE_UI_THREAD(setUserID, userID);
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

- (void)set:(id)args
{
    ENSURE_UI_THREAD(set, args);

    NSString* key;
    NSString* value;

    if ([args count] == 2) {
        ENSURE_ARG_AT_INDEX(key, args, 0, NSString);
        ENSURE_ARG_AT_INDEX(value, args, 1, NSString);
    
        [_tracker set:key value:value];
    } else {
        for (key in args) {
            [_tracker set:key value:[args objectForKey:key]];
        }
    }
}

- (void)send:(id)args
{
    TiGaDictionaryBuilderProxy* builderProxy;

    ENSURE_UI_THREAD(send, args);
    ENSURE_ARG_COUNT(args, 1)
    ENSURE_ARG_AT_INDEX(builderProxy, args, 0, TiGaDictionaryBuilderProxy);

    [_tracker send:[builderProxy.dictionary build]];

    if (_debug) {
        NSLog(@"[DEBUG] sent custom builder dictionary");
    }
}

- (void)trackProductImpression:(id)args
{
    TiGaProductProxy* productProxy;
    NSString* screenName;
    NSString* impressionList;
    NSString* impressionSource;

    ENSURE_UI_THREAD(trackProductAction, args);
    ENSURE_ARG_AT_INDEX(productProxy, args, 0, TiGaProductProxy);
    ENSURE_ARG_AT_INDEX(screenName, args, 1, NSString);
    ENSURE_ARG_OR_NIL_AT_INDEX(impressionList, args, 2, NSString);
    ENSURE_ARG_OR_NIL_AT_INDEX(impressionSource, args, 3, NSString);

    GAIDictionaryBuilder *builder = [GAIDictionaryBuilder createScreenView];

    [builder addProductImpression:productProxy.product
                   impressionList:impressionList
                 impressionSource:impressionSource];

    [_tracker set:kGAIScreenName value:screenName];
    [_tracker send:[builder build]];

    if (_debug) {
        NSLog(@"[DEBUG] trackProductImpression for screen: %@", screenName);
    }
}

- (void)trackProductAction:(id)args
{
    TiGaProductProxy* productProxy;
    TiGaProductActionProxy* productActionProxy;
    NSString* screenName;

    ENSURE_UI_THREAD(trackProductAction, args);
    ENSURE_ARG_COUNT(args, 3);
    ENSURE_ARG_AT_INDEX(productProxy, args, 0, TiGaProductProxy);
    ENSURE_ARG_AT_INDEX(productActionProxy, args, 1, TiGaProductActionProxy);
    ENSURE_ARG_AT_INDEX(screenName, args, 2, NSString);

    GAIDictionaryBuilder *builder = [GAIDictionaryBuilder createScreenView];
    [builder setProductAction:productActionProxy.productAction];
    [builder addProduct:productProxy.product];

    [_tracker set:kGAIScreenName value:screenName];
    [_tracker send:[builder build]];

    if (_debug) {
        NSLog(@"[DEBUG] trackProductAction for screen: %@", screenName);
    }
}

-(void)addScreenView:(id)args
{
    ENSURE_UI_THREAD(addScreenView, args);
    NSString* screen = [TiUtils stringValue:[args objectAtIndex:0]];

    GAIDictionaryBuilder *builder = [GAIDictionaryBuilder createScreenView];

    if(_debug){
        NSLog(@"[DEBUG] addScreenView: %@", screen);
    }

    if([args count] > 1) {
        [self handleCustomFields:builder jshash:[args objectAtIndex:1]];
    }

    [_tracker set:kGAIScreenName value:screen];
    [_tracker send:[builder build]];
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

    GAIDictionaryBuilder *builder = [GAIDictionaryBuilder createEventWithCategory:category
                                                                           action:action
                                                                            label:label
                                                                            value:value];

    if(_debug){
        NSLog(@"[DEBUG] addEvent category: %@ action: %@ label: %@ value: %f", category, action, label, value);
    }

    [self handleCustomFields:builder jshash:args];
    [_tracker send:[builder build]];
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

    GAIDictionaryBuilder *builder = [GAIDictionaryBuilder createTimingWithCategory:category
                                                                          interval:time
                                                                              name:name
                                                                             label:label];
    if(_debug){
        NSLog(@"[DEBUG] addTiming category: %@ name: %@ label: %@ time: %f", category, name, label, time);
    }

    [self handleCustomFields:builder jshash:args];
    [_tracker send:[builder build]];

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

    GAIDictionaryBuilder *builder = [GAIDictionaryBuilder createSocialWithNetwork:network
                                                                           action:action
                                                                           target:target];

    if(_debug){
        NSLog(@"[DEBUG] addSocialNetwork network: %@ action: %@ arget: %@", network, action, target);
    }

    [self handleCustomFields:builder jshash:args];
    [_tracker send:[builder build]];

}

// Common way to deal with adding customDimensions and customMetrics fields
// Taken and modified from https://github.com/Sitata/titanium-google-analytics/blob/master/ios/Classes/AnalyticsGoogleTrackerProxy.m
-(void) handleCustomFields:(GAIDictionaryBuilder*) builder jshash:(id)args
{
    NSString *key;
    NSString *val;
    NSNumber *metricVal;
    NSDictionary *customDimensions;
    NSDictionary *customMetrics;


    ENSURE_ARG_OR_NIL_FOR_KEY(customDimensions, args, @"customDimensions", NSDictionary);
    if ([customDimensions count]) {
        for(key in customDimensions) {
            val = [customDimensions objectForKey: key];
            ENSURE_TYPE(val, NSString);
            [builder set:val forKey:[GAIFields customDimensionForIndex:[key integerValue]]];
        }
    }

    ENSURE_ARG_OR_NIL_FOR_KEY(customMetrics, args, @"customMetrics", NSDictionary);
    if ([customMetrics count]) {
        for(key in customMetrics) {
            metricVal = [customMetrics objectForKey: key];
            ENSURE_TYPE(metricVal, NSNumber);
            [builder set:[metricVal stringValue] forKey:[GAIFields customMetricForIndex:[key integerValue]]];
        }
    }
}

-(void)fireTransactionEvent:(id)args
{
    ENSURE_SINGLE_ARG(args,NSDictionary);
    ENSURE_UI_THREAD(fireTransactionEvent, args);

    NSString *transactionId = [TiUtils stringValue: @"transactionId" properties:args];
    NSString *affiliation = [TiUtils stringValue: @"affiliation" properties:args];
    NSNumber *revenue = [NSNumber numberWithFloat:[TiUtils floatValue:@"revenue" properties:args]];
    NSNumber *tax = [NSNumber numberWithFloat:[TiUtils floatValue:@"tax" properties:args]];
    NSNumber *shipping = [NSNumber numberWithFloat:[TiUtils floatValue:@"shipping" properties:args]];
    NSString *currencyCode = [TiUtils stringValue: @"currencyCode" properties:args];

    if(_debug){
        NSLog(@"[DEBUG] fireTransactionEvent transactionId: %@", transactionId);
        NSLog(@"[DEBUG] fireTransactionEvent affiliation: %@", affiliation);
        NSLog(@"[DEBUG] fireTransactionEvent revenue: %f", revenue);
        NSLog(@"[DEBUG] fireTransactionEvent tax: %f", tax);
        NSLog(@"[DEBUG] fireTransactionEvent shipping: %f", shipping);
        NSLog(@"[DEBUG] fireTransactionEvent currencyCode: %@", currencyCode);
    }

    [_tracker send:[[GAIDictionaryBuilder createTransactionWithId:transactionId
                                                            affiliation:affiliation
                                                                revenue:revenue
                                                                    tax:tax
                                                               shipping:shipping
                                                           currencyCode:currencyCode] build]];
}

@end
