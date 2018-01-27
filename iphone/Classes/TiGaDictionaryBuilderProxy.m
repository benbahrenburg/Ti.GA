/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2017 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiGaDictionaryBuilderProxy.h"
#import "TiGaProductProxy.h"
#import "TiGaProductActionProxy.h"
#import "TiGaPromotionProxy.h"
#import "TiGaModuleConstants.h"

@implementation TiGaDictionaryBuilderProxy

- (void)_initWithProperties:(NSDictionary *)properties
{
    NSNumber* type = [properties valueForKey:@"type"];
    NSDictionary* options = [properties valueForKey:@"options"];

    NSLog(@"Type %@ %@", type, NSStringFromClass([type class]));

    if (options != nil) {
        NSLog(@"Options %@", NSStringFromClass([options class]));
    }

    if ([type intValue] == TiGaDictionaryTypeEvent) {
        NSString* event;
        NSString* action;
        NSString* label;
        NSNumber* value;

        ENSURE_ARG_FOR_KEY(event, options, @"name", NSString);
        ENSURE_ARG_FOR_KEY(action, options, @"action", NSString);
        ENSURE_ARG_OR_NIL_FOR_KEY(label, options, @"label", NSString);
        ENSURE_ARG_OR_NIL_FOR_KEY(value, options, @"value", NSNumber);

        _dictionary = [GAIDictionaryBuilder createEventWithCategory:event
                                                             action:action
                                                              label:label
                                                              value:value];
    } else {
        _dictionary = [GAIDictionaryBuilder createScreenView];
    }
}

#pragma mark Public APIs

- (void)addProduct:(id)arg
{
    TiGaProductProxy* productProxy;

    ENSURE_UI_THREAD(addProduct, arg);
    ENSURE_ARG_AT_INDEX(productProxy, arg, 0, TiGaProductProxy);

    [_dictionary addProduct:productProxy.product];
}

- (void)setProductAction:(id)arg
{
    TiGaProductActionProxy* productActionProxy;

    ENSURE_UI_THREAD(setProductAction, arg);
    ENSURE_ARG_AT_INDEX(productActionProxy, arg, 0, TiGaProductActionProxy);

    [_dictionary setProductAction:productActionProxy.productAction];
}

- (void)addPromotion:(id)arg
{
    TiGaPromotionProxy* promotionProxy;

    ENSURE_UI_THREAD(addPromotion, arg);
    ENSURE_ARG_AT_INDEX(promotionProxy, arg, 0, TiGaPromotionProxy);

    [_dictionary addPromotion:promotionProxy.promotion];
}

- (void)addImpression:(id)arg
{
    ENSURE_UI_THREAD(addImpression, arg);
    ENSURE_ARG_COUNT(arg, 3);

    TiGaProductProxy* productProxy;
    NSString* impressionList;
    NSString* impressionSource;

    ENSURE_ARG_AT_INDEX(productProxy, arg, 0, TiGaProductProxy);
    ENSURE_ARG_AT_INDEX(impressionList, arg, 1, NSString);
    ENSURE_ARG_AT_INDEX(impressionSource, arg, 2, NSString);

    [_dictionary addProductImpression:productProxy.product impressionList:impressionList impressionSource:impressionSource];
}

#pragma mark Internals

- (void)log:(NSString*)string forLevel:(NSString*)level
{
    NSLog(@"[%@] %@: %@", [level uppercaseString], NSStringFromClass([self class]), string);
}


@end
