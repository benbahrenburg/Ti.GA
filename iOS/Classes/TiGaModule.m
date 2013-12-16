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
#import "BXBUtil.h"

@implementation TiGaModule

static BOOL _LOG_DEBUG = NO;

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
    _errorHandlerEnabled = NO;
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

+(BOOL) LOG_DEBUG
{
    return _LOG_DEBUG;
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
        [[GAI sharedInstance].logger setLogLevel:kGAILogLevelVerbose];
        _LOG_DEBUG = YES;
        [BXBUtil logDebug:@"Debug enabled"];
    }else{
        [[GAI sharedInstance].logger setLogLevel:kGAILogLevelNone];
        _LOG_DEBUG = NO;
        [BXBUtil logDebug:@"Debug disabled, only warnings will be displayed"];
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
    
    [BXBUtil logDebug:[@"Display level set " stringByAppendingString:[NSString stringWithFormat:@"%f",
                                                                      [TiUtils doubleValue:value]]]];
    [GAI sharedInstance].dispatchInterval = [TiUtils doubleValue:value];
}

-(NSNumber*) isTrackUncaughtExceptionsActive:(id)unused
{
    return NUMBOOL(_errorHandlerEnabled);
}
-(void) enableTrackUncaughtExceptions:(id)unused
{
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    _errorHandlerEnabled = YES;
    [BXBUtil logDebug:@"trackUncaughtExceptions enabled "];
}

-(void)dispatch:(id)unused
{
    ENSURE_UI_THREAD(dispatch,unused);    
    [[GAI sharedInstance] dispatch];
    [BXBUtil logDebug:@"manual dispatch called"];
}

MAKE_SYSTEM_PROP(ANONYMIZE_IP,kGAIAnonymizeIp);
MAKE_SYSTEM_PROP(HIT_TYPE,kGAIHitType);
MAKE_SYSTEM_PROP(SESSION_CONTROL,kGAISessionControl);
MAKE_SYSTEM_PROP(NON_INTERACTION,kGAINonInteraction);
MAKE_SYSTEM_PROP(DESCRIPTION,kGAIDescription);  // synonym for kGAIScreenName
MAKE_SYSTEM_PROP(SCREEN_NAME,kGAIScreenName);   // synonym for kGAIDescription
MAKE_SYSTEM_PROP(LOCATION,kGAILocation);
MAKE_SYSTEM_PROP(REFERRER,kGAIReferrer);
MAKE_SYSTEM_PROP(PAGE,kGAIPage);
MAKE_SYSTEM_PROP(HOSTNAME,kGAIHostname);
MAKE_SYSTEM_PROP(TITLE,kGAITitle);
MAKE_SYSTEM_PROP(LANGUAGE,kGAILanguage);
MAKE_SYSTEM_PROP(TRACKING_ID,kGAITrackingId);
MAKE_SYSTEM_PROP(ENCODING,kGAIEncoding);
MAKE_SYSTEM_PROP(SCREEN_COLORS,kGAIScreenColors);
MAKE_SYSTEM_PROP(SCREEN_RESOLUTION,kGAIScreenResolution);
MAKE_SYSTEM_PROP(VIEWPORT_SIZE,kGAIViewportSize);
MAKE_SYSTEM_PROP(CLIENT_ID,kGAIClientId);

MAKE_SYSTEM_PROP(CAMPAIGN_NAME,kGAICampaignName);
MAKE_SYSTEM_PROP(CAMPAIGN_SOURCE,kGAICampaignSource);
MAKE_SYSTEM_PROP(CAMPAIGN_MEDIUM,kGAICampaignMedium);
MAKE_SYSTEM_PROP(CAMPAIGN_KEYWORD,kGAICampaignKeyword);
MAKE_SYSTEM_PROP(CAMPAIGN_CONTENT,kGAICampaignContent);
MAKE_SYSTEM_PROP(CAMPAIGN_ID,kGAICampaignId);

MAKE_SYSTEM_PROP(EVENT_CATEGORY,kGAIEventCategory);
MAKE_SYSTEM_PROP(EVENT_ACTION,kGAIEventAction);
MAKE_SYSTEM_PROP(EVENT_LABEL,kGAIEventLabel);
MAKE_SYSTEM_PROP(EVENT_VALUE,kGAIEventValue);

MAKE_SYSTEM_PROP(SOCIAL_NETWORK,kGAISocialNetwork);
MAKE_SYSTEM_PROP(SOCIAL_ACTION,kGAISocialAction);
MAKE_SYSTEM_PROP(SOCIAL_TARGET,kGAISocialTarget);


MAKE_SYSTEM_PROP(TIMING_CATEGORY,kGAITimingCategory);
MAKE_SYSTEM_PROP(TIMING_VAR,kGAITimingVar);
MAKE_SYSTEM_PROP(TIMING_VALUE,kGAITimingValue);
MAKE_SYSTEM_PROP(TIMING_LABEL,kGAITimingLabel);

MAKE_SYSTEM_PROP(APP_NAME,kGAIAppName);
MAKE_SYSTEM_PROP(APP_VERSION,kGAIAppVersion);
MAKE_SYSTEM_PROP(APP_ID,kGAIAppId);
MAKE_SYSTEM_PROP(APP_INSTALLER_ID,kGAIAppInstallerId);

MAKE_SYSTEM_PROP(EX_DESCRIPTION,kGAIExDescription);
MAKE_SYSTEM_PROP(EX_FATAL,kGAIExFatal);

MAKE_SYSTEM_PROP(CURRENCY_CODE,kGAICurrencyCode);
MAKE_SYSTEM_PROP(TRANSACTION_ID,kGAITransactionId);
MAKE_SYSTEM_PROP(TRANSACTION_AFFILIATION,kGAITransactionAffiliation);
MAKE_SYSTEM_PROP(TRANSACTION_REVENUE,kGAITransactionRevenue);
MAKE_SYSTEM_PROP(TRANSACTION_SHIPPING,kGAITransactionShipping);
MAKE_SYSTEM_PROP(TRANSACTION_TAX,kGAITransactionTax);

MAKE_SYSTEM_PROP(ITEM_PRICE,kGAIItemPrice);
MAKE_SYSTEM_PROP(ITEM_QUANTITY,kGAIItemQuantity);
MAKE_SYSTEM_PROP(ITEM_SKU,kGAIItemSku);
MAKE_SYSTEM_PROP(ITEM_NAME,kGAIItemName);
MAKE_SYSTEM_PROP(ITEM_CATEGORY,kGAIItemCategory);

MAKE_SYSTEM_PROP(USE_SECURE,kGAIUseSecure);
MAKE_SYSTEM_PROP(JAVA_ENABLED,kGAIJavaEnabled);
MAKE_SYSTEM_PROP(FLASH_VERSION,kGAIFlashVersion);
MAKE_SYSTEM_PROP(SAMPLE_RATE,kGAISampleRate);

// hit types
MAKE_SYSTEM_PROP(GAIAppView,kGAIAppView);
MAKE_SYSTEM_PROP(GAIEvent,kGAIEvent);
MAKE_SYSTEM_PROP(GAISocial,kGAISocial);
MAKE_SYSTEM_PROP(GAITransaction,kGAITransaction);
MAKE_SYSTEM_PROP(GAIItem,kGAIItem);
MAKE_SYSTEM_PROP(GAIException,kGAIException);
MAKE_SYSTEM_PROP(GAITiming,kGAITiming);

@end
