/**
 * Ti.GA - Google Analytics for Titanium
 * Copyright (c) 2013 by Benjamin Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the MIT License
 * Please see the LICENSE included with this distribution for details.
 *
 * Available at https://github.com/benbahrenburg/Ti.GA
 *
 */
#import "TiModule.h"

@interface TiGaModule : TiModule {
}

@property(nonatomic,readonly) NSString* GAIUseSecure;
@property(nonatomic,readonly) NSString* GAIHitType;
@property(nonatomic,readonly) NSString* GAITrackingId;
@property(nonatomic,readonly) NSString* GAIClientId;
@property(nonatomic,readonly) NSString* GAIAnonymizeIp;
@property(nonatomic,readonly) NSString* GAISessionControl;
@property(nonatomic,readonly) NSString* GAIScreenResolution;
@property(nonatomic,readonly) NSString* GAIViewportSize;
@property(nonatomic,readonly) NSString* GAIEncoding;
@property(nonatomic,readonly) NSString* GAIScreenColors;
@property(nonatomic,readonly) NSString* GAILanguage;
@property(nonatomic,readonly) NSString* GAIJavaEnabled;
@property(nonatomic,readonly) NSString* GAIFlashVersion;
@property(nonatomic,readonly) NSString* GAINonInteraction;
@property(nonatomic,readonly) NSString* GAIReferrer;
@property(nonatomic,readonly) NSString* GAILocation;
@property(nonatomic,readonly) NSString* GAIHostname;
@property(nonatomic,readonly) NSString* GAIPage;
@property(nonatomic,readonly) NSString* GAIDescription;  // synonym for kGAIScreenName
@property(nonatomic,readonly) NSString* GAIScreenName;   // synonym for kGAIDescription
@property(nonatomic,readonly) NSString* GAITitle;
@property(nonatomic,readonly) NSString* GAIAppName;
@property(nonatomic,readonly) NSString* GAIAppVersion;
@property(nonatomic,readonly) NSString* GAIAppId;
@property(nonatomic,readonly) NSString* GAIAppInstallerId;

@property(nonatomic,readonly) NSString* GAIEventCategory;
@property(nonatomic,readonly) NSString* GAIEventAction;
@property(nonatomic,readonly) NSString* GAIEventLabel;
@property(nonatomic,readonly) NSString* GAIEventValue;

@property(nonatomic,readonly) NSString* GAISocialNetwork;
@property(nonatomic,readonly) NSString* GAISocialAction;
@property(nonatomic,readonly) NSString* GAISocialTarget;

@property(nonatomic,readonly) NSString* GAITransactionId;
@property(nonatomic,readonly) NSString* GAITransactionAffiliation;
@property(nonatomic,readonly) NSString* GAITransactionRevenue;
@property(nonatomic,readonly) NSString* GAITransactionShipping;
@property(nonatomic,readonly) NSString* GAITransactionTax;
@property(nonatomic,readonly) NSString* GAICurrencyCode;


@property(nonatomic,readonly) NSString* GAIItemPrice;
@property(nonatomic,readonly) NSString* GAIItemQuantity;
@property(nonatomic,readonly) NSString* GAIItemSku;
@property(nonatomic,readonly) NSString* GAIItemName;
@property(nonatomic,readonly) NSString* GAIItemCategory;

@property(nonatomic,readonly) NSString* GAICampaignSource;
@property(nonatomic,readonly) NSString* GAICampaignMedium;
@property(nonatomic,readonly) NSString* GAICampaignName;
@property(nonatomic,readonly) NSString* GAICampaignKeyword;
@property(nonatomic,readonly) NSString* GAICampaignContent;
@property(nonatomic,readonly) NSString* GAICampaignId;

@property(nonatomic,readonly) NSString* GAITimingCategory;
@property(nonatomic,readonly) NSString* GAITimingVar;
@property(nonatomic,readonly) NSString* GAITimingValue;
@property(nonatomic,readonly) NSString* GAITimingLabel;

@property(nonatomic,readonly) NSString* GAIExDescription;
@property(nonatomic,readonly) NSString* GAIExFatal;

@property(nonatomic,readonly) NSString* GAISampleRate;

// hit types
@property(nonatomic,readonly) NSString* GAIAppView;
@property(nonatomic,readonly) NSString* GAIEvent;
@property(nonatomic,readonly) NSString* GAISocial;
@property(nonatomic,readonly) NSString* GAITransaction;
@property(nonatomic,readonly) NSString* GAIItem;
@property(nonatomic,readonly) NSString* GAIException;
@property(nonatomic,readonly) NSString* GAITiming;

@end
