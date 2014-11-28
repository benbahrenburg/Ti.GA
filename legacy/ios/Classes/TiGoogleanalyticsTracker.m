//
//  TiGoogleanalyticsTracker.m
//  googleanalytics
//
//  Created by Dawson Toth on 8/19/13.
//
//

#import "TiGoogleanalyticsTracker.h"

@implementation TiGoogleanalyticsTracker

-(id)initWithTracker:(id<GAITracker>)t
{
    if (self = [super init]) {
        // DToth: GAI.h tells us not to retain/release the tracker, so we won't.
        tracker = t;
    }
    return self;
}

#pragma mark Public API

-(id)get:(id)key
{
    ENSURE_SINGLE_ARG(key, NSString);
    return [tracker get:key];
}

-(id)name
{
    return tracker.name;
}

-(void)send:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);
    [tracker send:args];
}

-(void)set:(id)args
{
    NSString *key;
    NSString *value;
    ENSURE_ARG_COUNT(args, 2)
    ENSURE_ARG_AT_INDEX(key, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(value, args, 1, NSString);
    [tracker set:key value:value];
}

-(void)dealloc
{
    // DToth: GAI.h tells us not to retain/release the tracker, so we won't.
    tracker = nil;
	[super dealloc];
}

@end
