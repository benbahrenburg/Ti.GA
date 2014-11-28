//
//  TiGoogleanalyticsFields.m
//  googleanalytics
//
//  Created by Dawson Toth on 8/19/13.
//
//

#import "TiGoogleanalyticsFields.h"

@implementation TiGoogleanalyticsFields

+(NSDictionary *)fields
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            kGAIUseSecure, @"USE_SECURE",
            kGAIHitType, @"HIT_TYPE",
            kGAITrackingId, @"TRACKING_ID",
            kGAIClientId, @"CLIENT_ID",
            kGAIAnonymizeIp, @"ANONYMIZE_IP",
            kGAISessionControl, @"SESSION_CONTROL",
            kGAIScreenResolution, @"SCREEN_RESOLUTION",
            kGAIViewportSize, @"VIEWPORT_SIZE",
            kGAIEncoding, @"ENCODING",
            kGAIScreenColors, @"SCREEN_COLORS",
            kGAILanguage, @"LANGUAGE",
            kGAIJavaEnabled, @"JAVA_ENABLED",
            kGAIFlashVersion, @"FLASH_VERSION",
            kGAINonInteraction, @"NON_INTERACTION",
            kGAIReferrer, @"REFERRER",
            kGAILocation, @"LOCATION",
            kGAIHostname, @"HOSTNAME",
            kGAIPage, @"PAGE",
            kGAIDescription, @"DESCRIPTION",
            kGAIScreenName, @"SCREEN_NAME",
            kGAITitle, @"TITLE",
            kGAIAppName, @"APP_NAME",
            kGAIAppVersion, @"APP_VERSION",
            kGAIAppId, @"APP_ID",
            kGAIAppInstallerId, @"APP_INSTALLER_ID",
            
            kGAIEventCategory, @"EVENT_CATEGORY",
            kGAIEventAction, @"EVENT_ACTION",
            kGAIEventLabel, @"EVENT_LABEL",
            kGAIEventValue, @"EVENT_VALUE",
            
            kGAISocialNetwork, @"SOCIAL_NETWORK",
            kGAISocialAction, @"SOCIAL_ACTION",
            kGAISocialTarget, @"SOCIAL_TARGET",
            
            kGAITransactionId, @"TRANSACTION_ID",
            kGAITransactionAffiliation, @"TRANSACTION_AFFILIATION",
            kGAITransactionRevenue, @"TRANSACTION_REVENUE",
            kGAITransactionShipping, @"TRANSACTION_SHIPPING",
            kGAITransactionTax, @"TRANSACTION_TAX",
            kGAICurrencyCode, @"CURRENCY_CODE",
            
            kGAIItemPrice, @"ITEM_PRICE",
            kGAIItemQuantity, @"ITEM_QUANTITY",
            kGAIItemSku, @"ITEM_SKU",
            kGAIItemName, @"ITEM_NAME",
            kGAIItemCategory, @"ITEM_CATEGORY",
            
            kGAICampaignSource, @"CAMPAIGN_SOURCE",
            kGAICampaignMedium, @"CAMPAIGN_MEDIUM",
            kGAICampaignName, @"CAMPAIGN_NAME",
            kGAICampaignKeyword, @"CAMPAIGN_KEYWORD",
            kGAICampaignContent, @"CAMPAIGN_CONTENT",
            kGAICampaignId, @"CAMPAIGN_ID",
            
            kGAITimingCategory, @"TIMING_CATEGORY",
            kGAITimingVar, @"TIMING_VAR",
            kGAITimingValue, @"TIMING_VALUE",
            kGAITimingLabel, @"TIMING_LABEL",
            
            kGAIExDescription, @"EX_DESCRIPTION",
            kGAIExFatal, @"EX_FATAL",
            
            kGAISampleRate, @"SAMPLE_RATE",
            nil];
}

@end
