/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2013 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiProxy.h"
#import "GAI.h"
@interface TiGaTrackerObjectProxy : TiProxy {
    @private
    NSString *_trackingId;
    NSString *_appVersion;
    NSString *_appName;
    NSString *_appId;
    BOOL _useHttps;
    BOOL _anonymize;
    BOOL _sessionStart;
    NSNumber *_sampleRate;
}
-(id)initWithDefaultTracker;
-(id)initWithParams:(NSDictionary*)args;
@end
