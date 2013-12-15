/**
 * Ti.GA - Google Analytics for Titanium
 * Copyright (c) 2013 by Benjamin Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the MIT License
 * Please see the LICENSE included with this distribution for details.
 *
 * Available at https://github.com/benbahrenburg/Ti.GA
 *
 */
#import "TiProxy.h"
#import "GAI.h"
@interface TiGaTrackerObjectProxy : TiProxy {
    @private
    NSString *_trackingId;
    BOOL _sessionStart;
}
-(id)initWithDefaultTracker;
-(id)initWithParams:(NSDictionary*)args;
@end
