/**
 * Ti.GA - Google Analytics for Titanium
 * Copyright (c) 2013 by Benjamin Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the MIT License
 * Please see the LICENSE included with this distribution for details.
 *
 * Available at https://github.com/benbahrenburg/Ti.GA
 *
 */
#import "TiGaModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "GAI.h"
#import "GAIFields.h"
#import "TiGaTrackerObjectProxy.h"

@implementation TiGaModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"957d2892-5405-4a7f-8d44-8afaffeb17b1";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"ti.ga";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
}

-(void)shutdown:(id)sender
{	
	// you *must* call the superclass
	[super shutdown:sender];
    
    if(![NSThread isMainThread]){
        TiThreadPerformOnMainThread(^{
            [[GAI sharedInstance] dispatch];
        }, NO);
    }
}

#pragma mark Cleanup 


#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	[super didReceiveMemoryWarning:notification];
}

-(id)createTracker:(id)args
{
    if(args == nil){
        return [[TiGaTrackerObjectProxy alloc] initWithDefaultTracker];
    }
    
    ENSURE_SINGLE_ARG(args,NSDictionary);
    ENSURE_TYPE(args,NSDictionary);
    return [[TiGaTrackerObjectProxy alloc] initWithParams:args];
}

-(id)debug
{
    return NUMBOOL([[GAI sharedInstance].logger logLevel] == kGAILogLevelNone);
}

-(void) setDebug:(id)value
{
    if([TiUtils boolValue:value]){
        [[GAI sharedInstance].logger setLogLevel:kGAILogLevelNone];
    }else{
        [[GAI sharedInstance].logger setLogLevel:kGAILogLevelVerbose];
    }
}

-(id)optOut
{
    return NUMBOOL([[GAI sharedInstance] optOut]);
}
-(void)setOptOut:(id)value
{
    [[GAI sharedInstance] setOptOut:[TiUtils boolValue:value]];
}

-(id)dispatchInterval
{
    return [NSNumber numberWithDouble:[GAI sharedInstance].dispatchInterval];
}
-(void)setDispatchInterval:(id)value
{
    ENSURE_SINGLE_ARG(value,NSNumber);
    [GAI sharedInstance].dispatchInterval = [TiUtils doubleValue:value];
}

-(id) trackUncaughtExceptions
{
    return NUMBOOL([GAI sharedInstance].trackUncaughtExceptions);
}
-(void) setTrackUncaughtExceptions:(id)value
{
    ENSURE_SINGLE_ARG(value,NSNumber);
    [GAI sharedInstance].trackUncaughtExceptions = [TiUtils boolValue:value];
}

-(void)dispatch:(id)unused
{
    ENSURE_UI_THREAD(dispatch,unused);    
    [[GAI sharedInstance] dispatch];
}

MAKE_SYSTEM_PROP(GAIUseSecure,kGAIUseSecure);


MAKE_SYSTEM_PROP(GAIHitType,kGAIHitType);
MAKE_SYSTEM_PROP(GAITrackingId,kGAITrackingId);
MAKE_SYSTEM_PROP(GAIClientId,kGAIClientId);
MAKE_SYSTEM_PROP(GAIAnonymizeIp,kGAIAnonymizeIp);
MAKE_SYSTEM_PROP(GAISessionControl,kGAISessionControl);
MAKE_SYSTEM_PROP(GAIScreenResolution,kGAIScreenResolution);
MAKE_SYSTEM_PROP(GAIViewportSize,kGAIViewportSize);
MAKE_SYSTEM_PROP(GAIEncoding,kGAIEncoding);
MAKE_SYSTEM_PROP(GAIScreenColors,kGAIScreenColors);
MAKE_SYSTEM_PROP(GAILanguage,kGAILanguage);
MAKE_SYSTEM_PROP(GAIJavaEnabled,kGAIJavaEnabled);
MAKE_SYSTEM_PROP(GAIFlashVersion,kGAIFlashVersion);
MAKE_SYSTEM_PROP(GAINonInteraction,kGAINonInteraction);
MAKE_SYSTEM_PROP(GAIReferrer,kGAIReferrer);
MAKE_SYSTEM_PROP(GAILocation,kGAILocation);
MAKE_SYSTEM_PROP(GAIHostname,kGAIHostname);
MAKE_SYSTEM_PROP(GAIPage,kGAIPage);
MAKE_SYSTEM_PROP(GAIDescription,kGAIDescription);  // synonym for kGAIScreenName
MAKE_SYSTEM_PROP(GAIScreenName,kGAIScreenName);   // synonym for kGAIDescription
MAKE_SYSTEM_PROP(GAITitle,kGAITitle);
MAKE_SYSTEM_PROP(GAIAppName,kGAIAppName);
MAKE_SYSTEM_PROP(GAIAppVersion,kGAIAppVersion);
MAKE_SYSTEM_PROP(GAIAppId,kGAIAppId);
MAKE_SYSTEM_PROP(GAIAppInstallerId,kGAIAppInstallerId);

MAKE_SYSTEM_PROP(GAIEventCategory,kGAIEventCategory);
MAKE_SYSTEM_PROP(GAIEventAction,kGAIEventAction);
MAKE_SYSTEM_PROP(GAIEventLabel,kGAIEventLabel);
MAKE_SYSTEM_PROP(GAIEventValue,kGAIEventValue);

MAKE_SYSTEM_PROP(GAISocialNetwork,kGAISocialNetwork);
MAKE_SYSTEM_PROP(GAISocialAction,kGAISocialAction);
MAKE_SYSTEM_PROP(GAISocialTarget,kGAISocialTarget);

MAKE_SYSTEM_PROP(GAITransactionId,kGAITransactionId);
MAKE_SYSTEM_PROP(GAITransactionAffiliation,kGAITransactionAffiliation);
MAKE_SYSTEM_PROP(GAITransactionRevenue,kGAITransactionRevenue);
MAKE_SYSTEM_PROP(GAITransactionShipping,kGAITransactionShipping);
MAKE_SYSTEM_PROP(GAITransactionTax,kGAITransactionTax);
MAKE_SYSTEM_PROP(GAICurrencyCode,kGAICurrencyCode);



MAKE_SYSTEM_PROP(GAIItemPrice,kGAIItemPrice);
MAKE_SYSTEM_PROP(GAIItemQuantity,kGAIItemQuantity);
MAKE_SYSTEM_PROP(GAIItemSku,kGAIItemSku);
MAKE_SYSTEM_PROP(GAIItemName,kGAIItemName);
MAKE_SYSTEM_PROP(GAIItemCategory,kGAIItemCategory);

MAKE_SYSTEM_PROP(GAICampaignSource,kGAICampaignSource);
MAKE_SYSTEM_PROP(GAICampaignMedium,kGAICampaignMedium);
MAKE_SYSTEM_PROP(GAICampaignName,kGAICampaignName);
MAKE_SYSTEM_PROP(GAICampaignKeyword,kGAICampaignKeyword);
MAKE_SYSTEM_PROP(GAICampaignContent,kGAICampaignContent);
MAKE_SYSTEM_PROP(GAICampaignId,kGAICampaignId);

MAKE_SYSTEM_PROP(GAITimingCategory,kGAITimingCategory);
MAKE_SYSTEM_PROP(GAITimingVar,kGAITimingVar);
MAKE_SYSTEM_PROP(GAITimingValue,kGAITimingValue);
MAKE_SYSTEM_PROP(GAITimingLabel,kGAITimingLabel);

MAKE_SYSTEM_PROP(GAIExDescription,kGAIExDescription);
MAKE_SYSTEM_PROP(GAIExFatal,kGAIExFatal);

MAKE_SYSTEM_PROP(GAISampleRate,kGAISampleRate);

// hit types
MAKE_SYSTEM_PROP(GAIAppView,kGAIAppView);
MAKE_SYSTEM_PROP(GAIEvent,kGAIEvent);
MAKE_SYSTEM_PROP(GAISocial,kGAISocial);
MAKE_SYSTEM_PROP(GAITransaction,kGAITransaction);
MAKE_SYSTEM_PROP(GAIItem,kGAIItem);
MAKE_SYSTEM_PROP(GAIException,kGAIException);
MAKE_SYSTEM_PROP(GAITiming,kGAITiming);

@end
