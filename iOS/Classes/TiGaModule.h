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
@private
    BOOL _errorHandlerEnabled;
}

+(BOOL) LOG_DEBUG;

@property(nonatomic,readonly) NSString* ANONYMIZE_IP;
@property(nonatomic,readonly) NSString* HIT_TYPE;
@property(nonatomic,readonly) NSString* SESSION_CONTROL;
@property(nonatomic,readonly) NSString* NON_INTERACTION;
@property(nonatomic,readonly) NSString* DESCRIPTION;  // synonym for kGAIScreenName
@property(nonatomic,readonly) NSString* SCREEN_NAME;   // synonym for kGAIDescription
@property(nonatomic,readonly) NSString* LOCATION;
@property(nonatomic,readonly) NSString* REFERRER;
@property(nonatomic,readonly) NSString* PAGE;
@property(nonatomic,readonly) NSString* HOSTNAME;
@property(nonatomic,readonly) NSString* TITLE;
@property(nonatomic,readonly) NSString* LANGUAGE;
@property(nonatomic,readonly) NSString* TRACKING_ID;
@property(nonatomic,readonly) NSString* ENCODING;
@property(nonatomic,readonly) NSString* SCREEN_COLORS;
@property(nonatomic,readonly) NSString* SCREEN_RESOLUTION;
@property(nonatomic,readonly) NSString* VIEWPORT_SIZE;
@property(nonatomic,readonly) NSString* CLIENT_ID;

@property(nonatomic,readonly) NSString* CAMPAIGN_NAME;
@property(nonatomic,readonly) NSString* CAMPAIGN_SOURCE;
@property(nonatomic,readonly) NSString* CAMPAIGN_MEDIUM;
@property(nonatomic,readonly) NSString* CAMPAIGN_KEYWORD;
@property(nonatomic,readonly) NSString* CAMPAIGN_CONTENT;
@property(nonatomic,readonly) NSString* CAMPAIGN_ID;

@property(nonatomic,readonly) NSString* EVENT_CATEGORY;
@property(nonatomic,readonly) NSString* EVENT_ACTION;
@property(nonatomic,readonly) NSString* EVENT_LABEL;
@property(nonatomic,readonly) NSString* EVENT_VALUE;


@property(nonatomic,readonly) NSString* SOCIAL_NETWORK;
@property(nonatomic,readonly) NSString* SOCIAL_ACTION;
@property(nonatomic,readonly) NSString* SOCIAL_TARGET;

@property(nonatomic,readonly) NSString* TIMING_CATEGORY;
@property(nonatomic,readonly) NSString* TIMING_VAR;
@property(nonatomic,readonly) NSString* TIMING_VALUE;
@property(nonatomic,readonly) NSString* TIMING_LABEL;


@property(nonatomic,readonly) NSString* APP_NAME;
@property(nonatomic,readonly) NSString* APP_VERSION;
@property(nonatomic,readonly) NSString* APP_ID;
@property(nonatomic,readonly) NSString* APP_INSTALLER_ID;

@property(nonatomic,readonly) NSString* EX_DESCRIPTION;
@property(nonatomic,readonly) NSString* EX_FATAL;

@property(nonatomic,readonly) NSString* TRANSACTION_ID;
@property(nonatomic,readonly) NSString* TRANSACTION_AFFILIATION;
@property(nonatomic,readonly) NSString* TRANSACTION_REVENUE;
@property(nonatomic,readonly) NSString* TRANSACTION_SHIPPING;
@property(nonatomic,readonly) NSString* TRANSACTION_TAX;
@property(nonatomic,readonly) NSString* CURRENCY_CODE;

@property(nonatomic,readonly) NSString* ITEM_PRICE;
@property(nonatomic,readonly) NSString* ITEM_QUANTITY;
@property(nonatomic,readonly) NSString* ITEM_SKU;
@property(nonatomic,readonly) NSString* ITEM_NAME;
@property(nonatomic,readonly) NSString* ITEM_CATEGORY;

@property(nonatomic,readonly) NSString* SAMPLE_RATE;
@property(nonatomic,readonly) NSString* JAVA_ENABLED;
@property(nonatomic,readonly) NSString* FLASH_VERSION;
@property(nonatomic,readonly) NSString* USE_SECURE;

@property(nonatomic,readonly) NSString* HELPER_CONSTANT_TRUE;
@property(nonatomic,readonly) NSString* HELPER_CONSTANT_FALSE;


// hit types
@property(nonatomic,readonly) NSString* GAIAppView;
@property(nonatomic,readonly) NSString* GAIEvent;
@property(nonatomic,readonly) NSString* GAISocial;
@property(nonatomic,readonly) NSString* GAITransaction;
@property(nonatomic,readonly) NSString* GAIItem;
@property(nonatomic,readonly) NSString* GAIException;
@property(nonatomic,readonly) NSString* GAITiming;

@end
