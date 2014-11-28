//
//  TiGoogleanalyticsTracker.h
//  googleanalytics
//
//  Created by Dawson Toth on 8/19/13.
//
//

#import "TiProxy.h"
#import "GAITracker.h"

@interface TiGoogleanalyticsTracker : TiProxy {
        id<GAITracker> tracker;
}

-(id)initWithTracker:(id<GAITracker>)t;

@end
