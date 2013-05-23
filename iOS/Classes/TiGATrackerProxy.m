/**
 * Benjamin Bahrenburg
 * Copyright (c) 2009-2013 by Benjamin Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiGATrackerProxy.h"
#import "TiUtils.h"

id<GAITracker>  _tracker;

@implementation TiGATrackerProxy

-(void)dealloc
{
	// release any resources that have been retained by the module
    if(_tracker!=nil){
        [_tracker close];
        RELEASE_TO_NIL(_tracker);
    }

	[super dealloc];
}

-(void) _configure
{
    if([self valueForUndefinedKey:@"trackingId"]!=nil){
        [self setTrackingId:[self valueForUndefinedKey:@"trackingId"]];
    }else{
        _tracker = [GAI sharedInstance].defaultTracker;
    }
}

-(id<GAITracker>)tracker
{
    if(_tracker==nil){
       _tracker = [GAI sharedInstance].defaultTracker;
    }
    return _tracker;
}

-(id)appVersion
{
    return [[self tracker] appVersion];
}
-(void)setAppVersion:(id)value
{
    [[self tracker] setAppVersion:[TiUtils stringValue:value]];
}

-(id)appName
{
    return [[self tracker] appName];
}
-(void)setAppName:(id)value
{
    [[self tracker] setAppName:[TiUtils stringValue:value]];
}

-(id)appId
{
    return [[self tracker] appId];
}
-(void)setAppId:(id)value
{
    [[self tracker] setAppId:[TiUtils stringValue:value]];
}

-(void) close:(id)unused
{
    [[self tracker] close];
}

-(id)TrackingId
{
    return [[self tracker] trackingId];
}

-(void) setTrackingId:(id)value
{
    if(_tracker!=nil){
        RELEASE_TO_NIL(_tracker);
    }
    _tracker = [[GAI sharedInstance] trackerWithTrackingId:[TiUtils stringValue:value]];
}

-(void) sendEvent:(id)args
{
    ENSURE_SINGLE_ARG(args,NSDictionary);

    [[self tracker] sendEventWithCategory:[TiUtils stringValue:@"category"
                                              properties:args def:nil]
                         withAction:[TiUtils stringValue:@"action" properties:args def:nil]
                          withLabel:[TiUtils stringValue:@"label" properties:args def:nil]
                          withValue: [TiUtils intValue:@"value" properties:args def:nil]];
}

-(void) sendSocial:(id)args
{
    ENSURE_SINGLE_ARG(args,NSDictionary);
    
    [[self tracker] sendSocial:[TiUtils stringValue:@"network"
                                   properties:args def:nil]
              withAction:[TiUtils stringValue:@"action" properties:args def:nil]
              withTarget:[TiUtils stringValue:@"target" properties:args def:nil]];
}

-(void)sendView:(id)value
{
    ENSURE_SINGLE_ARG(value, NSString);
    [[self tracker] sendView:value];
}

-(void) send:(id)args
{
    enum Args {
        kArgTrackType=0,
        kArgParam,
        kArgCount
    };
    ENSURE_ARG_COUNT(args,kArgCount);
    
    id params = [args objectAtIndex:kArgParam];
    ENSURE_DICT(params)
    
    [[self tracker] send:[TiUtils stringValue:[args objectAtIndex:kArgTrackType]]
                  params:params];
}

-(void) sendTiming:(id)args
{
    ENSURE_SINGLE_ARG(args,NSDictionary);
    
    [[self tracker] sendTimingWithCategory:[TiUtils stringValue:@"category"
                                                     properties:args def:nil]
                                  withValue:[TiUtils doubleValue:@"value" properties:args]
                                  withName:[TiUtils stringValue:@"name"
                                                     properties:args def:nil]
                                 withLabel:[TiUtils stringValue:@"label"
                                                     properties:args def:nil]];
}

-(id)anonymize
{
    return NUMBOOL([[self tracker] anonymize]);    
}
-(void)setAnonymize:(id)value
{
    [[self tracker] setAnonymize:[TiUtils boolValue:value]];
}

-(id)useHttps
{
    return NUMBOOL([[self tracker] useHttps]);
}

-(void)setUseHttps:(id)value
{
    [[self tracker] setUseHttps:[TiUtils boolValue:value]];    
}

-(id)sampleRate
{
    return NUMDOUBLE([[self tracker] sampleRate]);
}
-(void)setSampleRate:(id)value
{
    ENSURE_SINGLE_ARG(value, NSNumber);
    [[self tracker] setSampleRate:[TiUtils doubleValue:value]];
}
-(void) setSessionTimeout:(id)value
{
    [[self tracker] setSessionTimeout:[TiUtils doubleValue:value]];
}

-(void) setSessionStart:(id)value
{
    [[self tracker] setSessionStart:[TiUtils boolValue:value]];
}

@end
