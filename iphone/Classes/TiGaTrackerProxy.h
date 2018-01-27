/**
 * Ti.GA - Basic Google Analytics for Titanium
 * Copyright (c) 2014 by Benjamin Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiProxy.h"
#import "GAI.h"

@interface TiGaTrackerProxy : TiProxy {
    NSString * _trackerId;
    BOOL _debug;
    BOOL _useSecure;
    id<GAITracker> _tracker;
}

- (void)trackProductImpression:(id)args;
- (void)trackProductAction:(id)args;
- (void)send:(id)args;

@end
