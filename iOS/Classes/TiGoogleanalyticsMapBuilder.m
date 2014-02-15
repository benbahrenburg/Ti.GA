//
//  TiGoogleanalyticsMapBuilder.m
//  googleanalytics
//
//  Created by Dawson Toth on 8/19/13.
//
//

#import "TiGoogleanalyticsMapBuilder.h"

@implementation TiGoogleanalyticsMapBuilder

-(id)createAppView:(id)args {
    RELEASE_TO_NIL(db);
    db = [[GAIDictionaryBuilder createAppView] retain];
    return self;
}

-(id)createEvent:(id)args {
    NSString *category;
    NSString *action;
    NSString *label;
    NSNumber *value;
    ENSURE_ARG_AT_INDEX(category, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(action, args, 1, NSString);
    ENSURE_ARG_OR_NIL_AT_INDEX(label, args, 2, NSString);
    ENSURE_ARG_OR_NIL_AT_INDEX(value, args, 3, NSNumber);
    RELEASE_TO_NIL(db);
    db = [[GAIDictionaryBuilder createEventWithCategory:category
                                                action:action
                                                 label:label
                                                 value:value] retain];
    return self;
}

-(id)createException:(id)args {
    NSString *exceptionDescription;
    NSNumber *fatal;
    ENSURE_ARG_AT_INDEX(exceptionDescription, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(fatal, args, 1, NSNumber);
    RELEASE_TO_NIL(db);
    db = [[GAIDictionaryBuilder createExceptionWithDescription:exceptionDescription
                                                    withFatal:fatal] retain];
    return self;
}

-(id)createItem:(id)args {
    NSString *transactionId;
    NSString *name;
    NSString *sku;
    NSString *category;
    NSNumber *price;
    NSNumber *quantity;
    NSString *currencyCode;
    ENSURE_ARG_AT_INDEX(transactionId, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(name, args, 1, NSString);
    ENSURE_ARG_AT_INDEX(sku, args, 2, NSString);
    ENSURE_ARG_AT_INDEX(category, args, 3, NSString);
    ENSURE_ARG_AT_INDEX(price, args, 4, NSNumber);
    ENSURE_ARG_AT_INDEX(quantity, args, 5, NSNumber);
    ENSURE_ARG_OR_NIL_AT_INDEX(currencyCode, args, 6, NSString);
    RELEASE_TO_NIL(db);
    db = [[GAIDictionaryBuilder createItemWithTransactionId:transactionId
                                                      name:name
                                                       sku:sku
                                                  category:category
                                                     price:price
                                                  quantity:quantity
                                              currencyCode:currencyCode] retain];
    return self;
}

-(id)createSocial:(id)args {
    NSString *network;
    NSString *action;
    NSString *target;
    ENSURE_ARG_AT_INDEX(network, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(action, args, 1, NSString);
    ENSURE_ARG_OR_NIL_AT_INDEX(target, args, 2, NSString);
    RELEASE_TO_NIL(db);
    db = [[GAIDictionaryBuilder createSocialWithNetwork:network
                                                action:action
                                                target:target] retain];
    return self;
}

-(id)createTiming:(id)args {
    NSString *category;
    NSNumber *intervalInMilliseconds;
    NSString *name;
    NSString *label;
    ENSURE_ARG_AT_INDEX(category, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(intervalInMilliseconds, args, 1, NSNumber);
    ENSURE_ARG_AT_INDEX(name, args, 2, NSString);
    ENSURE_ARG_OR_NIL_AT_INDEX(label, args, 3, NSString);
    RELEASE_TO_NIL(db);
    db = [[GAIDictionaryBuilder createTimingWithCategory:category
                                               interval:intervalInMilliseconds
                                                   name:name
                                                  label:label] retain];
    return self;
}

-(id)createTransaction:(id)args {
    NSString *transactionId;
    NSString *affiliation;
    NSNumber *revenue;
    NSNumber *tax;
    NSNumber *shipping;
    NSString *currencyCode;
    ENSURE_ARG_AT_INDEX(transactionId, args, 0, NSString);
    ENSURE_ARG_OR_NIL_AT_INDEX(affiliation, args, 1, NSString);
    ENSURE_ARG_AT_INDEX(revenue, args, 2, NSNumber);
    ENSURE_ARG_OR_NIL_AT_INDEX(tax, args, 3, NSNumber);
    ENSURE_ARG_OR_NIL_AT_INDEX(shipping, args, 4, NSNumber);
    ENSURE_ARG_OR_NIL_AT_INDEX(currencyCode, args, 5, NSString);
    RELEASE_TO_NIL(db);
    db = [[GAIDictionaryBuilder createTransactionWithId:transactionId
                                           affiliation:affiliation
                                               revenue:revenue
                                                   tax:tax
                                              shipping:shipping
                                          currencyCode:currencyCode] retain];
    return self;
}

-(id)build:(id)args {
    return [db build];
}

-(id)get:(id)paramName {
    ENSURE_SINGLE_ARG(paramName, NSString);
    return [db get:paramName];
}

-(id)set:(id)args {
    NSString *paramName;
    NSString *paramValue;
    ENSURE_ARG_AT_INDEX(paramName, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(paramValue, args, 1, NSString);
    [db set:paramValue forKey:paramName];
    return self;
}

-(id)setAll:(id)args {
    ENSURE_SINGLE_ARG(args, NSDictionary);
    [db setAll:args];
    return self;
}


-(id)setCampaignParamsFromUrl:(id)utmParams {
    ENSURE_SINGLE_ARG(utmParams, NSString);
    [db setCampaignParametersFromUrl:utmParams];
    return self;
}

-(void)dealloc
{
	RELEASE_TO_NIL(db);
	[super dealloc];
}

@end
